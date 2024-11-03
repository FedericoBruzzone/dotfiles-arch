(setq custom-file "~/.emacs.d/.emacs.custom.el")
(load-file custom-file)

;; (setq split-width-threshold nil)                   ; (setq split-width-threshold 1) -> for horizontal split.
(load-theme 'modus-themes)                           ; Load theme - 'leuven-dark
(tool-bar-mode -1)                                 ; Disable the toolbar
(scroll-bar-mode -1)                               ; Disable visible scrollbar
(menu-bar-mode -1)                                 ; Disable the menu bar
(setq inhibit-startup-message t)                   ; Hide the startup message
(setq visible-bell t)                              ; Set up the visible bell
(ido-mode 1)                                       ; Enable ido-mode
(ido-everywhere 1)                                 ; Enable ido-mode everywhere
(global-display-line-numbers-mode t)               ; Enable line numbers
(setq display-line-numbers-type 'relative)         ; Relative line numbers
(winner-mode 1)                                    ; Enable winner mode for window configuration
(setq-default indent-tabs-mode nil)                ; Disable tabs
(setq-default tab-width 4)                         ; Set the tab width (adjust as needed)
(set-frame-font "Fira Mono 14" nil t)              ; Set the font

;; Set auto revert mode for doc-view
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(setq auto-revert-interval 1) ;; checks for changes every 1 second

;; Set path to include TeXLive
(setenv "PATH" (concat "/usr/local/texlive/2024/bin/x86_64-linux:" (getenv "PATH")))
(setq exec-path (append exec-path '("/usr/local/texlive/2024/bin/x86_64-linux")))
;; Set path to use java21
(setenv "PATH" (concat "/usr/lib/jvm/java-21-openjdk/bin:" (getenv "PATH")))
(setq exec-path (append exec-path '("/usr/lib/jvm/java-21-openjdk/bin")))
(setq lsp-java-jdt-download-url "https://www.eclipse.org/downloads/download.php?file=/jdtls/milestones/1.37.0/jdt-language-server-1.37.0-202406271335.tar.gz") ; https://github.com/emacs-lsp/lsp-java/issues/478
;; Set path to include rust-analyzer
(setenv "PATH" (concat "/home/fcb/.cargo/bin:" (getenv "PATH")))
(setq exec-path (append exec-path '("/home/fcb/.cargo/bin")))

;; Backup files in a separate directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
)

;; Auto save file in a separate directory
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save-list/" t)))

;; =============== Set global keybindings ===============
;; Map C-{ to backward-paragraph
(global-set-key (kbd "C-{") 'backward-paragraph)

;; Map C-} to forward-paragraph
(global-set-key (kbd "C-}") 'forward-paragraph)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Enable revert-buffer
(global-set-key (kbd "C-x r") 'revert-buffer)

;; Duplicate line
(defun fcb/duplicate-line()
  "Duplicate the current line and keep the cursor in place."
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))
(global-set-key (kbd "C-,") 'fcb/duplicate-line)

;; =========================================

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

; Set up the straight package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Smex configuration - it is used to improve M-x with better sorting
(use-package smex
  :ensure t
  :bind
  ("M-x" . smex)
  ("M-X" . smex-major-mode-commands)
  ("C-c C-c M-x" . execute-extended-command)
  :config
  (setq smex-save-file "~/.emacs.d/.smex-items"))
(smex-initialize)

;; Multiple cursors configuration
(use-package multiple-cursors
  :ensure t
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C-<" . mc/mark-next-like-this)
  ("C->" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this)
  ("C-\"" . mc/skip-to-next-like-this)
  ("C-:" . mc/skip-to-previous-like-this))

;; Lsp mode configuration
  (use-package lsp-mode
    :ensure t
    :commands lsp
    :custom
    (lsp-rust-analyzer-cargo-watch-command "clippy")
    (lsp-rust-analyzer-rustc-source "discover")
    ;; enable / disable the hints as you prefer:
    ;; (lsp-inlay-hint-enable t)
    :bind
    ("C-c C-c l" . flycheck-list-errors)
    ("C-c C-c r" . lsp-rename)
    ("C-c C-c a" . lsp-execute-code-action)
    ("C-c C-c f" . lsp-format-buffer)
    ("C-c C-c d" . lsp-ui-doc-show)
    ("C-c C-c u" . lsp-find-references)
    :hook
    (rust-mode . lsp)
    (c-mode . lsp)
    (python-mode . (lambda ()
                     (require 'lsp-pyright)
                     (lsp)))
    (tuareg-mode . lsp)
    (java-mode . lsp))
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)
(use-package flycheck
  :ensure t)
(setq flycheck-highlighting-mode 'lines)
(use-package company
  :ensure t
  :custom
  (company-idle-delay 0.1) ;; 0.5 how long to wait until popup
  (company-minimum-prefix-length 1)
  ;; (company-begin-commands nil) ;; uncomment to disable popup
  :bind
  (:map company-active-map
	      ("C-n". company-select-next)
	      ("C-p". company-select-previous)
	      ("M-<". company-select-first)
	      ("M->". company-select-last)))
;; Enable company-mode globally
(add-hook 'after-init-hook 'global-company-mode)

;; Rust configuration
;;; Rust mode
(use-package rust-mode
  :ensure t
  ;; :config
  ;; (setq rust-format-on-save t)
  )

;; Python configuration
;;; Python LSP
(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
  )

;; OCaml configuration
;;; Ocaml mode
(use-package tuareg
  :ensure t
  :mode (("\\.ocamlinit\\'" . tuareg-mode)))
;;; Dune mode
(use-package dune
  :ensure t)
;;; OCaml LSP
(use-package merlin
  :ensure t
  :config
  (add-hook 'tuareg-mode-hook #'merlin-mode)
  (add-hook 'merlin-mode-hook #'company-mode)
  ;; we're using flycheck instead
  (setq merlin-error-after-save nil))
(use-package merlin-eldoc
  :ensure t
  :hook ((tuareg-mode) . merlin-eldoc-setup))
;;; OCaml Flycheck
(use-package flycheck-ocaml
  :ensure t
  :config
  (add-hook 'tuareg-mode-hook
            (lambda ()
              ;; disable Merlin's own error checking
              (setq-local merlin-error-after-save nil)
              ;; enable Flycheck checker
              (flycheck-ocaml-setup))))
;;; OCaml utop
(use-package utop
  :ensure t
  :config
  (add-hook 'tuareg-mode-hook #'utop-minor-mode))
;;; OCaml hook
(add-hook 'tuareg-mode-hook
          (lambda () (require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")))
;; ;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
;; (require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ;; ## end of OPAM user-setup addition for emacs / base ## keep this line

;;; Java configuration
(use-package lsp-java
  :ensure t)

;; Copilot configuration
(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :ensure t
  :init
  ;; Disable copilot in prog-mode by default
  (add-hook 'prog-mode-hook (lambda () (copilot-mode -1)))
  :config
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "C-TAB") 'copilot-accept-completion-by-word)
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

;; ====== USELESS =====
;; ;; Move text up and down
;; (defun move-text-internal (arg)
;;    (cond
;;     ((and mark-active transient-mark-mode)
;;      (if (> (point) (mark))
;;             (exchange-point-and-mark))
;;      (let ((column (current-column))
;;               (text (delete-and-extract-region (point) (mark))))
;;        (forward-line arg)
;;        (move-to-column column t)
;;        (set-mark (point))
;;        (insert text)
;;        (exchange-point-and-mark)
;;        (setq deactivate-mark nil)))
;;     (t
;;      (beginning-of-line)
;;      (when (or (> arg 0) (not (bobp)))
;;        (forward-line)
;;        (when (or (< arg 0) (not (eobp)))
;;             (transpose-lines arg))
;;        (Forward-line -1)))))
;; (defun move-text-down (arg)
;;    "Move region (transient-mark-mode active) or current line arg lines down."
;;    (interactive "*p")
;;    (move-text-internal arg))
;; (global-set-key (kbd "M-S-<up>") 'move-text-up)
;; (defun move-text-up (arg)
;;    "Move region (transient-mark-mode active) or current arg lines up."
;;    (interactive "*p")
;;    (move-text-internal (- arg)))
;; (global-set-key (kbd "M-S-<down>") 'move-text-down)
;; ;; Map M-p to my-goto-next-word-first-letter
;; (defun my-goto-next-word-first-letter ()
;;   "Move point to the first letter of the next word."
;;   (interactive)
;;   (forward-word)
;;   (forward-char))
;; (global-set-key (kbd "M-p") 'my-goto-previous-word-first-letter)
;; ;; Map M-n to my-goto-next-word-first-letter
;; (defun my-goto-previous-word-first-letter ()
;;   "Move point to the first letter of the previous word."
;;   (interactive)
;;   (backward-word)
;;   (backward-char))
;; (global-set-key (kbd "M-n") 'my-goto-next-word-first-letter)

;; Projectile configuration
;; (use-package projectile
;;   :ensure t
;;   :config
;;   (projectile-mode +1)
;;   (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

;; Set initial size of the frame
;; (setq initial-frame-alist
;;       (append initial-frame-alist
;;               '((left   . 100)
;;                 (top    . 100)
;;                 (width  . 150)
;;                 (height . 30))))

;; Fzf configuration
;; (use-package fzf
;;   :ensure t
;;   :bind
;;   ("C-c f" . fzf)
;;   ("C-c g" . fzf-grep)
;;   ("C-c b" . fzf-switch-buffer)
;;   ("C-c x" . fzf-directory)
;;   ("C-c z" . fzf-find-in-buffer)
;;   ("C-c d" . fzf-change-and-open-directory)
;;   :config
;;   (setq fzf/args "-x --color bw --print-query --margin=1,0 --no-hscroll"
;;         fzf/executable "fzf"
;;         fzf/git-grep-args "-i --line-number %s"
;;         ;; command used for `fzf-grep-*` functions
;;         ;; example usage for ripgrep:
;;         ;; fzf/grep-command "rg --no-heading -nH"
;;         fzf/grep-command "grep -nrH"
;;         ;; If nil, the fzf buffer will appear at the top of the window
;;         fzf/position-bottom t
;;         fzf/window-height 15)
;;   (defun fzf-change-and-open-directory ()
;;     "Change and open the current directory using fzf."
;;     (interactive)
;;     (fzf-with-command "find ~ -type d" (lambda (dir)
;; 					 (setq default-directory (file-name-as-directory dir))
;; 					 (dired dir)))
;;     (message "Changed directory to %s" default-directory)))
