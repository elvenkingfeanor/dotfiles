;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")
;;
(setq user-full-name "Tanmoy Sarkar"
      user-mail-address "tan99sarkar88@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;;(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 24 :weight 'regular)
;;      doom-variable-pitch-font (font-spec :family "Source Sans Pro" :size 26)
;;      doom-serif-font (font-spec :family "IBM Plex Serif")
;;      doom-symbol-font (font-spec :family "Noto Color Emoji" :size 26)
;;      )
;;
;; "JetBrainsMono Nerd Font:pixelsize=16:foundry=JB:weight=regular:slant=normal:width=normal:spacing=100:scalable=true"
;; "Source Sans Pro:pixelsize=16:foundry=ADBO:weight=regular:slant=normal:width=normal:scalable=true"
;; "IBM Plex Serif:pixelsize=16:foundry=IBM :weight=regular:slant=normal:width=normal:scalable=true"
;; "Noto Color Emoji:pixelsize=16:foundry=GOOG:weight=regular:slant=normal:width=normal:spacing=100:scalable=true"
;;
(setq doom-font "JetBrainsMono Nerd Font:pixelsize=24:antialias=off"
      doom-variable-pitch-font "Source Sans Pro:pixelsize=26"
      doom-serif-font "IBM Plex Serif"
      doom-symbol-font "Noto Color Emoji:pixelsize=26")

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "~/org/")
(setq org-directory "~/notx/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; start emacs as server
(require 'server)
(unless (server-running-p)
  (server-start))

;; Yasnippets directory
(setq yas-snippet-dirs
      '("~/.config/doom/snippets/snippets/"))

;; set default bibliography for reftex
(setq reftex-default-bibliography
      "~/sty/articles/bib/cite.bib")

;; path config for use of citar for vertico
(setq! citar-bibliography '("~/sty/articles/bib/cite.bib")
       citar-library-paths '("~/sty/articles/")
       citar-notes-paths '("~/notx/"))

;; marksman for markdown (no +lsp option for markdown in Doomemacs)
;; markdown-mode package already installed by Doomemacs
(use-package markdown-mode
  :hook (markdown-mode . lsp)
  :config
  (require 'lsp-marksman))
