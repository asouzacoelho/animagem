-- Novo papel: clinica veterinaria (busca medicos disponiveis e agenda exames em nome de tutores clientes)
alter table profiles drop constraint profiles_role_check;
alter table profiles add constraint profiles_role_check check (role in ('tutor','medico','admin','clinica'));

create table clinicas (
  id uuid primary key references profiles(id) on delete cascade,
  cnpj text not null,
  razao_social text not null,
  nome_fantasia text,
  cidade text not null,
  estado text not null,
  comissao_percentual numeric(5,2) not null default 0,
  ativo boolean not null default false, -- admin aprova antes de ficar visivel/operante
  created_at timestamptz not null default now()
);

alter table clinicas enable row level security;

create policy "clinicas: visivel publicamente se ativa"
  on clinicas for select using (ativo = true);

create policy "clinicas: clinica ve e edita o proprio registro"
  on clinicas for all using (id = auth.uid());

create policy "clinicas: admin tem acesso total"
  on clinicas for all using (is_admin());
