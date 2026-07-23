create table medico_onboarding (
  medico_id uuid primary key references medicos(id) on delete cascade,
  telefone text,
  documento_path text,
  termos_versao text,
  termos_aceitos_em timestamptz,
  status text not null default 'pendente' check (status in ('pendente','aprovado','rejeitado')),
  observacoes_admin text,
  created_at timestamptz not null default now()
);

alter table medico_onboarding enable row level security;

create policy "onboarding_proprio_select" on medico_onboarding
  for select using (medico_id = auth.uid());
create policy "onboarding_proprio_insert" on medico_onboarding
  for insert with check (medico_id = auth.uid());
create policy "onboarding_proprio_update_pendente" on medico_onboarding
  for update using (medico_id = auth.uid() and status='pendente') with check (medico_id = auth.uid());
create policy "onboarding_admin_all" on medico_onboarding
  for all using (is_admin());

insert into storage.buckets (id, name, public)
values ('documentos-medicos','documentos-medicos', false)
on conflict (id) do nothing;

create policy "doc_medico_insert_proprio" on storage.objects
  for insert with check (bucket_id='documentos-medicos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "doc_medico_select_proprio" on storage.objects
  for select using (bucket_id='documentos-medicos' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "doc_medico_admin_select" on storage.objects
  for select using (bucket_id='documentos-medicos' and is_admin());
