
const simpleF = function(a: number, b: number): number {
  return a + b
}

let message: string = 'Test TypeScript App'
let header = document.createElement('h1')

header.textContent = message
document.querySelector('.root-ts-test')?.appendChild(header)

export default simpleF
