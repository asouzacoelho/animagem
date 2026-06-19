# Pendências de robustez

Itens identificados que precisam ser resolvidos antes de abrir o sistema para usuários reais e dinheiro real. Em ordem de risco, não de data.

1. **Concorrência no agendamento** — dois tutores podem reservar o mesmo horário ao mesmo tempo. Precisa de constraint de unicidade (`medico_id + horario`) no banco e tratamento de erro no frontend, não só lock visual de 30 min.
2. **Expiração automática de reserva** — `agendamentos.expira_em` já existe na tabela, mas falta um job (`pg_cron` no Supabase) que libera o slot automaticamente quando o pagamento não é confirmado a tempo.
3. **Nunca confiar em preço vindo do cliente** — ao gravar `agendamentos.valor`, validar no backend (função/trigger) contra `medico_exames.preco`; não aceitar o valor que o navegador envia.
4. **Webhook do gateway como única fonte de verdade do pagamento** — status muda só quando o Pagar.me confirma via webhook server-side, nunca quando o usuário clica "já paguei" no frontend.
5. **Backups / Point-in-Time Recovery no Supabase** — o plano Free não tem PITR; revisar ao migrar para plano pago, antes de ter dados reais de pessoas.
6. **Monitoramento de erros e logs em produção** (ex: Sentry) — para saber quando algo quebra sem depender de reclamação de usuário.
7. **LGPD** — política de privacidade real, consentimento explícito para guardar endereço residencial e dados de pet/tutor, mecanismo de exclusão de conta/dados.

**Contexto:** essas pendências foram levantadas depois da Fase 0 (repo GitHub + schema Supabase com RLS + deploy Netlify), quando ficou claro que o frontend ainda não fala de fato com o banco — é a Fase 1 que vai expor esses riscos na prática.
