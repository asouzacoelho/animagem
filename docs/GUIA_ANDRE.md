# Guia André — o que precisa ser feito fora do sistema

Tudo abaixo é trabalho que **só você pode fazer** (decisões de negócio, pagamentos com cartão pessoal/PJ, assinaturas, contatos humanos). Eu não posso executar nada disso — explico em cada item por quê. Organizado por prioridade real, não por ordem alfabética.

Última revisão: 2026-08-09. **Status confirmado com André nesta data: nenhum dos itens abaixo avançou desde a última atualização (2026-06-21/2026-07-25)** — contador, advogado, Pagar.me, domínio e INPI seguem exatamente como descrito. Use este documento como checklist vivo: marque `[x]` conforme for avançando, e me avise a cada marco (documento assinado, conta aprovada, número de processo) para eu atualizar o resto da documentação e destravar a parte técnica correspondente.

## Resumo rápido — por onde começar

| Ordem | Item | Status em 2026-08-09 | Próxima ação imediata |
|---|---|---|---|
| 1 | Abrir LTDA | 🔴 Não iniciado | Escolher/contatar contador (Contabilizei, Agilize, Sirena, ou local) |
| 2 | Conta PJ | 🔴 Bloqueado pelo item 1 | — |
| 3 | Conta Pagar.me | 🔴 Bloqueado pelos itens 1–2 | — |
| 4 | Domínio (`animagemvet.com.br`) | 🟡 Decidido, não registrado | Registrar em registro.br (~R$40/ano, 5 min) |
| 5 | Advogado — termos + privacidade | 🔴 Não iniciado | Buscar advogado com experiência em marketplace/LGPD |
| 6 | Marca no INPI | 🔴 Pausado aguardando advogado | Mesmo advogado do item 5 pode avaliar o indeferimento anterior |
| 7 | Google Workspace | 🔴 Não urgente | Aguardar item 4 |

**Se você só puder fazer uma coisa esta semana:** registrar o domínio (item 4) é a ação mais rápida e sem dependências — 5 minutos, sem precisar de CNPJ nem de decisão jurídica prévia. As duas frentes que realmente destravam o resto do negócio (LTDA e advogado) exigem contato humano e não têm atalho técnico.

---

## ⚠ Decisão tomada em 2026-06-21: Animagem Ltda direto agora; holding fica para quando a 2ª empresa existir de fato

André decidiu **não usar o CNPJ que a Ana Camila já tem** (a "ANA CAMILA VELOSO AUGUSTI LTDA", da prática clínica dela) para a Animagem — separação de risco entre o negócio pessoal dela e o marketplace. A visão de André é ter no futuro um **grupo com várias empresas em segmentos diferentes** (exemplo citado: material de limpeza para piscina) — mas nenhuma delas no ar ainda, a Animagem é a primeira a ser executada de fato.

**Caminho escolhido: abrir só a Animagem Ltda agora, sem holding por cima ainda.** Motivo: manter uma holding hoje significaria pagar mensalidade de contador por uma empresa que não faz nada, e isso atrasaria sem necessidade o que é realmente urgente — a Animagem ter CNPJ próprio para abrir conta PJ e Pagar.me. "Encaixar" a Animagem numa holding **depois** não é um problema grande nem incomum: quando a segunda empresa do grupo existir de fato, o contador cria a holding e os sócios contribuem suas quotas da Animagem Ltda para ela em troca de quotas da holding (operação padrão, não é workaround arriscado).

**Estrutura de destino (futura, não para agora):**

```
[Holding — nome de trabalho sugerido: "Múltiplo Participações Ltda", a criar quando a 2ª empresa existir]
   ├── Animagem Ltda                          (abrir agora, direto, sem holding por cima)
   └── [futura empresa de limpeza de piscina] (só quando esse negócio existir de fato)
```

⚠ **Nota para quando a holding for criada (guardar para o futuro, não agir agora):** holding pura (que só detém participação em outras empresas) geralmente **não pode optar pelo Simples Nacional** — é vedado por lei, independente do faturamento. Na prática tende a não pesar, porque a holding não fatura nada por si (só recebe dividendos das operacionais, que já chegam isentos de imposto) — ficaria no Lucro Presumido. Confirmar com o contador nessa hora, não agora.

---

## 1. Abrir a empresa (Animagem Ltda)

**Status: 🔴 não iniciado.**

**Por que ainda fica registrado aqui:** sem CNPJ, não dá para abrir conta PJ, não dá para abrir conta no gateway de pagamento (Pagar.me), e sem isso o sistema nunca vai processar um pagamento real — por mais que eu evolua o código, essa pendência (a de maior risco no projeto, #4 em `docs/PENDENCIAS.md`) continua dependendo disso quando chegar a hora.

**Como fazer:**
- [ ] Contratar um contador (pode ser remoto — existem serviços como Contabilizei, Agilize, Sirena, ou um contador local de Campinas). Custo de referência: ~R$500–800 de honorário de abertura + ~R$150–250/mês de mensalidade contábil recorrente.
- [ ] Decidir antes de falar com o contador:
   - **Sócios:** só você, ou Ana Camila entra como sócia?
   - **Nome empresarial** e se vai ser `Animagem` mesmo ou outra razão social (`Animagem` ou `Animagem Vet`, a depender do desfecho da marca — ver item 6).
- [ ] Confirmar CNAEs com o contador: `6319-4/00` (portais de internet) + `7490-1/04` (intermediação de serviços).
- [ ] Confirmar regime tributário: Simples Nacional (~6% sobre receita).
- [ ] Enviar ao contador os documentos pedidos (RG/CPF dos sócios, comprovante de endereço, definição de capital social) para ele cuidar do registro na Junta Comercial, CNPJ na Receita Federal, inscrição municipal/estadual se aplicável.

**Prazo típico:** 5–15 dias úteis depois de enviar os documentos.

**Quando terminar, me avise:** o CNPJ ativo é o gatilho para eu te lembrar dos itens 2 e 3 e revisar junto com você o texto final dos termos (item 5) já mencionando a razão social correta.

---

## 2. Conta PJ

**Status: 🔴 bloqueado pelo item 1.**

**Por que depende do item 1:** todo banco exige CNPJ ativo para abrir conta de pessoa jurídica.

**Como fazer:**
- [ ] Depois do CNPJ pronto, abrir conta PJ digital (Inter, Stone, Nubank PJ — todas têm opção gratuita para o porte da Animagem hoje). Leva minutos, é 100% pelo app/site do banco.

---

## 3. Conta no Pagar.me (gateway de pagamento)

**Status: 🔴 bloqueado pelos itens 1–2.** Esta é a peça que destrava a pendência técnica #4 (`docs/PENDENCIAS.md`) — a de maior risco do projeto, já que hoje todo pagamento é simulado.

**Por que depende dos itens 1 e 2:** o Pagar.me (escolhido desde o roteiro original — é subsidiária da Stone, tem split de pagamento nativo, aceita CNPJ recém-aberto, PIX sem taxa e cartão 3,99%) exige CNPJ e dados bancários PJ para te credenciar.

**Como fazer:**
- [ ] Criar conta em https://pagar.me com o CNPJ da Animagem.
- [ ] Completar o processo de KYC (verificação de identidade da empresa — eles vão pedir contrato social, comprovante de conta PJ).
- [ ] Quando aprovado, guardar a **chave de API** (pública e secreta). **Me avise e me passe a chave pública** — é a partir dela que eu construo a integração real de pagamento, trocando a simulação atual por cobrança de verdade.
- [ ] **Importante:** a chave secreta do Pagar.me nunca deve ir para o frontend (`public/index.html`) — ela vai morar só numa Supabase Edge Function, que eu já vou configurar para isso quando chegar a hora.

**Prazo típico:** o credenciamento de uma conta nova costuma levar de poucos dias a duas semanas, dependendo da análise de risco deles.

---

## 4. Domínio próprio (`animagemvet.com.br`)

**Status: 🟡 nome decidido, registro ainda não feito.** É a ação mais rápida deste guia — sem CNPJ, sem advogado, sem dependência de mais ninguém.

**Por que importa:** hoje o sistema está em `animagem.pages.dev` (provisório). Um domínio próprio passa mais confiança para tutores e médicos, e é pré-requisito para ter e-mail profissional (`contato@animagemvet.com.br`).

**Decisão já tomada (2026-06-21):** `animagem.com.br` está ocupado por terceiro desde 2017 (confirmado via RDAP oficial do Registro.br, sem relação com a empresa) — segue com **`animagemvet.com.br`** (confirmado disponível na mesma consulta), inclusive aceitando que a marca registrada no INPI possa acompanhar essa variação ("Animagem Vet"), a depender da orientação do advogado sobre a pendência de indeferimento (ver item 6).

**Como fazer:**
- [ ] Verificar disponibilidade e registrar `animagemvet.com.br` em https://registro.br (custo: ~R$40/ano, cartão ou boleto).
- [ ] Depois de registrado, me avise — eu configuro o domínio para apontar para o Cloudflare Pages (já estamos na Cloudflare, que também é gestora de DNS, então é rápido).

---

## 5. Contrato padrão de parceria com médicos + revisão jurídica dos termos

**Status: 🔴 não iniciado.**

**Por que importa:** os termos que médico e clínica aceitam hoje no cadastro (entendimento do funcionamento, autorização de uso de dados/imagem, forma de pagamento/repasse) **foram escritos por mim, uma IA** — servem como estrutura funcional, mas não têm validade jurídica garantida. Isso é a pendência #7 em `docs/PENDENCIAS.md`.

**Como fazer:**
- [ ] Contratar um advogado (idealmente com experiência em marketplaces/plataformas digitais, ou ao menos em direito do consumidor + LGPD). Pode ser o mesmo profissional que vai avaliar o item 6 (INPI) — vale perguntar se ele atende as duas frentes numa consulta só.
- [ ] Levar a esse advogado o texto atual dos termos (estão no código, posso te extrair literalmente se pedir) para revisão/reescrita.
- [ ] Pedir a ele, na mesma consulta, dois itens estruturalmente parecidos:
   - **Política de privacidade** para tutores (consentimento de dados de pet/endereço — pendência #7).
   - **Termos de uso** gerais do portal.
- [ ] Quando tiver o texto final aprovado pelo advogado, me passe — eu atualizo o código (a constante `TERMOS_VERSAO` já está pronta para versionar isso, então dá pra trocar o texto sem perder o histórico de quem aceitou qual versão).

**Prazo típico:** depende do advogado, mas costuma ser semanas, não meses, para um documento desse porte.

---

## 6. Registro de marca no INPI

**Status: 🔴 pausado desde 2026-06-21, aguardando advogado.** Sem avanço confirmado em 2026-08-09.

**Por que importa:** sem isso, qualquer um pode registrar "Animagem" antes de você e te impedir de usar o próprio nome depois que o produto crescer. Não bloqueia nada tecnicamente, mas é risco que cresce com o tempo — quanto mais o produto for visível, mais vale a pena já ter isso resolvido. Também trava, em cascata: o nome empresarial final da LTDA (item 1) e qualquer material de marketing que assuma "Animagem" como nome definitivo.

**O que já aconteceu:** na busca de disponibilidade, foi encontrado um processo anterior (em nome da CNPJ da Ana Camila, depositado 16/04/2024) **indeferido em 21/10/2025** por colisão fonética com a marca de terceiro já registrada "ANIMAGE SAÚDE DE ESTIMAÇÃO" (Art. 124 XIX da LPI). Por isso o processo está pausado — **não decidir nome alternativo nem reprotocolar sem orientação jurídica.**

**Como fazer:**
- [ ] Levar o caso ao mesmo advogado do item 5 (ou um especialista em propriedade industrial): mostrar o processo indeferido e perguntar se "Animagem" ainda é defensável, se "Animagem Vet"/"Animagem Domiciliar" resolveria a colisão, ou se vale buscar um nome diferente.
- [ ] Com a orientação em mãos, seguir o roteiro passo a passo já pronto em [`docs/GUIA_MARCA_INPI.md`](GUIA_MARCA_INPI.md) (busca, classes 44/42/35, protocolo, pagamento da GRU).
- [ ] Me avisar o número do processo e as classes escolhidas assim que protocolar, para eu guardar isso na documentação do projeto.

**Prazo típico:** o registro em si é rápido de protocolar, mas a análise e concessão pelo INPI pode levar de 12 a 24 meses — quanto mais cedo protocolar (depois de resolvida a questão da colisão), melhor. Como o titular do pedido será o CPF do André (não há CNPJ ainda), depois que a LTDA existir é possível transferir a titularidade da marca para a empresa (averbação de cessão), sem precisar registrar de novo.

---

## 7. Google Workspace (e-mail profissional)

**Status: 🔴 não urgente ainda — depende do item 4.**

**Por que importa:** hoje o e-mail transacional do sistema (recuperação de senha, e quando eu construir a confirmação de agendamento) sai de um domínio genérico do Supabase. Com domínio próprio + Workspace, fica `naoresponda@animagemvet.com.br`, mais profissional e com limite de envio mais alto.

**Como fazer:**
- [ ] Depois de ter o domínio (item 4), assinar Google Workspace (~R$34/mês/usuário) em https://workspace.google.com.

Só vira relevante quando formos resolver a pendência técnica #9 (e-mail transacional de confirmação), e mesmo assim a recomendação técnica ali é usar um provedor dedicado de e-mail transacional (Resend/Postmark), não o Workspace — então este item é mais sobre profissionalizar o e-mail de contato/atendimento do que sobre o sistema em si.

---

## Ordem recomendada e dependências

| Ordem | Item | Depende de | Desbloqueia |
|---|---|---|---|
| 1 | Abrir LTDA | — | Conta PJ, Pagar.me, nome empresarial definitivo |
| 2 | Conta PJ | Item 1 | Pagar.me |
| 3 | Conta Pagar.me | Itens 1–2 | Pagamento real no sistema (pendência técnica #4) |
| 4 | Domínio (`animagemvet.com.br`) | — | Pode fazer **hoje**; desbloqueia e-mail profissional (item 7) |
| 5 | Advogado: termos + privacidade | — | Pode rodar em paralelo; fecha a pendência técnica #7; alimenta o item 6 |
| 6 | Registro de marca (INPI) | Orientação jurídica (pode vir do item 5) | Nome definitivo para item 1 e para o produto |
| 7 | Google Workspace | Item 4 | Não urgente |

Os itens 4, 5 e 6 não dependem um do outro nem dos itens 1–3 — podem (e devem) andar em paralelo enquanto o contador resolve a abertura da empresa, em vez de esperar tudo em fila. **Se a prioridade é reduzir risco jurídico o quanto antes, o item 5 (advogado) é o mais valioso a começar agora**, porque alimenta diretamente tanto os termos de uso (pendência técnica #7) quanto a decisão do item 6 (marca).
