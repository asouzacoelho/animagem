create or replace function solicitar_exclusao_propria()
returns text
language plpgsql
security definer
as $$
declare
  v_uid uuid := auth.uid();
begin
  if v_uid is null then
    raise exception 'Não autenticado';
  end if;

  begin
    delete from profiles where id = v_uid;
    delete from auth.users where id = v_uid;
    return 'excluido';
  exception when foreign_key_violation then
    -- existe historico de agendamento vinculado (qualquer status) — nao pode apagar de verdade,
    -- entao anonimiza os dados pessoais e desativa o login, preservando o registro financeiro/de atendimento
    update profiles set nome='Usuário removido', telefone=null, email=null where id = v_uid;
    update pets set nome='Pet removido', raca=null where tutor_id = v_uid;
    update medicos set ativo=false, bio=null, instagram=null, crmv='—' where id = v_uid;
    delete from medico_dados_bancarios where medico_id = v_uid;
    delete from medico_area where medico_id = v_uid;
    delete from medico_exames where medico_id = v_uid;
    update auth.users set banned_until = '2999-01-01T00:00:00Z' where id = v_uid;
    return 'anonimizado';
  end;
end;
$$;

revoke all on function solicitar_exclusao_propria() from public;
grant execute on function solicitar_exclusao_propria() to authenticated;
