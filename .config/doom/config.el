;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")
;;
(setq user-full-name "ts")


;; Doom-UI
(use-package doom-ui
  :ensure t
  :config
  (setq doom-font (font-spec :family "JetBrains Mono" :weight 'regular :size 24)
        doom-variable-pitch-font (font-spec :family "Source Sans Pro")
        doom-serif-font (font-spec :family "DejaVu Serif")
        doom-symbol-font (font-spec :family "Noto Color Emoji")
        doom-theme 'doom-one))
;; ;; Doom exposes five (optional) variables for controlling fonts in Doom:
;; ;;
;; ;; - `doom-font' -- the primary font to use
;; ;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; ;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;; ;;   presentations or streaming.
;; ;; - `doom-symbol-font' -- for symbols
;; ;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;; ;;
;; ;; See 'C-h v doom-font' for documentation and more examples of what they
;; ;; accept. For example:

;; (setq doom-font (font-spec :family "JetBrains Mono" :weight 'regular :size 24)
;;       doom-variable-pitch-font (font-spec :family "Source Sans Pro")
;;       doom-serif-font (font-spec :family "DejaVu Serif")
;;       doom-symbol-font (font-spec :family "Noto Color Emoji" :size 26))

;; ;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; ;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; ;; refresh your font settings. If Emacs still can't find your font, it likely
;; ;; wasn't installed correctly. Font issues are rarely Doom issues!

;; ;; There are two ways to load a theme. Both assume the theme is installed and
;; ;; available. You can either set `doom-theme' or manually load a theme with the
;; ;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)


;; Fonts
;; doom fonts not working. setting emacs init frame parameters
;;(add-to-list 'default-frame-alist '(font-spec :family "JetBrainsMono Nerd Font" :size 20)) ;; font-spec not working
;; (add-to-list 'default-frame-alist
;;              '(font . "JetBrainsMono Nerd Font-20")) ;; works


;; Grep
;; default grep-command
;; "grep --color=auto -nH --null -e "
(setopt grep-command "grep --color=auto -rnHiI -C2 -e ")


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;;(setq org-directory "~/org/")
;; (setq org-directory "~/notx/")


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
(use-package server
  :ensure t
  :config
  (unless (server-running-p) (server-start)))
;; (require 'server)
;; (unless (server-running-p)
;;   (server-start))


;; Orgmode
(use-package org
  :defer t
  :ensure t
  :config
  (setq org-directory "~/notx/"
        org-agenda-files (list "~/notx/inbox.org" org-directory)
        org-agenda-start-with-log-mode t
        org-log-into-drawer t
        org-log-done 'time
        org-todo-keywords '((sequence "TODO(t)" "MAYBE(m)" "|" "DONE(d!)" "CANCELLED(c)")
                            (sequence "[ ](T)" "[-](S)" "|" "[X](D)"))
        org-capture-templates '(("b" "bookmark" entry (file+headline "~/notx/links.org" "Bookmarks")
                                 "* %a %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n** %:initial%?"
                                 :empty-lines 1)
                                ("c" "contact" entry (file "~/notx/contacts.org")
                                 "* %^{Name} %^G\n:PROPERTIES:\n:EMAIL: %^{email}\n:PHONE: %^{phone}\n:ALIAS: %^{nickname}\n:ADDRESS: %^{address}\n:BIRTHDAY: %^{birthday}t\n:CREATED: %U\n:END:\n %?"
                                 :empty-lines 1)
                                ("i" "inbox")
                                ("ii" "ideas" entry (file+headline "~/notx/inbox.org" "Ideas")
                                 "* %?\n%U\n%i"
                                 :empty-lines 1)
                                ("ip" "problems" entry (file+headline "~/notx/inbox.org" "Problems")
                                 "* %?\n%U\n%i"
                                 :empty-lines 1)
                                ("it" "task" entry (file+headline "~/notx/inbox.org" "TODOs")
                                 "* TODO %?\n%U\n%a\n%i"
                                 :empty-lines 1)
                                ("n" "notes")
                                ("na" "article-notes" entry (file+headline "~/notx/notes.org" "Articles")
                                 "* %^{title} %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n#+NAME: %^{key}\n#+BEGIN_SRC bibtex\n@article{%\\2,\ntitle={%\\1},\nauthor={%^{authors}},\njournal={%^{journal}},\nyear={%^{year}},\ndoi={%^{doi}},\nkeywords={%^{keywords}}\n}\n#+END_SRC\n\n** %:initial%?"
                                 :empty-lines 1)
                                ("nb" "book-notes" entry (file+headline "~/notx/notes.org" "Books")
                                 "* %^{booktitle} %^{edition}E\n** %^{chapter-num}. %^{chapter-name} %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n#+NAME: %^{key}:%\\3\n#+BEGIN_SRC bibtex\n@inbook{%\\5:%\\3,\ntitle={%\\1},\nchapter={%\\3},\nauthor={%^{authors}},\npublisher={%^{publisher}},\nyear={%^{year}},\nedition={%\\2},\ndoi={%^{doi}},\nisbn={%^{isbn}},\nkeywords={%^{keywords}}\n}\n#+END_SRC\n\n*** %:initial%?"
                                 :empty-lines 1)
                                ("d" "dailies")
                                ("dd" "daily" entry (file+olp+datetree "~/notx/journal.org" "Journals")
                                 "* %(format-time-string \"%H:%M\") - Journal :journal:\n\n%?\n\n"
                                 :empty-lines 1)
                                ("dw" "wishlist" entry (file+headline "~/notx/journal.org" "Wishlists")
                                 "* %?\n%U\n%i"
                                 :empty-lines 1)
                                ("m" "media")
                                ("mm" "movies" entry (file+headline "~/notx/media.org" "Movies")
                                 "* %?\n%U\n%i")
                                ("md" "documentaries")
                                ("mdb" "BBC" entry (file+headline "~/notx/media.org" "Documentaries" "BBC")
                                 "* %?\n%U\n%i"))
        org-archive-location "~/notx/archive.org::* From %s"
        org-refile-targets '((org-agenda-files . (:maxlevel . 8))
                             (org-agenda-files . (:tag . "refile"))
                             (nil . (:maxlevel . 8)))
        org-refile-allow-creating-parent-nodes 'confirm
        org-refile-use-cache t
        org-reverse-note-order nil
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-log-refile 'time
        org-export-backends '("pandoc" "latex" "html" "beamer" "md" "ascii" "icalendar" "odt")
        org-latex-compiler "lualatex"
        org-latex-hyperref-template "\\hypersetup{\n linktoc=all,\n backref=section,\n breaklinks=true,\n colorlinks=true,\n linkcolor=red,\n urlcolor=magenta,\n pdfauthor={%a},\n pdftitle={%t},\n pdfkeywords={%k},\n pdfsubject={%d},\n pdfcreator={%c},\n pdflang={%L}}\n"
        org-export-default-language "en-gb"
        org-latex-classes '(("beamer"
                             "\\documentclass[presentation]{beamer}\n\\usepackage[usenames]{color}\n[DEFAULT-PACKAGES]\n[PACKAGES]\n\\urlstyle{tt}"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
                            ("article"
                             "\\documentclass[12pt,a4paper]{article}\n\\usepackage[usenames]{color}\n[DEFAULT-PACKAGES]\n[PACKAGES]\n\\urlstyle{tt}"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                            ("report"
                             "\\documentclass[12pt,a4paper]{report}\n\\usepackage[usenames]{color}\n[DEFAULT-PACKAGES]\n[PACKAGES]\n\\urlstyle{tt}"
                             ("\\part{%s}" . "\\part*{%s}")
                             ("\\chapter{%s}" . "\\chapter*{%s}")
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
                            ("book"
                             "\\documentclass[12pt,a4paper]{book}\n\\usepackage[usenames]{color}\n[DEFAULT-PACKAGES]\n[PACKAGES]\n\\urlstyle{tt}"
                             ("\\part{%s}" . "\\part*{%s}")
                             ("\\chapter{%s}" . "\\chapter*{%s}")
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
        org-latex-remove-logfiles t
        org-pandoc-options '((standalone . t) (toc . t) (mathjax . t) (variable . "revealjs-url=https://revealjs.com"))
        org-pandoc-options-for-latex-pdf '((pdf-engine . "lualatex")
                                         (shift-heading-level-by . "-1")
                                         (variable . "papersize:a4")
                                         (variable . "babeloptions:provide=english")
                                         (variable . "mainfont:DejaVuSerif")
                                         (variable . "mainfontoptions:Extensions=.ttf, UprightFont=*, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic")
                                         (variable . "sansfont:DejaVuSans")
                                         (variable . "monofont:DejaVuSansMono")
                                         (variable . "mathfont:DejaVuMathTeXGyre-Regular")
                                         (variable . "mainfontfallback:FreeSans:")
                                         (variable . "mainfontfallback:NotoColorEmoji:")
                                         (variable . "fontsize:12pt")
                                         (variable . "hyperrefoptions:linktoc=all")
                                         (variable . "hyperrefoptions:backref=section")
                                         (variable . "hyperrefoptions:breaklinks=true")
                                         (variable . "hyperrefoptions:colorlinks=true")
                                         (variable . "colorlinks:linkcolor=red")
                                         (variable . "colorlinks:urlcolor=magenta")
                                         (variable . "urlstyle:tt"))
        org-export-with-broken-links t
        org-contacts-files '("~/notx/contacts.org"))
  (advice-add 'org-refile :after 'org-save-all-org-buffers))

(use-package org-id
  :after org
  :config
  (setq org-id-method 'uuid
        org-id-link-to-org-use-id t))

(use-package org-protocol
  :defer t)

(use-package ox-md
  :after org
  :defer t)
;; ;; ;; Org-capture
;; ;; (require 'org-protocol) ;; org-protocol to capture directly from browser
;; ;; (require 'org-id) ;; generate unique IDs for captured items for future linking
;; ;; (after! org
;; ;;   (add-to-list 'org-modules 'org-id 'org-protocol))
;; ;; ;; Org-id
;; ;; (setq org-id-method 'uuid)
;; ;; (setq org-id-link-to-org-use-id t)
;; ;; Org-capture templates
;; ;; Doom org-capture presets
;; ;; (setq org-capture-templates
;; ;;       '(("t" "Personal todo" entry (file+headline +org-capture-todo-file "Inbox")
;; ;;          "* [ ] %?\n%i\n%a" :prepend t)
;; ;;         ("n" "Personal notes" entry (file+headline +org-capture-notes-file "Inbox")
;; ;;          "* %u %?\n%i\n%a" :prepend t)
;; ;;         ("j" "Journal" entry (file+olp+datetree +org-capture-journal-file)
;; ;;          "* %U %?\n%i\n%a" :prepend t)
;; ;;         ("p" "Templates for projects")
;; ;;         ("pt" "Project-local todo" entry
;; ;;          (file+headline +org-capture-project-todo-file "Inbox") "* TODO %?\n%i\n%a"
;; ;;          :prepend t)
;; ;;         ("pn" "Project-local notes" entry
;; ;;          (file+headline +org-capture-project-notes-file "Inbox") "* %U %?\n%i\n%a"
;; ;;          :prepend t)
;; ;;         ("pc" "Project-local changelog" entry
;; ;;          (file+headline +org-capture-project-changelog-file "Unreleased")
;; ;;          "* %U %?\n%i\n%a" :prepend t)
;; ;;         ("o" "Centralized templates for projects")
;; ;;         ("ot" "Project todo" entry #'+org-capture-central-project-todo-file
;; ;;          "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
;; ;;         ("on" "Project notes" entry #'+org-capture-central-project-notes-file
;; ;;          "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
;; ;;         ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file
;; ;;          "* %U %?\n %i\n %a" :heading "Changelog" :prepend t)))
;; (setq org-capture-templates
;;       '(("b" "bookmark" entry (file+headline "~/notx/links.org" "Bookmarks")
;;          "* %a %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n** %:initial%?"
;;          :empty-lines 1)
;;         ("c" "contact" entry (file "~/notx/contacts.org")
;;          "* %^{Name} %^G\n:PROPERTIES:\n:EMAIL: %^{email}\n:PHONE: %^{phone}\n:ALIAS: %^{nickname}\n:ADDRESS: %^{address}\n:BIRTHDAY: %^{birthday}t\n:CREATED: %U\n:END:\n %?"
;;          :empty-lines 1)
;;         ("i" "inbox")
;;         ("ii" "ideas" entry (file+headline "~/notx/inbox.org" "Ideas")
;;          "* %?\n%U\n%i"
;;          :empty-lines 1)
;;         ("ip" "problems" entry (file+headline "~/notx/inbox.org" "Problems")
;;          "* %?\n%U\n%i"
;;          :empty-lines 1)
;;         ("it" "task" entry (file+headline "~/notx/inbox.org" "TODOs")
;;          "* TODO %?\n%U\n%a\n%i"
;;          :empty-lines 1)
;;         ("n" "notes")
;;         ("na" "article-notes" entry (file+headline "~/notx/notes.org" "Articles")
;;          "* %^{title} %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n#+NAME: %^{key}\n#+BEGIN_SRC bibtex\n@article{%\\2,\ntitle={%\\1},\nauthor={%^{authors}},\njournal={%^{journal}},\nyear={%^{year}},\ndoi={%^{doi}},\nkeywords={%^{keywords}}\n}\n#+END_SRC\n\n** %:initial%?"
;;          :empty-lines 1)
;;         ("nb" "book-notes" entry (file+headline "~/notx/notes.org" "Books")
;;          "* %^{booktitle} %^{edition}E\n** %^{chapter-num}. %^{chapter-name} %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n\n#+NAME: %^{key}:%\\3\n#+BEGIN_SRC bibtex\n@inbook{%\\5:%\\3,\ntitle={%\\1},\nchapter={%\\3},\nauthor={%^{authors}},\npublisher={%^{publisher}},\nyear={%^{year}},\nedition={%\\2},\ndoi={%^{doi}},\nisbn={%^{isbn}},\nkeywords={%^{keywords}}\n}\n#+END_SRC\n\n*** %:initial%?"
;;          :empty-lines 1)
;;         ("d" "dailies")
;;         ("dd" "daily" entry (file+olp+datetree "~/notx/journal.org" "Journals")
;;          "* %(format-time-string \"%H:%M\") - Journal :journal:\n\n%?\n\n"
;;          :empty-lines 1)
;;         ("dw" "wishlist" entry (file+headline "~/notx/journal.org" "Wishlists")
;;          "* %?\n%U\n%i"
;;          :empty-lines 1)
;;         ("m" "media")
;;         ("mm" "movies" entry (file+headline "~/notx/media.org" "Movies")
;;          "* %?\n%U\n%i")
;;         ("md" "documentaries")
;;         ("mdb" "BBC" entry (file+headline "~/notx/media.org" "Documentaries" "BBC")
;;          "* %?\n%U\n%i")
;;         ))
;; ;; Org-agenda
;; (setq org-agenda-files (list "~/notx/inbox.org" org-directory))
;; (setq org-agenda-start-with-log-mode t)
;; (setq org-log-into-drawer t)
;; (setq org-log-done 'time)
;; (setq org-agenda-include-diary t) ;; diary integration with org-agenda
;; ;; Doom org-agenda presets
;; ;; (setq org-todo-keywords
;; ;;       '((sequence "TODO(t)" "PROJ(p)" "LOOP(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)"
;; ;;          "|" "DONE(d)" "KILL(k)")
;; ;;         (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
;; ;;         (sequence "|" "OKAY(o)" "YES(y)" "NO(n)")))
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "MAYBE(m)" "|" "DONE(d!)" "CANCELLED(c)")
;;         (sequence "[ ](T)" "[-](S)" "|" "[X](D)")))
;; ;; Org-refile
;; ;; org-refile targets and save org buffers
;; (setq org-refile-targets
;;       '((org-agenda-files . (:maxlevel . 8))
;;         (org-agenda-files . (:tag . "refile")) ;; use tags as filter for org-refile-targets
;;         (nil . (:maxlevel . 8))))
;; (setq org-refile-allow-creating-parent-nodes 'confirm)
;; (setq org-refile-use-cache t)
;; (setq org-log-refile 'time)
;; (setq org-reverse-note-order nil)
;; (setq org-refile-use-outline-path 'file)
;; (setq org-outline-path-complete-in-steps nil) ;; already use completion, no need for step completions
;; (advice-add 'org-refile :after 'org-save-all-org-buffers)
;; ;; org-archive
;; (setq org-archive-location "~/notx/archive.org::* From %s") ;; string-type syntax for org-archive-location
;; ;; org-contacts
;; (setq org-contacts-files '("~/notx/contacts.org")) ;; (repeat file)-type symbol property
;; ;; org export backends
;; ;; add markdown export as org export backend (mostly for rendering git readmes)
;; (require 'ox-md)
;; ;; (setq org-export-backends '(("pandoc" "beamer" "md" "ascii" "html" "icalendar" "latex" "odt"))


;; Yasnippets
(use-package yasnippet
  :defer t
  :init
  (setq yas-snippet-dirs
        '("~/.config/doom/snippets/"))
  :config
  (yas-global-mode 1)) ;; enable yasnippets globally
;; (use-package yasnippet
;;   :defer t ;; donot load immediately on startup
;;   :init
;;   (setq yas-snippet-dirs
;;         '("~/.config/doom/snippets/ts-snippets/" ;; personal snippets preferred
;;           "~/.config/doom/snippets/snippets/"))
;;   :config
;;   (yas-global-mode 1)) ;; enable yasnippets globally
  ;; (yas-reload-all)
  ;; :hook (prog-mode . yas-minor-mode)) ;; yasnippets as non-global minor mode, activated on a per-buffer basis
;; orgmode TAB conflicts with Yasnippets TAB (https://orgmode.org/manual/Conflicts.html)
;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (setq-local yas/trigger-key [tab])
;;             (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))


;; Eglot-booster
;; not needed since Emacs v30, project archived by creator since 30 Jun 2026
;; (use-package eglot-booster
;;   :after eglot
;;   :config (eglot-booster-mode))
;; Marksman
;; marksman for markdown (no +lsp option for markdown in Doomemacs init.el file)
;; LSP-mode
;; (use-package markdown-mode
;;   :hook (markdown-mode . lsp)
;;   :config
;;   (require 'lsp-marksman))
;; Eglot
;; (not needed since Marksman is implicitly added to Eglot)
;; (use-package markdown-mode
;;   :hook (markdown-mode . eglot-{}))


;; Citar
;; citations using Citar
;; path config for use of citar for vertico
(use-package citar
  :no-require
  :custom
  (org-cite-global-bibliography '("~/sty/articles/bib/cite.bib"))
  (org-cite-insert-processor 'citar)
  (org-cite-follow-processor 'citar)
  (org-cite-activate-processor 'citar)
  (citar-bibliography org-cite-global-bibliography)
  (citar-library-paths '("~/sty/articles/"))
  (citar-notes-paths '("~/notx/notes.org"))
  :config
  (setq citar-at-point-function 'embark-act)
  :hook
  (org-mode . citar-capf-setup))
;; (setq! citar-bibliography '("~/sty/articles/bib/cite.bib")
;;        citar-library-paths '("~/sty/articles/")
;;        citar-notes-paths '("~/notx/notes.org"))


;; LaTeX
;; LaTeX parsing using AucTeX
(use-package auctex
  :ensure t
  :config
  (setq TeX-auto-save t
        TeX-parse-self t))

(use-package cdlatex
  :defer t
  :init
  (add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)
  :config
  (map! :map cdlatex-mode-map
        :desc "Press TAB while in Insert mode in a LaTeX document to invoke CDLaTeX Tab function"
        :i "TAB" #'cdlatex-tab))

(use-package reftex
  :defer t
  :init
  (add-hook 'LaTeX-mode-hook #'turn-on-reftex)
  :config
  (setq reftex-default-bibliography "~/sty/articles/bib/cite.bib"
        reftex-plug-into-AUCTeX t
        reftex-cite-format 'natbib))
;; (use-package auctex)
;; ;; live-preview using AucTeX to pdf-viewer
;; ;; (setq +latex-viewers '(pdf-tools)) ;; set pdf-tools as default pdf viewer
;; (setq +latex-viewers '(zathura)) ;; set zathura as default pdf viewer
;; ;; set default bibliography for RefTeX
;; (setq reftex-default-bibliography
;;       "~/sty/articles/bib/cite.bib")
;; ;; LSP for LaTeX
;; ;; however, we're using eglot, instead of lsp-mode, as LSP server
;; ;; (setq lsp-tex-server 'texlab) ;; set texlab as default LaTeX LSP server with lsp-mode server
;; ;; live-preview using xenops inside Emacs LaTeX buffer
;; ;; use M-x xenops-mode
;; ;; cdlatex minor mode for all LaTeX files
;; (add-hook 'LaTeX-mode-hook #'turn-on-cdlatex) ;; for AucTeX LaTeX mode
;; ;; (add-hook 'latex-mode-hook #'turn-on-cdlatex) ;; for Emacs latex mode
;; ;; prioritize cdlatex for autocompletion in LaTeX file, over Yasnippets
;; (map! :map cdlatex-mode-map
;;       :i "TAB" #'cdlatex-tab) ;; pressing TAB while in insert mode, calls cdlatex-tab function


;; elfeed
;; org feed file for elfeed
;; (from [[https://github.com/remyhonig/elfeed-org?tab=readme-ov-file#installation][elfeed-org]])
(use-package elfeed-org
  :defer t
  :init
  (elfeed-org)
  :config
  (setq rmh-elfeed-org-files (list "~/notx/elfeed.org")))
;; (require 'elfeed-org) ;; load elfeed-org
;; (elfeed-org) ;; initializes elfeed-org ;; hooks up elfeed-org to read configuration when =M-x elfeed=
;; (setq rmh-elfeed-org-files (list "~/notx/elfeed.org"))


;; auth-sources
(use-package auth-source
  :defer t
  :config
  (setq auth-sources '("~/.local/share/authinfo.gpg"))
  (auth-source-pass-enable)
  (auth-source-pass-file-name-p (list "~/.local/share/pass/")))
;; (setq auth-sources '("~/.local/share/authinfo.gpg"))
;; ;; use pass
;; (auth-source-pass-enable)
;; (auth-source-pass-file-name-p (list "~/.local/share/pass/"))


;; Emacs-Everywhere
(use-package emacs-everywhere
  :config
  (setq emacs-everywhere-major-mode-function #'org-mode))


;; mu4e
(use-package mu4e
  :defer t
  :custom
  (set-variable 'read-mail-command 'mu4e)
  (setq mail-user-agent 'mu4e-user-agent
        mu4e-change-filenames-when-moving t
        mu4e-get-mail-command "/usr/bin/mbsync -c ~/.config/isync/mbsyncrc -a"
        mu4e-attachment-dir "~/dl/"
        sendmail-program "/usr/bin/msmtp"
        mu4e-sent-messages-behavior 'delete
        mu4e-search-skip-duplicates t
        message-kill-buffer-on-exit t
        mu4e-search-results-limit -1)
  :config
  (load "~/.config/doom/mu4e-credentials.el")
  (add-hook 'mu4e-compose-mode-hook #'(lambda () (auto-save-mode -1))))
;; (use-package mu4e
;;   :ensure nil
;;   :config
;;   ;; use mu4e to compose email in emacs
;;   (setq mail-user-agent 'mu4e-user-agent)
;;   ;; use mu4e to read email in emacs
;;   (set-variable 'read-mail-command 'mu4e)
;;   ;; rename files while moving between directories
;;   ;; to not trouble the default UID naming scheme of mbsync
;;   (setq mu4e-change-filenames-when-moving t)
;;   (setq mu4e-get-mail-command "/usr/bin/mbsync -c ~/.config/isync/mbsyncrc -a")
;;   ;; (setq mu4e-update-interval (* 10 60))
;;   (setq mu4e-maildir "~/.local/share/maildir/")
;;   (setq mu4e-attachment-dir "~/dl/")
;;   (setq sendmail-program "/usr/bin/msmtp")
;;   ;; don't save messages to Sent messages, Gmail/IMAP takes care of this
;;   (setq mu4e-sent-messages-behavior 'delete)
;;   ;; skip duplicate messages, due to representation of Gmail labels/virtual folders by mbsync
;;   (setq mu4e-search-skip-duplicates t)
;;   ;; don't autosave drafts
;;   (add-hook 'mu4e-compose-mode-hook #'(lambda () (auto-save-mode -1)))
;;   ;; don't keep message buffers around
;;   (setq message-kill-buffer-on-exit t)
;;   ;; show images
;;   (setq mu4e-show-images t)
;;   ;; don't limit search results to 500 (default)
;;   (setq mu4e-search-results-limit -1)
;;   (load "~/.config/doom/mu4e-credentials.el")
;;   )

;; common lisp, mostly for nyxt browser
;; use slime
;; (setq inferior-lisp-program "/usr/bin/clisp")
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
;; (require 'slime)
;; (evil-collection-slime-setup)

;; Custom Keybindings
;; consult-fd
;; since, locate is not used on my system, let's replace consult-locate with consult-fd
;; Doomemacs binds <SPC>-s-f to consult-locate, rebind it to consult-fd
(map!
 :leader
 :prefix ("s" . "search")
 :desc "Find file"
 "f" (cmd! (consult-fd "~")))

;; helpful-at-point
(map!
 :leader
 :prefix ("h" . "help")
 :desc "Help at point"
 "h" #'helpful-at-point)

;; org-paste-subtree
(map!
 :after org
 :map org-mode-map
 :localleader
 :prefix "s"
 :desc "org-paste-subtree"
 "p" #'org-paste-subtree)
