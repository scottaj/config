(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

;; Marmalade Packages
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(require 'ctags)
;; (require 'ctags-update)
;; (setq tags-revert-without-query t) (global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)
(global-set-key (kbd "<backtab>") 'ctags-search)
;; (ctags-update-minor-mode 1)

(require 'coffee-mode)

(require 'haml-mode)

(require 'ruby-end)

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

(require 'ruby-block)

(require 'ruby-tools)

(require 'yaml-mode)

(require 'slim-mode)

(require 'redo+)

(require 'clojure-mode)

;(require 'clojure-test-mode)

;(require 'cljdoc)

;(require 'color-theme)

(require 'flymake)
(require 'flymake-d)
(require 'flymake-css)
(require 'flymake-php)
(require 'flymake-haml)
(require 'flymake-ruby)
(require 'flymake-sass)
(require 'flymake-coffee)
(require 'flymake-jshint)

(require 'rvm)

(require 'starter-kit)

(require 'smart-operator)

(require 'sr-speedbar)

(require 'wrap-region)

(require 'paredit)

(require 'magit)

(require 'js2-mode)

(require 'heroku)

(require 'idle-highlight-mode)

(require 'dired-single)

(require 'feature-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 1.0)
 '(ac-ignores (quote ("end" "def")))
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(ctags-update-command "/usr/local/Cellar/ctags/5.8/bin/ctags")
 '(cua-enable-cua-keys nil)
 '(cua-mode t nil (cua-base))
 '(cua-rectangle-mark-key [C-return])
 '(cua-remap-control-v nil)
 '(cua-remap-control-z nil)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(electric-indent-mode t)
 '(electric-layout-mode t)
 '(electric-pair-mode t)
 '(fancy-splash-image nil)
 '(global-linum-mode t)
 '(ido-mode (quote both) nil (ido))
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "~/Documents")
 '(kill-whole-line t)
 '(line-number-mode nil)
 '(ruby-end-insert-newline nil)
 '(shell-file-name "/bin/bash")
 '(show-paren-mode t)
 '(show-paren-style (quote expression))
 '(size-indication-mode t)
 '(standard-indent 2)
 '(tab-always-indent (quote complete))
 '(tool-bar-mode nil)
 '(transient-mark-mode nil)
 '(wrap-region-global-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-errline ((t (:underline "brightred"))))
 '(flymake-warnline ((t (:underline "white"))))
 '(idle-highlight ((t (:inherit region :background "brightblack"))))
 '(linum ((t (:background "color-45" :foreground "black"))))
 '(mode-line ((t (:background "grey75" :foreground "color-29" :box 1 :height 0.9))))
 '(mode-line-buffer-id ((t (:background "grey65" :foreground "color-20" :weight bold :height 0.9))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "White"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "Red"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "Orange"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "Yellow"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "Green"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "Cyan"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "Blue"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "Purple"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "Magenta")))))

;; Turn off Bell
(setq ring-bell-function 'ignore)

(add-to-list 'load-path "~/.emacs.d/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)


;; Line Numbers in Margin
(require 'linum)

(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "M-z") 'redo)
(global-set-key (kbd "M-s") 'shell)

; Change C-up and C-down to be page up/down
(fset 'up-50 "\C-u50\C-p")
(fset 'down-50 "\C-u50\C-n")
(global-set-key (kbd "C-x <up>") 'up-50)
(global-set-key (kbd "C-x <down>") 'down-50)

;; Search word
(global-set-key (kbd "C-q") (kbd "M-b C-s C-w"))


(defadvice comment-or-uncomment-region (before slick-comment activate compile)
  "When called interactively with no active region, comment a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))

;(global-set-key (kbd "s-c s") 'shell)
;(global-set-key (kbd "s-z") 'undo)

;(setq visible-bell t)

;(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))


;; OSX font
(set-face-attribute 'default nil :font "consolas")
(set-face-attribute 'default nil :height 160)

;; Switch windows with SHIFT+arrow keys
(windmove-default-keybindings)
(global-set-key (kbd "<select>") 'windmove-up)
