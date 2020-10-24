; gem pristine --all
;;; .emacs
(setq user-full-name "Brian Henning"
      user-mail-address "henninb@msn.com")

(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

; required for bspwm 7/15/2020
;(setq frame-resize-pixelwise t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


(unless (package-installed-p 'evil)
   (package-install 'evil))

;(menu-bar-mode -1)
;(toggle-scroll-bar -1)
;(tool-bar-mode -1)
(blink-cursor-mode 1)

; visual helpers
(global-hl-line-mode +1)
(line-number-mode +1)
(global-display-line-numbers-mode 1)
(column-number-mode t)
(size-indication-mode t)

; disable startup screen
(setq inhibit-startup-screen t)

; disable scratch pad message
(setq initial-scratch-message "")

(setq frame-title-format
      '((:eval (if (buffer-file-name)
       (abbreviate-file-name (buffer-file-name))
       "%b"))))

(setq scroll-margin 0
            scroll-conservatively 100000
                  scroll-preserve-screen-position 1)

(set-frame-font "monofur for Powerline-18" nil t)
;(set-face-attribute 'default nil :height 150)

; theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config))

; smart mode line
(use-package smart-mode-line-powerline-theme
  :ensure t)

; language support mode
(use-package lsp-mode
  :ensure t)

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'powerline)
  (add-hook 'after-init-hook 'sml/setup))

; send backup files to the temp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


; fix the yes no prompts
(fset 'yes-or-no-p 'y-or-n-p)

; reload files during external edits
(global-auto-revert-mode t)

; set tabs to 4 spaces
(setq-default tab-width 4
              indent-tabs-mode nil)

; map kill buffer binding
(global-set-key (kbd "C-x k") 'kill-this-buffer)

; map magit status binding
(global-set-key (kbd "C-x g") 'magit-status)

; auto clean whitespace noise
(add-hook 'before-save-hook 'whitespace-cleanup)

(add-to-list 'default-frame-alist '(fullscreen . maximized))


(use-package diminish
  :ensure t)

;; M-x text-mode
;; M-x python-mode
;; M-x shell-script-mode
(setq-default major-mode 'text-mode)


;; load evil
; (use-package evil
;   :ensure t ;; install the evil package if not installed
;   :init ;; tweak evil's configuration before loading it
;   (setq evil-search-module 'evil-search)
;   (setq evil-ex-complete-emacs-commands nil)
;   (setq evil-vsplit-window-right t)
;   (setq evil-split-window-below t)
;   (setq evil-shift-round nil)
;   (setq evil-want-C-u-scroll t)
;   :config ;; tweak evil after loading it
;   (evil-mode)

; toggle evil mode Ctl-z
 (require 'evil)
   (evil-mode 1)

; smart parens in  emacs
(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (progn
    (require 'smartparens-config)
    (smartparens-global-mode 1)
    (show-paren-mode t)))

(use-package expand-region
  :ensure t
  :bind ("M-m" . er/expand-region))

; useful adons
(use-package crux
  :ensure t
  :bind
  ("C-k" . crux-smart-kill-line)
  ("C-c n" . crux-cleanup-buffer-or-region)
  ("C-c f" . crux-recentf-find-file)
  ("C-a" . crux-move-beginning-of-line))

; keystroke suggestion tool
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode +1))

(use-package company
  :ensure t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook #'global-company-mode))

; Autocomplete and syntax checking
(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; M-x package-install RET magit RET
;; git package
(use-package magit
  :ensure t
;;  :bind (("C-M-g" . magit-status))
)

(use-package emms
    :ensure t
    :config
    (require 'emms-setup)
    (emms-all)
    (emms-default-players)
;    (setq emms-source-file-default-directory "~/media/")
      (require 'emms-mode-line)
  (emms-mode-line 1)
  (require 'emms-playing-time)
  (emms-playing-time 1)
)

(defun toggle-evilmode ()
  (interactive)
  (if (bound-and-true-p evil-local-mode)
    (progn
      ; go emacs
      (evil-local-mode (or -1 1))
      (undo-tree-mode (or -1 1))
      (set-variable 'cursor-type 'bar)
    )
    (progn
      ; go evil
      (evil-local-mode (or 1 1))
      (set-variable 'cursor-type 'box)
    )
  )
)

; (require 'erc-sasl)
; (add-to-list 'erc-sasl-server-regexp-list "irc\\.freenode\\.net")

(use-package erc
  :custom
  (erc-autojoin-channels-alist '(("freenode.net" "#archlinux" "#freebsd" "#ubuntu" "#gentoo" "#fedora" "#voidlinux" "#manjaro" "#solus" "#neovim" "#vim" "#emacs" "#xmonad" "#i3" "#bspwm""#scala" "#kotlin" "#python" "#ruby" "#haskell")))
  (erc-autojoin-timing 'ident)
  (erc-fill-function 'erc-fill-static)
  (erc-fill-static-center 22)
  (erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-threshold-time 43200)
  (erc-prompt-for-nickserv-password nil)
  (erc-server-reconnect-attempts 5)
  (erc-server-reconnect-timeout 3)
  (erc-track-exclude-types '("JOIN" "MODE" "NICK" "PART" "QUIT" "324" "329" "332" "333" "353" "477"))
  :config
  (add-to-list 'erc-modules 'notifications)
  ; (add-to-list 'erc-modules 'spelling)
  (erc-services-mode 1)
  (erc-update-modules))

 ; (setq erc-server-history-list '("irc.freenode.net"
 ;                                 "test.erc.org"
 ;                                 "irc.lugs.ch"))
; (load "~/.emacs.d/.erc-auth")
; ;; C-c e f. connect to freenode
; (global-set-key "\C-cef" (lambda () (interactive)
 ;    (erc :server "irc.freenode.net" :port "6667" :nick "henninb")))

;(global-set-key (kbd "M-u") 'toggle-evilmode)

(use-package haskell-mode
  :ensure t
)

(use-package rust-mode
  :ensure t
)

(use-package markdown-mode
  :ensure t
)

; (use-package kotlin-mode
;   :ensure t
; )

(use-package json-mode
  :ensure t
)

;(use-package eval-in-repl-python
(use-package eval-in-repl
 :ensure t
)

;;C-c C-p
;;; Python support ;;
(require 'python) ; if not done elsewhere
(require 'eval-in-repl-python)
 (add-hook 'python-mode-hook
 '(lambda ()
 (local-set-key (kbd "<C-return>") 'eir-eval-in-python)))
(setq python-shell-completion-native-disabled-interpreters '("python"))

;(eval-in-repl-javascript)
;;python2 -m pip install --user --upgrade virtualenv
;;pip install virtualenv
;;pip3 install virtualenv
;; use elpy mode for python
(use-package elpy
  :ensure t
)

(use-package helm
   :ensure t
)

(use-package ido
   :ensure t
)

; (use-package rtags
;              )
; music player
(use-package bongo
   :ensure t
     :init (progn
    (setq bongo-default-directory "~/media/"
    bongo-confirm-flush-playlist nil
    bongo-insert-whole-directory-trees nil))
)

;; recreates an empty *scratch* buffer if it is killed.
(defun prepare-scratch-for-kill ()
  (save-excursion
    (set-buffer (get-buffer-create "*scratch*"))
    (add-hook 'kill-buffer-query-functions 'kill-scratch-buffer t)))

(defun kill-scratch-buffer ()
  (let (kill-buffer-query-functions)
    (kill-buffer (current-buffer)))
  ;; no way, *scratch* shall live
  (prepare-scratch-for-kill)
  ;; Since we "killed" it, don't let caller try too
  nil)

(prepare-scratch-for-kill)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e1ecb0536abec692b5a5e845067d75273fe36f24d01210bf0aa5842f2a7e029f" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default))
 '(erc-autojoin-channels-alist
   '(("freenode.net" "#archlinux" "#freebsd" "#ubuntu" "#gentoo" "#fedora" "#voidlinux" "#manjaro" "#solus" "#neovim" "#vim" "#emacs" "#xmonad" "#i3" "#bspwm" "#scala" "#kotlin" "#python" "#ruby" "#haskell")))
 '(erc-autojoin-timing 'ident)
 '(erc-fill-function 'erc-fill-static)
 '(erc-fill-static-center 22)
 '(erc-hide-list '("JOIN" "PART" "QUIT"))
 '(erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
 '(erc-lurker-threshold-time 43200)
 '(erc-prompt-for-nickserv-password nil)
 '(erc-server-reconnect-attempts 5)
 '(erc-server-reconnect-timeout 3)
 '(erc-track-exclude-types
   '("JOIN" "MODE" "NICK" "PART" "QUIT" "324" "329" "332" "333" "353" "477"))
 '(package-selected-packages
   '(diminish use-package smart-mode-line-powerline-theme doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; start a server with a pid
(require 'server)
(defun server-start-pid ()
  (interactive)
  (when (server-running-p server-name)
    (setq server-name (format "server%s" (emacs-pid)))
    (when (server-running-p server-name)
      (server-force-delete server-name)))
  (server-start))
