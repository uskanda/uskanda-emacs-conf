(require 'auto-complete)

(global-auto-complete-mode t)
(setq ac-auto-start 2)
(setq ac-limit 10)
(when (boundp 'ac-modes)
  (setq ac-modes
    (append ac-modes
      (list 'yatex-mode 'rhtml-mode 'css-mode 'html-mode 'haml-mode 'sass-mode 'fundamental-mode))))

(set-default 'ac-sources '(ac-source-filename
                   ac-source-yasnippet
                   ac-source-words-in-buffer
                   ac-source-words-in-same-mode-buffers
                   ac-source-words-in-all-buffer
                   ;ac-source-imenu
                   ))

(require 'auto-complete-config)

;;日本語をauto-completeしない。
;;IMEのSuggestと衝突する場合、設定推奨
(defadvice ac-candidate-words-in-buffer (after remove-word-contain-japanese activate)
 (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
   (setq ad-return-value
         (remove-if contain-japanese ad-return-value))))