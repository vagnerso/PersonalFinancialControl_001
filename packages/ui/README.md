# @pfc/ui

Interface React compartilhada pelo desktop (`apps/desktop`) e pela web (`apps/web`).

```
src/App.jsx + App.css      componente raiz; recebe `services` e os repassa às telas
src/screens/<Tela>/        telas (.jsx + .css), uma pasta por tela
src/components/            componentes compartilhados entre telas
src/services/              ServicesContext.js (useServices), ServicesProvider.jsx e contratos <entidade>Service.js
src/styles/theme.css       cores e fonte do tema (docs/SCREENS.md §3.5) como variáveis CSS
```

## Acesso a dados

Este pacote **não acessa dados**: nada de SQL, IPC (`window.api`) ou `fetch`. A tela pede o serviço ao contexto:

```jsx
import { useServices } from '../../services/ServicesContext.js'

const { category } = useServices()
const rows = await category.search(filters)
```

Cada contrato fica documentado (JSDoc) em `src/services/<entidade>Service.js`. Cada aplicação cria as implementações e as entrega ao `App`:

```jsx
import App from '@pfc/ui/App.jsx'

<App services={createServices()} />
```

## Importação

Pelo nome do pacote e **com** extensão, porque há `.jsx` e `.css`: `import App from '@pfc/ui/App.jsx'`.

Os comandos rodam na raiz do repositório (`npm run lint`, `npm run format`). Testes de componentes ainda não estão configurados.
