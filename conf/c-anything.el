;;----------------------------------------------------------------------------;;
;; fundamental settings for anything
;; なんでも絞り込める。
;;----------------------------------------------------------------------------;;
(setq anything-c-use-standard-keys t)
(require 'anything-config)

(setq anything-idle-delay 0.3)
(setq anything-input-idle-delay 0.2)
(setq anything-candidate-number-limit 100)
(add-hook 'anything-after-persistent-action-hook 'which-func-update)
(remove-hook 'kill-emacs-hook 'anything-c-adaptive-save-history)

(define-key anything-map "\C-v" 'anything-next-source)
(define-key anything-map "\M-v" 'anything-previous-source)
(define-key anything-map "\C-z" 'anything-execute-persistent-action)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; anything-kyr settings
;; M-x時などに空気を読んでくれる。
;;----------------------------------------------------------------------------;;
(require 'anything-kyr-config)
(when (require 'anything-complete nil t)
  (anything-read-string-mode 1))
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; anything-match-plugin settings
;;----------------------------------------------------------------------------;;
(require 'anything-match-plugin) ;; スペース区切りで複数の正規表現で絞り込み可能にする。
(setq anything-mp-space-regexp "[\\ ] ")
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; anything-c-kill-ring (self packing) settings
;; M-y(kill-ring)時にanythingを使う。
;;----------------------------------------------------------------------------;;
(require 'anything-c-kill-ring)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;;source変更時に先頭から表示されるようにする(デフォルトは中央)
;;----------------------------------------------------------------------------;;
(defadvice anything-move-selection (after screen-top activate)
  "Display at the top of window when moving selection to the prev/next source."
  (if (eq unit 'source)
      (save-selected-window
        (select-window (get-buffer-window anything-buffer 'visible))
        (set-window-start (selected-window)
                          (save-excursion (forward-line -1) (point))))))
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; anything-c-moccur
;;----------------------------------------------------------------------------;;
;;; color-moccur.elの設定
(require 'color-moccur)
;; 複数の検索語や、特定のフェイスのみマッチ等の機能を有効にする
;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751
(setq moccur-split-word t)
;; migemoがrequireできる環境ならmigemoを使う
(when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
  (setq moccur-use-migemo t))

;;; anything-c-moccurの設定
(require 'anything-c-moccur)
;; カスタマイズ可能変数の設定(M-x customize-group anything-c-moccur でも設定可能)
(setq anything-c-moccur-anything-idle-delay 0.1 ;`anything-idle-delay'
      anything-c-moccur-higligt-info-line-flag t ; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
      anything-c-moccur-enable-auto-look-flag t ; 現在選択中の候補の位置を他のwindowに表示する
      anything-c-moccur-enable-initial-pattern t) ; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする

;;; キーバインドの割当(好みに合わせて設定してください)
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur) ;バッファ内検索
(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur) ;ディレクトリ
(add-hook 'dired-mode-hook ;dired
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; refe
;;----------------------------------------------------------------------------;;
;; (defun refe2x (kw)
;;   (interactive "sReFe2x: ")
;;   (with-current-buffer (get-buffer-create (concat "*refe2x:" kw "*"))
;;     (when (zerop (buffer-size))
;;       (call-process "refe2x" nil t t kw)
;;       (diff-mode))
;;     (setq minibuffer-scroll-window (get-buffer-window (current-buffer) t))
;;     (goto-char (point-min))
;;     (display-buffer (current-buffer))))

;; (defun anything-c-source-static-escript (symbol desc filename &rest other-attrib)
;;   `((name . ,desc)
;;     (candidates . ,symbol)
;;     ,@other-attrib
;;     (init
;;      . (lambda ()
;;          (unless (and (boundp ',symbol) ,symbol)
;;            (with-current-buffer (find-file-noselect ,filename)
;;              (setq ,symbol (split-string (buffer-string) "\n" t))))))
;;     (action
;;      ("Eval it"
;;       . (lambda (cand)
;;           (with-temp-buffer
;;             (insert cand)
;;             (cd ,(file-name-directory filename))
;;             (backward-sexp 1)
;;             (eval (read (current-buffer)))))))))

;; (setq anything-c-source-refe2x
;;       (anything-c-source-static-escript
;;        'anything-c-refe2x-candidates "ReFe2x"
;;        "~/bin/ruby-refm-1.9.0-dynamic/bitclust/refe2x.e"
;;        '(delayed)
;;        '(requires-pattern . 3)))
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; anythingでgrep(応用例としてTODO/FIXME検索)
;;----------------------------------------------------------------------------;;
(defmacro define-anything-grep (var name regexp condition &optional subexp recenter)
  `(setq ,var
         '((name . ,name)
           (candidates
            . (lambda ()
                (anything-grep-get-candidates ',condition ,regexp ,subexp)))
           (invariant)
           (action
            ("Go to line"
             . (lambda (candidate)
                 (anything-grep-goto-position candidate ,recenter)))))))
(defun anything-grep-get-candidates (condition-sexp regexp subexp)
  (save-excursion
    (set-buffer anything-current-buffer)
    (when (eval condition-sexp)
      (goto-char (point-min))
      (if (functionp regexp) (setq regexp (funcall regexp)))
      (loop while (re-search-forward regexp nil t)
            collect (if (numberp subexp)
                        (cons (match-string subexp) (match-beginning subexp))
                      (cons (buffer-substring (point-at-bol) (point-at-eol))
                            (point-at-bol)))))))

(define-anything-grep anything-c-source-fixme "TODO/FIXME"  "^.*\\<\\(TODO\\|FIXME\\|DRY\\)\\>.*$" 'always nil t)
;;----------------------------------------------------------------------------;;

(require 'anything-web-search)
(global-set-key "\C-cs" 'anything-web-search)

(require 'anything-project)
(global-set-key "\M-p" 'anything-project)

;;----------------------------------------------------------------------------;;
;; デフォルトのsourcesを決める
;;----------------------------------------------------------------------------;;
(setq anything-sources (list anything-c-source-buffers
                             anything-c-source-files-in-current-dir
                             anything-c-source-recentf
;                             anything-c-source-gtags-select
                             anything-c-source-fixme
;                             anything-c-source-occur-by-moccur
                             anything-c-source-buffer-not-found
;                             anything-c-source-emacs-commands
;                             anything-c-source-refe2x
;                             anything-c-source-calculation-result
                             anything-c-source-locate
;                             anything-c-source-google-suggest))
                             anything-c-source-my-projects
                             anything-c-source-projects-history
                             ))
;;----------------------------------------------------------------------------;;


