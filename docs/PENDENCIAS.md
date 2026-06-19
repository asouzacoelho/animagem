# Pendências de robustez

Itens identificados que precisam ser resolvidos antes de abrir o sistema para usuários reais e dinheiro real. Em ordem de risco, não de data.

1. ~~**Concorrência no agendamento**~~ — ✅ resolvido em 2026-06-19: índice único parcial `agendamentos_medico_horario_ativo_uidx` (medico_id+horario, só para status ativo) impede double-booking no banco. Frontend trata erro `23505` e avisa o tutor para escolher outro horário.
2. ~~**Expiração automática de reserva**~~ — ✅ resolvido em 2026-06-19: `pg_cron` roda a função `expirar_reservas_vencidas()` a cada 5 min, marcando como `expirado` quem passou de `expira_em` sem pagar.
3. ~~**Nunca confiar em preço vindo do cliente**~~ — ✅ resolvido em 2026-06-19: trigger `agendamentos_validar_valor` recalcula `valor` a partir de `medico_exames.preco` antes de gravar, ignorando o que vier do navegador.
4. **Webhook do gateway como única fonte de verdade do pagamento** — ainda não implementado. O frontend hoje cria o `agendamento` real (status `reservado`) mas não escreve em `pagamentos` (RLS bloqueia isso de propósito). Falta integrar Pagar.me/outro gateway com webhook server-side (Edge Function) que confirme o pagamento e mude o status.
5. **Backups / Point-in-Time Recovery no Supabase** — o plano Free não tem PITR; revisar ao migrar para plano pago, antes de ter dados reais de pessoas.
6. **Monitoramento de erros e logs em produção** (ex: Sentry) — para saber quando algo quebra sem depender de reclamação de usuário.
7. **LGPD** — política de privacidade real, consentimento explícito para guardar endereço residencial e dados de pet/tutor, mecanismo de exclusão de conta/dados.
8. **Monetização por publicidade** — estrutura de dados e UI já criadas (ver seção detalhada abaixo), venda ainda não ativada. Falta: tela de admin para cadastrar patrocinador sem SQL, modelo de cobrança, critério de quem pode anunciar, limite de slots por página.

**Contexto:** essas pendências foram levantadas depois da Fase 0 (repo GitHub + schema Supabase com RLS + deploy Netlify), quando ficou claro que o frontend ainda não fala de fato com o banco — é a Fase 1 que vai expor esses riscos na prática.

---

## Monetização por publicidade (estrutura criada, venda NÃO ativada)

Em 2026-06-19, a pedido do André, criamos a estrutura para vender espaço patrocinado no portal — pensando em ROI desde já, mesmo sem vender nada ainda.

- **Schema:** tabela `patrocinadores` (nome, descrição, link, cidade, `ativo`, `ordem`). RLS: leitura pública só de quem está `ativo=true`; escrita só admin. Seed de demonstração: "Animaltec" (Campinas), marcado como exemplo.
- **Frontend:** bloco "Conteúdo patrocinado" no portal (`public/index.html`), claramente rotulado como patrocínio, entre os resultados de busca e o rodapé de estatísticas. Hoje mostra 1 patrocinador ativo; o componente já suporta múltiplos (`order by ordem`).
- **Por que essa estrutura, não outra:** rótulo "Conteúdo patrocinado" visível evita parecer anúncio enganoso e problema de confiança num portal de saúde de pet — isso foi decisão deliberada, não só estética.
- **O que falta para vender de fato (quando decidirem ativar):**
  - Tela de admin para cadastrar/editar patrocinador sem precisar de SQL (hoje só dá pra inserir via banco).
  - Modelo de cobrança: mensalidade fixa por slot é o mais simples de operar agora (sem precisar de tracking de clique/impressão); CPM/CPC exigiria instrumentação extra.
  - Definir quem pode anunciar: negócios locais relacionados a pet em Campinas/região (clínicas, pet food, laboratórios) — evitar anúncio genérico que não tenha relação com o público.
  - Limite de quantos slots por página, para não comprometer a experiência do tutor.
- **Por que vale considerar para o ROI do projeto:** é receita não-dependente de comissão de agendamento — relevante porque hoje a comissão está em 0% (fase MVP) e o volume de transações ainda é baixo; patrocínio pode gerar caixa antes do marketplace atingir volume.
