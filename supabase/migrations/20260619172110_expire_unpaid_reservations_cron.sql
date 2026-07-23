create extension if not exists pg_cron;

create or replace function expirar_reservas_vencidas()
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  update agendamentos
  set status = 'expirado'
  where status = 'reservado'
    and expira_em < now();
end;
$$;

select cron.schedule(
  'expirar-reservas-vencidas',
  '*/5 * * * *',
  $$select expirar_reservas_vencidas();$$
);
