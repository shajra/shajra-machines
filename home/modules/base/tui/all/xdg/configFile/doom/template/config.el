;;; -*- lexical-binding: t; -*-


;; Simple settings

;; DESIGN: See how bad this is or isn't on a Mac
;;(let ((scale (if (eq system-type 'darwin) 1.5 1.0)))
  (setq-default
   doom-font                (font-spec :family "@theme_font_mono_code@")
   doom-serif-font          (font-spec :family "@theme_font_mono_serif@")
   doom-unicode-font        (font-spec :family "FreeSerif")  ; alternative to Symbola
   doom-variable-pitch-font (font-spec :family "@theme_font_proportional@")
   )
;;)

(setq-default
 dante-methods '(alt-stack-project alt-cabal)
 doom-large-file-size-alist '(("/TAGS\\([.]local\\)?$". 50.0) ("." . 1.0))
 doom-modeline-major-mode-icon t
 doom-theme '@theme_doom_name@
 fancy-splash-image "~/.config/doom/snowman.png"
 fill-column 80
 +haskell-dante-xref-enable nil
 haskell-hoogle-command nil
 lsp-haskell-formatting-provider "stylish-haskell"
 lsp-haskell-server-path "haskell-language-server-wrapper"
 org-agenda-show-all-dates nil
 org-log-into-drawer t
 org-startup-folded 'content
 projectile-project-search-path '(("~/src/work" . 2) ("~/src/shajra" . 2))
 warning-suppress-types '((with-editor))
 whitespace-line-column 79
 x-select-enable-clipboard (eq system-type 'darwin))

(add-to-list '+org-babel-mode-alist '(fish . shell))

;; DESIGN: light override of Solarized Light theme
;;
(custom-set-faces!
  `(cursor :background ,(doom-color '@theme_color_unifying@)))


;; Function calls

(doom/set-indent-width 4)
(global-display-fill-column-indicator-mode)
(after! treemacs (treemacs-follow-mode))


;; Hooks

;; DESIGN: font with Haskell ligatures, but restricted to Haskell code
(add-hook! haskell-mode
  (setq buffer-face-mode-face '(:family "Hasklug Nerd Font"))
  (buffer-face-mode))

;; DESIGN: maybe redundant with the default, but using etags with xref
(after! xref
  (add-hook 'xref-backend-functions 'etags--xref-backend))

;; DESIGN: Doom dashboard looks bad with an indicator
;; DESIGN: consider deleting if it looks fine on a Mac (fixed upstream)
;(add-hook! +doom-dashboard-mode :append
;  (display-fill-column-indicator-mode -1))

;; DESIGN: need to load after Doom to change Doom settings
(after! org-fancy-priorities
  (setq-default
   org-priority-default 4
   org-priority-highest 1
   org-priority-lowest  5
   ;;(?A . "🅐") (?B . "🅑") (?C . "🅒") (?D . "🅓")
   ;;(?A . "🅰") (?B . "🅱") (?C . "🅲") (?D . "🅳")
   ;;(?A . "🄰") (?B . "🄱") (?C . "🄲") (?D . "🄳")
   ;;(?1 . " ") (?2 . " ") (?3 . " ") (?4 . " ") (?5 . " ")
   ;;(?1 . " ") (?2 . " ") (?3 . " ") (?4 . " ") (?5 . " ")
   ;;(?1 . " ") (?2 . " ") (?3 . " ") (?4 . " ") (?5 . " ")
   ;;(?1 . "⓵") (?2 . "⓶") (?3 . "⓷") (?4 . "⓸") (?5 . "⓹")
   ;;(?1 . "🌑") (?2 . "🌒") (?3 . "🌓") (?4 . "🌔") (?5 . "🌕")
   ;;(?1 . "🌕") (?2 . "🌔") (?3 . "🌓") (?4 . "🌒") (?5 . "🌑")
   org-fancy-priorities-list
   '((?A . "🅐") (?B . "🅑") (?C . "🅒") (?D . "🅓")
     (?1 . "🌑") (?2 . "🌒") (?3 . "🌓") (?4 . "🌔") (?5 . "🌕"))))

;; DESIGN: not indenting by default for long prose, but indenting agenda items
(add-hook! org-load :append
  (setq-default org-startup-indented nil))
(add-hook! org-mode :append
  (if (+org-agenda-files-includes? (buffer-name))
      (org-indent-mode)))

;; DESIGN: some configuration is more personal...
(load! "managed" "~/.config/doom-local" t)
(load! "unmanaged" "~/.config/doom-local" t)
