-- Função auxiliar SECURITY DEFINER: roda com privilégio do owner (bypassa RLS),
-- então checar role=admin não dispara recursão das políticas de profiles.
create or replace function public.is_admin()
returns boolean
language sql
security definer
stable
set search_path = public
as $$
  select exists(select 1 from profiles where id = auth.uid() and role = 'admin');
$$;
revoke all on function public.is_admin() from public;
grant execute on function public.is_admin() to authenticated, anon;

drop policy "profiles_admin_select_all" on profiles;
create policy "profiles_admin_select_all" on profiles for select using (is_admin());

drop policy "medicos_admin_all" on medicos;
create policy "medicos_admin_all" on medicos for all using (is_admin());

drop policy "exames_catalogo_admin_all" on exames_catalogo;
create policy "exames_catalogo_admin_all" on exames_catalogo for all using (is_admin());

drop policy "medico_exames_admin_all" on medico_exames;
create policy "medico_exames_admin_all" on medico_exames for all using (is_admin());

drop policy "medico_area_admin_all" on medico_area;
create policy "medico_area_admin_all" on medico_area for all using (is_admin());

drop policy "agendamentos_admin_all" on agendamentos;
create policy "agendamentos_admin_all" on agendamentos for all using (is_admin());

drop policy "pagamentos_admin_all" on pagamentos;
create policy "pagamentos_admin_all" on pagamentos for all using (is_admin());

drop policy "comissoes_admin_all" on comissoes;
create policy "comissoes_admin_all" on comissoes for all using (is_admin());

drop policy "pets_admin_tudo" on pets;
create policy "pets_admin_tudo" on pets for all using (is_admin());

drop policy "patrocinadores_admin_tudo" on patrocinadores;
create policy "patrocinadores_admin_tudo" on patrocinadores for all using (is_admin());
