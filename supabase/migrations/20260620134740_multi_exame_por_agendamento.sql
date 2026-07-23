-- remove a validação antiga (estava presa a um único exame por agendamento)
drop trigger agendamentos_validar_valor on agendamentos;
drop function validar_valor_agendamento();

-- agendamentos passa a representar a VISITA (1 horário, 1 endereço); os exames ficam em tabela própria
alter table agendamentos drop column exame_id;
alter table agendamentos alter column valor set default 0;

create table agendamento_exames (
  agendamento_id uuid not null references agendamentos(id) on delete cascade,
  exame_id uuid not null references exames_catalogo(id),
  preco numeric(10,2) not null,
  primary key (agendamento_id, exame_id)
);

alter table agendamento_exames enable row level security;

create policy "agendamento_exames_tutor"
  on agendamento_exames for all using (
    exists (select 1 from agendamentos a where a.id = agendamento_id and a.tutor_id = auth.uid())
  );

create policy "agendamento_exames_medico_pago"
  on agendamento_exames for select using (
    exists (select 1 from agendamentos a where a.id = agendamento_id and a.medico_id = auth.uid() and a.status in ('pago','confirmado'))
  );

create policy "agendamento_exames_admin"
  on agendamento_exames for all using (is_admin());

-- valida o preço de cada exame no momento do insert (nunca confiar no valor do navegador)
create or replace function validar_preco_exame()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  preco_real numeric(10,2);
  v_medico uuid;
begin
  select medico_id into v_medico from agendamentos where id = new.agendamento_id;
  select preco into preco_real from medico_exames where medico_id = v_medico and exame_id = new.exame_id;
  if preco_real is null then
    raise exception 'Médico não oferece esse exame (medico_id=%, exame_id=%)', v_medico, new.exame_id;
  end if;
  new.preco := preco_real;
  return new;
end;
$$;

create trigger agendamento_exames_validar_preco
  before insert on agendamento_exames
  for each row execute function validar_preco_exame();

-- recalcula o total do agendamento sempre que a lista de exames muda
create or replace function recalcular_valor_agendamento()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  v_agendamento_id uuid := coalesce(new.agendamento_id, old.agendamento_id);
begin
  update agendamentos
  set valor = (select coalesce(sum(preco),0) from agendamento_exames where agendamento_id = v_agendamento_id)
  where id = v_agendamento_id;
  return null;
end;
$$;

create trigger agendamento_exames_recalc
  after insert or update or delete on agendamento_exames
  for each row execute function recalcular_valor_agendamento();

revoke execute on function validar_preco_exame() from anon, authenticated;
revoke execute on function recalcular_valor_agendamento() from anon, authenticated;
