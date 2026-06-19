-- Animagem — schema inicial + RLS
-- Rodar no SQL Editor do Supabase (ou via `supabase db push` depois de `supabase link`).

-- ════════════════════════════════
-- PROFILES (1 linha por usuário autenticado, espelha auth.users)
-- ════════════════════════════════
create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role text not null check (role in ('tutor','medico','admin')),
  nome text not null,
  telefone text,
  email text not null,
  created_at timestamptz not null default now()
);

alter table profiles enable row level security;

create policy "profiles: usuário vê o próprio perfil"
  on profiles for select using (id = auth.uid());

create policy "profiles: usuário edita o próprio perfil"
  on profiles for update using (id = auth.uid());

create policy "profiles: admin vê todos"
  on profiles for select using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')
  );

-- ════════════════════════════════
-- MÉDICOS (dados públicos exibidos no portal)
-- ════════════════════════════════
create table medicos (
  id uuid primary key references profiles(id) on delete cascade,
  crmv text not null,
  bio text,
  instagram text,
  cidade text not null,
  estado text not null,
  antecedencia_min int not null default 60,
  aceita_fds boolean not null default false,
  aceita_noturno boolean not null default false,
  ativo boolean not null default false, -- admin aprova antes de ficar visível
  created_at timestamptz not null default now()
);

alter table medicos enable row level security;

create policy "medicos: visível publicamente se ativo"
  on medicos for select using (ativo = true);

create policy "medicos: médico vê e edita o próprio registro"
  on medicos for all using (id = auth.uid());

create policy "medicos: admin tem acesso total"
  on medicos for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')
  );

-- ════════════════════════════════
-- CATÁLOGO DE EXAMES (mestre, definido pelo admin)
-- ════════════════════════════════
create table exames_catalogo (
  id uuid primary key default gen_random_uuid(),
  nome text not null unique,
  duracao_min int not null,
  preco_base numeric(10,2) not null
);

alter table exames_catalogo enable row level security;

create policy "exames_catalogo: leitura pública"
  on exames_catalogo for select using (true);

create policy "exames_catalogo: só admin escreve"
  on exames_catalogo for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')
  );

-- ════════════════════════════════
-- EXAMES POR MÉDICO (preço pode variar por médico)
-- ════════════════════════════════
create table medico_exames (
  medico_id uuid not null references medicos(id) on delete cascade,
  exame_id uuid not null references exames_catalogo(id) on delete cascade,
  preco numeric(10,2) not null,
  primary key (medico_id, exame_id)
);

alter table medico_exames enable row level security;

create policy "medico_exames: leitura pública"
  on medico_exames for select using (true);

create policy "medico_exames: médico edita o próprio"
  on medico_exames for all using (medico_id = auth.uid());

create policy "medico_exames: admin tem acesso total"
  on medico_exames for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')
  );

-- ════════════════════════════════
-- ÁREA DE ATENDIMENTO (bairros/cidades ativados por médico)
-- ════════════════════════════════
create table medico_area (
  id uuid primary key default gen_random_uuid(),
  medico_id uuid not null references medicos(id) on delete cascade,
  tipo text not null check (tipo in ('bairro','cidade')),
  nome text not null,
  ativo boolean not null default true,
  unique (medico_id, tipo, nome)
);

alter table medico_area enable row level security;

create policy "medico_area: leitura pública"
  on medico_area for select using (true);

create policy "medico_area: médico edita a própria área"
  on medico_area for all using (medico_id = auth.uid());

create policy "medico_area: admin tem acesso total"
  on medico_area for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')
  );

-- ════════════════════════════════
-- AGENDAMENTOS
-- ════════════════════════════════
create table agendamentos (
  id uuid primary key default gen_random_uuid(),
  tutor_id uuid not null references profiles(id),
  medico_id uuid not null references medicos(id),
  exame_id uuid not null references exames_catalogo(id),
  horario timestamptz not null,
  endereco text not null,
  pet_nome text not null,
  pet_especie text not null,
  pet_raca text,
  observacoes text,
  valor numeric(10,2) not null,
  status text not null default 'reservado'
    check (status in ('reservado','pago','confirmado','cancelado','expirado')),
  expira_em timestamptz not null default (now() + interval '30 minutes'),
  created_at timestamptz not null default now()
);

create index agendamentos_medico_horario_idx on agendamentos (medico_id, horario);

alter table agendamentos enable row level security;

create policy "agendamentos: tutor vê os próprios"
  on agendamentos for select using (tutor_id = auth.uid());

create policy "agendamentos: tutor cria os próprios"
  on agendamentos for insert with check (tutor_id = auth.uid());

create policy "agendamentos: médico vê e atualiza os seus"
  on agendamentos for all using (medico_id = auth.uid());

create policy "agendamentos: admin tem acesso total"
  on agendamentos for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')
  );

-- ════════════════════════════════
-- PAGAMENTOS
-- só o backend (service_role / webhook do gateway) pode inserir ou confirmar.
-- nenhuma policy de insert/update para 'authenticated' — propositalmente.
-- ════════════════════════════════
create table pagamentos (
  id uuid primary key default gen_random_uuid(),
  agendamento_id uuid not null references agendamentos(id) on delete cascade,
  metodo text not null check (metodo in ('pix','cartao')),
  valor numeric(10,2) not null,
  status text not null default 'pendente'
    check (status in ('pendente','confirmado','falhou','expirado')),
  gateway_id text,
  criado_em timestamptz not null default now(),
  confirmado_em timestamptz
);

alter table pagamentos enable row level security;

create policy "pagamentos: tutor vê os próprios via agendamento"
  on pagamentos for select using (
    exists (select 1 from agendamentos a where a.id = agendamento_id and a.tutor_id = auth.uid())
  );

create policy "pagamentos: médico vê os relacionados aos seus agendamentos"
  on pagamentos for select using (
    exists (select 1 from agendamentos a where a.id = agendamento_id and a.medico_id = auth.uid())
  );

create policy "pagamentos: admin tem acesso total"
  on pagamentos for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')
  );

-- ════════════════════════════════
-- COMISSÕES (configurável por especialidade ou por médico — só admin)
-- ════════════════════════════════
create table comissoes (
  id uuid primary key default gen_random_uuid(),
  tipo text not null check (tipo in ('especialidade','medico')),
  referencia_id uuid not null, -- exames_catalogo.id ou medicos.id, dependendo do tipo
  percentual numeric(5,2) not null default 0,
  unique (tipo, referencia_id)
);

alter table comissoes enable row level security;

create policy "comissoes: só admin"
  on comissoes for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')
  );
