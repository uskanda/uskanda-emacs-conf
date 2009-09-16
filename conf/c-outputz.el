;;----------------------------------------------------------------------------;;
;; outputz-mode settings
;; outputzにマイナーモード名と入力文字数を5秒入力がないと送信する
;;----------------------------------------------------------------------------;;
(require 'outputz)
(setq outputz-uri "http://%s.emacs/%s")

(defun outputz-buffers ()
  (dolist (buf (buffer-list))
    (with-current-buffer buf
    (outputz))))

(run-with-idle-timer 5 t 'outputz-buffers)
(remove-hook 'after-save-hook 'outputz)
;;----------------------------------------------------------------------------;;
