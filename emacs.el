;; Packages
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; General options
(scroll-bar-mode 0)
(tool-bar-mode 0)
(setq semantic-mode t)
(show-paren-mode t)
(setq column-number-mode t)
(setq-default indent-tabs-mode nil)

;; OSX options
(if (eq system-type 'darwin)
    (setq mac-option-modifier nil
          mac-command-modifier 'meta
          mac-allow-anti-aliasing t
          x-select-enable-clipboard t))

(set-default-font "Fira Mono OT 11")

;; Themes
(load-theme 'zenburn t)

;; Whitespace mode
(setq whitespace-style
      '(face trailing tabs lines-tail empty indentation::tabs))
(set-face-attribute 'whitespace-tab nil :background "#4F4F4F")

;; FCI mode
(setq fci-rule-column 80)

;; Erlang mode
(when (require 'erlang)
  (add-hook 'erlang-mode-hook 'fci-mode)
  (add-hook 'erlang-mode-hook 'whitespace-mode)
  (add-to-list 'exec-path "/usr/local/bin")

  ;; EDTS
  (add-to-list 'load-path "~/dotfiles/edts")
  (require 'edts-start))

;; Autocomplete mode
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (ac-config-default))

;; Flycheck
(when (require 'flycheck nil t)
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (require 'auto-complete-clang-async)
  (setq flycheck-clang-language-standard "c++11")
  (setq flycheck-clang-standard-library "libc++"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("cd70962b469931807533f5ab78293e901253f5eeb133a46c2965359f23bfb2ea" default))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide '.emacs)
;;; .emacs ends here
