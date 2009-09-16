;;-------------------------------------------------;;
;; Fundamental Keybind Settings
;;-------------------------------------------------;;
(global-set-key "\C-h" 'delete-backward-char) ;C-h�ňꕶ���폜
(global-set-key "\C-m" 'newline-and-indent) ;���s�Ƌ��ɃC���f���g
(global-set-key "\C-j" 'newline) ;���s
(global-set-key "\C-xg" 'goto-line) ; C-c g �ŔC�ӂ̍s�ւ̃W�����v
(global-set-key "\C-x\C-g" 'goto-line) ; C-c g �ŔC�ӂ̍s�ւ̃W�����v
;(global-set-key "\C-cc" 'comment-dwim) ;; comment-dwim��M-;�B�o����
(global-set-key "\C-co" 'ff-find-other-file)
;;-------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; C-w�ŒP��L�����s��
;;----------------------------------------------------------------------------;;
(defun kill-region-or-backward-kill-word (arg)
  (interactive "p")
  (if mark-active
    (call-interactively 'kill-region)
    (backward-kill-word arg)))
(global-set-key "\C-w" 'kill-region-or-backward-kill-word)
;;----------------------------------------------------------------------------;;
