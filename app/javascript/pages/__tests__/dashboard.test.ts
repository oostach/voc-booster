import simpleF from "../dashboard"

describe('Add function test', () => {
  test('Adding 5 and 3 to be number 8', () => {
    expect(simpleF(5, 3)).toBe(8)
  })
})
