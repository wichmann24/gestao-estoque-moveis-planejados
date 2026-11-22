# Gestão de Estoque • Móveis Planejados

Aplicação web para gerenciar fitas, ferragens e pistões.

## O que já está pronto

- Cadastro inicial dos 89 itens da lista fornecida.
- Quantidade atual e estoque mínimo editáveis.
- Entradas e saídas de material.
- Busca por produto e filtro por categoria.
- Histórico de movimentações.
- Interface responsiva para computador e celular.
- Modo local de teste no navegador.
- Integração preparada com Supabase Auth + PostgreSQL + Realtime, com políticas RLS para cada usuário.

## Publicar no GitHub Pages

1. Abra **Settings** deste repositório.
2. No menu lateral, abra **Pages**.
3. Em **Build and deployment**, escolha **Deploy from a branch**.
4. Selecione branch `main` e pasta `/(root)`.
5. Clique em **Save**.
6. Aguarde a publicação aparecer no topo da página Pages.

O endereço esperado é:

`https://wichmann24.github.io/gestao-estoque-moveis-planejados/`

## Ativar banco de dados e sincronização em tempo real

O GitHub Pages hospeda arquivos estáticos. Para que alterações apareçam em outros dispositivos, configure o banco Supabase:

1. Crie um projeto em https://supabase.com.
2. No projeto, abra **SQL Editor > New query**.
3. Cole e execute todo o conteúdo do arquivo `supabase/schema.sql`.
4. Em **Project Settings > API**, copie **Project URL** e **anon/public key**.
5. No GitHub, abra `config.js), clique no lápis e preencha:
   - `SUPABASE_URL` com o Project URL.
   - `SUPABASE_ANON_KEY` com a anon/public key.
6. Salve com **Commit changes** e aguarde o GitHub Pages atualizar.
7. Abra o site, crie uma conta com e-mail e senha e entre com a mesma conta em todos os dispositivos.

Ao primeiro acesso autenticado, o sistema cadastra os 89 itens iniciais na conta. Depois, as quantidades, entradas, saídas e histórico são sincronizados pelo Supabase Realtime.

### Segurança

- A chave `anon/public` foi feita para uso no navegador e pode ficar no arquivo público.
- **Nunca** coloque a chave `service_role` ou qualquer segredo privado no GitHub.
- As tabelas usam Row Level Security (RLS) e os registros são isolados por usuário autenticado.
- Para compartilhar o mesmo estoque entre dispositivos, use a mesma conta da aplicação em todos eles.

## Observação sobre o saldo inicial

As duas linhas originais chamadas "Ponteiras" (43 e 26) foram consolidadas em um único item com saldo 69. Estoque mínimo começa em zero para ser definido conforme a operação.
