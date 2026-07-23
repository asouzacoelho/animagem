create or replace function validar_ativacao_medico()
returns trigger as $$
begin
  if new.ativo = true then
    if not exists (
      select 1 from medico_onboarding
      where medico_id = new.id and status = 'aprovado'
    ) then
      raise exception 'Médico não pode ser ativado sem onboarding aprovado (documento + termos verificados pelo admin)';
    end if;
  end if;
  return new;
end;
$$ language plpgsql security definer;

revoke execute on function validar_ativacao_medico() from anon, authenticated;

create trigger trg_validar_ativacao_medico
before insert or update of ativo on medicos
for each row
execute function validar_ativacao_medico();
