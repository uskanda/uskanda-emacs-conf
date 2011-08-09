;;----------------------------------------------------------------------------;;
;; loading misc elisps
;;----------------------------------------------------------------------------;;
(require 'count-words);;文字数カウント機能。 C-c w で指定領域の文字数と行数を表示
(require 'view-extend);;閲覧専用モードでviライクな移動を可能にする 
(require 'zombie-scratch);;*scratch*を自動的に復元する
(require 'query-replace-auto-highlight)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; windmove Settings
;; ウィンドウを分割時、Shift+カーソルキーで移動可能にする
;;----------------------------------------------------------------------------;;
(windmove-default-keybindings)
(setq windmove-wrap-around t) ;トーラスにする
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; Windows & Session Settings
;; Windowsはウィンドウ分割状態を記憶する。
;; Sessionはemacs終了時に開いていたバッファ群を保存する。
;; C-x Fで再起動後に全バッファを復元できる。
;; save sassion : C-x S
;; restore session : C-x F
;; kill session : C-x K
;;----------------------------------------------------------------------------;;
 (require 'windows)
 (setq win:use-frame nil)
 (win:startup-with-window)
 (define-key ctl-x-map "C" 'see-you-again)

 (when (require 'session nil t)
   (add-hook 'after-init-hook 'session-initialize))
 (autoload 'save-current-configuration "revive" "Save status" t)
 (autoload 'resume "revive" "Resume Emacs" t)
 (autoload 'wipe "revive" "Wipe emacs" t)
 (define-key ctl-x-map "F" 'resume)                        ;; C-x F で復元
 (define-key ctl-x-map "K" 'wipe)                          ;; C-x K で Kill
 (add-hook 'kill-emacs-hook 'save-current-configuration)   ;; 終了時に保存
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; 同一ファイル名の時、バッファ名にディレクトリ名を付加
;;----------------------------------------------------------------------------;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; develock Settings : タブ、全角スペース、行末のスペースに色を付ける
;;; http://www.bookshelf.jp/soft/meadow_26.html#SEC313
;;; http://homepage1.nifty.com/blankspace/emacs/color.html
;;----------------------------------------------------------------------------;;
(require 'develock)
(if (featurep 'develock)
    (progn
      (setq develock-max-column-plist
            (list 'java-mode  120
                  'jde-mode   120
                  'emacs-lisp-mode 120
                  'lisp-interaction-mode 120
                  'c++-mode 120
                  'html-mode  nil
                  'html-helper-mode nil
                  'cperl-mode 120
                  'perl-mode  120
                  'c-mode 120))
      (let ((elem (copy-sequence (assq 'message-mode develock-keywords-alist))))
        (setcar elem 'html-helper-mode)
        (setq develock-keywords-alist
              (cons elem (delq (assq 'html-helper-mode develock-keywords-alist)
                               develock-keywords-alist))))))

(defface my-face-r-1 '((t (:background "gray15"))) nil :group 'my-faces)
(defface my-face-b-1 '((t (:background "gray26"))) nil :group 'my-faces)
(defface my-face-b-2 '((t (:background "gray70"))) nil :group 'my-faces)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil :group 'my-faces)
(defvar my-face-r-1 'my-face-r-1)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     ;;("[\r]*\n" 0 my-face-r-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

(defun toggle-colorful-space()
  "toggle while space font-lock"
  (interactive)
  (if my-face-b-1
      (progn
        (setq my-face-b-1 nil)
        (setq my-face-b-2 nil)
        (setq my-face-u-1 nil)
        (if (featurep 'develock)
            (develock-mode 0)))
    (progn
      (setq my-face-b-1 'my-face-b-1)
      (setq my-face-b-2 'my-face-b-2)
      (setq my-face-u-1 'my-face-u-1))))
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; ポップアップの表示手法を変更
;;----------------------------------------------------------------------------;;
(setq split-height-threshold 100)
(setq pop-up-windows t)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; recentf Settings
;; "最近使ったファイルを開く"。
;; anything.elでも利用できる。
;;----------------------------------------------------------------------------;;
(setq recentf-auto-cleanup 'never)
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(setq recentf-max-saved-items 300)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; ファイルの先頭が"#!"のとき、 自動で chmod +x する。
;; スクリプト用。
;;----------------------------------------------------------------------------;;
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; .emacs.elを保存したらバイトコンパイル
;; コンパイル済設定ファイル.emacs.elcを生成し、
;; emacsの初期起動が高速になる。
;; M-x byte-compile-fileで任意のタイミングでバイトコンパイル可能
;;----------------------------------------------------------------------------;;
(add-hook 'after-save-hook
          (function (lambda ()
                      (if (string= (expand-file-name "~/.emacs.el")
                                   (buffer-file-name))
                          (save-excursion
                            (byte-compile-file "~/.emacs.el"))))))
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; skeleton settings
;; 対応する括弧を自動挿入する。
;;----------------------------------------------------------------------------;;
(require 'skeleton)
(setq skeleton-pair-on-word t)
(setq skeleton-pair t)
(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
(global-set-key "`" 'skeleton-pair-insert-maybe)
(global-set-key "\"" 'skeleton-pair-insert-maybe)

(add-hook 'c-mode-common-hook
          #'(lambda ()
(local-set-key "(" 'skeleton-pair-insert-maybe)
(local-set-key "[" 'skeleton-pair-insert-maybe)
(local-set-key "{" 'skeleton-pair-insert-maybe)
(local-set-key "`" 'skeleton-pair-insert-maybe)
(local-set-key "\"" 'skeleton-pair-insert-maybe)
              ))
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; occur & moccur Setting : ファイル内grep。moccurは複数ファイルへのoccur。
;; moccurを使うと、ディレクトリ以下の全ファイルから検索して置換、などが可能。
;; C-c C-sでmoccur,
;; C-c C-gでmoccur-grep-find
;;----------------------------------------------------------------------------;;
(require 'color-moccur)
(require 'moccur-edit)
(autoload 'moccur-grep "color-moccur" nil t)
(autoload 'moccur-grep-find "color-moccur" nil t)
(global-set-key "\C-c\C-s" 'moccur)
(global-set-key "\C-c\C-g" 'moccur-grep-find)
(setq dmoccur-exclusion-mask
      (append '("\\~$" "\\.o$" "\\.git\*" "\\.svn\\/\*") dmoccur-exclusion-mask))
;;;occurをmigemo対応させる
;(defvar migemo-occur t)
;(defadvice occur
;  (around migemo-occur activate)
;  (if migemo-occur
;      (setq regexp (migemo-get-pattern regexp))
;    ())
;  ad-do-it)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; linum settings
;; 行数を各行の左側に表示する。
;;----------------------------------------------------------------------------;;
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d")
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; popwin settings
;; dependencies: anything.el
;;----------------------------------------------------------------------------;;
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq anything-samewindow nil)
(push '("*anything*" :height 20) popwin:special-display-config)
;;----------------------------------------------------------------------------;;