;;----------------------------------------------------------------------------;;
;; Yasnippet settings
;;----------------------------------------------------------------------------;;
(require 'yasnippet)
(setq yas/trigger-key "") ;;yasnippetによる補完の始動キー。SPACEは強力だけどたまにイラつく
(setq yas/next-field-key (kbd "TAB"))
 (fset 'yas/default-trigger-fallback ;; 対応するsnippetがない場合はSPCを挿入する
       (lambda ()
         (interactive)
         (insert yas/trigger-key)))
(yas/load-directory "~/.emacs.d/snippets/builtin")
(defvar my-snippet-directories
  (list (expand-file-name "~/.emacs.d/snippets/uskanda")
        (expand-file-name "~/.emacs.d/snippets/rails")))
(defun yas/load-all-directories ()
  (interactive)
  (yas/reload-all)
  (mapc 'yas/load-directory-1 my-snippet-directories))
(yas/initialize)
(yas/load-all-directories)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; コメントやリテラルではスニペットを展開しない
;;----------------------------------------------------------------------------;;
(setq yas/buffer-local-condition
      '(or (not (or (string= "font-lock-comment-face"
                             (get-char-property (point) 'face))
                    (string= "font-lock-string-face"
                             (get-char-property (point) 'face))))
           '(require-snippet-condition . force-in-comment)))
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; yasnippet展開中はflymakeを無効にする
;;----------------------------------------------------------------------------;;
(defvar flymake-is-active-flag nil)
(defadvice yas/expand-snippet
  (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
  (setq flymake-is-active-flag
        (or flymake-is-active-flag
            (assoc-default 'flymake-mode (buffer-local-variables))))
  (when flymake-is-active-flag
    (flymake-mode-off)))
(add-hook 'yas/after-exit-snippet-hook
          '(lambda ()
             (when flymake-is-active-flag
               (flymake-mode-on)
               (setq flymake-is-active-flag nil))))
;               (parenthesis-register-keys "{('\"[" (current-local-map)))))
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; \から始まる単語を補完する場合\を削除。TeXの補完時等に。
;;----------------------------------------------------------------------------;;
(defadvice yas/expand-snippet (before delete-backslash activate)
  (when (eq (char-before start) ?\\ )
    (progn (goto-char start)
           (backward-delete-char 1)
           (setq start (- start 1))
           (setq end (- end 1)))))
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; アンドゥ直後はスニペットを展開しない
;;----------------------------------------------------------------------------;;
(defadvice yas/expand-snippet (around disable-if-after-undo activate) 
  (if (eq last-command 'undo)  (insert yas/trigger-key) ad-do-it))
;;----------------------------------------------------------------------------;;


