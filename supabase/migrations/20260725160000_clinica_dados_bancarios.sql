-- Espelha medico_dados_bancarios: dados bancarios da clinica para repasse da comissao por indicacao
-- (pendencia: hoje o repasse em si ainda e manual/inexistente, mesma pendencia 4 do medico, so que agora
-- com 3 partes: medico, clinica, Animagem — este passo so guarda o dado, nao automatiza o repasse)
create table clinica_dados_bancarios (
  clinica_id uuid primary key references clinicas(id) on delete cascade,
  pix_chave text,
  banco text,
  agencia text,
  conta text,
  conta_tipo text,
  titular_nome text,
  titular_cpf_cnpj text,
  updated_at timestamptz not null default now()
);

alter table clinica_dados_bancarios enable row level security;

create policy "dados_bancarios_clinica_proprio" on clinica_dados_bancarios
  for all using (clinica_id = auth.uid()) with check (clinica_id = auth.uid());

create policy "dados_bancarios_clinica_admin" on clinica_dados_bancarios
  for all using (is_admin());
