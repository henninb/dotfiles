;;; package --- my setup
; gem pristine --all
;;; .emacs
(setq user-full-name "Brian Henning"
      ;;; Code: this is my setup
      user-mail-address "henninb@msn.com")

(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

; valid backspace key
(normal-erase-is-backspace-mode 1)

; buffer switching
; (iswitchb-mode 1) ;depricated

; required for bspwm 7/15/2020
;(setq frame-resize-pixelwise t)

(require 'package)

; original
;(setq package-enable-at-startup nil)
;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
;(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Add my elisp path to load-path
;(push "~/.emacs.d/elisp" load-path)
(load-file "~/.emacs.d/elisp/tools.el")

;; order matters in the initialization process.
; (mapc 'load
;       (list
;        "init-settings"
;        "init-completion"
;        "init-csharp"
;        ;; This should come after evil due to performance issues see:
;        ;; https://github.com/noctuid/general.el/issues/180
;        "init-keys"))

(unless (package-installed-p 'evil)
   (package-install 'evil))

(unless (package-installed-p 'erc)
   (package-install 'erc))

(unless (package-installed-p 'eww)
   (package-install 'eww))

(menu-bar-mode 1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
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

; prompt for gpg
; (unless dw/is-termux
;   (setq epa-pinentry-mode 'loopback)
;   (pinentry-start))

; best terminal emulator for me 10/27/2020
(use-package vterm
  :ensure t ;; install package if not installed
  )

; theme
;(use-package spacegray-theme :defer t)
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config))

; smart mode line
;(use-package smart-mode-line-powerline-theme
;  :ensure t)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))


(add-to-list 'default-frame-alist '(font . "monofur for Powerline 12"))
; (set-frame-font "monofur for Powerline 12" nil t)
;(set-face-attribute 'default nil :height 150)

; language support mode
(defun efs/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook (lsp-mode . efs/lsp-mode-setup)
  :init
  (setq lsp-keymap-prefix "C-c l")  ;; Or 'C-l', 's-l'
  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom))

(use-package smart-mode-line
  :ensure t )
;   :config
;   (setq sml/theme 'powerline)
;   (add-hook 'after-init-hook 'sml/setup))

(use-package fish-completion
  :ensure t
  :hook (eshell-mode . fish-completion-mode))

; TODO: how to enable this?
(use-package eshell-syntax-highlighting
  :ensure t
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

(use-package eterm-256color
   :ensure t
   :hook (term-mode . eterm-256color-mode))

; TODO: how to enable this?
; (use-package esh-autosuggest
;   :hook (eshell-mode . esh-autosuggest-mode)
;   :config
;   (setq esh-autosuggest-delay 0.5)
;   (set-face-foreground 'company-preview-common "#4b5668")
;   (set-face-background 'company-preview nil))

(use-package eshell-toggle
  :bind ("C-M-'" . eshell-toggle)
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil))

; send backup files to the temp directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

; added on 10/27/2020
(use-package auth-source
  :ensure t ; install if not already installed
)

; echo "machine irc.libera.chat login <nick> password <password>" >> ~/.authinfo
; echo "machine freebsd.local login <username> password <password> port ssh" >> ~/.authinfo
(setq auth-sources '("/home/henninb/.authinfo"))

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
(setq evil-want-keybinding nil)
 (require 'evil)
   (evil-mode 1)

(use-package evil-collection
  :after evil
  :ensure t ;; install package if not installed
  :custom
  (evil-collection-outline-bind-tab-p nil)
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter
  :ensure t ;; install package if not installed
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

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

(use-package flycheck-kotlin :ensure t)

; (eval-after-load 'flycheck
;   (progn
;     (require 'flycheck-kotlin)
;     (flycheck-kotlin-setup)))

;; M-x package-install RET magit RET
;; git package
(use-package magit
  :ensure t ; install package if not installed
;;  :bind (("C-M-g" . magit-status))
)

(use-package emms
  :ensure t
  :config
    (require 'emms-setup)
    (require 'emms-player-mpd)
    (emms-all) ; don't change this to values you see on stackoverflow questions if you expect emms to work
    (setq emms-seek-seconds 5)
    (setq emms-player-list '(emms-player-mpd))
    (setq emms-info-functions '(emms-info-mpd))
    (setq emms-player-mpd-server-name "localhost")
    (setq emms-player-mpd-server-port "6600")
  :bind
    ("s-m p" . emms)
    ("s-m b" . emms-smart-browse)
    ("s-m r" . emms-player-mpd-update-all-reset-cache)
    ("<XF86AudioPrev>" . emms-previous)
    ("<XF86AudioNext>" . emms-next)
    ("<XF86AudioPlay>" . emms-pause)
    ("<XF86AudioStop>" . emms-stop))

(setq mpc-host "localhost:6600")

(defun mpd/start-music-daemon ()
  "Start MPD, connects to it and syncs the metadata cache."
  (interactive)
  (shell-command "mpd")
  (mpd/update-database)
  (emms-player-mpd-connect)
  (emms-cache-set-from-mpd-all)
  (message "MPD started"))

(global-set-key (kbd "s-m c") 'mpd/start-music-daemon)
; (global-set-key (kbd "C-m c") 'mpd/start-music-daemon)
; (global-set-key [?\s-m c] 'mpd/start-music-daemon)

(defun mpd/kill-music-daemon ()
  "Stops playback and kill the music daemon."
  (interactive)
  (emms-stop)
  (call-process "killall" nil nil nil "mpd")
  (message "MPD Killed!"))
(global-set-key (kbd "s-m k") 'mpd/kill-music-daemon)


(defun mpd/update-database ()
  "Updates the MPD database synchronously."
  (interactive)
  (call-process "mpc" nil nil nil "update")
  (message "MPD Database Updated!"))
(global-set-key (kbd "s-m u") 'mpd/update-database)

; (use-package emms
;     :ensure t
;     :config
;     (require 'emms-setup)
;     (require 'emms-player-mpd)
;     (emms-all)
;     (emms-default-players)
; ;    (setq emms-source-file-default-directory "~/media/")
;       (require 'emms-mode-line)
;   (emms-mode-line 1)
;   (require 'emms-playing-time)
;   (emms-playing-time 1)
; )

; (use-package emms
;   :config
;     (require 'emms-setup)
;     (require 'emms-player-mpd)
;     (emms-all) ; don't change this to values you see on stackoverflow questions if you expect emms to work
;     (setq emms-player-list '(emms-player-mpd))
;     (add-to-list 'emms-info-functions 'emms-info-mpd)
;     (add-to-list 'emms-player-list 'emms-player-mpd)

;     ;; Socket is not supported
;     (setq emms-player-mpd-server-name "localhost")
;     (setq emms-player-mpd-server-port "6600")
;     (setq emms-player-mpd-music-directory "/data/music")
;   )

(use-package super-save
  :ensure t ; install package if not installed
  :defer 1
  :diminish super-save-mode
  :config
  (super-save-mode +1)
  (setq super-save-auto-save-when-idle t))

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

; frogfind.com for web browser
; yeyeye, 'M-x customize-group RET shr' has some handy variables in it.
(setq
 browse-url-browser-function 'eww-browse-url ; Use eww as the default browser
 shr-use-fonts  nil                          ; No special fonts
 shr-use-colors nil                          ; No colours
 shr-indentation 2                           ; Left-side margin
 shr-width 70                                ; Fold text to 70 columns
 eww-search-prefix "https://www.duckduckgo.com")    ; Use another engine for searching


(use-package erc
  :ensure t
  )
;; echo "machine irc.libera.chat login <nick> password <password>" >> ~/.authinfo
(defun start-irc (nick)
  (interactive "sTell me your nick please: ")
  (setq erc-track-shorten-start 8
        erc-kill-buffer-on-part t
        erc-auto-query 'bury
        erc-hide-list '("JOIN" "PART" "QUIT")
        erc-network-hide-list '(("irc.libera.chat" "JOIN" "PART" "QUIT"))
        erc-channel-hide-list '(("#emacs" "JOIN" "PART" "QUIT"))
        erc-rename-buffers t
        erc-autojoin-channels-alist '(("libera.chat" "#emacs" "#freebsd" "#gentoo" "#archlinux" "#haskell" "#xmonad"))
        erc-interpret-mirc-color t
        erc-modules '(autojoin button completion fill irccontrols list match menu move-to-prompt netsplit networks noncommands notifications readonly ring stamp track truncate))
  (erc-tls :server "irc.libera.chat"
           :port 6697
           :nick nick
           :full-name "emacs-user"))


;; ;; IRC works ok
; (use-package auth-source-pass
;    :ensure t
;    :config
;    (auth-source-pass-enable))
;  (use-package erc
;    ; :straight nil
;    :commands (erc)
;    :init
;    (require 'erc-join)
;    (setq erc-autojoin-channels-alist '(("irc.libera.chat" "#haskell", "#emacs" ))
;   erc-hide-list '("JOIN" "PART" "QUIT")
;     erc-autojoin-mode t

;   )
;    (defun irc-connect ()
;      (interactive)
;      (erc-tls
;       :server "irc.libera.chat"
;       :port 6697
;       :nick "henninb"
;       :password ""
;       ; :nick (auth-source-pass-get "login" "irc/libera.chat")
;       ; :password (auth-source-pass-get 'secret "irc/libera.chat")
;       )))



; (use-package erc
;   :custom
;   (erc-autojoin-channels-alist '(("irc.libera.chat" "#archlinux" "#freebsd" "#ubuntu" "#gentoo" "#fedora" "#voidlinux" "#manjaro" "#solus" "#neovim" "#vim" "#emacs" "#xmonad" "#i3" "#bspwm""#scala" "#kotlin" "#python" "#ruby" "#haskell")))
;   (erc-autojoin-timing 'ident)
;   (erc-fill-function 'erc-fill-static)
;   (erc-fill-static-center 22)
;   (erc-autojoin-mode t)
;   (erc-hide-list '("JOIN" "PART" "QUIT"))
;   (erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
;   (erc-lurker-threshold-time 43200)
;   (erc-prompt-for-nickserv-password nil)
;   (erc-server-reconnect-attempts 5)
;   (erc-server-reconnect-timeout 3)
;   (erc-track-exclude-types '("JOIN" "MODE" "NICK" "PART" "QUIT" "324" "329" "332" "333" "353" "477"))
;   :config
;   (add-to-list 'erc-modules 'notifications)
;   ; (add-to-list 'erc-modules 'spelling)
;   (erc-services-mode 1)
;   (erc-update-modules))

; might be useful
; (use-package erc-sasl
;   :after erc
;   :ensure t
;   :config
;   (add-to-list 'erc-sasl-server-regexp-list my/znc-server-regex)
;   (defun erc-login ()
;     "Perform user authentication at the IRC server."
;     (erc-log (format "login: nick: %s, user: %s %s %s :%s"
;                (erc-current-nick)
;                (user-login-name)
;                (or erc-system-name (system-name))
;                erc-session-server
;                erc-session-user-full-name))
;     (if erc-session-password
;       (erc-server-send (format "PASS %s" erc-session-password))
;       (message "Logging in without password"))
;     (when (and (featurep 'erc-sasl) (erc-sasl-use-sasl-p))
;       (erc-server-send "CAP REQ :sasl"))
;     (erc-server-send (format "NICK %s" (erc-current-nick)))
;     (erc-server-send
;       (format "USER %s %s %s :%s"
;         ;; hacked - S.B.
;         (if erc-anonymous-login erc-email-userid (user-login-name))
;         "0" "*"
;         erc-session-user-full-name))
;     (erc-update-mode-line)))

(use-package elfeed
  :ensure t
  :config
  (setq elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory)
        elfeed-show-entry-switch 'display-buffer)
  ; :bind
  ; ("C-x w" . elfeed )
  )

(use-package lsp-haskell
 :ensure t
 :config
 (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
 ;; Comment/uncomment this line to see interactions between lsp client/server.
 ;;(setq lsp-log-io t)
)

; (use-package lsp-haskell
;   :ensure t
; )

(add-hook 'haskell-mode-hook #'lsp)

(use-package haskell-mode
  :ensure t

)

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
 '(eshell-toggle-run-command nil t)
 '(eshell-toggle-size-fraction 3 t)
 '(eshell-toggle-use-projectile-root t t)
 '(haskell-process-type 'stack-ghci)
 '(helm-minibuffer-history-key "M-p")
 '(lsp-ui-doc-position 'bottom t)
 '(package-selected-packages
   '(beacon dired-single fsharp-mode elfeed bongo helm-dired-history helm elpy eval-in-repl json-mode markdown-mode rust-mode haskell-mode emms magit flycheck-kotlin flycheck company which-key crux expand-region smartparens diminish eshell-syntax-highlighting fish-completion doom-modeline doom-themes evil use-package)))
; (add-hook 'haskell-mode-hook #'hindent-mode)
  ; (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
; (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
; (add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

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

(use-package fsharp-mode
 :ensure t
 :mode ".fs[iylx]?\\'")

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

;; newly added on 3/8/2022
(use-package beacon
    :ensure t
    :config
    (setq beacon-mode 1)
    (setq beacon-blink-delay 0.2)
    (setq beacon-blink-duration 0.2)
    (setq beacon-blink-when-point-moves 7)
    (setq beacon-blink-when-window-changes nil)
    (setq beacon-blink-when-window-scrolls nil)
    (setq beacon-color "green")
    (setq beacon-push-mark 5)
    (setq beacon-size 25)
)

; (use-package ccls
;   :ensure t
;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;          (lambda () (require 'ccls) (lsp))))

;; TODO: helm or ivy?
(use-package helm
   :ensure t
)

; (use-package helm-dired-history
  ; :ensure t
; )

 (use-package dired-single
    :ensure t
    :defer t)

(use-package dired-ranger
    :defer t)

(use-package dired-collapse
    :defer t)

; (require 'savehist)
; (add-to-list 'savehist-additional-variables 'helm-dired-history-variable)
; savehist-mode 1)

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

;; Set default connection mode to SSH for tramp
(require 'tramp)
;(setq tramp-verbose 10)
(setq tramp-default-method "ssh")

(add-to-list 'tramp-connection-properties
             (list (regexp-quote "/ssh:user@host:")
                   "remote-shell" "/bin/bash"))

(add-hook 'window-setup-hook 'my-disable-fullscreen)

(defun my-disable-fullscreen ()
  (modify-frame-parameters (selected-frame) '((fullscreen . nil)))
)

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
