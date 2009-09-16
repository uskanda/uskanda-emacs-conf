(require 'auto-complete)

(global-auto-complete-mode t)
(setq ac-auto-start t)
(setq ac-limit 20)
(setq ac-limit-max 100)
(setq ac-candidate-menu-height 15)
(when (boundp 'ac-modes)
  (setq ac-modes
    (append ac-modes
      (list 'yatex-mode 'rhtml-mode))))

(set-default 'ac-sources '(ac-source-yasnippet
                   ac-source-words-in-buffer
                   ac-source-imenu
                   ))

(require 'auto-complete-ruby)
(require 'auto-complete-yasnippet)
(require 'auto-complete-cpp)

;;日本語 を auto-complete しない
(defadvice ac-candidate-words-in-buffer (after remove-word-contain-japanese activate)
  (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
    (setq ad-return-value
          (remove-if contain-japanese ad-return-value))))


;; (add-hook 'ruby-mode-hook
;;           (lambda ()
;;             (setq ac-omni-completion-sources '(("\\.\\=" ac-source-rcodetools)))
;;             ))

(add-hook 'yatex-mode-hook
          (lambda ()
            (setq ac-omni-completion-sources '(("\\\\\\=" ac-source-yasnippet)))))



