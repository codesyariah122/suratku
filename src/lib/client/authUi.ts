export function initializePasswordToggles(root: ParentNode = document) {
  root.querySelectorAll<HTMLButtonElement>('[data-password-toggle]').forEach((toggle) => {
    toggle.addEventListener('click', () => {
      const inputId = toggle.dataset.passwordToggle
      const input = inputId ? root.querySelector<HTMLInputElement>(`#${inputId}`) : null
      if (!input) return

      const willShow = input.type === 'password'
      input.type = willShow ? 'text' : 'password'
      toggle.textContent = willShow ? 'Tutup' : 'Lihat'
      toggle.setAttribute('aria-label', willShow ? 'Sembunyikan password' : 'Tampilkan password')
    })
  })
}
