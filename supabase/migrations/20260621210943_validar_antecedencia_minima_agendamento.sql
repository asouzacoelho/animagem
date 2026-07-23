create or replace function validar_antecedencia_agendamento()
returns trigger as $$
declare
  v_antecedencia_min integer;
begin
  select antecedencia_min into v_antecedencia_min from medicos where id = new.medico_id;
  if new.horario < now() + (coalesce(v_antecedencia_min,60) || ' minutes')::interval then
    raise exception 'Este horário não respeita a antecedência mínima exigida pelo médico (% min)', coalesce(v_antecedencia_min,60);
  end if;
  return new;
end;
$$ language plpgsql security definer;

revoke execute on function validar_antecedencia_agendamento() from anon, authenticated;

create trigger trg_validar_antecedencia_agendamento
before insert on agendamentos
for each row
execute function validar_antecedencia_agendamento();
