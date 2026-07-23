create table medico_dados_bancarios (
  medico_id uuid primary key references medicos(id) on delete cascade,
  pix_chave text,
  banco text,
  agencia text,
  conta text,
  conta_tipo text,
  titular_nome text,
  titular_cpf_cnpj text,
  updated_at timestamptz not null default now()
);

alter table medico_dados_bancarios enable row level security;

create policy "dados_bancarios_proprio" on medico_dados_bancarios
  for all using (medico_id = auth.uid()) with check (medico_id = auth.uid());

create policy "dados_bancarios_admin" on medico_dados_bancarios
  for all using (is_admin());
