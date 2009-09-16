;;----------------------------------------------------------------------------;;
;; psvn Settings
;; Subversion操作をemacsから可能にする。
;;----------------------------------------------------------------------------;;
(require 'psvn)
(add-hook 'dired-mode-hook
          '(lambda ()
             (require 'dired-x)
             ;;(define-key dired-mode-map "V" 'cvs-examine)
             (define-key dired-mode-map "V" 'svn-status)
             (turn-on-font-lock)))
(setq svn-status-hide-unmodified t)
(setq process-coding-system-alist
      (cons '("svn" . utf-8) process-coding-system-alist))
;;----------------------------------------------------------------------------;;

