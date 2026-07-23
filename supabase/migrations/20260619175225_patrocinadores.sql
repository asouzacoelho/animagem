create table patrocinadores (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  descricao text,
  link text,
  cidade text,
  ativo boolean not null default false,
  ordem int not null default 0,
  created_at timestamptz not null default now()
);

alter table patrocinadores enable row level security;

create policy "patrocinadores_leitura_publica_ativos"
  on patrocinadores for select using (ativo = true);

create policy "patrocinadores_admin_tudo"
  on patrocinadores for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')
  );

insert into patrocinadores (nome, descricao, link, cidade, ativo, ordem) values
('Animaltec', 'Diagnóstico veterinário especializado em Campinas — parceira Animagem.', 'https://animaltec.example.com', 'Campinas', true, 1);
