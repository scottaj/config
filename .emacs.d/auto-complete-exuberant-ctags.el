;;; auto-complete-exuberant-ctags.el --- Exuberant ctags auto-complete.el source

;; Filename: auto-complete-exuberant-ctags.el
;; Description: Exuberant ctags auto-complete.el source
;; Author: Kenichirou Oyama <k1lowxb@gmail.com>
;; Maintainer: Kenichirou Oyama <k1lowxb@gmail.com>
;; Copyright (C) 2011, 101000code/101000LAB, all rights reserved.
;; Created: 2011-08-09
;; Modified: 2011-09-08
;; Version: 0.0.5
;; URL:
;; Keywords: anything, exuberant ctags
;; Compatibility: GNU Emacs 23
;;
;; Features that might be required by this library:
;;
;; `auto-complete'
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

;;; Commentary:
;;
;; This package provide Exuberant ctags auto-complete.el source
;;
;;; Installation:
;;
;; Put anything-exuberant-ctags.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'auto-complete-exuberant-ctags)
;;
;; In your project root directory, do follow command to make tags file.
;;
;; ctags --verbose -R --fields="+afikKlmnsSzt"
;;
;; No need more.

;;; Commands:
;;
;; Below are complete command list:
;;
;;
;;; Customizable Options:
;;
;; Below are customizable option list:
;;
;;  `ac-exuberant-ctags-tag-file-name'
;;    Exuberant ctags tag file name.
;;    default = "tags"
;;  `ac-exuberant-ctags-tag-file-search-limit'
;;    The limit level of directory that search tag file.
;;    default = 10
;;  `ac-exuberant-ctags-line-length-limit'
;;    The limit level of line length.
;;    default = 400

;;; Code:

;;require
(require 'auto-complete)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Customize ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defgroup ac-exuberant-ctags nil
  "Exuberant ctags auto-complete.el source"
  :prefix "ac-exuberant-ctags-"
  :group 'convenience)

(defcustom ac-exuberant-ctags-tag-file-name "tags"
  "Exuberant ctags tag file name."
  :type 'string
  :group 'ac-exuberant-ctags)

(defcustom ac-exuberant-ctags-tag-file-search-limit 10
  "The limit level of directory that search tag file.
Don't search tag file deeply if outside this value.
This value only use when option
`ac-exuberant-ctags-tag-file-dir-cache' is nil."
  :type 'number
  :group 'ac-exuberant-ctags)

(defcustom ac-exuberant-ctags-line-length-limit 400
  "The limit level of line length.
Don't search line longer if outside this value."
  :type 'number
  :group 'ac-exuberant-ctags)

(defun ac-exuberant-ctags-setup ()
  "Setup ac-exuberant-ctags-setup."
  (add-hook 'after-save-hook 'ac-exuberant-ctags-build-index))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Variable ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar ac-exuberant-ctags-index nil
  "Index of Exuberant ctags candidates.")

(defvar ac-exuberant-ctags-tag-file-dir nil
  "Exuberant ctags file directory.")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Utilities Functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun ac-exuberant-ctags-build-index ()
  "Build index."
  (let (tag-name kind language)
    (with-temp-buffer
      (insert-file-contents (ac-exuberant-ctags-get-tag-file))
      (goto-char (point-min))
      (flush-lines "^ *$")
      (setq ac-exuberant-ctags-index nil)
      (goto-char (point-min))
      (while (not (eobp))
        (let* ((start (point))
               (end (save-excursion (end-of-line) (point)))
               (line (ac-exuberant-ctags-get-line start end)))
          (if (not (string-match "^\\([^\t\s]+\\)\t\\([^\t]+\\)\t.*kind:\\([^\t\s]+\\)\t.*language:\\([^\t\s]+\\)" line))
              (goto-char (+ end 1))
            (setq tag-name (match-string 1 line))
            (setq kind (match-string 3 line))
            (setq language (match-string 4 line))
            (goto-char (+ end 1))
            (push (concat tag-name " " kind " " language) ac-exuberant-ctags-index))))
      ac-exuberant-ctags-index)))

(defun ac-exuberant-ctags-get-line (s e)
  (let ((substr (buffer-substring s e)))
    (if (or (< ac-exuberant-ctags-line-length-limit (length substr)) (string-match "^!_" substr))
        ""
      substr)))

(defun ac-exuberant-ctags-get-tag-file ()
  "Get Exuberant ctags tag file."
  ;; Get tag file from `default-directory' or upper directory.
  (let ((current-dir (ac-exuberant-ctags-find-tag-file default-directory)))
    ;; Return nil if not find tag file.
    (when current-dir
      (setq ac-exuberant-ctags-tag-file-dir current-dir) ;set tag file directory
      (expand-file-name ac-exuberant-ctags-tag-file-name current-dir))))

(defun ac-exuberant-ctags-find-tag-file (current-dir)
  "Find tag file.
Try to find tag file in upper directory if haven't found in CURRENT-DIR."
  (flet ((file-exists? (dir)
                       (let ((tag-path (expand-file-name ac-exuberant-ctags-tag-file-name dir)))
                         (and (stringp tag-path)
                              (file-exists-p tag-path)
                              (file-readable-p tag-path)))))
    (loop with count = 0
          until (file-exists? current-dir)
          ;; Return nil if outside the value of
          ;; `ac-exuberant-ctags-tag-file-search-limit'.
          if (= count ac-exuberant-ctags-tag-file-search-limit)
          do (return nil)
          ;; Or search upper directories.
          else
          do (incf count)
          (setq current-dir (expand-file-name (concat current-dir "../")))
          finally return current-dir)))

(defun ac-exuberant-ctags-candidate ()
  (let* ((index (sort (all-completions ac-target ac-exuberant-ctags-index) #'string<))
         (len (length candidates))
         (backward-str (buffer-substring (- ac-point 3) ac-point))
         (count 0)
         candidate)
    (loop for x in index
          unless (> (length candidate) ac-exuberant-ctags-line-length-limit)
          do (progn
               (unless (not (string-match "^\\([^\t\s]+\\) \\([^\t\s]+\\) \\([^\t\s]+\\)" x))
                 ;; @todo use property
                 (push (match-string 1 x) candidate))))
    candidate))

(ac-define-source exuberant-ctags
  '((init . (lambda () (unless ac-exuberant-ctags-index
                         (ac-exuberant-ctags-build-index))))
    (candidates . ac-exuberant-ctags-candidate)
    (requires . 3)
    (symbol . "s")))

(provide 'auto-complete-exuberant-ctags)

;;; Code ends