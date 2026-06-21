# Guia André — o que precisa ser feito fora do sistema

Tudo abaixo é trabalho que **só você pode fazer** (decisões de negócio, pagamentos com cartão pessoal/PJ, assinaturas, contatos humanos). Eu não posso executar nada disso — explico em cada item por quê. Organizado por prioridade real, não por ordem alfabética.

---

## ⚠ Decisão tomada em 2026-06-20: LTDA fica para depois

André decidiu **não abrir a LTDA agora**. Avaliamos usar o MEI da Ana Camila como alternativa, mas não serve para a Animagem como plataforma — MEI não permite a atividade de intermediação/portal (CNAE 6319-4/00 e 7490-1/04) e tem teto de R$81 mil/ano. O MEI dela continua válido **só para os próprios atendimentos dela** como médica, não para a empresa por trás do marketplace.

**Como isso foi resolvido sem travar o projeto:** a comissão da Animagem é 0% na fase MVP (ver tabela de monetização). Como não há dinheiro a reter, **decidimos manter o pagamento simulado no sistema até o CNPJ existir**, em vez de já mudar a arquitetura para pagamento direto tutor→médico. Ou seja: o item 1 abaixo deixa de ser bloqueante imediato — ele só volta a ser urgente quando vocês decidirem ativar comissão (fase pós-MVP) ou formalizar a empresa por outro motivo (ex: o investidor exigir).

---

## 1. Abrir a empresa (LTDA) — pausado por decisão do André em 2026-06-20

**Por que ainda fica registrado aqui:** sem CNPJ, não dá para abrir conta PJ, não dá para abrir conta no gateway de pagamento (Pagar.me), e sem isso o sistema nunca vai processar um pagamento real — por mais que eu evolua o código, essa pendência (a de maior risco no projeto, #4 em `docs/PENDENCIAS.md`) continua dependendo disso quando chegar a hora.

**Como fazer:**
1. Contratar um contador (pode ser remoto — existem serviços como Contabilizei, Agilize, Sirena, ou um contador local de Campinas). Custo de referência: ~R$500–800 de honorário de abertura + ~R$150–250/mês de mensalidade contábil recorrente.
2. Decidir antes de falar com o contador:
   - **Sócios:** só você, ou Ana Camila entra como sócia? (Isso também resolve a "decisão em aberto" antiga do roteiro original sobre a sociedade dela.)
   - **Nome empresarial** e se vai ser `Animagem` mesmo ou outra razão social.
3. CNAEs sugeridos (já estavam no documento original do projeto): `6319-4/00` (portais de internet) + `7490-1/04` (intermediação de serviços).
4. Regime tributário: Simples Nacional é o recomendado para o estágio atual (~6% sobre receita).
5. O contador cuida do registro na Junta Comercial, CNPJ na Receita Federal, inscrição municipal/estadual se aplicável.

**Prazo típico:** 5–15 dias úteis depois de enviar os documentos pedidos pelo contador (RG/CPF dos sócios, comprovante de endereço, definição de capital social).

---

## 2. Conta PJ

**Por que depende do item 1:** todo banco exige CNPJ ativo para abrir conta de pessoa jurídica.

**Como fazer:** depois do CNPJ pronto, abrir conta PJ digital (Inter, Stone, Nubank PJ — todas têm opção gratuita para o porte da Animagem hoje). Leva minutos depois de ter o CNPJ, é 100% pelo app/site do banco.

---

## 3. Conta no Pagar.me (gateway de pagamento)

**Por que depende dos itens 1 e 2:** o Pagar.me (escolhido desde o roteiro original — é subsidiária da Stone, tem split de pagamento nativo, aceita CNPJ recém-aberto, PIX sem taxa e cartão 3,99%) exige CNPJ e dados bancários PJ para te credenciar.

**Como fazer:**
1. Criar conta em https://pagar.me com o CNPJ da Animagem.
2. Completar o processo de KYC (verificação de identidade da empresa — eles vão pedir contrato social, comprovante de conta PJ).
3. Quando aprovado, você vai receber uma **chave de API** (pública e secreta). **Quando tiver essa chave, me avise e me passe a chave pública** — é a partir dela que eu construo a integração real de pagamento (pendência #4), trocando a simulação atual por cobrança de verdade.
4. **Importante:** a chave secreta do Pagar.me nunca deve ir para o frontend (`public/index.html`) — ela vai morar só numa Supabase Edge Function, que eu já vou configurar para isso quando chegar a hora.

**Prazo típico:** o credenciamento de uma conta nova costuma levar de poucos dias a duas semanas, dependendo da análise de risco deles.

---

## 4. Registro de marca no INPI

**Por que importa:** sem isso, qualquer um pode registrar "Animagem" antes de você e te impedir de usar o próprio nome depois que o produto crescer. Não bloqueia nada tecnicamente, mas é risco que cresce com o tempo — quanto mais o produto for visível, mais vale a pena já ter isso resolvido.

**Decisão em 2026-06-20:** André vai fazer a busca e o protocolo ele mesmo, sem despachante. Roteiro completo passo a passo em [`docs/GUIA_MARCA_INPI.md`](GUIA_MARCA_INPI.md) — inclui onde fazer a busca gratuita de disponibilidade, quais classes registrar (44, 42, 35), como pagar a GRU e como acompanhar o processo depois de protocolado.

**Prazo típico:** o registro em si é rápido de protocolar, mas a análise e concessão pelo INPI pode levar de 12 a 24 meses — quanto mais cedo protocolar, melhor, mesmo sabendo que a aprovação é lenta. Como o titular do pedido será o CPF do André (não há CNPJ ainda), depois que a LTDA existir é possível transferir a titularidade da marca para a empresa (averbação de cessão), sem precisar registrar de novo.

---

## 5. Domínio próprio (`animagem.com.br` ou equivalente)

**Por que importa:** hoje o sistema está em `animagem.pages.dev` (provisório). Um domínio próprio passa mais confiança para tutores e médicos, e é pré-requisito para ter e-mail profissional (`contato@animagem.com.br`).

**Como fazer:**
1. Verificar disponibilidade e registrar em https://registro.br (custo: ~R$40/ano).
2. Depois de registrado, me avise — eu mesmo consigo configurar o domínio para apontar para o Cloudflare Pages (isso eu posso fazer, é técnico, especialmente fácil porque já estamos na Cloudflare, que também é gestora de DNS).

**Decisão tomada em 2026-06-21:** `animagem.com.br` está ocupado por terceiro desde 2017 (confirmado via RDAP oficial do Registro.br, sem relação com a empresa) — segue com **`animagemvet.com.br`** (confirmado disponível na mesma consulta). André já decidiu seguir com esse nome, inclusive aceitando que a marca registrada no INPI possa acompanhar essa variação ("Animagem Vet"), a depender da orientação do advogado sobre a pendência de indeferimento (ver `GUIA_MARCA_INPI.md`).

---

## 6. Contrato padrão de parceria com médicos + revisão jurídica dos termos

**Por que importa:** os termos que o médico aceita hoje no cadastro (entendimento do funcionamento, autorização de uso de dados/imagem, forma de pagamento/repasse) **foram escritos por mim, uma IA** — servem como estrutura funcional, mas não têm validade jurídica garantida. Isso é a pendência #7 em `docs/PENDENCIAS.md`.

**Como fazer:**
1. Contratar um advogado (idealmente com experiência em marketplaces/plataformas digitais, ou ao menos em direito do consumidor + LGPD).
2. Levar a esse advogado o texto atual dos termos (estão no código, posso te extrair literalmente se pedir) para revisão/reescrita.
3. Também pedir a ele, na mesma consulta, dois outros itens estruturalmente parecidos:
   - **Política de privacidade** para tutores (consentimento de dados de pet/endereço — pendência #7).
   - **Termos de uso** gerais do portal.
4. Quando tiver o texto final aprovado pelo advogado, me passe — eu atualizo o código (a constante `TERMOS_VERSAO` já está pronta para versionar isso, então dá pra trocar o texto sem perder o histórico de quem aceitou qual versão).

**Prazo típico:** depende do advogado, mas costuma ser semanas, não meses, para um documento desse porte.

---

## 7. Google Workspace (e-mail profissional)

**Por que importa:** hoje o e-mail transacional do sistema (recuperação de senha, e quando eu construir a confirmação de agendamento) sai de um domínio genérico do Supabase. Com domínio próprio + Workspace, fica `naoresponda@animagem.com.br`, mais profissional e com limite de envio mais alto.

**Como fazer:** depende do item 5 (domínio). Depois de ter o domínio, assinar Google Workspace (~R$34/mês/usuário) em https://workspace.google.com.

**Não é urgente agora** — só vira relevante quando formos resolver a pendência #9 (e-mail transacional), e mesmo assim a recomendação técnica ali é usar um provedor dedicado de e-mail transacional (Resend/Postmark), não o Workspace, então este item é mais sobre profissionalizar o e-mail de contato/atendimento do que sobre o sistema em si.

---

## Ordem recomendada (resumo)

| Ordem | Item | Depende de | Desbloqueia |
|---|---|---|---|
| 1 | Abrir LTDA | — | Conta PJ, Pagar.me |
| 2 | Conta PJ | Item 1 | Pagar.me |
| 3 | Conta Pagar.me | Itens 1–2 | Pagamento real no sistema (pendência #4) |
| 4 | Domínio | — | Pode rodar em paralelo com 1–3; desbloqueia e-mail profissional |
| 5 | Advogado: termos + privacidade | — | Pode rodar em paralelo; fecha a pendência #7 |
| 6 | Registro de marca (INPI) | — | Pode rodar em paralelo; protocolar logo, aprovação é lenta |
| 7 | Google Workspace | Item 4 | Não urgente |

Os itens 4, 5 e 6 não dependem um do outro nem dos itens 1–3 — podem (e devem) andar em paralelo enquanto o contador resolve a abertura da empresa, em vez de esperar tudo em fila.
