create table config_portal (
  id boolean primary key default true,
  aceitar_novos_medicos boolean not null default true,
  fase_mvp_ativa boolean not null default true,
  email_contato text,
  whatsapp_suporte text,
  check (id)
);
insert into config_portal (id) values (true);

alter table config_portal enable row level security;

create policy "config_portal_select_publico" on config_portal for select using (true);
create policy "config_portal_admin_update" on config_portal for update using (is_admin());
