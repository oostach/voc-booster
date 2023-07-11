
const closeFlashHandler = (): void => {
  const flashes: NodeListOf<Element> = document.querySelectorAll('.flash')

  flashes.forEach((flash) => {
    const closeButton: HTMLElement = flash.querySelector('.close-button')

    closeButton.addEventListener('click', () => flash.remove())
  })
}

export {
  closeFlashHandler
}
