;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;; tangled from ~/.config/doom.org, read it for documentation

(use-package server
  :ensure t
  :config
  (unless (server-running-p) (server-start)))

(setq user-full-name "ts")

(use-package auth-source
  :defer t
  :config
  (setq auth-sources '("~/.local/share/authinfo.gpg"))
  (auth-source-pass-enable)
  (auth-source-pass-file-name-p (list "~/.local/share/pass/")))

(use-package doom-ui
  :ensure t
  :config
  (setq doom-font (font-spec :family "JetBrains Mono" :weight 'regular :size 24)
        doom-variable-pitch-font (font-spec :family "Source Sans Pro")
        doom-serif-font (font-spec :family "DejaVu Serif")
        doom-symbol-font (font-spec :family "Noto Color Emoji")
        doom-theme 'doom-one))

(setq display-line-numbers-type 'relative)

(setopt grep-command "grep --color=auto -rnHiI -C2 -e ")

(use-package smartparens
  :ensure t
  :defer t
  :config
  (require 'smartparens-config))

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

(use-package ox-md
  :after org
  :defer t)



(use-package org-id
  :after org
  :config
  (setq org-id-method 'uuid
        org-id-link-to-org-use-id t))

(use-package org-protocol
  :defer t)

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

(use-package yasnippet
  :defer t
  :init
  (setq yas-snippet-dirs
        '("~/.config/doom/snippets/"))
  :config
  (yas-global-mode 1)) ;; enable yasnippets globally

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

(use-package elfeed-org
  :defer t
  :init
  (elfeed-org)
  :config
  (setq rmh-elfeed-org-files (list "~/notx/elfeed.org")))

(use-package emacs-everywhere
  :config
  (setq emacs-everywhere-major-mode-function #'org-mode))

(map!
 :leader
 :prefix ("s" . "search")
 :desc "Find file"
 "f" (cmd! (consult-fd "~")))

(map!
 :leader
 :prefix ("h" . "help")
 :desc "Help at point"
 "h" #'helpful-at-point)

(map!
 :after org
 :map org-mode-map
 :localleader
 :prefix "s"
 :desc "org-paste-subtree"
 "p" #'org-paste-subtree)
