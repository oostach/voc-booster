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

addEventListener('beforeunload', (e) => {
  e.preventDefault()

  const csrfToken = document.getElementsByName("csrf-token")[0].content

  fetch('/signout', {
    method: 'GET',
    headers: {
      "X-CSRF-Token": csrfToken
    }
  })
})
