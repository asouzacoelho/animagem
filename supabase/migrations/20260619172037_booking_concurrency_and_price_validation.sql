-- Pendência 1: impedir double-booking do mesmo médico no mesmo horário.
-- Unique parcial: só bloqueia enquanto o agendamento está ativo (reservado/pago/confirmado).
-- cancelado/expirado não contam, então o horário pode ser reocupado.
create unique index agendamentos_medico_horario_ativo_uidx
  on agendamentos (medico_id, horario)
  where status in ('reservado', 'pago', 'confirmado');

-- Pendência 3: nunca confiar no valor enviado pelo cliente.
-- Trigger recalcula o valor a partir de medico_exames antes de gravar/atualizar.
create or replace function validar_valor_agendamento()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  preco_real numeric(10,2);
begin
  select preco into preco_real
  from medico_exames
  where medico_id = new.medico_id and exame_id = new.exame_id;

  if preco_real is null then
    raise exception 'Médico não oferece esse exame (medico_id=%, exame_id=%)', new.medico_id, new.exame_id;
  end if;

  new.valor := preco_real;
  return new;
end;
$$;

create trigger agendamentos_validar_valor
  before insert or update of medico_id, exame_id on agendamentos
  for each row execute function validar_valor_agendamento();
