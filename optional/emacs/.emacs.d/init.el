(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))

;; Turns off elpaca-use-package-mode current declaration
;; Note this will cause evaluate the declaration immediately. It is not deferred.
;; Useful for configuring built-in emacs features.
(use-package emacs :ensure nil :config (setq ring-bell-function #'ignore))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("691d671429fa6c6d73098fc6ff05d4a14a323ea0a18787daeb93fde0e48ab18b" "d6b934330450d9de1112cbb7617eaf929244d192c4ffb1b9e6b63ad574784aad" "1594eb8fc081be254c7df7b2a37e9808f79c94863366da6d34bbe735519a30f5" "372905daccda4574b28e5d5b64d5a4059da9e3c5548abc274af04fe63adc1372" "9a977ddae55e0e91c09952e96d614ae0be69727ea78ca145beea1aae01ac78d2" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
