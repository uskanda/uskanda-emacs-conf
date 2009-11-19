;;----------------------------------------------------------------------------;;
;;query-replaceのクエリ入力中に置換対象をハイライトする
;;http://d.hatena.ne.jp/m2ym/20090716/1247713644
;;----------------------------------------------------------------------------;;
(defvar query-replace-auto-highlight-buffer nil)
(defvar query-replace-auto-highlight-regexp-flag nil)
(defvar query-replace-auto-highlight-interval 0.5)
(defvar query-replace-auto-highlight-timer nil)

(defun query-replace-auto-highlight ()
  (when (minibufferp)
    (let ((isearch-string (minibuffer-contents-no-properties))
          (isearch-regexp query-replace-auto-highlight-regexp-flag)
          (search-whitespace-regexp nil)
          (isearch-case-fold-search case-fold-search))
      (if (string= isearch-string "")
          (setq isearch-string (car query-replace-defaults)))
      (when (and (stringp isearch-string)
                 (not (string= isearch-string "")))
        (with-selected-window (get-buffer-window query-replace-auto-highlight-buffer)
          (isearch-lazy-highlight-new-loop (window-start) (window-end)))))))

(defadvice query-replace-read-from (around query-replace-auto-highlight (prompt regexp-flag) activate)
  (setq query-replace-auto-highlight-buffer (current-buffer))
  (setq query-replace-auto-highlight-regexp-flag regexp-flag)
  (setq query-replace-auto-highlight-timer
        (run-with-idle-timer query-replace-auto-highlight-interval query-replace-auto-highlight-interval 'query-replace-auto-highlight))
  (unwind-protect
      ad-do-it
    (cancel-timer query-replace-auto-highlight-timer)
    (lazy-highlight-cleanup t)
    (setq isearch-lazy-highlight-last-string nil)))
;;----------------------------------------------------------------------------;;

(provide 'query-replace-auto-highlight)
