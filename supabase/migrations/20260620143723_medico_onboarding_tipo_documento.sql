alter table medico_onboarding
  add column documento_tipo text check (documento_tipo in ('CRMV','RG','CPF')),
  add column documento_extra_path text;
