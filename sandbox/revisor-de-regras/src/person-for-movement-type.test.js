import { describe, test, expect } from 'vitest';
import { personTypeForMovement, TypeMovement, TypePerson } from './person-for-movement-type.js';

describe('RN-21 Pessoa conforme o tipo', () => {
  test('Receita pesquisa clientes', () => {
    expect(personTypeForMovement(TypeMovement.REVENUES)).toBe(TypePerson.CUSTOMER);
  });

  test('Despesa pesquisa fornecedores', () => {
    expect(personTypeForMovement(TypeMovement.EXPENSES)).toBe(TypePerson.PROVIDER);
  });

  test('tipo inválido lança erro', () => {
    expect(() => personTypeForMovement(2)).toThrow(RangeError);
  });
});
