(setq viper-mode t)
(require 'viper)
(setq viper-expert-level '5)
(setq viper-inhibit-startup-message 't)
(defun viper-change-cursor-color (new-color) nil) 

;; ;(eval-after-load "viper-init"
;; ;  '(defun viper-set-insert-cursor-type ()
;; ;     (if viper-xemacs-p
;; ;         (setq bar-cursor 2)
;; ;       (setq cursor-type 'box))))

(defun my-viper-beginning-of-buffer ()
  (interactive)
  (beginning-of-buffer))
(define-key viper-vi-global-user-map [?g?g] 'my-viper-beginning-of-buffer)

(define-key viper-vi-global-user-map [?u] 'undo)
(define-key viper-insert-global-user-map (kbd "\C-d") 'delete-char)

