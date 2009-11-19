;;----------------------------------------------------------------------------;;
;; shell settings
;;----------------------------------------------------------------------------;;
 (autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'shell-mode-hook (function
;;;       (lambda () (set-buffer-process-coding-system 'euc-japan 'euc-japan))))
  (lambda () (set-buffer-process-coding-system 'utf-8 'utf-8))))

;; zsh の履歴を shell-mode で使う
(if (not (getenv "HISTFILE"))
    (setenv "HISTFILE" (expand-file-name "~/.zsh/zsh_history")))
(setq comint-input-ring-separator "n\(:.+:.;\)?"
      comint-input-ring-size 10000)

(autoload 'shell-toggle "shell-toggle"
  "Toggles between the *shell* buffer and whatever buffer you are editing."
  t)
(autoload 'shell-toggle-cd "shell-toggle"
  "Pops up a shell-buffer and insert a \"cd \" command." t)
;;----------------------------------------------------------------------------;;