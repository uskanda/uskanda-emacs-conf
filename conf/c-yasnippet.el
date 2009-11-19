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
(setq yas/root-directories
  '("~/.emacs.d/snippets/uskanda"
   "~/.emacs.d/snippets/builtin"
   "~/.emacs.d/snippets/imported"))
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/completing-prompt))

(defvar yas/ruby-snippet-open-paren " "
  "The open parenthesis used in ruby-mode snippets. Normally blank but could be (")
(defvar yas/ruby-snippet-close-paren " "
  "The close parenthesis used in ruby-mode snippets. Normally blank but could be )")
(defun yas/ruby-snippet-paren (&optional arg)
  "Defaults to returning the open paren. If arg equals t then shows close paren."
  (if arg
      yas/ruby-snippet-close-paren
    yas/ruby-snippet-open-paren))

(defun yas/ruby-infer-class-name ()
  "Infer the class name from the buffer. Thanks to hitesh <hitesh.jasani@gmail.com>"
  (let ((fn (capitalize (file-name-nondirectory
                         (file-name-sans-extension
                          (buffer-file-name))))))
    (cond
     ((string-match "_" fn) (replace-match "" nil nil fn))
     (t fn))))

(defun yas/ruby-in-interpolated-string-p ()
  (eq (fourth (syntax-ppss))
      ?\"))

(defun yas/ruby-in-comment-p ()
  (fifth (syntax-ppss)))

(yas/initialize)
(mapc 'yas/load-directory yas/root-directories)
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


