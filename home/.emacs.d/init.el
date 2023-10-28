;; Manage packages
;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                        ;; This package archive is outdated
                        ;; ("org" . "https://orgmode.org/elpa/")
                        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-contrib org-roam diff-hl flycheck vertico company-box xref company company-mode cmake-mode which-key use-package rainbow-delimiters org-bullets lsp-ui lsp-treemacs lsp-pyright ivy-rich helpful general evil-collection counsel-projectile command-log-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; "Sane defaults"
;; Disable UI clutters
(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(menu-bar-mode -1)          ; Disable the menu bar
; (set-fringe-mode 10)        ; Give some breathing room
;; Font
(set-face-attribute 'default nil :font "ComicShannsMono Nerd Font" :height 132)
;; Theme
(load-theme 'tango t)
;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Backup files
(setq make-backup-files nil) ; stop creating ~ files
;; Recovery files
(setq auto-save-default nil) ; stop creating #...# files

;; Logging key events
(use-package command-log-mode
  :commands command-log-mode)


;; Line numbers
;; Load the built-in line-number mode
(column-number-mode)
(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
            term-mode-hook
        shell-mode-hook
            eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))



;; Bracket coloring for Lisp
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


;; Ivy
(use-package ivy
  ;; :diminish  ;; hide the minor mode from mode line
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))
;; Provide useful descriptions in ivy minibuffers
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
     ("C-x b" . counsel-ibuffer)
     ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  (counsel-mode 1)
  (setq ivy-initial-input-alist nil))  ;; don't start searches with ^


;; Better help
(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))


;; Project management
(use-package projectile
  :config (projectile-mode)
  ;; :bind-keymap ("<leader>g" . projectile-command-map)
  :init
  (setq projectile-project-search-path '(
                                         "~/dev/personal"
                                         "~/dev/orcl"
  ))
)

(use-package counsel-projectile
  :config (counsel-projectile-mode))

;; Key-bindings
;; Which-key
(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))
;; Set keys
;; Some useful resources:
;; https://github.com/noctuid/evil-guide#bare-minimum-emacs-knowledge
(use-package evil
  :after (projectile)
  :init
  ;; use ctrl-h + v to view what each option does
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)  ;; not turning on evil for other modes
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  ;; set leader key in normal state
  ; (evil-set-leader 'normal (kbd "SPC"))
  ;; set local leader
  ; (evil-set-leader 'normal "," t)
  ;; keybindings
  ;; projectile & counsel
  ; (evil-define-key 'normal 'global (kbd "<leader>fp") 'projectile-switch-project)
  ; (evil-define-key 'normal 'global (kbd "<leader>ff") 'projectile-find-file)
  ; (evil-define-key 'normal 'global (kbd "<leader>fg") 'counsel-projectile-rg)
  ; (evil-define-key 'normal 'global (kbd "<leader>fb") 'counsel-buffer-or-recentf)
  ;; lsp
  ; (evil-define-key 'normal lsp-mode-map (kbd "d") 'lsp-find-definition)
  ; (evil-define-key 'normal lsp-mode-map (kbd "t") 'lsp-find-type-definition)
)
;; Sane evil config for a lot of modes
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
;; Key-mapping utility
(use-package general
  :config
  (general-evil-setup t)
  (general-create-definer my-leader-def
     :states '(normal visual motion emacs insert)
     :prefix "SPC")
  (general-create-definer my-local-leader-def
    :states '(normal visual motion emacs)
    :prefix ",")
  (my-leader-def
    :states '(normal visual)
    :keymaps 'override
    "ff" 'projectile-find-file
    "fg" 'counsel-projectile-rg
    "fp" 'projectile-switch-project
    ;; org-roam
    "of" 'org-roam-node-find
    "oi" 'org-roam-node-insert
    "oo" 'org-roam-buffer-toggle
    )
  (general-nmap
    :keymaps 'override
    "]e" 'flymake-goto-next-error
    "[e" 'flymake-goto-prev-error
    "]c" 'diff-hl-next-hunk
    "[c" 'diff-hl-previous-hunk
  )
  ;; (my-leader-def
  ;;   :states '(normal visual)
  ;;   :keymaps 'override
  ;;   "gd" 'lsp-find-definition
  ;;   "gt" 'lsp-find-type-definition
  ;; )
)


;; Org-mode
;; This is the nongnu version
(use-package org-contrib
  :config
  (setq org-ellipsis " ▾"           ;; modify default ellipsis marker (...)
        org-hide-emphasis-markers t ;; hide emphasis markers
  )
)
;; bullet
(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :init
  (add-hook 'org-mode-hook
      (lambda ()
        (toggle-truncate-lines nil) ))
)
;; org-roam
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/dev/personal/org-notes")
  :config
  (org-roam-setup)
)


;; LSP
;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   ;; :init
;;   ;; (setq lsp-keymap-prefix "C-l")
;;   ;; (setq lsp-diagnostics-provider :none) ;; disable flymake spell-checking
;;   :config
;;   (lsp-enable-which-key-integration t))
;; ui
;; (use-package lsp-ui
;;   :hook (lsp-mode . lsp-ui-mode)
;; )
;; outline
;; (use-package lsp-treemacs
;;   :after lsp)
(use-package eglot
    :hook (prog-mode . eglot-ensure)
)
;; (use-package vertico
;;     :config (vertico-mode t)
;; )

;; languages
;; python
;; (use-package python-mode
;;   :ensure t
;;   :hook (python-mode . lsp-deferred)
;;   ;; :custom
;;   ;; ;; NOTE: Set these if Python 3 is called "python3" on your system!
;;   ;; ;; (python-shell-interpreter "python3")
;;   ;; ;; (dap-python-executable "python3")
;;   ;; (dap-python-debugger 'debugpy)
;;   ;; :config
;;   ;; (require 'dap-python)
;; )

;; autocompletion
(use-package company
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map ("<tab>" . company-complete-selection))
        ;; use this if you want tab for cycling
        ;; (:map company-active-map ("<tab>" . company-complete-common-or-cycle))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

;; (use-package company-box
;;   :hook (company-mode . company-box-mode))

;; git
(use-package diff-hl
    :init (global-diff-hl-mode)
)

