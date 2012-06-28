;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; Hotkeys
(global-set-key (kbd "s-c c") 'comment-or-uncomment-region)

(defadvice comment-or-uncomment-region (before slick-comment activate compile)
  "When called interactively with no active region, comment a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))

(global-set-key (kbd "s-c s") 'shell)
(global-set-key (kbd "s-z") 'undo)

(setq visible-bell t)

;; Paren Matching
(show-paren-mode t)
(setq show-paren-style 'expression)

;; IDO Mode
(setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1)

;; Snippets
(add-to-list 'load-path "/usr/share/emacs/site-lisp/yas")
   (require 'yasnippet) ;; not yasnippet-bundle
   (yas/initialize)
   (yas/load-directory "/usr/share/emacs/site-lisp/yas/snippets")
(yas/global-mode 1)

;; Git
(autoload 'magit-status "magit" nil t)


;; Colors
(add-to-list 'load-path "/usr/share/emacs/site-lisp/color-theme.el")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-midnight)))

;; Javascript
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Clojure
(add-to-list 'load-path "~/.clojure_emacs/clojure-mode")
(require 'clojure-mode)

(add-to-list 'load-path "~/.clojure_emacs/rainbow.el")

;; Auto Complete
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/usr/share/emacs/site-lisp//ac-dict")
(ac-config-default)

;; Ruby
(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
  (autoload 'inf-ruby-keys "inf-ruby" "" t)
   (eval-after-load 'ruby-mode
     '(add-hook 'ruby-mode-hook 'inf-ruby-keys))


(require 'ruby-electric)
(add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode t)))

(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))


;; Line Numbers
(require 'linum)


;; Slim Mode
(require 'slim-mode)

;; Coffeescript
(require 'coffee-mode)

;; Packages
;(require 'package)
;(add-to-list 'package-archives
;             '("marmalade" . "http://marmalade-repo.org/packages/") t)
;(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-revert-check-vc-info t)
 '(electric-indent-mode t)
 '(electric-pair-mode t)
 '(global-auto-revert-mode t)
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(standard-indent 2)
 '(yas/trigger-key "RET"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
