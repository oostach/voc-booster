// Entry point for the build script in your package.json
import '@hotwired/turbo-rails'
import './controllers'
import { closeFlashHandler } from './components/flash'
import './pages/dashboard'

document.addEventListener('turbo:load', () => {
  closeFlashHandler()
})

document.addEventListener('load', () => {
  closeFlashHandler()
})
