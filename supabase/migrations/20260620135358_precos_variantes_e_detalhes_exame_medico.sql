alter table medico_exames
  add column preco_fim_de_semana numeric(10,2),
  add column preco_noturno numeric(10,2),
  add column duracao_min int,
  add column pre_requisitos text;

-- substitui a validação simples por uma que escolhe o preço certo conforme dia/hora do agendamento
create or replace function validar_preco_exame()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_medico uuid;
  v_horario timestamptz;
  v_dow int;
  v_hora int;
  m record;
begin
  select medico_id, horario into v_medico, v_horario from agendamentos where id = new.agendamento_id;
  select * into m from medico_exames where medico_id = v_medico and exame_id = new.exame_id;
  if m is null then
    raise exception 'Médico não oferece esse exame (medico_id=%, exame_id=%)', v_medico, new.exame_id;
  end if;

  v_dow := extract(dow from v_horario); -- 0=domingo,6=sabado
  v_hora := extract(hour from v_horario);

  if v_dow in (0,6) and m.preco_fim_de_semana is not null then
    new.preco := m.preco_fim_de_semana;
  elsif (v_hora >= 19 or v_hora < 7) and m.preco_noturno is not null then
    new.preco := m.preco_noturno;
  else
    new.preco := m.preco;
  end if;

  return new;
end;
$$;
