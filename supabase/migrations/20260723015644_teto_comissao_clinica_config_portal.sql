alter table config_portal add column clinica_comissao_teto numeric(5,2) not null default 20;

create or replace function validar_comissao_clinica()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_teto numeric(5,2);
begin
  select clinica_comissao_teto into v_teto from config_portal limit 1;
  if new.comissao_percentual < 0 or new.comissao_percentual > coalesce(v_teto, 20) then
    raise exception 'Comissao da clinica deve ficar entre 0 e o teto definido pelo admin (hoje: %)', coalesce(v_teto,20);
  end if;
  return new;
end;
$$;

revoke execute on function validar_comissao_clinica() from public;

create trigger trg_validar_comissao_clinica
before insert or update of comissao_percentual on clinicas
for each row execute function validar_comissao_clinica();
