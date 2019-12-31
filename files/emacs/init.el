;; When this is after the CUSTOMIZE section, the custom-enabled-themes theme is not loaded properly.
(package-initialize)

;; CUSTOMIZE (modularize this out eventually).
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (doom-challenger-deep)))
 '(custom-safe-themes
   (quote
    ("bc99493670a29023f99e88054c9b8676332dda83a37adb583d6f1e4c13be62b8" "4b0b568d63b1c6f6dddb080b476cfba43a8bbc34187c3583165e8fb5bbfde3dc" "92d8a13d08e16c4d2c027990f4d69f0ce0833c844dcaad3c8226ae278181d5f3" default)))
 '(fci-rule-color "#505050")
 '(jdee-db-active-breakpoint-face-colors (cons "#1b1d1e" "#fc20bb"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1b1d1e" "#60aa00"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1b1d1e" "#505050"))
 '(objed-cursor-color "#d02b61")
 '(package-selected-packages
   (quote
    (projectile yaml-mode json-mode gitignore-mode jinja2-mode systemd doom-themes dockerfile-mode yasnippet company-lsp company lsp-ui go-mode go-rename lsp-mode)))
 '(paradox-github-token t)
 '(pdf-view-midnight-colors (cons "#dddddd" "#1b1d1e"))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(vc-annotate-background "#1b1d1e")
 '(vc-annotate-color-map
   (list
    (cons 20 "#60aa00")
    (cons 40 "#859f0d")
    (cons 60 "#aa931a")
    (cons 80 "#d08928")
    (cons 100 "#d38732")
    (cons 120 "#d6863d")
    (cons 140 "#da8548")
    (cons 160 "#ce8379")
    (cons 180 "#c281aa")
    (cons 200 "#b77fdb")
    (cons 220 "#bf63b2")
    (cons 240 "#c74789")
    (cons 260 "#d02b61")
    (cons 280 "#b0345c")
    (cons 300 "#903d58")
    (cons 320 "#704654")
    (cons 340 "#505050")
    (cons 360 "#505050")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka" :foundry "CYEL" :slant normal :weight normal :height 112 :width normal)))))


;; IDO mode settings.
;; See https://masteringemacs.org/article/introduction-to-ido-mode
(require 'ido)
(setq ido-enable-flex-matching t
      ido-everywhere t)
(ido-mode t)

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
