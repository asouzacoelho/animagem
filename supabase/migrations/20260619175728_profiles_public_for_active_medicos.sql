create policy "profiles_publico_medico_ativo"
  on profiles for select using (
    exists (select 1 from medicos m where m.id = profiles.id and m.ativo = true)
  );
