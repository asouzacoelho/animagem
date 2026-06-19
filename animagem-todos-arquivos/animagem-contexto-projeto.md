# ANIMAGEM — Contexto Completo do Projeto
> Documento de continuidade para Claude Projects  
> Última atualização: Junho 2025 | André Coelho

---

## 🎯 O que é o Animagem

**Marketplace digital de ultrassonografia veterinária domiciliar.**

Conecta médicos veterinários autônomos especializados em diagnóstico por imagem a tutores de animais de estimação que precisam de exames sem sair de casa.

**Tagline:** *"Encontre o especialista certo para o seu pet"*

---

## 👤 Quem está por trás

**André Coelho** — Gestor Nacional de Vendas (Boxer Soldas, Campinas SP). Idealizador e desenvolvedor de negócio do projeto.

**Ana Camila V. Augusti** — M.V. Ultrassonografista veterinária. Hospital Veterinário Taquaral, Campinas SP. Médica fundadora e primeira usuária do portal.
- Instagram: @animagem_ac
- Email: animagem_ac@outlook.com  
- WhatsApp: (19) 99518-8335
- Área de atendimento: domiciliar (base Taquaral) + clínicas + DDD 19

---

## 📦 Arquivos gerados (todos disponíveis)

| Arquivo | Descrição |
|---|---|
| `animagem-portal.html` | Portal completo mobile-first: busca de médicos, agendamento 5 passos, pagamento PIX/cartão, painel médico, painel admin |
| `animagem-landing.html` | Landing page da Ana Camila (stand-by) |
| `animagem-admin.html` | Painel admin standalone com mapa Leaflet |
| `animagem-agenda.xlsx` | Planilha modelo Google Sheets (Agenda / Agendamentos / Instruções) |
| `animagem-financeiro.xlsx` | Plano financeiro 24 meses (4 abas) |
| `animagem-area.jsx` | Componente React de gestão de área de atendimento |

---

## 🏗️ Arquitetura atual (protótipo)

**Frontend:** HTML5 + CSS3 mobile-first + JavaScript vanilla  
**Design:** DM Sans + Fraunces (Google Fonts) | Paleta: roxo `#4A2D6E` + verde-sage `#3D7A6A`  
**Mapas:** Leaflet.js  
**Pagamento:** Simulado — pronto para conectar Pagar.me

---

## 🚀 Stack de produção (planejada)

```
Frontend:    React + Vite → Vercel (free tier)
Backend/DB:  Supabase (PostgreSQL + Auth + API REST)
Pagamento:   Pagar.me (filha da Stone) — PIX grátis, cartão 3,99%, split nativo
Auth:        Google Auth (login social para tutores e médicos)
Agenda:      Portal próprio (toggles) + opcional sync Google Calendar
Analytics:   Google Analytics 4
Email:       Google Workspace — @animagem.com.br
Domínio:     animagem.com.br (Registro.br, R$40/ano)
```

---

## 👥 Três perfis de usuário

### 🐾 Tutor
Dono do pet. Acessa o portal público.
- Busca por tipo de exame, especialidade ou cidade/estado
- Vê cards dos médicos com especialidades, preço e disponibilidade
- Agenda em 5 passos: exame → horário → dados → pagamento → confirmação
- Paga via PIX (sem taxa extra) ou cartão de crédito (3,99%)
- Recebe confirmação automática após pagamento

### 🩺 Médico Veterinário
Ultrassonografista autônomo. Painel próprio de gestão.
- Dashboard: agendamentos, receita prevista, slots livres, pendentes
- Agenda: toggles por horário, regras de antecedência mínima (padrão 60 min)
- Meus Exames: lista de exames que realiza + preços
- Área de Atendimento: bairros Campinas + cidades DDD 19 ativáveis/bloqueáveis
- Perfil público exibido no portal

### ⚙️ Admin (André)
Visão consolidada de todo o portal.
- Gestão de médicos cadastrados
- Todos os agendamentos consolidados
- Comissões configuráveis por especialidade e por médico
- Configurações gerais do portal (fase MVP, antecedência padrão, etc.)

---

## 💳 Fluxo de pagamento

```
Tutor paga no portal
    ↓
Dinheiro cai na conta Animagem LTDA (Pagar.me)
    ↓
Portal retém comissão (% configurável por médico/especialidade)
    ↓
Repasse líquido ao médico — todo dia 5 do mês
```

**Importante:** sem pagamento confirmado, não há agendamento. O horário fica reservado por 30 minutos durante o PIX; se não pago, libera automaticamente.

---

## 💰 Modelo de monetização (fases)

| Fase | Período | Modelo | Receita Animagem |
|---|---|---|---|
| MVP | M1–M6 | Zero cobrança | R$ 0 |
| Comissão | M7–M18 | 8–10% por agendamento | R$ 480–2.720/mês |
| Entrada + Comissão | M19+ | Taxa entrada + 12% | R$ 5.616–9.504/mês |

**Break-even projetado: mês 10**  
**Pro-labore administrador: R$ 2.000 (M7) → R$ 5.000 (M19)**

---

## 🗓️ Catálogo de exames (inicial)

| Serviço | Preço ref. | Duração |
|---|---|---|
| Ultrassom Abdominal | R$ 180 | 30–40 min |
| Ultrassom Gestacional | R$ 200 | 30–45 min |
| Ecocardiograma | R$ 280 | 40–50 min |
| Ultrassom Ortopédico | R$ 160 | 25–35 min |
| Ultrassom Ocular | R$ 150 | 20–30 min |
| Raio-X Portátil | R$ 120 | 20–30 min |
| Eletrocardiograma | R$ 140 | 25–35 min |

---

## 🏢 Estrutura jurídica

**Formato:** LTDA (2 sócios ou apenas André)  
**Regime:** Simples Nacional (~6% sobre receita)  
**CNAEs:** 6319-4/00 (portais) + 7490-1/04 (intermediação de serviços)  
**Por que não MEI:** limite R$81k/ano, sem sócios, atividade não permitida

### Passos pendentes (por ordem de prioridade)
1. ☐ Registrar marca ANIMAGEM no INPI — classes 44 + 42 (~R$ 710–1.200)
2. ☐ Contratar contador e abrir LTDA (~R$ 500–800)
3. ☐ Registrar domínio animagem.com.br (R$ 40/ano)
4. ☐ Abrir conta PJ (Stone/Inter — gratuito)
5. ☐ Criar conta Pagar.me com CNPJ
6. ☐ Contratar Google Workspace (R$ 34/mês)

---

## 🛠️ Próximos passos técnicos

### Alta prioridade
1. **Google Apps Script** — script que transforma planilha de horários em API JSON para o portal
2. **Pagar.me API** — substituir simulação por chamadas reais (requer CNPJ)
3. **Supabase** — banco de dados real: tabelas médicos, tutores, agendamentos, pagamentos

### Médio prazo
4. **Google Auth** — login social para tutores e médicos
5. **Vercel deploy** — portal em domínio real
6. **WhatsApp Business API** — notificação automática pós-agendamento

### Longo prazo
7. **App mobile nativo** (React Native) — quando volume justificar
8. **Expansão de especialidades** — raio-x, eletrocardiograma, citologia
9. **Expansão geográfica** — outras cidades e estados

---

## 🔧 Decisões de produto já tomadas

- ✅ **Pagamento obrigatório** para confirmar agendamento (sem pagamento = sem reserva)
- ✅ **Pagar.me** como gateway (filha da Stone, split nativo, aceita MEI/CNPJ)
- ✅ **Split de pagamento**: dinheiro passa pela Animagem, repasse mensal ao médico
- ✅ **Agenda no portal** como padrão (Google Calendar como opção futura, não obrigatório)
- ✅ **Mobile-first**: portal e admin responsivos, navegação inferior no mobile
- ✅ **Antecedência mínima**: 60 minutos (configurável por médico)
- ✅ **PIX sem taxa extra** para o tutor; cartão = taxa de 3,99%
- ✅ **Comissão fase MVP = 0%** — ativa a partir do M7

---

## ❓ Decisões ainda em aberto

- Nome de domínio final: `animagem.com.br` ou `animagemvet.com.br`?
- Ana Camila terá sócietária na LTDA ou será apenas médica parceira?
- Preços dos exames — validar com a Ana Camila
- Bairros e cidades exatas que ela atende
- Foto profissional e bio oficial para o portal
- Contrato padrão de parceria com médicos veterinários

---

## 📐 Design System

```css
--sage:     #3D7A6A  /* verde principal */
--sage-mid: #5A9E8C
--sage-pale:#E6F4F0
--plum:     #4A2D6E  /* roxo principal */
--plum-mid: #7A5AAA
--plum-pale:#F0EAF8
--ink:      #0F0A1A  /* texto escuro */
--cream:    #FAF7F2  /* fundo */
--warm:     #F5F0E8
--mid:      #6A5E7A
--light:    #A89AB8

Fontes: DM Sans (corpo) + Fraunces (display/títulos)
Botões: min-height 50px (mobile touch targets)
Inputs: font-size 16px (evita zoom iOS)
```

---

## 🗺️ Área de atendimento (base)

**Bairros Campinas:** Taquaral (base ★), Cambuí, Bosque, Centro, Guanabara, Nova Campinas, Barão Geraldo, Parque Prado, Alphaville, Sousas, Jardim Chapadão, Cidade Universitária

**Cidades DDD 19:** Valinhos, Vinhedo, Paulínia, Sumaré, Hortolândia, Indaiatuba, Americana, Cosmópolis, Itatiba, Jaguariúna

*Todas ativáveis/bloqueáveis individualmente no painel do médico*

---

## 📊 Custos operacionais (referência)

| Fase | Custo fixo/mês (essenciais) |
|---|---|
| MVP (M1–M6) | ~R$ 310 |
| Crescimento (M7–M18) | ~R$ 1.113 |
| Escala (M19+) | ~R$ 2.938 |

**Investimento inicial:** R$ 3.700–7.500 (dependendo do escopo)

---

*Documento gerado por Claude Sonnet 4.6 em sessão de desenvolvimento Animagem — André Coelho — 2025*
