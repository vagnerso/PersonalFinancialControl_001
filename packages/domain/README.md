# @pfc/domain

Regras de negócio (RN-xx de `docs/BUSINESS_RULES.md`) e conversões de tipos do legado, em **JavaScript puro**: nada de React, Electron, navegador ou banco. É usado por `@pfc/ui` e pelos apps.

```
src/legacy-types.js          conversões de tipos do banco legado (skill tipos-legado-delphi)
src/rules/<área>/<nome>.js   uma regra por arquivo, com <nome>.test.js ao lado
```

## Importação

Pelo nome do pacote e **sem** extensão, porque o `exports` acrescenta `.js`:

```js
import { … } from '@pfc/domain/legacy-types'
import { … } from '@pfc/domain/rules/<área>/<nome>'
```

## Testes

Vitest, com `describe`/`test`/`expect` importados de `'vitest'`. Na raiz: `npm test`.

Ainda não há regras migradas; o andamento está em [BUSINESS_RULES.md §11](../../docs/BUSINESS_RULES.md#11-status-da-migração).
