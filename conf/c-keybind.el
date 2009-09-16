;;-------------------------------------------------;;
;; Fundamental Keybind Settings
;;-------------------------------------------------;;
(global-set-key "\C-h" 'delete-backward-char) ;C-hで一文字削除
(global-set-key "\C-m" 'newline-and-indent) ;改行と共にインデント
(global-set-key "\C-j" 'newline) ;改行
(global-set-key "\C-xg" 'goto-line) ; C-c g で任意の行へのジャンプ
(global-set-key "\C-x\C-g" 'goto-line) ; C-c g で任意の行へのジャンプ
;(global-set-key "\C-cc" 'comment-dwim) ;; comment-dwimはM-;。覚える
(global-set-key "\C-co" 'ff-find-other-file)
;;-------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; C-wで単語キルを行う
;;----------------------------------------------------------------------------;;
(defun kill-region-or-backward-kill-word (arg)
  (interactive "p")
  (if mark-active
    (call-interactively 'kill-region)
    (backward-kill-word arg)))
(global-set-key "\C-w" 'kill-region-or-backward-kill-word)
;;----------------------------------------------------------------------------;;
