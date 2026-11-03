import { describe, test, expect } from 'vitest'
import { formatMoney, parseMoneyInput, toCents } from './legacy-types.js'

describe('parseMoneyInput', () => {
  test('aceita o valor com milhar que o campo formata ao sair (D-12 corrigida)', () => {
    expect(parseMoneyInput('1.500,00')).toBe(150000)
    expect(parseMoneyInput('1.234.567,89')).toBe(123456789)
  })

  test('aceita o que o usuário digita no campo', () => {
    expect(parseMoneyInput('1500')).toBe(150000)
    expect(parseMoneyInput('1500,5')).toBe(150050)
    expect(parseMoneyInput('0,99')).toBe(99)
  })

  test('sem vírgula, o ponto é decimal, como no Delphi (RN-25)', () => {
    expect(parseMoneyInput('10.5')).toBe(1050)
  })

  test('aceita o símbolo R$ e espaços', () => {
    expect(parseMoneyInput('R$ 1.234,56')).toBe(123456)
  })

  test('retorna null para vazio ou inválido; quem chama decide (RN-25 trata como 0)', () => {
    expect(parseMoneyInput('')).toBeNull()
    expect(parseMoneyInput(null)).toBeNull()
    expect(parseMoneyInput('abc')).toBeNull()
    expect(parseMoneyInput('1,234')).toBeNull()
    expect(parseMoneyInput('12,')).toBeNull()
  })
})

describe('formatMoney', () => {
  test('formata como #,##0.00 (RN-25)', () => {
    expect(formatMoney(150000)).toBe('1.500,00')
    expect(formatMoney(0)).toBe('0,00')
    expect(formatMoney(5)).toBe('0,05')
  })

  test('com symbol, usa o prefixo R$ dos totais (RN-60)', () => {
    expect(formatMoney(123456, { symbol: true })).toBe('R$ 1.234,56')
  })

  test('volta para o mesmo valor ao ser lido de novo', () => {
    for (const cents of [0, 1, 99, 100000, 150050, 123456789]) {
      expect(parseMoneyInput(formatMoney(cents))).toBe(cents)
    }
  })
})

describe('toCents', () => {
  test('converte o DOUBLE do banco sem erro de arredondamento', () => {
    expect(toCents(0.1 + 0.2)).toBe(30)
    expect(toCents(1500)).toBe(150000)
    expect(toCents(null)).toBe(0)
  })
})
