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
 '(custom-safe-themes
   '("7d26b8ba9cfe187712ba9816307809d22bdc202c2da21ea800c26a6d2151a23b" default))
 '(package-selected-packages
   '(toc-org evil-org org-superstar org-superstar: org-tempo elisp-autofmt org-contrib org-roam diff-hl flycheck vertico company-box xref company company-mode cmake-mode which-key use-package rainbow-delimiters org-bullets lsp-ui lsp-treemacs lsp-pyright ivy-rich helpful general evil-collection counsel-projectile command-log-mode))
 '(safe-local-variable-values
   '((eval setq-local org-roam-db-location
	   (expand-file-name "org-roam.db" org-roam-directory))
     (eval setq-local org-roam-directory
	   (expand-file-name
	    (locate-dominating-file default-directory ".dir-locals.el"))))))
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
(blink-cursor-mode -1)      ; Disable cursor blinking
; (set-fringe-mode 10)        ; Give some breathing room
;; Font
(set-face-attribute 'default nil :font "ComicShannsMono Nerd Font" :height 132)
(set-face-attribute 'fixed-pitch nil :font "ComicShannsMono Nerd Font" :height 132)
(set-face-attribute 'variable-pitch nil :font "Source Sans Pro" :height 140)
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
  :diminish  ;; hide the minor mode from mode line
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
  :diminish
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :diminish
  :bind (
     ("M-x" . counsel-M-x)
     ("C-x b" . counsel-ibuffer)
     ("C-x C-f" . counsel-find-file)
     :map minibuffer-local-map
     ("C-r" . 'counsel-minibuffer-history)
  )
  :config
  (counsel-mode 1)
  ;; don't start searches with ^ to allow fuzzy search
  (setq ivy-initial-inputs-alist nil))


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
  (setq projectile-project-search-path '(("~/dev/" . 2)))
)

(use-package counsel-projectile
  :diminish
  :config (counsel-projectile-mode))

;; Key-bindings
;; Which-key
(use-package which-key
  :defer 0
  :diminish ;; which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))
;; Set keys
;; Some useful resources:
;; https://github.com/noctuid/evil-guide#bare-minimum-emacs-knowledge
(use-package evil
  :diminish
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
  ;; enable redo with C-r
  (evil-set-undo-system 'undo-redo)
  ;; make :q/:wq kill the buffer, and not Emacs
  (global-set-key [remap evil-quit] 'kill-buffer-and-window)
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
  ;; finders (projectile and counsel)
  (my-leader-def
    :states '(normal visual)
    :keymaps 'override
    "f"  '(:ignore t :wk "Find")
    "ff" '(projectile-find-file :wk "Find file (project)")
    "fg" '(counsel-projectile-rg :wk "Ripgrep (project)")
    "fp" '(projectile-switch-project :wk "Switch project")
    "fb" '(counsel-ibuffer :wk "Find buffer")
    "fc" '(counsel-grep :wk "Grep")
    "fo" '(counsel-minibuffer-history :wk "Find prev")
    "fx" '(counsel-M-x :wk "Find command")
  )
  ;; lsp
  (my-leader-def
    :states '(normal visual)
    ;; :keymaps 'override
    :keymaps 'eglot-mode-map
    "gd" 'eglot-find-declaration
    "gt" 'eglot-find-typeDefinition
    "gi" 'eglot-find-implementation
    "ga" 'eglot-code-actions
    "gr" 'eglot-rename
  )
  ;; org-roam
  (my-leader-def
    :states '(normal visual)
    :keymaps 'org-mode-map
    "gd" 'org-open-at-point
  )
  (my-leader-def
    :states '(normal visual)
    :keymaps 'override
    "r"  '(:ignore t :wk "Org-roam")
    "rf" '(org-roam-node-find :wk "Find")
    "ri" '(org-roam-node-insert :wk "Insert")
    "rt" '(org-roam-buffer-toggle :wk "Buffer toggle")
  )
  ;; buffer navigation
  (general-nmap
    :states '(normal)
    :keymaps 'override
    "]e" 'flymake-goto-next-error
    "[e" 'flymake-goto-prev-error
    "]c" 'diff-hl-next-hunk
    "[c" 'diff-hl-previous-hunk
  )
  ;; zooming
  (global-set-key (kbd "C-=") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease)
)


;; Org-mode
;; This is the nongnu version
(defun my-org-mode-setup ()
  (org-indent-mode)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1)
  ;; stop emacs from automatically 
  (electric-indent-mode -1)
  (setq evil-auto-indent nil)
  ;; modify default ellipsis marker (...)
  (setq org-ellipsis " ▾")
  ;; hide emphasis markers
  (setq org-hide-emphasis-markers t)
  ;; syntax highlighting in org src blocks
  (setq org-src-fontify-natively t)
  ;; highlight inline LaTeX
  (setq org-highlight-latex-and-related '(native))
  ;; automatically change bullet type when indenting
  ;; Ex: indenting a + makes the bullet a *.
  (setq org-list-demote-modify-bullet
        '(("+" . "-") ("-" . "+") ("+" . "-")))
  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
)

(use-package org-contrib
  :hook (org-mode . my-org-mode-setup)
  :config
  (require 'ox-md nil t)
)
;; useful src snippets
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
;; fonts
(dolist (face '((org-level-1 . 2)
                (org-level-2 . 1.6)
                (org-level-3 . 1.3)
                (org-level-4 . 1.2)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.05)
                (org-level-8 . 1.05)))
    ;; (set-face-attribute (car face) nil :font "Source Sans Pro" :weight 'regular :height (cdr face))
)
;; Make sure org-indent face is available
(require 'org-indent)
;; bullet
;; (use-package org-bullets
;;   :after org
;;   :hook (org-mode . org-bullets-mode)
;;   :init
;;   (add-hook 'org-mode-hook
;;       (lambda ()
;;         (toggle-truncate-lines nil) ))
;; )
(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  ;; (org-superstar-remove-leading-stars t)
  (org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))
)
(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))
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
  :diminish
  :hook (prog-mode . company-mode)
  :bind (:map company-active-map ("<tab>" . company-complete-common-or-cycle))
        ;; use this if you want tab for cycling
        ;; (:map company-active-map ("<tab>" . company-complete-common-or-cycle))
        ;; use this if you want tab for completion
        ;; (:map company-active-map ("<tab>" . company-complete-selection))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :diminish
  :hook (company-mode . company-box-mode))

;; git
(use-package diff-hl
  :init (global-diff-hl-mode)
)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'papercolor t)
