alter table agendamentos
  add column clinica_id uuid references clinicas(id),
  add column origem text not null default 'portal' check (origem in ('portal','clinica'));

alter table agendamento_exames
  add column preco_medico numeric(10,2),
  add column comissao_clinica numeric(10,2) not null default 0;

update agendamento_exames set preco_medico = preco where preco_medico is null;

alter table agendamento_exames alter column preco_medico set not null;

-- validar_preco_exame passa a separar preco do medico x comissao da clinica (quando origem=clinica)
create or replace function validar_preco_exame()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_medico uuid;
  v_horario timestamptz;
  v_clinica_id uuid;
  v_dow int;
  v_hora int;
  v_preco_medico numeric(10,2);
  v_comissao_pct numeric(5,2);
  m record;
begin
  select medico_id, horario, clinica_id into v_medico, v_horario, v_clinica_id from agendamentos where id = new.agendamento_id;
  select * into m from medico_exames where medico_id = v_medico and exame_id = new.exame_id;
  if m is null then
    raise exception 'Médico não oferece esse exame (medico_id=%, exame_id=%)', v_medico, new.exame_id;
  end if;

  v_dow := extract(dow from v_horario);
  v_hora := extract(hour from v_horario);

  if v_dow in (0,6) and m.preco_fim_de_semana is not null then
    v_preco_medico := m.preco_fim_de_semana;
  elsif (v_hora >= 19 or v_hora < 7) and m.preco_noturno is not null then
    v_preco_medico := m.preco_noturno;
  else
    v_preco_medico := m.preco;
  end if;

  new.preco_medico := v_preco_medico;

  if v_clinica_id is not null then
    select comissao_percentual into v_comissao_pct from clinicas where id = v_clinica_id;
    new.comissao_clinica := round(v_preco_medico * coalesce(v_comissao_pct,0) / 100, 2);
  else
    new.comissao_clinica := 0;
  end if;

  new.preco := v_preco_medico + new.comissao_clinica;

  return new;
end;
$$;

-- clinica ve os agendamentos que ela mesma criou (e o pet/perfil do tutor vinculado, ja que foi ela quem coletou o dado)
create policy "agendamentos_clinica_propria" on agendamentos
  for select using (clinica_id = auth.uid());

create policy "agendamento_exames_clinica" on agendamento_exames
  for select using (
    exists (select 1 from agendamentos a where a.id = agendamento_id and a.clinica_id = auth.uid())
  );

create policy "profiles_clinica_do_agendamento" on profiles
  for select using (
    exists (select 1 from agendamentos a where a.tutor_id = profiles.id and a.clinica_id = auth.uid())
  );

create policy "pets_clinica_do_agendamento" on pets
  for select using (
    exists (select 1 from agendamentos a where a.pet_id = pets.id and a.clinica_id = auth.uid())
  );
