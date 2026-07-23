create table clinica_onboarding (
  clinica_id uuid primary key references clinicas(id) on delete cascade,
  contrato_social_path text,
  documentos_socios_path text,
  comprovante_endereco_path text,
  crmv_path text,
  cnpj_situacao text,
  cnpj_situacao_verificado_em timestamptz,
  termos_versao text,
  termos_aceitos_em timestamptz,
  status text not null default 'pendente' check (status in ('pendente','aprovado','rejeitado')),
  observacoes_admin text,
  created_at timestamptz not null default now()
);

alter table clinica_onboarding enable row level security;

create policy "clinica_onboarding_proprio_select" on clinica_onboarding
  for select using (clinica_id = auth.uid());
create policy "clinica_onboarding_proprio_insert" on clinica_onboarding
  for insert with check (clinica_id = auth.uid());
create policy "clinica_onboarding_proprio_update_pendente" on clinica_onboarding
  for update using (clinica_id = auth.uid() and status='pendente') with check (clinica_id = auth.uid());
create policy "clinica_onboarding_admin_all" on clinica_onboarding
  for all using (is_admin());

insert into storage.buckets (id, name, public)
values ('documentos-clinicas','documentos-clinicas', false)
on conflict (id) do nothing;

create policy "doc_clinica_insert_proprio" on storage.objects
  for insert with check (bucket_id='documentos-clinicas' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "doc_clinica_select_proprio" on storage.objects
  for select using (bucket_id='documentos-clinicas' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "doc_clinica_admin_select" on storage.objects
  for select using (bucket_id='documentos-clinicas' and is_admin());

-- trava: clinica so pode ficar ativa=true com onboarding aprovado (espelha trg_validar_ativacao_medico)
create or replace function validar_ativacao_clinica()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.ativo = true then
    if not exists (
      select 1 from clinica_onboarding
      where clinica_id = new.id and status = 'aprovado'
    ) then
      raise exception 'Clinica nao pode ser ativada sem onboarding aprovado (documentos verificados pelo admin)';
    end if;
  end if;
  return new;
end;
$$;

revoke execute on function validar_ativacao_clinica() from public;

create trigger trg_validar_ativacao_clinica
before insert or update of ativo on clinicas
for each row execute function validar_ativacao_clinica();
