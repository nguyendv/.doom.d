;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(if (file-directory-p "~/Dropbox/Notes")
    (setq org-directory "~/Dropbox/Notes"))
(if (file-directory-p "~/Dropbox/Notes")
    (setq org-agenda-files (directory-files-recursively "~/Dropbox/Notes/" "\\.org$")))

 ;; Custom agenda views
(setq org-agenda-custom-commands
'(
        ("2" "+/- 1w Agenda" (
                        (tags-todo "SCHEDULED>=\"<-1w>\"&SCHEDULED<\"<+1w>\""
                                ((org-agenda-overriding-header "2 weeks Schedule:")
                                (org-agenda-entry-types '(:scheduled :deadline))))

        )
        )
)
)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; lsp optimization
(setq lsp-optimization-mode t)

(after! org
   (setq org-todo-keywords
        '((sequence
           "TODO(t)"  ; A task that needs doing & is ready to do
           "STRT(s)"  ; A task that is in progress
           "WAIT(w)"  ; Something external is holding up this task
           "REFLECT(f)"; A completed task but still needs to refect
           "|"
           "DONE(d)"  ; Task successfully completed
           "KILL(k)"))))


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! lsp-mode
  (lsp-register-client
    (make-lsp-client
      :new-connection (lsp-tramp-connection '("typescript-language-server" "--stdio"))
      :major-modes '(typescript-mode)
      :remote? t
      :server-id 'ts-ls-remote))
  ;;(setq lsp-log-io t)  ;; without this line the ts lang server is tuck at /starting. Need investigating
  )

;; for .ts, I use prettier instead of lsp format,,
(after! typescript-mode (setq +format-with-lsp nil))
