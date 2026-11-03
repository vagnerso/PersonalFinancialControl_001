# desktop

Aplicação desktop (Electron) do Personal Financial Control. Foi criada a partir do template [electron-vite](https://electron-vite.org) (`@quick-start/electron`, variante `react` em JavaScript) e faz parte do monorepo da raiz.

As telas e as regras de negócio **não ficam aqui**. Elas estão nos pacotes compartilhados com a aplicação web: `@pfc/ui` (`packages/ui/`) e `@pfc/domain` (`packages/domain/`). Aqui fica só o que é específico do desktop:

```
src/main/                   processo principal: janela, handlers IPC
src/main/database.js        conexão única com o banco de dados
src/preload/                ponte segura entre main e renderer (contextBridge)
src/renderer/index.html     página carregada pela janela
src/renderer/src/main.jsx   monta o App de @pfc/ui, passando os serviços do desktop
src/renderer/src/services/  createServices(): implementa os contratos de @pfc/ui/services via IPC
electron.vite.config.mjs    build e dev (electron-vite)
electron-builder.yml        empacotamento (ferramenta ainda não confirmada)
build/, resources/          ícones e recursos do instalador e da janela
scripts/                    copy-dev-database.mjs: cria a cópia do banco para desenvolvimento
dev-data/                   cópia do banco para desenvolvimento (fora do git e do instalador)
```

A entrada do renderer só faz isto:

```jsx
<App services={createServices()} />
```

O `App` de `@pfc/ui` repassa os serviços às telas pelo `ServicesProvider`, e cada tela os obtém com `useServices()`. Hoje, `createServices()` devolve um objeto vazio, porque nenhum contrato de serviço foi implementado.

Os pacotes `@pfc/*` ficam em `devDependencies`. Assim, o electron-vite embute o código deles no bundle, e o instalador não precisa copiá-los como dependências.

## Banco de dados

O processo principal abre o banco com o `better-sqlite3` ao iniciar o app e fecha ao sair ([src/main/database.js](src/main/database.js)). As telas ainda não leem dados: faltam os handlers IPC, o preload e os serviços.

| Onde roda | Arquivo aberto |
|---|---|
| Desenvolvimento | `apps/desktop/dev-data/PersonalFinancialControl`, criado por `npm run db:dev-copy` |
| Empacotado | `PersonalFinancialControl` na pasta de dados do usuário (`%APPDATA%\desktop\`) |

- O app em desenvolvimento nunca abre `database/PersonalFinancialControl`, que é o banco do Delphi.
- A `dev-data/` guarda dados reais. Ela fica fora do git e do instalador.
- Se o arquivo não existir, o app mostra uma mensagem de erro e encerra. O banco nunca é criado vazio.
- A conexão desliga a verificação de FK (`foreign_keys = OFF`), que o `better-sqlite3` liga por padrão, para manter o comportamento do legado (D-14).
- Como levar os dados reais para a pasta do app instalado ainda não foi definido.

## Comandos

Rode **na raiz do repositório**, não nesta pasta, porque as dependências são instaladas pelo npm workspaces:

```bash
npm install             # instala tudo (inclui o binário do Electron)
npm run db:dev-copy     # cria a cópia do banco; para substituí-la: npm run db:dev-copy -- --force
npm run dev:desktop     # modo de desenvolvimento, com recarga automática
npm run build:desktop   # build de produção em apps/desktop/out/
npm run lint            # ESLint de todo o monorepo (a configuração fica na raiz)
```

ESLint, Prettier, `.editorconfig` e as configurações do VS Code (incluindo a depuração "Debug All") ficam na raiz e valem para todo o monorepo.

Os scripts `build:win`, `build:mac` e `build:linux` (electron-builder) vieram do template. A ferramenta de empacotamento ainda não foi confirmada; veja o CLAUDE.md.

## Observações

- O Electron está fixado na versão exata (`44.7.2`) no `package.json`. O electron-builder exige isso quando o Electron fica no `node_modules` da raiz.
- Se `npm run dev:desktop` falhar com `Cannot read properties of undefined (reading 'isPackaged')`, a variável `ELECTRON_RUN_AS_NODE` está definida no terminal. Remova-a com `Remove-Item Env:ELECTRON_RUN_AS_NODE` (PowerShell) ou `unset ELECTRON_RUN_AS_NODE` (bash).
