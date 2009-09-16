
(defvar anything-kill-ring-threshold 10)
(defvar anything-c-source-kill-ring
  '((name . "Kill Ring")
    (init . (lambda ()
              (setq anything-kill-ring-buffer (current-buffer))))
    (candidates . (lambda ()
                    (remove-if
                     (lambda (kill)
                       (or (< (length kill) anything-kill-ring-threshold)
                           (string-match "^[\\s\\t]+$" kill)))
                     kill-ring)))
    (action . (("Insert" . (lambda (candidate)
                             (with-current-buffer anything-kill-ring-buffer
                               (insert candidate))))))
    ;(requires-pattern . 3)
    (multiline)))

(defun anything-kill-ring (&rest sources)
  (let ((anything-sources sources))
    (call-interactively 'anything)))

(defmacro anything-kill-ring-command (&rest sources)
  `(lambda ()
     (interactive)
     (anything-kill-ring ,@sources)))

(global-set-key "\M-y" (anything-kill-ring-command anything-c-source-kill-ring))

(provide 'anything-c-kill-ring)