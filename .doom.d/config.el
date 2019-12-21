;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(advice-add #'x-apply-session-resources :override #'ignore)

;; disable backup files
(setq make-backup-files nil)

;; disable xwindows
(setq mouse-drag-copy-region nil)

;; disable splash screen and startup message
; (setq inhibit-startup-message t)
; (setq initial-scratch-message nil)
