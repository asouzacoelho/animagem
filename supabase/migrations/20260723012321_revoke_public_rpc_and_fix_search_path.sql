-- Fecha avisos do Supabase advisor:
-- 1) funcoes internas (triggers/cron/event trigger) nao devem ser chamaveis via RPC publica
--    (ficam expostas em /rest/v1/rpc/... a qualquer um so por terem sido criadas com o
--    grant default de EXECUTE a PUBLIC). Revogar de PUBLIC nao afeta os triggers/cron que
--    as chamam internamente, so impede a chamada direta via RPC.
-- 2) funcoes SECURITY DEFINER sem search_path fixo podem ser sequestradas por um
--    search_path malicioso da sessao; fixamos explicitamente para 'public'.
-- is_admin() e solicitar_exclusao_propria() ficam de fora dos revokes: is_admin precisa
-- ser chamavel por anon/authenticated (usada dentro das policies de RLS) e
-- solicitar_exclusao_propria e chamada via RPC pelo frontend (botao "Minha conta").

revoke execute on function public.expirar_reservas_vencidas() from public;
revoke execute on function public.recalcular_valor_agendamento() from public;
revoke execute on function public.validar_preco_exame() from public;
revoke execute on function public.validar_ativacao_medico() from public;
revoke execute on function public.validar_antecedencia_agendamento() from public;
revoke execute on function public.rls_auto_enable() from public;

alter function public.validar_ativacao_medico() set search_path = public;
alter function public.solicitar_exclusao_propria() set search_path = public;
alter function public.validar_antecedencia_agendamento() set search_path = public;
