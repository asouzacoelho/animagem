-- adiciona parametro de observacoes (orientacoes da clinica pro medico do exame)
-- precisa dropar porque a assinatura muda (novo parametro), create or replace nao troca assinatura
drop function if exists clinica_criar_agendamento(uuid,timestamptz,text,text,text,text,text,text,text,uuid[]);

create or replace function clinica_criar_agendamento(
  p_medico_id uuid,
  p_horario timestamptz,
  p_endereco text,
  p_tutor_email text,
  p_tutor_nome text,
  p_tutor_telefone text,
  p_pet_nome text,
  p_pet_especie text,
  p_pet_raca text,
  p_exame_ids uuid[],
  p_observacoes text default null
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_clinica_id uuid := auth.uid();
  v_tutor_id uuid;
  v_pet_id uuid;
  v_agendamento_id uuid;
  v_exame_id uuid;
begin
  if v_clinica_id is null then
    raise exception 'Não autenticado';
  end if;

  if not exists (select 1 from clinicas where id = v_clinica_id and ativo = true) then
    raise exception 'Clínica não está ativa/aprovada';
  end if;

  if p_exame_ids is null or array_length(p_exame_ids, 1) is null then
    raise exception 'Selecione ao menos um exame';
  end if;

  select id into v_tutor_id from auth.users where lower(email) = lower(p_tutor_email);
  if v_tutor_id is null then
    raise exception 'Tutor ainda não tem conta — crie o acesso dele (link mágico) antes de agendar';
  end if;

  if not exists (select 1 from profiles where id = v_tutor_id) then
    insert into profiles (id, role, nome, telefone, email)
    values (v_tutor_id, 'tutor', p_tutor_nome, p_tutor_telefone, p_tutor_email);
  end if;

  select id into v_pet_id from pets
    where tutor_id = v_tutor_id and lower(nome) = lower(p_pet_nome)
    limit 1;
  if v_pet_id is null then
    insert into pets (tutor_id, nome, especie, raca)
    values (v_tutor_id, p_pet_nome, p_pet_especie, p_pet_raca)
    returning id into v_pet_id;
  end if;

  insert into agendamentos (tutor_id, medico_id, horario, endereco, pet_id, valor, clinica_id, origem, observacoes)
  values (v_tutor_id, p_medico_id, p_horario, p_endereco, v_pet_id, 0, v_clinica_id, 'clinica', p_observacoes)
  returning id into v_agendamento_id;

  foreach v_exame_id in array p_exame_ids loop
    insert into agendamento_exames (agendamento_id, exame_id, preco, preco_medico)
    values (v_agendamento_id, v_exame_id, 0, 0);
  end loop;

  return v_agendamento_id;
end;
$$;

revoke all on function clinica_criar_agendamento(uuid,timestamptz,text,text,text,text,text,text,text,uuid[],text) from public;
grant execute on function clinica_criar_agendamento(uuid,timestamptz,text,text,text,text,text,text,text,uuid[],text) to authenticated;

-- nova funcao: clinica confirma se um tutor ja tem conta, sem expor dados sensiveis de alguem
-- que ela ainda nao atendeu (so diz se existe + primeiro nome, nunca telefone/endereco)
create or replace function clinica_verificar_tutor(p_email text)
returns table(existe boolean, primeiro_nome text)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid uuid;
  v_nome text;
begin
  if not exists (select 1 from clinicas where id = auth.uid() and ativo = true) then
    raise exception 'Apenas clínicas ativas podem verificar isso';
  end if;

  select u.id into v_uid from auth.users u where lower(u.email) = lower(p_email);
  if v_uid is null then
    return query select false, null::text;
    return;
  end if;

  select p.nome into v_nome from profiles p where p.id = v_uid;
  return query select true, split_part(coalesce(v_nome,''),' ',1);
end;
$$;

revoke all on function clinica_verificar_tutor(text) from public;
grant execute on function clinica_verificar_tutor(text) to authenticated;
