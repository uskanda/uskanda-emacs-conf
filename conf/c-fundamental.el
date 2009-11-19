(eval-when-compile (require 'cl)) ;common-lisp機能を読みこむ

;;----------------------------------------------------------------------------;;
;; fundamental settings
;;----------------------------------------------------------------------------;;
(setq max-lisp-eval-depth 5000)
(setq max-specpdl-size 5000)
(setq inhibit-startup-message t) ;emacs開始時のメッセージ表示をしない
(setq backup-inhibited t) ;バックアップをやめる
(setq scroll-step 1) ;スクロールを1行ごとにする
(setq scroll-conservatively 1)
(setq completion-ignore-case t) ; 補完時に大文字小文字を区別しない
(setq initial-major-mode 'fundamental-mode) ;*scratch*バッファのデフォルトメジャーモードを決定
(line-number-mode nil) ; 行番号を表示
(display-time-mode 1) ;現在の時間を表示
(show-paren-mode 1) ;対応する括弧を強調表示
(transient-mark-mode 1) ;マークした箇所からカーソル位置までを強調表示
(global-auto-revert-mode t) ;変更があったら自動的に読み直す
(global-font-lock-mode t) ;いつでも色分けして表示
(setq-default tab-width 2 indent-tabs-mode nil) ;インデントにタブを使わない。
(setq ring-bell-function 'ignore) ;ベル(ビジュアルベル含)を鳴らさない。
;;(setq visible-bell t) ; ビープ音を鳴らすかわりに画面フラッシュ
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; Color Settings
;; Emacsの配色をまとめて設定
;;----------------------------------------------------------------------------;;
(require 'color-theme)
(color-theme-initialize)
;(color-theme-dark-laptop)
(color-theme-clarity)
;;----------------------------------------------------------------------------;;

(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

(require 'tramp)
