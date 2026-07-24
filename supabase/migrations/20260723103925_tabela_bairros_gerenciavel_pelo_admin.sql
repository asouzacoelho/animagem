-- nao existe API publica confiavel de "bairros por cidade" no Brasil (IBGE so tem distrito/subdistrito,
-- que nao corresponde aos bairros informais usados em endereco). Por isso mantemos nossa propria lista,
-- gerenciavel pelo admin, em vez de depender de fonte externa.
create table bairros (
  id uuid primary key default gen_random_uuid(),
  cidade text not null,
  estado text not null,
  nome text not null,
  ativo boolean not null default true,
  created_at timestamptz not null default now(),
  unique (cidade, estado, nome)
);

alter table bairros enable row level security;

create policy "bairros: leitura publica dos ativos" on bairros for select using (ativo = true);
create policy "bairros: admin gerencia" on bairros for all using (is_admin());

-- seed com a lista que ja existia fixa no frontend (Campinas), preservando os bairros ja
-- cadastrados por medicos em medico_area para nao quebrar nada
insert into bairros (cidade, estado, nome) values
('Campinas','SP','Taquaral'),('Campinas','SP','Cambuí'),('Campinas','SP','Bosque'),
('Campinas','SP','Centro'),('Campinas','SP','Guanabara'),('Campinas','SP','Nova Campinas'),
('Campinas','SP','Barão Geraldo'),('Campinas','SP','Parque Prado'),('Campinas','SP','Alphaville Campinas'),
('Campinas','SP','Sousas'),('Campinas','SP','Jardim Chapadão'),('Campinas','SP','Cidade Universitária'),
('Campinas','SP','Cambará'),('Campinas','SP','Castelo'),('Campinas','SP','Flamboyant'),
('Campinas','SP','Jardim Guanabara'),('Campinas','SP','Mansões Santo Antônio'),('Campinas','SP','Parque Taquaral'),
('Campinas','SP','Ponte Preta'),('Campinas','SP','Vila Industrial'),('Campinas','SP','Jardim das Paineiras'),
('Campinas','SP','Swift'),('Campinas','SP','Jardim São Bernardo'),('Campinas','SP','Vila Nova'),
('Campinas','SP','Botafogo'),('Campinas','SP','Cura D''Ars'),('Campinas','SP','Jardim Proença'),
('Campinas','SP','Parque das Universidades'),('Campinas','SP','Vila Brandina'),('Campinas','SP','Anhumas');
