# Guia André — o que precisa ser feito fora do sistema

Tudo abaixo é trabalho que **só você pode fazer** (decisões de negócio, pagamentos com cartão pessoal/PJ, assinaturas, contatos humanos). Eu não posso executar nada disso — explico em cada item por quê. Organizado por prioridade real, não por ordem alfabética.

Última revisão: 2026-08-25. **André confirmou nesta data que "Animagem" não vai servir como nome definitivo** — isso reabre os itens 1 (nome empresarial), 4 (domínio) e 6 (marca no INPI), que estavam avançando em cima desse nome. Contador, advogado e Pagar.me seguem como em 2026-08-09. Use este documento como checklist vivo: marque `[x]` conforme for avançando, e me avise a cada marco (documento assinado, conta aprovada, número de processo, nome escolhido) para eu atualizar o resto da documentação e destravar a parte técnica correspondente.

## Resumo rápido — por onde começar

| Ordem | Item | Status em 2026-08-25 | Próxima ação imediata |
|---|---|---|---|
| 0 | **Decidir novo nome** | 🔴 Em aberto — Animagem descartado | Ver seção "Nome do marketplace" abaixo — avaliar candidatos, escolher 1–2 favoritos |
| 1 | Abrir LTDA | 🔴 Não iniciado (nome empresarial depende do item 0) | Escolher/contatar contador (Contabilizei, Agilize, Sirena, ou local) |
| 2 | Conta PJ | 🔴 Bloqueado pelo item 1 | — |
| 3 | Conta Pagar.me | 🔴 Bloqueado pelos itens 1–2 | — |
| 4 | Domínio | 🔴 Pausado — `animagemvet.com.br` não faz mais sentido | Registrar o domínio do nome novo assim que decidido (item 0) |
| 5 | Advogado — termos + privacidade | 🔴 Não iniciado | Buscar advogado com experiência em marketplace/LGPD (mesmo profissional pode avaliar o item 0/6) |
| 6 | Marca no INPI | 🔴 Pausado — decisão de nome (item 0) é pré-requisito | Levar candidatos do item 0 ao advogado junto com o caso do indeferimento anterior |
| 7 | Google Workspace | 🔴 Não urgente | Aguardar itens 0 e 4 |
| 7.5 | Sentry (monitoramento de erros) | 🟡 Código pronto, falta conta | Criar conta grátis em sentry.io e me passar o DSN (ver seção própria abaixo) |

**Se você só puder fazer uma coisa esta semana:** avaliar os candidatos de nome (item 0) é o que mais destrava em cascata agora — sem nome definido, domínio e marca ficam parados. LTDA e advogado continuam exigindo contato humano sem atalho técnico.

---

## 0. Nome do marketplace — "Animagem" descartado, avaliando alternativas

**Status: 🔴 em aberto (2026-08-25).** André confirmou que "Animagem" não serve mais — tanto pelo risco de colisão com a marca já registrada "ANIMAGE SAÚDE DE ESTIMAÇÃO" (que já causou um indeferimento no INPI, ver item 6) quanto porque o nome remete só a "imagem", e o posicionamento mudou pra qualquer especialidade veterinária (ver `docs/CONTEXTO.md` §1).

**O que eu já fiz:** pesquisei candidatos evitando repetir o erro de soar parecido com marcas já existentes no setor pet/veterinário no Brasil. Fiz busca textual (não é o mesmo que a busca oficial do INPI, que só o André/advogado consegue fazer — ver `docs/GUIA_MARCA_INPI.md`), mas já elimina os candidatos obviamente colididos antes de gastar tempo do advogado com eles.

**Descartados por colisão real encontrada (não levar ao advogado):**
- ~~VetLar~~ — marca já em uso, veterinário em domicílio (justamente nosso nicho de origem).
- ~~ConectaVet~~ — app já existente no Brasil com o mesmo conceito (conecta tutor a veterinário).
- ~~PataVet~~ — clínica registrada (CNPJ) em São Paulo com esse nome.
- ~~AchaVet~~ — app já existente, busca/marketplace de veterinários — colisão de nome E de conceito.
- ~~Amparo / AmparoVet~~ — usado por múltiplos hospitais veterinários em várias cidades do Brasil.
- ~~Doutor Pata(s) / Dr. Patas~~ — clínicas já registradas no Brasil e em Portugal.
- ~~Focinho~~ — termo genérico já usado por dezenas de petshops/clínicas locais; baixa distintividade também dificultaria registro exclusivo.
- ~~Petivo~~ — marca já em uso (loja de petiscos naturais); categoria diferente mas mesmo público.
- ~~Petrix~~ — marca já estabelecida ("Petrix Pet" e "Petrix PetCare").
- ~~Curavet~~ — marca brasileira consolidada (terapia celular/células-tronco veterinária, vários estados).
- ~~Pety~~ — já existe como plataforma pet ("Pety Technology JSC", app "A Platform For Pet Lovers").
- ~~Vety~~ — colide com app-jogo existente ("Vety - Vet Simulator Game") e é próximo de "VeteApp" (software brasileiro de gestão de clínica veterinária).
- ~~VetVia~~ — domínio `vetvia.com` já em uso.
- ~~VetHub~~ — dois produtos já usando (testes de intolerância alimentar veterinária e sistema de gestão de clínica).
- ~~PetHub~~ — app já estabelecido internacionalmente ("PetHub" — Airbnb para pets — e "PetHub Brasil").
- ~~VetPonte~~ — foneticamente quase idêntico a "VetPonto", clínica veterinária já registrada em Novo Hamburgo/RS.
- ~~Petryx~~ — nome exato já usado por uma startup de geociência digital.
- ~~EloPet~~ — **já existe**: "Elopet" é uma rede brasileira de descontos e proteção animal, redeelopet.com.br. Mesmo público, colisão real.
- ~~VetGuia~~ / ~~PetGuia~~ — "PetGuia Brasil" já é plataforma brasileira ativa; "Guiavet" (BH) é plataforma de saúde veterinária quase com o mesmo nome invertido; "VetGuia" também existe como clínica em Portugal.
- ~~VetFlow~~ / ~~PetFlow~~ — "Vetflow" (plataforma de anatomia veterinária), "VetFlow Sistema Veterinário" e "PetFlow" (sistema para pet shop e clínica veterinária, petflow.app) — três colisões no próprio setor.
- ~~SoulPet~~ *(2026-11-06, André perguntou)* — **já existe**: "SOULPET PETSHOP E HOSPITAL VETERINÁRIO LTDA" (CNPJ 40.017.777/0001-83, Goiânia) e também "Soul Pet Estética, Banho e Tosa" (zona norte de SP). Dois usos comerciais independentes, ambos no setor pet/veterinário.

### Rodada 12 *(2026-11-06)* — raízes latinas ligadas a cuidado, lealdade e vida animal

Seguindo a linha do SoulVet (raiz com significado + "Vet"), testei raízes latinas do campo semântico de cuidado/guarda/vida animal:

| Candidato | Significado em latim | Resultado |
|---|---|---|
| 🏆 **TutelaVet** / **Tutela** | *tutela* = **guarda, proteção, tutela** (mesma família de *tutor* = protetor). **No Brasil o dono do pet é chamado justamente de "tutor"** — o nome descreve literalmente a relação que o produto intermedeia | ✅ **Nenhuma colisão encontrada.** Vizinhos só de longe: "Tudodvet" (franquia de farmácias veterinárias, RJ — fonética bem distinta) e "Tutor&Pet" (plano veterinário da Unimed, Fortaleza, 2026 — mesma família de ideia, palavra diferente). **Vantagem decisiva sobre o SoulVet: não tem vizinho com o mesmo radical na classe 44** |
| **FidelisVet** / **Fidelis** | *fidelis* = **fiel, leal** — a virtude canina por excelência, raiz de "fidelidade" | ✅ Nenhuma colisão no setor pet brasileiro. O mais próximo é a seguradora portuguesa "Fidelidade" (que tem seguro pet) — palavra diferente, outro país. Atenção: "Fidelis/Fidelidade" é muito usado em marcas financeiras/seguros, então a adjacência existe fora do setor |
| Tutamen | *tutamen* = "aquilo que protege", defesa (latim poético) | ✅ Nada encontrado — totalmente livre, **mas obscuro demais**: ninguém decifra o significado sem explicação, o que anula a vantagem de ter significado |
| ~~Pietas~~ | *pietas* = virtude romana da devoção e do dever afetuoso com quem está sob seus cuidados | 🟡 Livre como "Pietas" (existem "Pieta" x2 e a marca de moda "Piet"), **mas a leitura cotidiana é ruim**: remete a "piedade/pena" e, pior, à *Pietà* (a escultura da mãe com o filho morto) — associação fúnebre péssima para saúde animal |
| ~~FaunaVet~~ / ~~Fauna~~ | *Fauna* = deusa romana da vida animal; fauna = conjunto dos animais | ❌ Mesmo problema do SoulVet, e pior: existe "Veterinária Fauna" ativa (CNPJ desde 2017, CNAE 7500-1/00 — atividade veterinária) e "Fauna Brasil Petshop e Agropecuária" — vizinho direto na mesma classe |
| ~~SalusVet~~ / ~~Salus~~ | *Salus* = deusa romana da saúde e do bem-estar; raiz de "saúde" | ❌ Ocupado duas vezes dentro de saúde animal: salus.vet.br (engenharia biomédica veterinária, produtos cirúrgicos) e uma "Salus" de aditivos para ração animal (participação majoritária comprada pelo grupo francês Avril) |
| ~~Vivax~~ | *vivax* = vivaz, de vida longa | ❌ **Associação péssima em saúde:** *Plasmodium vivax* é a espécie de parasita da malária, e existe uma vacina brasileira chamada "Vivaxin" em ensaio clínico. Descartar |

**Conclusão da rodada:** **TutelaVet** é o achado mais forte desta linha. Entrega o que o SoulVet prometia (raiz latina com significado real, ligada a cuidado) **sem o defeito que o enfraquece** — não existe um "TutelaPet" ou similar na classe 44 para gerar colidência. E tem uma vantagem que nenhum outro candidato tem: o nome usa a palavra que o próprio mercado brasileiro já emprega para o dono do pet ("tutor"), então explica o produto sem precisar de tradução.

**⚠ Caso especial — SoulVet *(2026-11-06)*:** não encontrei nenhuma empresa chamada "SoulVet"/"Soul Vet" no Brasil, e o nome tem uma simetria bonita com a origem do projeto ("soul" = alma em inglês; "alma" em latim é ***anima***, a raiz que inspirou "Animagem" — o mesmo conceito, sem arrastar a colisão antiga). **Mas o risco de registro é maior que o dos outros candidatos:** o "SoulPet" já existente é um **hospital veterinário**, ou seja, mesma classe do INPI (44 — serviços veterinários) que vocês vão pedir. Um examinador pode considerar "SoulVet" × "SoulPet" confundíveis na mesma classe — que é **exatamente o mecanismo que indeferiu o Animagem** (Art. 124 XIX da LPI, proximidade com "Animage Saúde de Estimação"). Se o nome agradar, vale levar essa dúvida específica ao advogado antes de investir nele.

**Candidatos sem colisão aparente na minha busca (ordem de preferência):**

| Candidato | Por quê | Ponto de atenção |
|---|---|---|
| **Vetrix** | Nome inventado, soa moderno/tech, nenhuma marca veterinária brasileira encontrada. Origem do "-trix": sufixo latino de agente (como em "imperatrix"), aparece também no nome de uma tribo celta antiga ("Vetrix/Uetrix") — sem significado negativo; a única referência pop relevante é uma família fictícia no anime Yu-Gi-Oh! | Existem "Vetrix Digital" e "Vetrix Ltd" no Reino Unido (TI/software, fora do Brasil e de outro ramo) — baixo risco, mas checar na busca oficial do INPI antes de se apegar |
| **Zootrix** | Mesmo estilo do Vetrix, "zoo-" comunica "animal" de forma mais ampla que "vet-" (reforça o posicionamento de qualquer especialidade), nenhuma colisão encontrada | Menos testado que Vetrix |
| **VetElo** / **PetElo** | "Elo" = elo/ligação, comunica bem o conceito de marketplace; nenhuma colisão encontrada | Ver aviso sobre "Elo" como marca-mãe isolada em 0.1.2 |
| **VetJunto** / **PetJunto** | "Junto" reforça rede/comunidade; nenhuma colisão encontrada | Menos testados |
| **VetTribo** / **PetTribo** | "Tribo" reforça comunidade/pertencimento; nenhuma colisão encontrada | Menos testados |
| **VetNinho** | "Ninho" remete ao cuidado/lar; sem colisão | **PetNinho já existe** (loja de produtos pet) — só use com "Vet" |
| **PetPonte** | "Ponte" = conexão, mesma família de VetElo/VetJunto; sem colisão | Menos testado |
| Vetzinho | Tom afetivo/brasileiro, sem colisão, fácil de lembrar | Nome descritivo — proteção jurídica mais estreita |
| Vetperto | Comunica a proposta de valor na hora ("vet perto de você"), sem colisão | Mesmo ponto do Vetzinho |
| Vetora *(menor confiança)* | Soa profissional, sem colisão exata | Próxima de "Vetor" (distribuidora do mercado pet em MG) |

**Isso NÃO substitui a busca oficial:** antes de decidir, o André (ou o advogado do item 5) precisa repetir a checagem de verdade em https://busca.inpi.gov.br/pePI/ (passo 1 do `docs/GUIA_MARCA_INPI.md`) para os 1-2 favoritos, e confirmar disponibilidade do domínio `.com.br` em https://registro.br.

**Depois de decidido:** me avise o nome escolhido — eu atualizo `README.md`, `docs/CONTEXTO.md` (§1 e §5), `docs/GUIA_MARCA_INPI.md` e preparo a lista de todo lugar no código/copy que precisa trocar de "Animagem" para o nome novo (é bastante coisa espalhada pelo `public/index.html` e `public/landing.html` — melhor trocar tudo de uma vez).

---

## 0.1. Nome da empresa/holding (separado do nome do produto)

André propôs "Vetrix" como possível substituto pra **"Operix"** (nome cotado pra empresa/holding, não pro produto) — mas isso mistura dois problemas diferentes: **nome de empresa (razão social) e nome de produto (marca) são checagens separadas**, uma não protege a outra. E faz mais sentido a empresa/holding ter um nome neutro, não vinculado a "vet", já que a visão de longo prazo é ela abrigar negócios em segmentos diferentes (ver seção "Decisão tomada em 2026-06-21" abaixo).

**"Operix" já existe como razão social no Brasil** — encontrei ao menos "Operix Soluções Tecnológicas LTDA" registrada (setor de TI). Não impede necessariamente registrar uma "Operix" diferente (Juntas Comerciais controlam duplicidade dentro do mesmo estado, e o ramo entra na análise), mas é um risco real a checar com o contador no item 1.

André também mencionou a ideia original **"Sold.ia"** (trocadilho com "soldados da IA" / "vender IA"). Pesquisei esse padrão — "raiz em português + `.ia`/`.ai`" — e ele está **extremamente saturado** no Brasil:

| Candidato | Resultado |
|---|---|
| **Sold.ia** | Nenhuma colisão direta encontrada — mas ver aviso abaixo sobre o padrão estar saturado |
| ~~Multiplic.ia~~ | Ocupado — "Multiplic.ai" é empresa brasileira de IA ativa e financiada |
| ~~Oper.ia~~ | Ocupado — "Opera.ia" (operaia.com.br) e "Oper IA" (operia.info) |
| ~~Cria.ia~~ | Ocupado — "Cria.AI", scale-up jurídica brasileira consolidada |
| ~~Forja.ia~~ | Ocupado — várias empresas/produtos usando "Forja" (Forja AI, Forja 7, IA Forja RH) |
| ~~Flow.ia~~ | Ocupado — FlowIA (flowia.ia.br), FlowIA Studio, Flow IA (flowia.tec.br), Flow IA Oficial, além do "Flow" de IA do Google |
| ~~Maestro.ia~~ | Ocupado — "Maestro IA" é plataforma brasileira de IA pra marketing/vendas (BRL Labs) |
| ~~Rumo.ia~~ | Ocupado — rumoia.com.br, agentes de IA de vendas (quase o conceito exato pretendido) |
| ~~Galax.ia~~ | Mesma palavra que "Galáxia", já ocupada (ver 0.1.1) |

**Leitura minha:** quase todas as tentativas nesse padrão já estavam ocupadas — é o padrão de naming mais popular entre startups de IA no Brasil agora, então mesmo o "Sold.ia" livre na minha busca merece desconfiança extra.

### 0.1.1. "-ix"/"-tix" e palavras com significado real

| Candidato | Significado | Resultado |
|---|---|---|
| **Genitrix** | Latim: "a que gera/cria", feminino de "genitor" — literalmente **"mãe"**. Em português holding é chamada de **"empresa-mãe"**: o significado bate exatamente com o papel pretendido | ✅ **Nenhuma colisão encontrada em nenhuma rodada** — candidato mais forte de toda a pesquisa |
| **Substrato** | Base/camada sobre a qual algo cresce ou se apoia | ✅ **Nenhuma colisão encontrada** |
| **Nebulosa** | Astronomia: nuvem onde novas estrelas nascem — metáfora de holding que "gera" negócios | ✅ Só um pequeno instituto educacional sem relação ("Instituto Nebulosa Marginal") |
| Âmago *(menor confiança)* | Português: essência mais profunda | 🟡 Já tem uso comercial (Âmago Assessoria, Âmago Capital, Amago Negócios Digitais) |
| Sinfonia *(inconclusivo)* | Harmonia de várias vozes tocando juntas | 🟡 Busca não conclusiva — tratar como não testado, não como livre |
| ~~Radix~~ | Latim: "raiz/origem" | ❌ 2 "Radix Holding LTDA" registradas + "Radix Engenharia" (global, 30+ países) |
| ~~Vertix~~ | Vértice/ponto de encontro | ❌ 3 marcas brasileiras ativas (beleza, radiocomunicação desde 1989, cloud) |
| ~~Victrix~~ | Latim: "vencedora" | ❌ Existe literalmente "Victrix Consultoria e Participações LTDA" (holding) + Victrix Capital |
| ~~Salix~~ | Latim: salgueiro | ❌ "Salix Group Investimentos e Participações S.A" (holding), Salix Tributária, Salix Engenharia |
| ~~Calyx~~ | Cálice da flor | ❌ "Calyx Agro Brasil" e "Calyx Agropecuária" |
| ~~Nutrix~~ | Latim: "a que nutre" | ❌ Maior distribuidora de food service do Brasil |
| ~~Maestrix~~ | "Maestro" + "-trix" (variação moderna, sem raiz clássica) | ❌ Pior colisão: "Maestrix — Soluções em IA e Automação" (brasileira, **mesmo ramo**) + "Maestrix.ai" internacional |
| ~~Maestria~~ | Domínio/excelência num ofício | ❌ Existe "Maestria Hub de Soluções Financeiras" (hubmaestria.com) |
| ~~Sinergia~~ / ~~Sinergix~~ | Efeito conjunto maior que a soma das partes | ❌ "Sinergia Empreendimentos e Participações" (holding desde 2001); "SINERGIX Contabilidade, RH e Treinamentos" |
| ~~Criatix~~ | "Criar/criativo" + "-tix" | ❌ "Criatix Comunicações Ltda" desde 1991 (SP) + vizinhança lotada (CreatiX, Creat.X, Criatizy) |
| ~~Vantix~~ / ~~Fortix~~ | Vantagem / força | ❌ Vantix Tecnologia (cibersegurança desde 2003); Fortix usado por 3 marcas diferentes |
| ~~Nexix~~ | Nexo/conexão | 🟡 Sem colisão exata, mas vizinhança concorrida (Nexa, Nexx, Nexxees, Nex Group Participações) |
| ~~Cerne~~ | Núcleo essencial | ❌ "Cerne Holding" é uma holding brasileira real, estabelecida, com participações em energia |
| ~~Constelação~~ | Grupo de estrelas | ❌ "Constelação Participações" + "Constellation Investimentos e Participações" (ANBIMA) |
| ~~Galáxia~~ | Conjunto de estrelas | ❌ Galáxia Marítima, Galaxia Navegação, AgroGalaxy Participações (holding) |
| ~~Concórdia~~ | Harmonia (deusa romana) | ❌ Várias "Concórdia Participações" já são holdings reais |
| ~~Ágora~~ | Grego: a praça-mercado da Grécia antiga (significado ideal pra marketplace) | ❌ Ágora Investimentos (Bradesco, desde 1993), Agora Tecnologia (30 anos), Agora Marcas, Agora Distribuidora |

**Padrão confirmado em ~25 palavras testadas:** qualquer palavra com significado óbvio e positivo pra uma holding (vitória, harmonia, sinergia, raiz, núcleo) **já está ocupada, frequentemente por outra holding de verdade** — é exatamente a primeira coisa que qualquer advogado ou agência de naming também tentaria. Os sobreviventes (Genitrix, Substrato, Nebulosa) têm em comum vir de palavras menos óbvias no vocabulário de negócios.

### 0.1.2. Estrutura marca-mãe + família de produtos (ideia do André)

André propôs: a empresa se chamar **Flow.ia** e dentro dela nascerem produtos por segmento profissional — **VetFlow** (veterinários), **VendFlow** (representantes comerciais), etc. **A estrutura é boa** (marca-mãe + família com palavra compartilhada é exatamente como Salesforce, Zoho e Adobe organizam portfólio), **mas a palavra "Flow" não serve**: Flow.ia está ocupado por várias empresas de IA brasileiras, e VetFlow/PetFlow já existem **dentro do próprio setor veterinário**.

Testei outras palavras de processo pra ocupar o lugar do "Flow" (Giro, Fácil, Prumo, Trilho, Rota) — todas descartadas. A única com detalhe preservado: ~~Rota~~ — "ROTAVET" (Rota Serviços Veterinários, SC) e Rota Distribuidora (atende segmento pet/veterinário). *(Os detalhes das outras se perderam num reset de ambiente; se alguma voltar a interessar, vale refazer a conferência.)*

**Lição:** qualquer palavra curta, positiva e ligada a "fluxo/processo/facilidade" — em português ou inglês — é a primeira que todo mundo escolhe, então já está ocupada, e frequentemente **já ocupada dentro do próprio setor veterinário**.

⚠ **Cuidado sobre "Elo"**: como marca-mãe isolada, "Elo" colide com a **Elo (bandeira de cartão)**, uma das maiores marcas de pagamento do Brasil — e o produto processa pagamento, então o risco de confusão é real. "VetElo" como nome de produto segue viável; "Elo" sozinho como marca-mãe, não.

### 0.1.3. 🏆 A proposta mais forte para a estrutura: **Teca**

| Candidata | Significado | Resultado |
|---|---|---|
| 🏆 **Teca** | Duplo: (1) **"-teca"** vem do grego *thēkē* = "lugar onde algo é guardado/reunido" — é o sufixo de bibli**oteca**, disc**oteca**, vide**oteca**, pinac**oteca**, brinqued**oteca**. Qualquer brasileiro lê "X-teca" instantaneamente como "o lugar onde se reúne X". (2) "Teca" sozinha também é palavra real: madeira nobre e durável (teak) | ✅ **Nada encontrado** para VetTeca, VendTeca, Teca.ia, MedTeca, AdvTeca nem ContaTeca. A palavra isolada só aparece em negócios pequenos de setores distantes (Teca Brasil = pisos náuticos; Teca Automóveis = concessionária). Nenhuma empresa de tecnologia/software/IA com esse nome |
| Seiva | A seiva que circula e leva vida à planta inteira | 🟡 "VetSeiva" livre, mas a palavra isolada já tem vários usos (Grupo Seiva, Seiva Ambiental, Seiva Brazilis desde 1992, Vita Seiva) — serve como palavra de produto, fraca como marca-mãe |
| Farol | Farol que orienta a navegação | 🟡 "VetFarol" livre, mas a palavra isolada é muito usada (Farol Marcas e Patentes, Dr Farol, Farol Soluções, Farol Algodão desde 1911, Farol Marketing) |
| ~~Rumo~~ | Direção/curso | ❌ Colisão tripla: **"rumo.ia" existe literalmente** (agentes de IA de vendas), Grupo Rumo (logística ferroviária, listada) e Rumo Nutrição Animal (setor veterinário) |

**Sistema completo com "Teca":**

```
Marca-mãe:  Teca  (ou Teca.ia)
   ├── VetTeca    — veterinários  (substitui o Animagem)
   ├── VendTeca   — representantes comerciais
   ├── MedTeca    — médicos
   ├── AdvTeca    — advogados
   └── ContaTeca  — contadores
```

⚠ **Dois pontos a verificar antes de fechar:** (1) a família "-tec" (sem o "a") é concorrida no Brasil — MedTec, Itautec, Contec — então cada produto novo precisa de uma conferida rápida contra o equivalente "-tec"; (2) em inglês, "vet tech" é o termo padrão para técnico/auxiliar veterinário, então "VetTeca" pode ter essa leitura secundária para ouvido anglófono (não é problema no mercado brasileiro, mas vale saber).

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
   - **Nome empresarial**: `Animagem` foi descartado (ver item 0) — decidir isso antes de falar com o contador, senão ele registra a empresa com um nome que já sabemos que vai trocar.
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

## 4. Domínio próprio

**Status: 🔴 pausado em 2026-08-25 — a decisão de 2026-06-21 (`animagemvet.com.br`) não vale mais, porque "Animagem" foi descartado (ver item 0).** Antes era a ação mais rápida deste guia; agora depende do item 0.

**Por que importa:** hoje o sistema está em `animagem.pages.dev` (provisório). Um domínio próprio passa mais confiança para tutores e médicos, e é pré-requisito para ter e-mail profissional.

**Contexto da decisão antiga:** `animagem.com.br` está ocupado por terceiro desde 2017 (confirmado via RDAP oficial do Registro.br) — por isso a reserva tinha sido `animagemvet.com.br`, hoje descartada junto com o nome.

**Como fazer (assim que o nome novo estiver decidido):**
- [ ] Verificar disponibilidade e registrar o domínio `.com.br` do nome escolhido em https://registro.br (custo: ~R$40/ano, cartão ou boleto) — já entra como parte da avaliação de candidatos do item 0.
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

**Status: 🔴 pausado desde 2026-06-21. Em 2026-08-25, André confirmou que não vai insistir em "Animagem"** — a colisão abaixo foi justamente o que motivou descartar o nome (ver item 0), então a pergunta pro advogado deixa de ser "Animagem ainda é defensável?" e passa a ser "os candidatos novos têm risco parecido?".

**Por que importa:** sem registro, qualquer um pode registrar o nome escolhido antes de você e te impedir de usar depois que o produto crescer. Não bloqueia nada tecnicamente, mas é risco que cresce com o tempo. Também trava, em cascata: o nome empresarial final da LTDA (item 1) e qualquer material de marketing.

**O que já aconteceu:** na busca de disponibilidade, foi encontrado um processo anterior (em nome da CNPJ da Ana Camila, depositado 16/04/2024) **indeferido em 21/10/2025** por colisão fonética com a marca de terceiro já registrada "ANIMAGE SAÚDE DE ESTIMAÇÃO" (Art. 124 XIX da LPI).

**Como fazer:**
- [ ] Decidir o nome novo primeiro (item 0).
- [ ] Levar o(s) candidato(s) escolhido(s) ao mesmo advogado do item 5 (ou um especialista em propriedade industrial) para confirmar que não repetem o mesmo tipo de colisão.
- [ ] Com a orientação em mãos, seguir o roteiro passo a passo já pronto em [`docs/GUIA_MARCA_INPI.md`](GUIA_MARCA_INPI.md) (busca, classes 44/42/35, protocolo, pagamento da GRU).
- [ ] Me avisar o número do processo e as classes escolhidas assim que protocolar, para eu guardar isso na documentação do projeto.

**Prazo típico:** o registro em si é rápido de protocolar, mas a análise e concessão pelo INPI pode levar de 12 a 24 meses — quanto mais cedo protocolar (depois de resolvida a questão da colisão), melhor. Como o titular do pedido será o CPF do André (não há CNPJ ainda), depois que a LTDA existir é possível transferir a titularidade da marca para a empresa (averbação de cessão), sem precisar registrar de novo.

---

## 7.5. Sentry (monitoramento de erros) — 5 minutos, sem dependências

**Status: 🟡 código já pronto (2026-08-25), só falta a conta.** Hoje se algo quebra pra um usuário no site, ninguém fica sabendo até ele reclamar. O `public/index.html` já está preparado pra mandar esses erros automaticamente pra um painel — só falta você criar a conta gratuita e me passar uma chave.

**Como fazer:**
- [ ] Criar conta grátis em https://sentry.io.
- [ ] Criar um projeto novo, plataforma **Browser JavaScript**.
- [ ] Ir em **Settings → Client Keys (DSN)** do projeto, copiar o valor (algo como `https://xxxx@xxxx.ingest.sentry.io/xxxx`).
- [ ] Me passar esse DSN — eu colo na constante `SENTRY_DSN` (já existe pronta no código, hoje vazia) e o monitoramento liga sozinho.

**Custo:** plano free do Sentry cobre um volume de eventos de erro bem acima do que esse projeto deve gerar nessa fase.

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
