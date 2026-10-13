// RN-21 Pessoa conforme o tipo
// Origem: TfrmMovement.SearchPerson (forms/fMovement.pas)

export const TypeMovement = Object.freeze({
  REVENUES: 0, // Receita
  EXPENSES: 1, // Despesa
});

export const TypePerson = Object.freeze({
  PROVIDER: 0, // Fornecedor
  CUSTOMER: 1, // Cliente
});

/**
 * Retorna o tipo de pessoa a ser pesquisado para a movimentação.
 * Receita → Cliente; Despesa → Fornecedor.
 * @param {number} typeMovement valor de TYPE_MOVEMENT (0 ou 1)
 * @returns {number} valor de TYPE_PERSON (0 ou 1)
 */
export function personTypeForMovement(typeMovement) {
  switch (typeMovement) {
    case TypeMovement.REVENUES:
      return TypePerson.CUSTOMER;
    case TypeMovement.EXPENSES:
      return TypePerson.PROVIDER;
    default:
      throw new RangeError(`Tipo de movimentação inválido: ${typeMovement}`);
  }
}
