;;; textmate-to-yas-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (textmate-import-svn-from-url textmate-import-bundle
;;;;;;  textmate-import-git-tar\.gz) "textmate-to-yas" "textmate-to-yas.el"
;;;;;;  (20525 48446))
;;; Generated autoloads from textmate-to-yas.el

(autoload 'textmate-import-git-tar\.gz "textmate-to-yas" "\
* Imports a TextMate git-hub bundle.

\(fn FILE PARENT-MODES)" t nil)

(autoload 'textmate-import-bundle "textmate-to-yas" "\
Imports textmate bundle to new-dir.  Mode may be a string or a function determining which mode to place files in...

\(fn DIR PARENT-MODES &optional ORIGINAL-AUTHOR YAS-DIR MODE TRANSFORM-FUNCTION)" t nil)

(autoload 'textmate-import-svn-from-url "textmate-to-yas" "\
* Imports a textmate bundle and extracts snippets from `textmate-import-svn-url'

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("textmate-to-yas-pkg.el") (20525 48446
;;;;;;  450018))

;;;***

(provide 'textmate-to-yas-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; textmate-to-yas-autoloads.el ends here
