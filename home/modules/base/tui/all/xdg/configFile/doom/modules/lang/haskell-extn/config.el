;;; -*- lexical-binding: t; -*-


(when (or (modulep! +lsp) (modulep! +dante))

  (defcustom +haskell-backend
    (cond
     ((modulep! +lsp) 'lsp)
     ((modulep! +dante) 'dante))
    "Backend to use for Haskell support.

There's a variety of packages that support Haskell for Emacs.  There has always
been ‘haskell-mode’ which a solid base of features (see
http://haskell.github.io/haskell-mode/manual/latest/ for a full list).

However, for all the great things ‘haskell-mode’ has, it's missing features
people may expect from modern IDEs, for instance good interactive feedback of
errors.  You can use ‘flycheck’ for this, which does have some Haskell support,
however, this does a complete build to get compilation errors, which can be slow
on large projects.

To get faster feedback with incremental builds we have two options:

- ‘dante-mode’ (https://github.com/jyp/dante)
- ‘lsp-haskell’ (https://github.com/emacs-lsp/lsp-haskell)"
    :type '(radio
            (const :tag "Disabled" ())
            (const :tag "Dante" dante)
            (const :tag "LSP" lsp))
    :group 'haskell)

  (defcustom +haskell-exclude-regexes
    '("/\\.haskdogs/"
      "/\\.codex/"
      "/\\.stack/"
      "/\\.stack-work/"
      "^/run/user/"
      "^/nix/store/")
    "Regular expressions to exclude buffers from ‘dante-mode’ and ‘lsp-mode’.

Source code doesn't always have well-formed project files, which prevents Dante
from loading. This happens in particular with source downloaded with tools like
Haskell's haskdogs and codex."
    :type '(set regexp)
    :group 'haskell)

  (after! (haskell-mode flycheck)
    (add-hook! haskell-mode-local-vars #'+haskell--checkers-disable-h)
    (add-hook! haskell-literate-mode #'+haskell--checkers-disable-h)))

(when (modulep! +dante)
  (load! "+dante"))

(when (modulep! +lsp)
  (load! "+lsp"))
