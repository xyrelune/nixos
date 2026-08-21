;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-

;; Keybinds
(global-set-key (kbd "C-x a") #'org-agenda)
(global-set-key (kbd "C-x c") #'org-capture)

;; Font 
(set-face-attribute 'default nil :family "JetBrainsMono Nerd Font Mono" :height 110)
(set-frame-font "JetBrainsMono Nerd Font Mono 11" nil t)

;; qol customizations
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
(global-hl-line-mode 0)
(global-visual-line-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(electric-indent-mode 1)

;; Transparency 
;;(add-to-list 'default-frame-alist '(alpha-background . 70))

;; Custom Fonts for org mode
(add-hook 'org-mode-hook 'variable-pitch-mode)
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "Noto Sans" :height 110))))
 '(fixed-pitch ((t (:family "JetBrainsMono Nerd Font Mono" :height 110))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit fixed-pitch))))
 '(org-block ((t (:inherit fixed-pitch)))))

;; Base16 Theme
(use-package base16-theme
  :config
  (load-theme 'base16-tokyo-night-terminal-dark t))

;; Evil Mode
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; Org mode evil next line
(with-eval-after-load 'org
  (evil-define-key 'normal org-mode-map
    (kbd "gj") #'evil-next-visual-line
    (kbd "gk") #'evil-previous-visual-line))

;; org-autolist
(use-package org-autolist
  :hook (org-mode . org-autolist-mode))

;; Magit
(use-package magit)

;; Nix Mode for syntax highlighting
(use-package nix-mode
	:mode "\\.nix\\'")

;; Yaml Major Mode
(use-package yaml-mode
  :mode "\\.yml\\'")

;; Nerd Icons
(use-package nerd-icons
  :custom
  (nerd-icons-color-icons nil))

;; Rainbow Mode
(use-package rainbow-mode
  :hook (after-change-major-mode . rainbow-mode))

;; Pdf-tools
(use-package pdf-tools
  :defer t
  :mode "\\.pdf\\'"
  :commands (pdf-loader-install)
  :bind (:map pdf-view-mode-map
              ("j" . pdf-view-next-line-or-next-page)
              ("k" . pdf-view-previous-line-or-previous-page)
              ("C-=" . pdf-view-enlarge)
              ("C--" . pdf-view-shrink))
  :init (pdf-loader-install)
  :config (add-to-list 'revert-without-query ".pdf"))
(add-hook 'pdf-view-mode-hook #'(lambda () (interactive) (display-line-numbers-mode -1)))
(add-hook 'pdf-view-mode-hook #'pdf-view-roll-minor-mode)

;; Emms
(use-package emms
  :config
  (require 'emms-setup)
  (emms-all)
  (emms-default-players)
  (setq emms-player-list '(emms-player-mpv)))

;; Multi-Vterm
(use-package multi-vterm
  :bind (("C-c t" . multi-vterm))
        (("C-c [" . multi-vterm-prev))
        (("C-c ]" . multi-vterm-next))
  :config
  (add-hook 'vterm-mode-hook
		(lambda ()
		(setq-local evil-insert-state-cursor 'box)
		(evil-insert-state)))
(define-key vterm-mode-map [return]                      #'vterm-send-return)

(setq vterm-keymap-exceptions nil)
(evil-define-key 'insert vterm-mode-map (kbd "C-e")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-f")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-a")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-v")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-b")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-w")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-u")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-n")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-m")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-p")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-j")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-k")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-r")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-t")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-g")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-c")      #'vterm--self-insert)
(evil-define-key 'insert vterm-mode-map (kbd "C-SPC")    #'vterm--self-insert)
(evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
(evil-define-key 'normal vterm-mode-map (kbd ",c")       #'multi-vterm)
(evil-define-key 'normal vterm-mode-map (kbd ",n")       #'multi-vterm-next)
(evil-define-key 'normal vterm-mode-map (kbd ",p")       #'multi-vterm-prev)
(evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
(evil-define-key 'normal vterm-mode-map (kbd "o")        #'evil-insert-resume)
(evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume))
