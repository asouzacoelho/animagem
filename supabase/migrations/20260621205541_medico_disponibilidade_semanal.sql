create table medico_disponibilidade (
  medico_id uuid not null references medicos(id) on delete cascade,
  dia_semana smallint not null check (dia_semana between 0 and 6),
  hora smallint not null check (hora between 0 and 23),
  disponivel boolean not null default true,
  primary key (medico_id, dia_semana, hora)
);

alter table medico_disponibilidade enable row level security;

create policy "disponibilidade_publica_medico_ativo" on medico_disponibilidade
  for select using (exists (select 1 from medicos m where m.id = medico_disponibilidade.medico_id and m.ativo = true));

create policy "disponibilidade_propria" on medico_disponibilidade
  for all using (medico_id = auth.uid()) with check (medico_id = auth.uid());

create policy "disponibilidade_admin" on medico_disponibilidade
  for all using (is_admin());
