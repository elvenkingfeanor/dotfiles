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
;;      ) ;; not working
;;
;; "JetBrainsMono Nerd Font:pixelsize=16:foundry=JB:weight=regular:slant=normal:width=normal:spacing=100:scalable=true"
;; "Source Sans Pro:pixelsize=16:foundry=ADBO:weight=regular:slant=normal:width=normal:scalable=true"
;; "IBM Plex Serif:pixelsize=16:foundry=IBM :weight=regular:slant=normal:width=normal:scalable=true"
;; "Noto Color Emoji:pixelsize=16:foundry=GOOG:weight=regular:slant=normal:width=normal:spacing=100:scalable=true"
;;
;;(setq doom-font "JetBrainsMono Nerd Font:pixelsize=20:antialias=off"
;;      doom-variable-pitch-font "Source Sans Pro:pixelsize=22"
;;      doom-serif-font "IBM Plex Serif"
;;      doom-symbol-font "Noto Color Emoji:pixelsize=22") ;; not working

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

;; doom fonts not working. setting emacs init frame parameters
;;(add-to-list 'default-frame-alist '(font-spec :family "JetBrainsMono Nerd Font" :size 20)) ;; font-spec not working
(add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-20")) ;; works

;; Yasnippets directory
(setq yas-snippet-dirs
      '("~/.config/doom/snippets/snippets/"))
;; orgmode TAB conflicts with Yasnippets TAB (https://orgmode.org/manual/Conflicts.html)
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (setq-local yas/trigger-key [tab])
;;             (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))

;; set default bibliography for reftex
(setq reftex-default-bibliography
      "~/sty/articles/bib/cite.bib")

;; path config for use of citar for vertico
(setq! citar-bibliography '("~/sty/articles/bib/cite.bib")
       citar-library-paths '("~/sty/articles/")
       citar-notes-paths '("~/notx/notes.org"))

;; marksman for markdown (no +lsp option for markdown in Doomemacs)
;; markdown-mode package already installed by Doomemacs
(use-package markdown-mode
  :hook (markdown-mode . lsp)
  :config
  (require 'lsp-marksman))

;; Orgmode
;; Org-capture
(require 'org-protocol) ;; org-protocol to capture directly from browser
(require 'org-id) ;; generate unique IDs for captured items for future linking

(after! org
  (add-to-list 'org-modules 'org-id 'org-protocol))

;; Doom presets
;; (setq org-capture-templates
;;       '(("t" "Personal todo" entry (file+headline +org-capture-todo-file "Inbox")
;;          "* [ ] %?\n%i\n%a" :prepend t)
;;         ("n" "Personal notes" entry (file+headline +org-capture-notes-file "Inbox")
;;          "* %u %?\n%i\n%a" :prepend t)
;;         ("j" "Journal" entry (file+olp+datetree +org-capture-journal-file)
;;          "* %U %?\n%i\n%a" :prepend t)
;;         ("p" "Templates for projects")
;;         ("pt" "Project-local todo" entry
;;          (file+headline +org-capture-project-todo-file "Inbox") "* TODO %?\n%i\n%a"
;;          :prepend t)
;;         ("pn" "Project-local notes" entry
;;          (file+headline +org-capture-project-notes-file "Inbox") "* %U %?\n%i\n%a"
;;          :prepend t)
;;         ("pc" "Project-local changelog" entry
;;          (file+headline +org-capture-project-changelog-file "Unreleased")
;;          "* %U %?\n%i\n%a" :prepend t)
;;         ("o" "Centralized templates for projects")
;;         ("ot" "Project todo" entry #'+org-capture-central-project-todo-file
;;          "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
;;         ("on" "Project notes" entry #'+org-capture-central-project-notes-file
;;          "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
;;         ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file
;;          "* %U %?\n %i\n %a" :heading "Changelog" :prepend t)))

(setq org-id-method 'uuid)
(setq org-id-link-to-org-use-id t)
;; not able to change TODO states after this addition

(setq org-capture-templates
      '(("b" "bookmark" entry (file+headline "~/notx/links.org" "Bookmarks")
         "* %a %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n** %:initial%?"
         :empty-lines 1)
        ("c" "contact" entry (file "~/notx/contacts.org")
         "* %^{Name} %^G\n:PROPERTIES:\n:EMAIL: %^{email}\n:PHONE: %^{phone}\n:ALIAS: %^{nickname}\n:ADDRESS:\n:BIRTHDAY: %^{birthday}t\n:CREATED: %U\n:END:\n %?"
         :empty-lines 1)
        ("i" "inbox")
        ("ii" "ideas" entry (file+headline "~/notx/inbox.org" "Ideas")
         "* %?\n%U\n%i"
         :empty-lines 1)
        ("it" "problems" entry (file+headline "~/notx/inbox.org" "Problems")
         "* %?\n%U\n%i"
         :empty-lines 1)
        ("iw" "wishlist" entry (file+headline "~/notx/inbox.org" "Wishlists")
         "* %?\n%U\n%i"
         :empty-lines 1)
        ("l" "link" plain (file "~/.local/share/bookmarks")
         "%L %?"
         :immediate-finish t)
        ("n" "notes")
        ("na" "article-notes" entry (file+headline "~/notx/notes.org" "Articles")
         "* %^{title} %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n#+NAME: %^{key}\n#+BEGIN_SRC bibtex\n@article{%\\2\ntitle={%\\1},\nauthor={%^{authors}},\njournal={%^{journal}},\nyear={%^{year}},\ndoi={%^{doi}},\n}\n#+END_SRC\n\n** %:initial%?"
         :empty-lines 1)
        ("nb" "book-notes" entry (file+headline "~/notx/notes.org" "Books")
         "* %^{title} %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n#+NAME: %^{key}\n#+BEGIN_SRC bibtex\n@book{%\\2\ntitle={%\\1},\nauthor={%^{authors}},\npublisher={%^{publisher}},\nyear={%^{year}},\ndoi={%^{doi}},\n}\n#+END_SRC\n\n** %:initial%?"
         :empty-lines 1)
        ("t" "todos & dailies")
        ("td" "daily" entry (file+olp+datetree "~/notx/journal.org" "Journals")
         "* %(format-time-string \"%H:%M\") - Journal :journal:\n\n%?\n\n"
         :empty-lines 1)
        ("tt" "task" entry (file+olp "~/notx/journal.org" "TODOs")
         "* TODO %?\n%u\n%a\n%i"
         :empty-lines 1)
        ))

;; Org-agenda
(setq org-agenda-files (list "~/notx/journal.org" org-directory))
(setq org-agenda-start-with-log-mode t)
(setq org-log-into-drawer t)
(setq org-log-done 'time)

;; Doom presets
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "PROJ(p)" "LOOP(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)"
;;          "|" "DONE(d)" "KILL(k)")
;;         (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
;;         (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")))
(setq org-todo-keywords
      '((sequence "TODO(t)" "MAYBE(m)" "|" "DONE(d)" "CANCELLED(c)")))

;; org-refile targets and save org buffers
(setq org-refile-targets
      '((org-agenda-files . (:maxlevel . 2))
        (nil . (:maxlevel . 2))))
(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-refile-use-cache t)
(setq org-reverse-note-order nil)

(advice-add 'org-refile :after 'org-save-all-org-buffers)

;; org-contacts
(setq org-contacts-files '("~/notx/contacts.org"))
