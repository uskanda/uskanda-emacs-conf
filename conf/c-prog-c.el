;;----------------------------------------------------------------------------;;
;; Fundamental settings for C, C++ and Java
;;----------------------------------------------------------------------------;;
(add-hook 'c-mode-common-hook
          '(lambda ()
             ;; センテンスの終了である ';' を入力したら、自動改行+インデント
             (c-toggle-auto-hungry-state 1)
             ;; RET キーで自動改行+インデント
             (define-key c-mode-base-map "\C-m" 'newline-and-indent)
             (setq tab-width 4)
             (setq c-basic-offset tab-width)
             (setq indent-tabs-mode nil)
))
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; flyspell settings
;;----------------------------------------------------------------------------;;
(mapc
 (lambda (hook)
   (add-hook hook 'flyspell-prog-mode))
 '(
   c-mode-common-hook
   emacs-lisp-mode-hook
   ))
;;----------------------------------------------------------------------------;;