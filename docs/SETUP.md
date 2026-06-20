# Setup — Fase 0

Duas ações exigem login nas suas contas pessoais e por isso não foram feitas automaticamente. O resto do projeto já está pronto para elas.

## 1. Criar o projeto no Supabase (5 min)

1. Acesse https://supabase.com, crie/entre na sua conta, clique em **New project**.
2. Nome: `animagem` (ou o que preferir). Guarde a senha do banco em local seguro.
3. Depois de criado, vá em **SQL Editor** → cole o conteúdo de [`supabase/migrations/0001_init_schema.sql`](../supabase/migrations/0001_init_schema.sql) → Run.
   Isso cria todas as tabelas (`profiles`, `medicos`, `exames_catalogo`, `medico_exames`, `medico_area`, `agendamentos`, `pagamentos`, `comissoes`) já com Row Level Security ativado — cada papel (tutor/médico/admin) só acessa o que pode.
4. Em **Authentication → Providers**, ative **Email**. Se quiser login social (Google), ative depois.
5. Em **Project Settings → API**, copie a `Project URL` e a `anon public key` — vão para o frontend (nunca a `service_role key`, essa fica só em backend/webhooks).

## 2. Criar o repositório no GitHub (2 min)

1. Crie um repositório novo em https://github.com/new (ex: `animagem`), vazio, sem README (já temos arquivos locais).
2. Rode localmente:
   ```
   git remote add origin https://github.com/SEU-USUARIO/animagem.git
   git branch -M main
   git add -A
   git commit -m "Fase 0: estrutura inicial do projeto"
   git push -u origin main
   ```

## 3. Conectar Cloudflare Pages ao GitHub (depois do push)

> Atualizado em 2026-06-20: migramos do Netlify para o Cloudflare Pages (https://animagem.pages.dev), porque a conta do Netlify ficou sem créditos e bloqueou deploys de produção sem aviso.

1. https://dash.cloudflare.com → **Workers & Pages → Create → Pages → Connect to Git** → escolha o repo `animagem`.
2. Build settings: **Build command vazio**, **Build output directory: `public`** (equivalente ao `_redirects` em [`public/_redirects`](../public/_redirects), que cobre o redirecionamento de rotas).
3. Variáveis de ambiente não são necessárias hoje — o frontend usa a `anon public key` do Supabase direto no código-fonte (chave pública, segura para expor; a segurança real vem das políticas de RLS no banco, não do sigilo dessa chave).

---

Depois desses 3 passos, o projeto estará: versionado no GitHub, com banco real e RLS configurada no Supabase, e publicado no Cloudflare Pages a cada push. Isso fecha a Fase 0. A Fase 1 (ligar o frontend ao Supabase de fato, com login por papel) já está concluída — ver [`docs/PENDENCIAS.md`](PENDENCIAS.md) para o que falta nas fases seguintes.
