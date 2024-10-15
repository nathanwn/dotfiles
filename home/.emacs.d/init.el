(load-file "~/.emacs.d/local.el")
(setq custom-file "~/.emacs.d/custom.el")
(add-to-list 'load-path "~/.emacs.d/elisp/")

(require 'package)

;; Add MELPA, GNU ELPA, and MELPA Stable to your package-archives
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")))

;; Initialize the package system
(package-initialize)

;; Refresh package contents if needed (optional)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)

(setq use-package-always-ensure t
      use-package-verbose t
)

(setq inhibit-startup-message t)
;; Disable visible scrollbar
(scroll-bar-mode -1)
;; Disable the toolbar
(tool-bar-mode -1)
;; Disable tooltips
(tooltip-mode -1)
;; Disable the menu bar
(menu-bar-mode -1)
;; Disable cursor blinking
(blink-cursor-mode -1)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Backup files
(setq make-backup-files nil) ; stop creating ~ files
;; Recovery files
(setq auto-save-default nil) ; stop creating #...# files

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default indent-line-function 'insert-tab)
(setq-default c-basic-offset 4)

;; Theme
; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
; (load-theme 'papercolor t)
(use-package modus-themes
  :ensure t
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)
  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        modus-themes-preset-overrides-intense)
  ;; Load the theme of your choice.
  (load-theme 'modus-operandi-tritanopia))
;; (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 122)
(set-face-attribute 'default nil :font "RobotoMono Nerd Font" :height 140)
(set-face-attribute 'variable-pitch nil :font "Sans" :height 128)
;; (set-face-attribute 'fixed-pitch nil :font "JetBrainsMono Nerd Font" :height 122)
(set-face-attribute 'fixed-pitch nil :font "RobotoMono Nerd Font" :height 140)

;; Load the built-in line-number mode
(column-number-mode)
(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; ; Finders
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

; Repo navigation
(use-package projectile
  :config (projectile-mode)
  :init
  (setq projectile-project-search-path '(("~/dev/" . 4)))
)

(use-package counsel-projectile
  :diminish
  :config (counsel-projectile-mode))


;; Vi {{{
(use-package evil
  :diminish
  :after (projectile)
  :init
  ;; use ctrl-h + v to view what each option does
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)  ;; not turning on evil for other modes
  (setq evil-want-C-u-scroll t)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  (define-key evil-normal-state-map (kbd "<C-i>") nil)
  (define-key evil-normal-state-map (kbd "<C-i>") 'evil-jump-forward)
  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)
  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal)
  ;; enable redo with C-r
  (evil-set-undo-system 'undo-redo)
  ;; make :q/:wq kill the buffer, and not Emacs
  (global-set-key [remap evil-quit] 'kill-buffer-and-window)
)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
;; }}}

;; ;; Keymapping {{{
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
    "fw" '(projectile-switch-project :wk "Switch project")
    "fb" '(counsel-ibuffer :wk "Find buffer")
    "fc" '(counsel-grep :wk "Grep")
    "fp" '(counsel-minibuffer-history :wk "Find prev")
    "f;" '(counsel-M-x :wk "Find command")
    "fh"  '(:ignore t :wk "Help/Describe")
    "fhv"  '(counsel-describe-variable :wk "Describe variable")
    "fhx"  '(describe-command :wk "Describe command")
    "fhp"  '(describe-package :wk "Describe package")
  )
  (my-leader-def
    :states '(normal visual)
    :keymaps 'override
    "p"  '(:ignore t :wk "Project")
    "pr" '(projectile-discover-projects-in-search-path :wk "Rediscover projects")
    "pg" '(projectile-run-project :wk "Run command")
    "pc" '(projectile-compile-project :wk "Compile")
  )
  ;; ;; lsp
  ;; (my-leader-def
  ;;   :states '(normal visual)
  ;;   ;; :keymaps 'override
  ;;   :keymaps 'eglot-mode-map
  ;;   "gd" 'eglot-find-declaration
  ;;   "gt" 'eglot-find-typeDefinition
  ;;   "gi" 'eglot-find-implementation
  ;;   "ga" 'eglot-code-actions
  ;;   "gr" 'eglot-rename
  ;; )
  ;; buffer navigation
  (general-nmap
    :states '(normal)
    :keymaps 'override
    "]d" 'flymake-goto-next-error
    "[d" 'flymake-goto-prev-error
    "]c" 'diff-hl-next-hunk
    "[c" 'diff-hl-previous-hunk
  )
  ;; zooming
  (global-set-key (kbd "C-=") 'text-scale-increase)
  (global-set-key (kbd "C--") 'text-scale-decrease)
)

(use-package which-key
  :defer 0
  :diminish
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))
;; }}}

;; direnv {{{
(use-package direnv
  :config
  (direnv-mode))
;; }}}

;; Utils
;; Logging key events
(use-package command-log-mode
  :commands command-log-mode)
;; Bracket coloring for Lisp
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Languages
(use-package groovy-mode)
