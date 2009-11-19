;;----------------------------------------------------------------------------;;
;; マイナーモード表示の省略
;;----------------------------------------------------------------------------;;
(require 'diminish)
(diminish 'outputz-mode)
(diminish 'font-lock-mode)
(diminish 'abbrev-mode)
;; scratch バッファの Lisp Interaction も長い
(add-hook 'lisp-interaction-mode-hook
          '(lambda ()
             (setq mode-name "Lisp-Int")))
;; Emacs-Lisp も長い
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (setq mode-name "Elisp")))
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; ミニバッファ内で C-w で単語削除。上位パスのファイルを選択する際に便利
;;----------------------------------------------------------------------------;;
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; which-func Setting
;; 現在どの関数/メソッドにカーソルがあるのか表示する。
;;----------------------------------------------------------------------------;;
(require 'which-func)
; java-mode と javascript-mode でも which-func を使う
(setq which-func-modes (append which-func-modes '(java-mode javascript-mode)))
(which-func-mode t)
;;----------------------------------------------------------------------------;;

