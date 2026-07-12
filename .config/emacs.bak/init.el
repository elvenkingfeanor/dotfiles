;; ui
(setq inhibit-startup-message t)
(set-scroll-bar-mode nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode nil)
(hl-line-mode 1)
(column-number-mode 1)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type t)


;; font
;;(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-20"))
(set-face-attribute 'default nil :font "JetBrains Mono" :height 200)
(set-face-attribute 'fixed-pitch nil :font "Iosevka Fixed")
(set-face-attribute 'variable-pitch nil :font "Source Sans Pro")
(set-face-attribute 'fixed-pitch-serif nil :font "DejaVu Serif")


;; history
(recentf-mode 1)
(savehist-mode 1)
(save-place-mode 1)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)


;; packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; donot clutter here
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)


(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.3))


(use-package vertico
  :init (vertico-mode))


(use-package consult
  :init)


(use-package corfu
  :init (global-corfu-mode))


(use-package marginalia
  :ensure t
  :config (marginalia-mode))


(use-package orderless
  :ensure t
  :config
  (setq orderless-smart-case t
  	orderless-expand-substring 'prefix
	orderless-matching-styles
	(list #'orderless-literal #'orderless-regexp)))


(use-package embark
  :ensure t
  :init
  (setq prefix-help-command #'embark-prefix-help-command))


(use-package embark-consult
  :ensure t)
