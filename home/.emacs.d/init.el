(setq custom-file "~/.emacs.d/custom.el")

(require 'package)

;; Add MELPA, GNU ELPA, and MELPA Stable to your package-archives
(setq package-archives
      '(("melpa"        . "https://melpa.org/packages/")
        ("gnu"          . "https://elpa.gnu.org/packages/")
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
;; Turn off bell sound
(setq ring-bell-function 'ignore)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
;; Backup files
(setq make-backup-files nil) ; stop creating ~ files
;; Recovery files
(setq auto-save-default nil) ; stop creating #...# files

;; Control vertical/horizontal split
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default indent-line-function 'insert-tab)
(setq-default c-basic-offset 4)

;; Load the built-in line-number mode
(column-number-mode)
(global-display-line-numbers-mode t)
;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package projectile
  :config (projectile-mode)
  :init
  (setq projectile-project-search-path '(("~/dev/" . 4)))
  (projectile-discover-projects-in-search-path)
)

;; Evil
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

;; picker
(use-package counsel
  :diminish
  :config
  (counsel-mode 1)
  ;; don't start searches with ^ to allow fuzzy search
  (setq ivy-initial-inputs-alist nil))

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
    "p"  '(execute-extended-command :wk "Run command")
  )
  (my-leader-def
    :states '(normal visual)
    :keymaps 'override
    ;; Projects
    "a"  '(:ignore t :wk "Projectile")
    "ag" '(projectile-switch-project :wk "Switch project")
    ;; Compile
    "ds"  '(compile   :wk "Switch")
    "dg"  '(recompile :wk "Go")
    ;; Finders
    "f"  '(:ignore t :wk "Find")
    "ff" '(projectile-find-file :wk "Find file (project)")
    "fg" '(projectile-grep :wk "Grep (project)")
    "fb" '(counsel-ibuffer :wk "Find buffer")
    "fc" '(counsel-grep :wk "Find in current buffer")
    "f;" '(counsel-M-x :wk "Find command")
    "fh"  '(:ignore t :wk "Help/Describe")
    "fhv"  '(counsel-describe-variable :wk "Describe variable")
    "fhx"  '(describe-command :wk "Describe command")
    "fhp"  '(describe-package :wk "Describe package")
  )
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

;; Theme
(use-package ef-themes
  :ensure t
  :init
  :config
  (setq modus-themes-mixed-fonts t)
  (setq modus-themes-italic-constructs t)
  ;; https://protesilaos.com/emacs/ef-themes-pictures
  ;; (modus-themes-load-theme 'ef-reverie)
  ;; (modus-themes-load-theme 'ef-cyprus)
  (modus-themes-load-theme 'ef-trio-light)
)

;; Org-mode
(add-hook 'org-mode-hook #'visual-line-mode)  ;; Enable word-wrap
(add-hook 'org-mode-hook #'org-indent-mode)  ;; Enable smart-wrap & indent

;; (set-face-attribute 'default nil :font "Menlo" :height 150)
(set-face-attribute 'fixed-pitch nil :font "Google Sans Code" :height 160)
;; (set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 170)
