# CONTEXTO.md — Animagem, estado real do sistema

> Documento vivo. É a fonte da verdade sobre o que **existe de fato** hoje (código/schema), não sobre planos. Decisões de negócio/jurídico ficam em [`GUIA_ANDRE.md`](GUIA_ANDRE.md), pendências técnicas em [`PENDENCIAS.md`](PENDENCIAS.md), passo a passo de infra em [`SETUP.md`](SETUP.md), histórico de visão original (parcialmente desatualizado) em [`animagem-contexto-projeto.md`](animagem-contexto-projeto.md). Atualizar este arquivo sempre que uma mudança estrutural for feita — é o que qualquer pessoa (ou IA) deveria ler primeiro para entender o projeto.

Última revisão: 2026-07-25.

## 1. O que é

**Posicionamento atual (redefinido em 2026-07-25):** marketplace para **qualquer médico veterinário autônomo**, de qualquer especialidade — não só ultrassonografia/diagnóstico por imagem. O objetivo é que, em qualquer situação em que um tutor precise de um veterinário, ele encontre no Animagem: clínico geral, dermatologista, nutricionista, ultrassonografista, etc. Exames/diagnóstico por imagem continuam sendo a **prioridade** (é onde o produto nasceu e onde a Dra. Ana Camila, primeira médica parceira, atua), mas não são mais o limite do escopo. Um terceiro papel, **clínica veterinária**, agenda em nome dos próprios clientes ganhando comissão por indicação. Região inicial: Campinas/SP e DDD 19.

**⚠ Isso é mais amplo do que o que o código reflete hoje** — ver nota em §3 (catálogo) e §7. `exames_catalogo`/`medico_exames` só modelam "exame" (nome+duração+preço), sem conceito de especialidade do médico nem de "consulta" (atendimento sem exame de imagem associado); a busca do tutor também assume que se busca por tipo de exame. Antes de expandir o catálogo para outras especialidades, vale mapear com André se o modelo atual (tabela de "exames" com preço/duração) serve para representar uma consulta de nutrição ou dermatologia, ou se precisa de um conceito mais genérico de "serviço"/"atendimento" com uma taxonomia de especialidade por médico.

## 2. Arquitetura real (não a planejada originalmente)

| Camada | Tecnologia real |
|---|---|
| Frontend | **1 arquivo único** `public/index.html` (~2600 linhas: HTML+CSS+JS vanilla inline, sem build step, sem framework) |
| Landing separada | `public/landing.html` — página da Dra. Ana Camila, desconectada do resto do sistema |
| Backend | Supabase (Postgres 17 + Auth + REST + RLS + pg_cron + Storage), projeto `animagem` (`xtmuffomynrwpxswrdvy`) |
| Hosting | Cloudflare Pages (`animagem.pages.dev`), deploy automático a cada push em `main`, publish dir `public/` |
| Repo | `github.com/asouzacoelho/animagem`, branch única `main` |
| Pagamento | **Simulado no frontend** — formulário de cartão/PIX válida formato mas não fala com gateway nenhum ainda |

Não existe build/bundler, não existe backend próprio (toda lógica de servidor mora em triggers e funções `SECURITY DEFINER` do Postgres, chamadas via RPC), não existem Edge Functions deployadas ainda.

### Mapa do frontend (`public/index.html`)

Um único HTML com estado em variáveis JS globais e troca de "telas" via `showView()`/`display:none`. Funções-chave por área:

- **Auth/sessão:** `submitAuth`, `renderAuth`, `refreshProfile`, `renderAuthSlot`, `logout`, `enviarRecuperacao`/`salvarNovaSenha` (reset de senha), `excluirMinhaConta` (LGPD)
- **Portal do tutor (busca + agendamento):** `buscar`, `renderCards`, `openModal`/`renderM` (fluxo de agendamento em passos: `prog`), `getSlotsReais`, `precarregarDadosTutor`, `pagarCC`/`obterOuCriarPet`/`criarAgendamento`
- **Painel do médico:** `initMedico` → sub-telas via `initDashMedico` (dashboard real), `initHistorico`, `initPerfil`/`salvarPerfil`/`salvarDadosBancarios`, `initAgenda`/`carregarDisponibilidade` (toggles de horário), `initExames`/`salvarExame` (preços por dia/fim-de-semana/noturno), `initArea`/`salvarArea` (bairros/cidades atendidas)
- **Painel da clínica:** `initClinica` → `renderCs` (busca médico + agenda em nome do tutor, passos via `prog2`), `verificarTutorExistente` (debounced, usa RPC `clinica_verificar_tutor`), `clinicaCriarAgendamento` (RPC `clinica_criar_agendamento`), `carregarAgendamentosClinica`, `initClinicaPerfil`/`salvarPerfilClinica`
- **Painel admin:** `initAdmin` → navegação por `switchAp(ap)` entre abas `dash`/`medicos`/`clinicas`/`agendamentos`/`patrocinadores`/`bairros`/`comissoes`/`config`; destaques: `loadAdminMedicos`/`toggleMedicoAtivo`/`verDocMedico` (aprovação com doc), `loadAdminClinicas`/`toggleClinicaAtiva`/`verDocClinica` (espelha médico), `marcarComoPago` (stand-in manual de pagamento), `loadAdminDash` (números reais)

## 3. Modelo de dados (schema `public`, todas as tabelas com RLS ativo)

```
profiles (1:1 com auth.users)
  id, role (tutor|medico|admin|clinica), nome, telefone, email, criado_em
  + endereço do tutor: rua, numero, complemento, cep, bairro, cidade, estado

medicos (id = profiles.id)
  crmv, bio, instagram, cidade, estado, antecedencia_min, aceita_fds, aceita_noturno, ativo
medico_exames (medico_id, exame_id) — preco, preco_fim_de_semana, preco_noturno, duracao_min, pre_requisitos
medico_area (medico_id, tipo bairro|cidade, nome, ativo)
medico_disponibilidade (medico_id, dia_semana, hora) — toggle de disponibilidade
medico_onboarding (medico_id) — documento_path, documento_tipo, termos_versao/aceitos_em, status
medico_dados_bancarios (medico_id) — pix/banco/agencia/conta, RLS restrita ao próprio + admin

clinicas (id = profiles.id)
  cnpj, razao_social, nome_fantasia, cidade, estado, comissao_percentual (≤ config_portal.clinica_comissao_teto), ativo
  ⚠ sem endereço próprio (rua/número) — só cidade/estado. Relevante para a ideia de "exame na clínica".
clinica_onboarding (clinica_id) — documentos + cnpj_situacao (via BrasilAPI) + termos, status

pets (tutor_id, nome, especie, raca)
exames_catalogo (nome único, duracao_min, preco_base) — mestre, definido pelo admin
agendamentos — 1 visita (horário+endereço+pet), N exames via agendamento_exames
  tutor_id, medico_id, horario, endereco, pet_id, valor, status, expira_em, clinica_id, origem (portal|clinica), observacoes
agendamento_exames (agendamento_id, exame_id) — preco (=preco_medico+comissao_clinica), preco_medico, comissao_clinica
pagamentos — só backend escreve (nenhuma policy de insert/update para authenticated, de propósito)
comissoes (tipo especialidade|medico, referencia_id, percentual) — hoje sem efeito automático no repasse
patrocinadores (nome, descricao, link, cidade, ativo, ordem) — bloco "conteúdo patrocinado" no portal
bairros (cidade, estado, nome, ativo) — lista própria gerenciável pelo admin (não existe API pública confiável de bairros no Brasil)
config_portal — singleton (id=true): aceitar_novos_medicos, fase_mvp_ativa, email_contato, whatsapp_suporte, clinica_comissao_teto
```

Buckets privados no Storage: `documentos-medicos`, `documentos-clinicas` (RLS: só o próprio dono da pasta `{auth.uid()}/...` e admin).

### Regras de negócio impostas no banco (não confiar no frontend)

- **`is_admin()`** — função `SECURITY DEFINER` usada dentro das próprias policies de RLS pra evitar recursão infinita ao checar `role='admin'`.
- **Preço nunca vem do cliente**: trigger `validar_preco_exame()` recalcula `agendamento_exames.preco_medico` a partir de `medico_exames` (escolhendo preço normal/fim-de-semana/noturno pelo dia/hora do agendamento) e soma `comissao_clinica` (se `origem='clinica'`, % vem de `clinicas.comissao_percentual`); trigger `recalcular_valor_agendamento()` mantém `agendamentos.valor` = soma dos exames.
- **Sem double-booking**: índice único parcial em `(medico_id, horario)` só para status ativo (`reservado|pago|confirmado`).
- **Sem antecedência mínima violada**: trigger `trg_validar_antecedencia_agendamento` bloqueia insert se `horario < now() + medicos.antecedencia_min`.
- **Reserva expira sozinha**: `pg_cron` roda `expirar_reservas_vencidas()` a cada 5 min (reservado + `expira_em` vencido → `expirado`).
- **Médico/clínica só ativa com onboarding aprovado**: triggers `trg_validar_ativacao_medico` / `trg_validar_ativacao_clinica` bloqueiam `ativo=true` sem uma linha `status='aprovado'` na respectiva tabela de onboarding — vale até via SQL direto, não só pela tela do admin.
- **Comissão da clínica tem teto**: trigger `trg_validar_comissao_clinica` valida contra `config_portal.clinica_comissao_teto`.
- **Exclusão de conta (LGPD)**: RPC `solicitar_exclusao_propria()` — exclui de verdade (perfil + `auth.users`) se não há `foreign_key_violation` (sem histórico); se há histórico, anonimiza (nome/telefone/email/CRMV/bio/dados bancários/área) e bane o login (`banned_until` no ano 3000), preservando o registro do atendimento.
- **Visibilidade de dados sensíveis é condicionada a pagamento**: médico só vê `profiles`/`pets` do tutor via policy quando `agendamentos.status in ('pago','confirmado')` — não antes.
- **Funções internas (triggers/cron) não são chamáveis via RPC pública** — `revoke execute ... from public` explícito nelas; só `is_admin()` e as RPCs de frontend (`solicitar_exclusao_propria`, `clinica_criar_agendamento`, `clinica_verificar_tutor`) ficam liberadas para `authenticated`.

## 4. Por papel: o que já existe de verdade

**Tutor:** cadastro com endereço completo (Estado→Cidade via IBGE→Bairro em cascata), busca por exame/cidade/bairro, agendamento em 5 passos (exame → horário → dados pré-preenchidos → pagamento simulado → confirmação), "Minha conta" com exclusão LGPD.

**Médico:** onboarding com CRMV + upload de documento + aceite de 3 termos (bloqueado até admin aprovar), dashboard e histórico com dados reais, agenda por toggle de horário, exames com preço diferenciado (normal/fim de semana/noturno), área de atendimento (bairros/cidades), dados bancários para repasse (ainda sem repasse automático real).

**Clínica** *(papel mais novo, 2026-07-23)*: onboarding espelhando médico (+ verificação automática de CNPJ via BrasilAPI), busca o mesmo catálogo de médicos/horários, preenche dados do tutor+pet, `signInWithOtp` cria/acha a conta do tutor sem Edge Function, RPC `clinica_criar_agendamento` cria o agendamento em nome dele com split de preço correto; tutor recebe magic link e confirma/paga. Dados bancários para repasse da comissão (`clinica_dados_bancarios`, 2026-07-25) espelham o padrão do médico. Endereço do exame hoje é **sempre** o endereço residencial do tutor (não existe opção "na própria clínica" — `clinicas` não tem colunas de endereço próprio; ver `docs/PENDENCIAS.md`).

**Admin:** aprovação de médicos e clínicas (com visualização de documento), visão geral com números reais, gestão de agendamentos (incl. botão manual "Marcar como pago", stand-in temporário), patrocinadores, bairros, comissões (persistidas, sem efeito automático ainda), config geral.

## 5. Nome e marca

Ver [`GUIA_MARCA_INPI.md`](GUIA_MARCA_INPI.md): processo de registro **pausado**, risco real de colisão fonética com marca já registrada "ANIMAGE SAÚDE DE ESTIMAÇÃO" (pedido anterior semelhante foi rejeitado por isso). Domínio de reserva: `animagemvet.com.br` (`animagem.com.br` é de terceiro desde 2017).

## 6. Nota sobre o pivot de escopo (2026-07-25)

O catálogo (`exames_catalogo`, seed original: Ultrassom Abdominal/Gestacional, Ecocardiograma, Ultrassom Ortopédico/Ocular, Raio-X, Eletrocardiograma) e toda a busca do tutor (`buscar()`, `renderCards`) foram desenhados assumindo que o médico oferece "exames" de imagem/diagnóstico. Com o novo posicionamento (qualquer especialidade), isso precisa evoluir.

**Atualizado em 2026-07-25 — o que já mudou vs. o que ainda não mudou:**
- ✅ **Mensagens/copy já corrigidas** (commit "Reescrever mensagens do portal..."): hero, painel "por que agendar", rótulos de busca ("Tipo de atendimento" em vez de "Tipo de exame"), "Meus Atendimentos" (antes "Meus Exames"), termo de aceite do médico (não afirma mais que o modelo é só domiciliar) e da clínica — todos revisados pra não presumir imagem/domiciliar como único formato. `TERMOS_VERSAO` foi incrementada pra `2026-07-25` por causa da mudança no texto de aceite do médico.
- ⚠ **Ainda não mudou (decisão de modelagem pendente):** o schema continua sem conceito de especialidade do médico separado do catálogo de "exames" — cadastrar um médico como "dermatologista" ou "nutricionista" hoje exigiria o admin criar uma entrada tipo "Consulta Dermatológica" na tabela `exames_catalogo`, mecanicamente possível (é só nome+duração+preço) mas nunca testado, e a busca/cards continuam com a linguagem "exame". Não assumir que isso já foi resolvido — é a pendência estrutural mais importante do pivot, ainda sem decisão do André.

## 7. Onde ver o que falta

Pendências técnicas priorizadas: [`PENDENCIAS.md`](PENDENCIAS.md). Dos 3 temas que André priorizou em 2026-07-25 (monitoramento de erros, papel Clínica, marca/identidade): Clínica avançou (dados bancários ✅, tela admin testada ✅, escolha de local do exame ainda pendente); monitoramento de erros **ainda não iniciado**; marca/identidade **travada** no risco de colisão do INPI (ver §5).
