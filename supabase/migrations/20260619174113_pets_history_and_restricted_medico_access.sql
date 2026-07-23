create table pets (
  id uuid primary key default gen_random_uuid(),
  tutor_id uuid not null references profiles(id) on delete cascade,
  nome text not null,
  especie text not null,
  raca text,
  created_at timestamptz not null default now()
);

alter table agendamentos add column pet_id uuid references pets(id);
alter table agendamentos drop column pet_nome;
alter table agendamentos drop column pet_especie;
alter table agendamentos drop column pet_raca;
alter table agendamentos alter column pet_id set not null;

alter table pets enable row level security;

create policy "pets_tutor_dono"
  on pets for all using (tutor_id = auth.uid());

create policy "pets_admin_tudo"
  on pets for all using (
    exists (select 1 from profiles p where p.id = auth.uid() and p.role = 'admin')
  );

create policy "pets_medico_com_agendamento_pago"
  on pets for select using (
    exists (
      select 1 from agendamentos a
      where a.pet_id = pets.id
        and a.medico_id = auth.uid()
        and a.status in ('pago','confirmado')
    )
  );

drop policy "agendamentos_medico_all" on agendamentos;

create policy "agendamentos_medico_so_pagos"
  on agendamentos for select using (
    medico_id = auth.uid() and status in ('pago','confirmado')
  );

create policy "profiles_medico_com_agendamento_pago"
  on profiles for select using (
    exists (
      select 1 from agendamentos a
      where a.tutor_id = profiles.id
        and a.medico_id = auth.uid()
        and a.status in ('pago','confirmado')
    )
  );
