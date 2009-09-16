;;----------------------------------------------------------------------------;;
;; hippie-expand Settings
;; 補完を取り纏める。
;;----------------------------------------------------------------------------;;
(global-set-key "\M-/" 'hippie-expand)
(global-set-key [C-tab] 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))
;;----------------------------------------------------------------------------;;

