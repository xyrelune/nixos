;;; init.el --- Emacs configuration -*- lexical-binding: t; -*-

;; Keybinds
(global-set-key (kbd "C-x a") #'org-agenda)
(global-set-key (kbd "C-x c") #'org-capture)

;; Font 
(set-face-attribute 'default nil :family "Iosevka Nerd Font Mono" :height 120)
(set-frame-font "Iosevka Nerd Font Mono 12" nil t)

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
(add-to-list 'default-frame-alist '(alpha-background . 70))

;; Custom Fonts for org mode
(add-hook 'org-mode-hook 'variable-pitch-mode)
(custom-theme-set-faces
 'user
 '(variable-pitch ((t (:family "SF Pro" :height 120))))
 '(fixed-pitch ((t (:family "Iosevka Nerd Font Mono" :height 120))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit fixed-pitch))))
 '(org-block ((t (:inherit fixed-pitch)))))

;; Custom folder which contains .el files that can be loaded by the load command
;;(add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))
;; (load "rose-pine-color-theme")
;; (load-theme 'rose-pine-color t)

;; Base16 Theme
(use-package base16-theme
  :config
  (load-theme 'base16-kanagawa t))

;; Evil Mode
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

;; Binding vterm
(use-package vterm
	:bind ("C-x C-t" . vterm))

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

;; elcord - Discord Rich Presence
;;(use-package elcord
;;  :config
;;  (elcord-mode))
