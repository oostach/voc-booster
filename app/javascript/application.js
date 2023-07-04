// Entry point for the build script in your package.json
import '@hotwired/turbo-rails'
import './controllers'
import './pages/dashboard'

document.addEventListener('turbo:load', () => {
  const flashes = document.querySelectorAll('.flash')

  flashes.forEach((flash) => {
    const closeButton = flash.querySelector('.close-button')

    closeButton.addEventListener('click', () => flash.remove())
  })
})
