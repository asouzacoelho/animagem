create policy "profiles_insert_own"
  on profiles for insert with check (id = auth.uid());
