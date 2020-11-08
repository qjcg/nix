;; When this is after the CUSTOMIZE section, the custom-enabled-themes theme is not loaded properly.
(package-initialize)

;; Use a *separate* file for customizations.
;; See M-x customize
(setq custom-file "~/.config/emacs/custom.el")
(unless (file-exists-p custom-file)
  (make-directory
(load custom-file)

;; IDO mode settings.
;; See https://masteringemacs.org/article/introduction-to-ido-mode
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-everywhere t
      ido-create-new-buffer 'always
)


;; Enable MELPA repo.
;; See https://github.com/melpa/melpa#usage
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)


;; Go Settings.
;; See: https://arenzana.org/2019/12/emacs-go-mode-revisited/
(use-package lsp-mode
  :ensure
  :commands (lsp lsp-deferred)
  :hook (go-mode . lsp-deferred))

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :init
  (setq lsp-ui-doc-enable t
	lsp-ui-peek-enable t
	lsp-ui-sideline-enable t
	lsp-ui-imenu-enable t
	lsp-ui-flycheck-enable t))

;; Company mode is a standard completion package that works well with lsp-mode.
;; company-lsp integrates company mode completion with lsp-mode.
;; completion-at-point also works out of the box but doesn't support snippets.
(use-package company
  :ensure
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1))

(use-package company-lsp
  :ensure
  :commands company-lsp)

;; Optional - provides snippet support.
(use-package yasnippet
  :ensure
  :commands yas-minor-mode
  :hook (go-mode . yas-minor-mode))

(defun custom-go-mode ()
  (display-line-numbers-mode 1))

(use-package go-mode
  :defer t
  :ensure
  :mode ("\\.go\\'" . go-mode)
  :init
  (setq compile-command "echo Building... && go build -v && echo Testing... && go test -v && echo Linter... && golint")  
  (setq compilation-read-command nil)
  (add-hook 'go-mode-hook 'custom-go-mode)
  :bind (("M-," . compile)
	 ("M-." . godef-jump)))

(setq compilation-window-height 14)
(defun my-compilation-hook ()
  (when (not (get-buffer-window "*compilation*"))
    (save-selected-window
      (save-excursion
	(let* ((w (split-window-vertically))
	       (h (window-height w)))
	  (select-window w)
	  (switch-to-buffer "*compilation*")
	  (shrink-window (- h compilation-window-height)))))))
(add-hook 'compilation-mode-hook 'my-compilation-hook)

(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(setq compilation-scroll-output t)

(use-package projectile
  :ensure
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package dumb-jump
  :ensure
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g b" . dumb-jump-back)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
  )

(defhydra dumb-jump-hydra (:color blue :columns 3)
  "Dumb Jump"
  ("j" dumb-jump-go "Go")
  ("o" dumb-jump-go-other-window "Other window")
  ("e" dumb-jump-go-prefer-external "Go external")
  ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
  ("i" dumb-jump-go-prompt "Prompt")
  ("l" dumb-jump-quick-look "Quick look")
  ("b" dumb-jump-back "Back"))

(use-package all-the-icons :ensure)
(use-package bug-hunter :ensure)
(use-package discover-my-major :ensure)
(use-package dockerfile-mode :ensure)
(use-package doom-themes :ensure)
(use-package gitignore-mode :ensure)
(use-package hydra :ensure)
(use-package jinja2-mode :ensure)
(use-package json-mode :ensure)
(use-package nix-mode :ensure)
(use-package olivetti :ensure)
(use-package page-break-lines :ensure)
(use-package paradox :ensure)
(use-package systemd :ensure)
(use-package yaml-mode :ensure)

;; FIXME: Using the dashboard package results in a VERY slow startup on eiffel. Fix before re-enabling.
;; (use-package dashboard
;;   :ensure
;;   :requires page-break-lines
;;   :init
;;   (setq	dashboard-center-content t
;; 	dashboard-banner-logo-title "My Dashboard"
;; 	dashboard-show-shortcuts t
;; 	dashboard-items '((recents  . 5)
;; 			  (bookmarks . 5)
;; 			  (projects . 5)
;; 			  (registers . 5))
;; 	dashboard-set-navigator t
;; 	dashboard-set-init-info t
;; 	dashboard-set-heading-icons t
;; 	dashboard-set-file-icons t
;; 	)
;;   :config
;;   (dashboard-setup-startup-hook)
;;   )

(use-package neotree
  :ensure
  :config
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))
