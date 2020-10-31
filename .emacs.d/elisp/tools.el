;; remote shell tools

(defvar remote-shell-fav-hosts (make-hash-table :test 'equal)
  "Table of host aliases for IPs or other actual references.")

(defun remote-shell-fav-hosts-map ()
  "Returns the mapping between our simple names of our favorite
hosts and their IP address. If the map is empty, and the function
`remote-shell-fav-hosts-get' has been defined, it calls that
function to populate the map prior to returning it. This may
return an empty map."
  (when (and #'remote-shell-fav-hosts-get
             (hash-table-empty-p remote-shell-fav-hosts))
    (remote-shell-fav-hosts-get))
  remote-shell-fav-hosts)

(defun remote-shell-fav-hosts-get ()
  "My hook to the remote-shell processes in order to connect to
    my OpenStack controller, and create a hashtable of host names as
    the keys, and IP addresses as the values."
  (interactive)
  )

(defun remote-shell-fav-hosts-list ()
  "Simply returns a list of known hosts from the cached map, or
populates it first if it is empty and the
`remote-shell-fav-hosts-get' function has been defined."
  (hash-table-keys (remote-shell-fav-hosts-map)))

(defun remote-shell-tramp-connection (hostname &optional root directory)
  "Return a TRAMP connection string to HOSTNAME. If ROOT is
non-nil, returns an sudo compatible string."
  (when (null directory)
    (setq directory ""))

  ;; The ip address is either the value from a key in our cache, or whatever we pass in:
  (let ((ipaddr (gethash hostname (remote-shell-fav-hosts-map) hostname)))
    (if root
        (format "/ssh:%s|sudo:%s:%s" ipaddr ipaddr directory)
        (format "/ssh:%s:%s"         ipaddr directory))))

(defun remote-shell-buffer-name (hostname &optional command-str default-name)
  "Returns a standard format for our remote shell command buffer
windows based on the HOSTNAME and the COMMAND-STR. Uses
DEFAULT-NAME if specified."
  (cond
   (default-name     default-name)
   (command-str      (let ((command (car (split-string command-str))))
                        (format "*%s:%s*" hostname command)))
   (t                (format "*%s*" hostname))))

(defun remote-shell (hostname &optional root)
  "Start an shell experience on HOSTNAME, that can be an alias to
a virtual machine in the overcloud. With prefix command, opens
the shell as the root user account."
  (interactive
   (list (if #'ido-completing-read
             (ido-completing-read "Hostname: " (remote-shell-fav-hosts-list))
           (completing-read "Hostname: " (remote-shell-fav-hosts-list)))))

  (when (equal current-prefix-arg '(4))
    (setq root t))
  (let ((default-directory (remote-shell-tramp-connection hostname root)))
    (shell (remote-shell-buffer-name hostname))))

(defun remote-shell-command (hostname command
                                      &optional root bufname directory)
  "On HOSTNAME, run COMMAND (if the command ends with &, run
asynchronously). With a `C-u' prefix, run the command as ROOT.
When non-interactive, you can specify BUFNAME for the buffer's
name, and DIRECTORY where the command should run."
  (interactive
   (list (if #'ido-completing-read
             (ido-completing-read "Hostname: " (remote-shell-fav-hosts-list))
           (completing-read "Hostname: " (remote-shell-fav-hosts-list)))
         (read-string "Command: ")))
  (when (equal current-prefix-arg '(4))
    (setq root t))
  (let ((default-directory (remote-shell-tramp-connection hostname root directory)))
    (shell-command command (remote-shell-buffer-name hostname command bufname))))

(defun remote-shell-commands (clients command
                                      &optional root async directory)
  "On each host entry in CLIENTS, run the shell COMMAND,
optionally as ROOT. If ASYNC is non-nil, appends the `&' to the
shell command in order to run it asynchronously. Runs the command
in the default home directory unless DIRECTORY is specified."
  (if async
      (setq command (concat command " &")))
  (dolist (host clients)
    (remote-shell-command host command root nil directory)))

(defun remote-shell-commands-show (clients command)
  "Shows each buffer of a previously executed command. For example:

        (let ((my-favs '(\"pi\" \"contrail-controller\"
                         \"compute\" \"nagios\" \"elk\"))
              (command \"chef-client\"))
          (remote-shell-commands my-favs command t t)
          (remote-shell-commands-show my-favs command))"

  (delete-other-windows)
  (let ((first-time t))
    (dolist (host clients)
      (if (not first-time)
          (split-window-vertically)
        (split-window-horizontally)
        (setq first-time nil))

      (other-window 1)
      (switch-to-buffer (remote-shell-buffer-name host command))
      (balance-windows)
      (sit-for 0.5))))

; (let ((my-favs '("pi")) (command "ls"))
;   (remote-shell-commands t t)
;   (remote-shell-commands-show command))

; (defvar my-global-utility-menu-def
;   '(
;     ("Emacs REPL" . ielm)
;     ("Emacs Edit Init" . (lambda () (find-file user-init-file)))
;     )

; (defun my-global-utility-popup ()
;   "Pop up my menu. Hit RET immediately to select the default item."
;   (interactive)
;   (custom-popup my-global-utility-menu-def "Select: ", 1))

; (global-set-key (kbd "<f12>") 'my-global-utility-popup)

(easy-menu-define my-menu global-map "My server menu"
  '("Servers"
    ("primary"
    ["pi" (my-remote-shell "pi") t]
    ["archlinux" (my-remote-shell "archlinux") t]
    ["silverfox" (my-remote-shell "silverfox") t]
    ["gentoo" (my-remote-shell "gentoo") t]
    )
    ("secondary"
     ["option1" my-obscure-function t]
     )
    ))

(defvar my-number-list
  '("one", "two", "three", "four", "five")
  )

(defun my-menu ()
  (interactive)
  ; (x-popup-menu (list '(200 200) (selected-window)) my-menu)
  (tmm-prompt my-menu)
  )

(global-set-key (kbd "<f12>") 'my-menu)

(defun my-remote-shell (server)
    (interactive)
    (let ((default-directory (format "/ssh:%s:" server)))
      (shell)))

; doesnt seem to work with vterm
(defun pi-shell ()
    (interactive)
    (let ((default-directory "/ssh:pi:"))
      (vterm)))

(defun gentoo-shell()
  (interactive)
  (my-remote-shell "gentoo")
  )

(defun pi-shell-v2()
  (interactive)
  (my-remote-shell "pi")
  )

(defun eshell-there (host)
  (interactive "sHost: ")
  (let ((default-directory (format "/ssh:%s:" host)))
    (eshell host)))
