# RottenPotatoes 🍿

Aplicação web desenvolvida em Ruby on Rails para gerenciamento, ordenação e filtragem de um catálogo de filmes, estruturada sob o padrão MVC e gerenciada com boas práticas profissionais de controle de versão (Git/GitHub).

---

## 🚀 Funcionalidades e Aprimoramentos Realizados

Durante o ciclo de desenvolvimento e aprimoramento da aplicação, foram implementadas as seguintes funcionalidades:

1. **Ordenação Dinâmica de Colunas com Destaque CSS:**
   - Adição de links de ordenação nos cabeçalhos por **Título** (`id: 'title_header'`) e **Data de Lançamento** (`id: 'release_date_header'`).
   - Aplicação dinâmica da classe CSS `.hilite` no cabeçalho correspondente para destacar visualmente a coluna ordenada.

2. **Filtragem por Classificação Indicativa (Checkboxes):**
   - Formulário com caixas de seleção (*checkboxes*) para selecionar as classificações desejadas (`G`, `PG`, `PG-13`, `R`, `NC-17`).
   - Botão de submissão com o identificador `id: 'ratings_submit'`.
   - Consulta ao banco de dados via `ActiveRecord`, preservando as seleções marcadas.
   - Compatibilidade total entre filtro e ordenação (as seleções de filtro são mantidas ao ordenar a tabela e vice-versa).

3. **Persistência de Estado (`session`) e Redirecionamento RESTful:**
   - Armazenamento das preferências do usuário no hash `session` do Rails.
   - Redirecionamento automático (`redirect_to`) caso o usuário acesse a rota base `/movies` sem parâmetros, restaurando a visualização configurada anteriormente.
   - Preservação de mensagens do sistema utilizando `flash.keep`.

4. **Gerenciamento de Projeto e Versionamento:**
   - Rastreabilidade de tarefas com **Issues** no GitHub.
   - Isolamento de funcionalidades em **branches de trabalho** específicas (`feature/*` e `docs/*`).
   - Revisão de alterações (*diff*) e integração contínua via **Pull Requests**.

---

## 💻 Como executar o projeto localmente

### 1. Instalar as dependências

```bash
bundle install
```

### 2. Criar e preparar o banco de dados

```bash
bin/rails db:migrate
bin/rails db:seed
```

### 3. Executar a suíte de testes automatizados

```bash
bin/rails test
```

### 4. Iniciar o servidor local

```bash
bin/rails server
```

Acesse no seu navegador: `http://localhost:3000/movies`