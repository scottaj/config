(add-to-list 'load-path "~/.emacs.d/")

(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell 
      (replace-regexp-in-string "[[:space:]\n]*$" "" 
        (shell-command-to-string "$SHELL -l -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(when (equal system-type 'darwin) (set-exec-path-from-shell-PATH))

;; Marmalade Packages
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(require 'flymake)

(require 'ctags)
;; (require 'ctags-update)
;; (setq tags-revert-without-query t) (global-set-key (kbd "<f5>") 'ctags-create-or-update-tags-table)
(global-set-key (kbd "<backtab>") 'complete-tag)
;; (ctags-update-minor-mode 1)

(require 'coffee-mode)

(require 'haml-mode)

(require 'ruby-end)

(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)

(require 'ruby-block)

(require 'ruby-tools)

(require 'flymake-ruby)

(require 'yaml-mode)

(require 'slim-mode)

(require 'redo+)

(require 'clojure-mode)

;(require 'clojure-test-mode)

;(require 'cljdoc)

(require 'color-theme)

(setq pretty-symbol-categories '(lambda relational))

(require 'pretty-symbols)
(pretty-symbols-mode 1)

(require 'markdown-mode)

(require 'rvm)

(require 'wrap-region)

(require 'paredit)

(require 'magit)

(require 'js2-mode)

(require 'heroku)

(require 'idle-highlight-mode)

(require 'dired-single)
(defun my-dired-init ()
  "Bunch of stuff to run for dired, either immediately or when it's
        loaded."
  ;; <add other stuff here>
  (define-key dired-mode-map [return] 'dired-single-buffer)
  (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
  (define-key dired-mode-map "^"
    (function
     (lambda nil (interactive) (dired-single-buffer "..")))))

;; if dired's already loaded, then the keymap will be bound
(if (boundp 'dired-mode-map)
;; we're good to go; just add our bindings
    (my-dired-init)
  ;; it's not loaded yet, so add our bindings to the load-hook
(add-hook 'dired-load-hook 'my-dired-init))


(require 'feature-mode)

(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; Cursor
(setq cursor-type 'bar)
;; highlight current line
;; (global-hl-line-mode 1)

(require 'go-mode)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold ((t (:weight extra-bold))))
 '(flymake-errline ((t (:underline "brightred"))))
 '(flymake-warnline ((t (:underline "white"))))
 '(highlight ((t (:inherit nil :background "gray10"))))
 '(hl-line ((t (:background "grey10"))))
 '(idle-highlight ((t (:background "disabledControlTextColor"))))
 '(linum ((t (:background "cyan" :foreground "black"))))
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
 '(rainbow-delimiters-depth-9-face ((t (:foreground "Magenta"))))
 '(show-paren-match ((t (:background "selectedKnobColor")))))

;; Turn off Bell
(setq ring-bell-function 'ignore)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

;; Line Numbers in Margin
(require 'linum)

(global-set-key (kbd "C-c c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "M-z") 'redo)
(global-set-key (kbd "M-s") 'shell)
(global-set-key (kbd "C-<escape>") 'magit-status)
(global-set-key (kbd "C-l") 'goto-line)

(defadvice comment-or-uncomment-region (before slick-comment activate compile)
  "When called interactively with no active region, comment a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))

;(global-set-key (kbd "s-c s") 'shell)
;(global-set-key (kbd "s-z") 'undo)

;(setq visible-bell t)

(defun ruby-get-containing-block ()
  (let ((pos (point))
        (block nil))
    (save-match-data
      (save-excursion
        (catch 'break
          ;; If in the middle of or at end of do, go back until at start
          (while (and (not (looking-at "do"))
                      (string-equal (word-at-point) "do"))
            (backward-char 1))
          ;; Keep searching for the containing block (i.e. the block that begins
          ;; before our point, and ends after it)
          (while (not block)
            (if (looking-at "do\\|{")
                (let ((start (point)))
                  (ruby-forward-sexp)
                  (if (> (point) pos)
                      (setq block (cons start (point)))
                    (goto-char start))))
            (if (not (search-backward-regexp "do\\|{" (point-min) t))
                (throw 'break nil))))))
        block))

(defun ruby-goto-containing-block-start ()
  (interactive)
  (let ((block (ruby-get-containing-block)))
    (if block
        (goto-char (car block)))))

(defun ruby-flip-containing-block-type ()
  (interactive)
  (save-excursion
    (let ((block (ruby-get-containing-block)))
      (goto-char (car block))
      (save-match-data
        (let ((strings (if (looking-at "do")
                           (cons
                            (if (= 3 (count-lines (car block) (cdr block)))
                                "do\\( *|[^|]+|\\)? *\n *\\(.*?\\) *\n *end"
                              "do\\( *|[^|]+|\\)? *\\(\\(.*\n?\\)+\\) *end")
                            "{\\1 \\2 }")
                         (cons
                          "{\\( *|[^|]+|\\)? *\\(\\(.*\n?\\)+\\) *}"
                          (if (= 1 (count-lines (car block) (cdr block)))
                              "do\\1\n\\2\nend"
                            "do\\1\\2end")))))
          (when (re-search-forward (car strings) (cdr block) t)
            (replace-match (cdr strings) t)
            (delete-trailing-whitespace (match-beginning 0) (match-end 0))
            (indent-region (match-beginning 0) (match-end 0))))))))

(add-hook 'ruby-mode-hook (lambda () (local-set-key (kbd "C-|") 'ruby-goto-containing-block-start)))
(add-hook 'ruby-mode-hook (lambda () (local-set-key (kbd "C-`") 'ruby-flip-containing-block-type)))
(add-hook 'ruby-mode-hook 'pretty-symbols-mode)

;; OSX font
(set-face-attribute 'default nil :font "consolas")
(set-face-attribute 'default nil :height 160)

;; Switch windows with SHIFT+arrow keys
(windmove-default-keybindings)
(global-set-key (kbd "<select>") 'windmove-up)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-auto-show-menu 1.0)
 '(ac-ignores (quote ("end" "def" "begin")))
 '(ac-modes (quote (emacs-lisp-mode lisp-interaction-mode c-mode cc-mode c++-mode java-mode clojure-mode scala-mode scheme-mode ocaml-mode tuareg-mode perl-mode cperl-mode python-mode ruby-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode slim-mode coffee-mode)))
 '(blink-cursor-mode t)
 '(coffee-tab-width 2)
 '(color-theme-is-cumulative nil)
 '(column-number-mode t)
 '(cua-enable-cua-keys nil)
 '(cua-mode t nil (cua-base))
 '(cua-normal-cursor-color "black")
 '(cua-rectangle-mark-key [C-return])
 '(cua-remap-control-v nil)
 '(cua-remap-control-z nil)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(electric-indent-mode t)
 '(electric-layout-mode t)
 '(electric-pair-mode t)
 '(eol-mnemonic-mac "(Mac)")
 '(fancy-splash-image nil)
 '(flyspell-auto-correct-binding [C-x 9])
 '(global-highlight-changes-mode nil)
 '(global-hl-line-mode nil)
 '(global-linum-mode t)
 '(highlight-changes-visibility-initial-state nil)
 '(ido-mode (quote both) nil (ido))
 '(imenu-auto-rescan t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "~/Documents")
 '(js2-auto-indent-p t)
 '(js2-basic-offset 2)
 '(kill-whole-line t)
 '(line-number-mode t)
 '(linum-format (quote linum-relativenumber-format))
 '(menu-bar-mode t)
 '(mode-require-final-newline nil)
 '(pretty-symbol-patterns (quote ((955 lambda "\\<lambda\\>" (emacs-lisp-mode inferior-lisp-mode lisp-mode clojure-mode python-mode ruby-mode)) (402 lambda "\\<function\\>" (js-mode js2-mode)) (8800 relational "!=" (c-mode c++-mode go-mode java-mode js-mode perl-mode cperl-mode python-mode ruby-mode coffee-mode)) (8800 relational "/=" (emacs-lisp-mode inferior-lisp-mode lisp-mode clojure-mode)) (8805 relational ">=" (c-mode c++-mode go-mode java-mode js-mode perl-mode cperl-mode python-mode ruby-mode coffee-mode emacs-lisp-mode inferior-lisp-mode lisp-mode clojure-mode)) (8804 relational "<=" (c-mode c++-mode go-mode java-mode js-mode perl-mode cperl-mode python-mode ruby-mode coffee-mode emacs-lisp-mode inferior-lisp-mode lisp-mode clojure-mode)) (8743 logical "&&" (c-mode c++-mode go-mode java-mode js-mode perl-mode cperl-mode python-mode ruby-mode coffee-mode)) (8743 logical "\\<and\\>" (emacs-lisp-mode inferior-lisp-mode lisp-mode clojure-mode)) (8744 logical "||" (c-mode c++-mode go-mode java-mode js-mode perl-mode cperl-mode python-mode ruby-mode coffee-mode)) (8744 logical "\\<or\\>" (emacs-lisp-mode inferior-lisp-mode lisp-mode clojure-mode)) (172 logical "\\<not\\>" (emacs-lisp-mode inferior-lisp-mode lisp-mode clojure-mode)))))
 '(require-final-newline nil)
 '(ruby-end-insert-newline nil)
 '(save-place-file "~/.emacs.d/places")
 '(scroll-bar-mode nil)
 '(semantic-mode t)
 '(sentence-end-double-space nil)
 '(shell-file-name "/bin/bash")
 '(show-paren-mode t)
 '(show-paren-style (quote expression))
 '(size-indication-mode t)
 '(standard-indent 2)
 '(tab-always-indent (quote complete))
 '(tool-bar-mode nil)
 '(transient-mark-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(wrap-region-global-mode t)
 '(yas/also-auto-indent-first-line t)
 '(yas/global-mode t nil (yasnippet))
 '(yas/root-directory (quote ("/Users/al/.emacs.d/elpa/feature-mode-0.4/snippets/" "/Users/al/.emacs.d/snippets/")) nil (yasnippet))
 '(yas/wrap-around-region t))

;;; relativenumber like vim
(global-linum-mode t)
(setq linum-last-pos 0)

(eval-after-load "linum"
  '(defun linum-update (buffer)
     "Update line numbers for all windows displaying BUFFER."
     ;; this is only change but couldn't find better way to do it, tried
     ;; linum-before-update-hook but it runs in an excursion so I couldn't get
     ;; current line number
     (setq linum-last-pos (line-number-at-pos))
     (with-current-buffer buffer
       (when linum-mode
         (setq linum-available linum-overlays)
         (setq linum-overlays nil)
         (save-excursion
           (mapc #'linum-update-window
                 (get-buffer-window-list buffer nil 'visible)))
         (mapc #'delete-overlay linum-available)
         (setq linum-available nil)))))

(defface linum-zero
  '((t :inherit linum :foreground "grey10" :background "magenta" :weight bold))
  "Face for displaying line number 0"
  :group 'linum)

(defface linum-top
  '((t :inherit linum :foreground "grey80" :background "grey30" :weight bold))
  "Face for displaying top line number"
  :group 'linum)

(defface linum-line
  '((t :inherit linum :foreground "grey35" :background "grey10" :weight normal))
  "Face for displaying absolute line number"
  :group 'linum)

(defun linum-relativenumber-format (line-number)
  (let ((diff (abs (- line-number linum-last-pos))))
    (concat
     ;(propertize (format "%5d" line-number)
      ;                  'face 'linum-line)  ; Uncomment this chunk for absolute line numbers next to the relative ones.
            (propertize (format "%3d" diff)
                        'face (cond ((zerop diff) 'linum-zero)
                                    ((eq 1 line-number) 'linum-top)
                                    (t 'linum))))))

;; (setq linum-format 'dynamic)
(setq linum-format 'linum-relativenumber-format)

(setq auto-mode-alist  (cons '("Gemfile$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("Gemfile.lock$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("Rakefile$" . ruby-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
