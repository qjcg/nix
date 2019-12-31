(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#E5E9F0" "#99324B" "#4F894C" "#9A7500" "#3B6EA8" "#97365B" "#398EAC" "#3B4252"])
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (JG_doom-challenger-deep_readable-comments)))
 '(custom-safe-themes
   (quote
    ("75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "6515fcc302292f29a94f6ac0c5795c57a396127d5ea31f37fc5f9f0308bbe19f" "6b289bab28a7e511f9c54496be647dc60f5bd8f9917c9495978762b99d8c96a0" "4098d428e5298702e6eed2602da99bcb044fdc604576d0216315efd39014f930" "6d589ac0e52375d311afaa745205abb6ccb3b21f6ba037104d71111e7e76a3fc" "bdb4509c123230a059d89fc837c40defdecee8279c741b7f060196b343b2d18d" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" "ed17fef69db375ae1ced71fdc12e543448827aac5eb7166d2fd05f4c95a7be71" "5a45c8bf60607dfa077b3e23edfb8df0f37c4759356682adf7ab762ba6b10600" "fe666e5ac37c2dfcf80074e88b9252c71a22b6f5d2f566df9a7aa4f9bea55ef8" "08a89acffece58825e75479333109e01438650d27661b29212e6560070b156cf" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "fd944f09d4d0c4d4a3c82bd7b3360f17e3ada8adf29f28199d09308ba01cc092" "a8c210aa94c4eae642a34aaf1c5c0552855dfca2153fa6dd23f3031ce19453d4" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" default)))
 '(dashboard-center-content t)
 '(dashboard-set-heading-icons t)
 '(dashboard-set-navigator nil)
 '(debug-on-error t)
 '(epa-pinentry-mode (quote loopback))
 '(fci-rule-color "#AEBACF")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(inhibit-startup-echo-area-message t)
 '(inhibit-startup-screen t)
 '(jdee-db-active-breakpoint-face-colors (cons "#F0F4FC" "#5d86b6"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#F0F4FC" "#4F894C"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#F0F4FC" "#B8C5DB"))
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode nil)
 '(mouse-yank-at-point t)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(objed-cursor-color "#99324B")
 '(package-selected-packages
   (quote
    (elpher emojify doom-modeline git-gutter-fringe keycast imenu-list circadian solarized-theme projectile easy-hugo flymd rainbow-delimiters exwm-randr exwm-config pkgbuild-mode exwm basic-mode esup restclient dmenu buttons camcorder blacken go-complete go-scratch elfeed-org god-mode py-autopep8 elpy use-package go-mode ghub git-commit magit-popup with-editor elfeed sudo-edit alda-mode flycheck go-autocomplete go-direx go-dlv go-rename char-menu chess dashboard decide discover-my-major doom-themes fortune-cookie go-eldoc go-guru gorepl-mode green-screen-theme hacker-typer html-to-markdown keyfreq nofrils-acme-theme olivetti paradox pass password-store pomidor skeletor speed-type systemd terraform-mode timesheet typit vagrant writeroom-mode slime yaml-mode markdown-mode magit go-playground ansible-doc ansible)))
 '(paradox-automatically-star t)
 '(paradox-execute-asynchronously t)
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(scroll-bar-mode nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 465)
 '(smtpmail-stream-type (quote ssl))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tool-bar-mode nil)
 '(user-full-name "John Gosset")
 '(user-mail-address "john@gossetx.com")
 '(vc-annotate-background "#E5E9F0")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (list
    (cons 20 "#4F894C")
    (cons 40 "#688232")
    (cons 60 "#817b19")
    (cons 80 "#9A7500")
    (cons 100 "#a0640c")
    (cons 120 "#a65419")
    (cons 140 "#AC4426")
    (cons 160 "#a53f37")
    (cons 180 "#9e3a49")
    (cons 200 "#97365B")
    (cons 220 "#973455")
    (cons 240 "#983350")
    (cons 260 "#99324B")
    (cons 280 "#a0566f")
    (cons 300 "#a87b93")
    (cons 320 "#b0a0b6")
    (cons 340 "#AEBACF")
    (cons 360 "#AEBACF")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dashboard-banner-logo-title ((t (:inherit default :foreground "gold" :weight bold :height 2.0 :family "Symbola"))))
 '(dashboard-footer ((t (:inherit font-lock-doc-face :slant italic))))
 '(dashboard-heading ((t (:inherit font-lock-keyword-face :height 1.3))))
 '(eshell-prompt ((t (:foreground "spring green" :weight bold))))
 '(font-lock-comment-face ((t (:foreground "dark gray"))))
 '(variable-pitch ((t (:family "Noto Serif")))))
