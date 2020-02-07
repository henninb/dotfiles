(setq user-full-name "Brian Henning"
      user-mail-address "henninb@msn.com")

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)


;;(setq inhibit-startup-screen t)
;; disable x - did not work
;(advice-add #'x-apply-session-resources :override #'ignore)

;; disable backup file from being created
(setq make-backup-files nil)

(setq doom-theme 'doom-dracula)

(setq doom-font (font-spec :family "Monofur for Powerline" :size 18))


;; disable xwindows
;; (setq mouse-drag-copy-region nil)

;; disable splash screen and startup message
; (setq inhibit-startup-message t)
; (setq initial-scratch-message nil)

;; not sure if this works
;(setq doom-font (font-spec :family "Mononoki Nerd Font Mono" :size 9))
;(setq doom-font (font-spec :family "Inconsolata" :size 20))

; (ignore-errors
;   (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;         doom-variable-pitch-font (font-spec :family "Noto Sans" :size 13)))

; pick a theme
; (setq doom-theme 'doom-dracula)
;   (def-package! highlight-indent-guides   :commands highlight-indent-guides-mode   :hook (prog-mode . highlight-indent-guides-mode)   :config
; (setq highlight-indent-guides-method 'character highlight-indent-guides-character ?\⇨ highlight-indent-guides-delay 0.01 highlight-indent-guides-responsive 'top highlight-indent-guides-auto-enabled nil))

; (use-package smart-mode-line-powerline-theme
;   :ensure t)

; (use-package smart-mode-line
;   :ensure t
;   :config
;   (setq sml/theme 'powerline)
;   (add-hook 'after-init-hook 'sml/setup))

;(setq doom-theme 'doom-city-lights)
