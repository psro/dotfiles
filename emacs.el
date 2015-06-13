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

;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")

;; Start server
(server-start)

;; OSX options
(if (eq system-type 'darwin)
    (setq mac-option-modifier nil
          mac-command-modifier 'meta
          mac-allow-anti-aliasing t
          x-select-enable-clipboard t))

;; Ido mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(ido-mode 1)

;; Windmove
(global-set-key (kbd "C-M-<left>")  'windmove-left)
(global-set-key (kbd "C-M-<right>") 'windmove-right)
(global-set-key (kbd "C-M-<up>")    'windmove-up)
(global-set-key (kbd "C-M-<down>")  'windmove-down)

;; Whitespace mode
(global-whitespace-mode)
(setq whitespace-style
      '(face trailing tabs lines-tail empty indentation::space))
(set-face-attribute 'whitespace-tab nil :background "#4F4F4F")

;; FCI mode
(setq fci-rule-column 80)

;; Bootstrap install Use-package
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

;; Use-package
(require 'use-package)

;; Erlang mode
(use-package erlang
             :ensure erlang
             :config (progn
                       (add-hook 'erlang-mode-hook 'fci-mode)
                       (add-hook 'erlang-mode-hook 'whitespace-mode)
                       (add-to-list 'exec-path "/usr/bin")
                       (add-to-list 'exec-path "/usr/local/bin")
                       (setq erlang-indent-level 2)
                       ;; EDTS
                       ;(require 'edts-start)
                       ))

(use-package edts)

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

;; Org-mode
(when (require 'org nil t)
  (make-directory "~/notes" t)
  (setq org-directory "~/notes")
  (setq org-default-notes-file (concat org-directory "/capture.org"))
  (setq org-log-done 'time)
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb))

;; Projectile
(use-package projectile
  :config (projectile-global-mode))

;; Multiple Cursors
(when (require 'multiple-cursors nil t)
  (global-set-key "\C-cm" 'mc/mark-more-like-this-extended))

;; Align Regexp keybindings
(global-set-key "\C-xa" 'align-regexp)


;; Dired related
(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)
(autoload 'dired-jump-other-window "dired-x"
  "Like \\[dired-jump] (dired-jump) but in other window." t)

(define-key global-map "\C-x\C-j" 'dired-jump)
(define-key global-map "\C-x4\C-j" 'dired-jump-other-window)
