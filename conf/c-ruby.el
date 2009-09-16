;;----------------------------------------------------------------------------;;
;;ruby-block
;;対応するendを表示する
;;----------------------------------------------------------------------------;;
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay);; オーバレイする
;;----------------------------------------------------------------------------;;

;; Rinari
(add-to-list 'load-path "~/.emacs.d/vc/rinari")
(require 'rinari)

;;; rhtml-mode
(add-to-list 'load-path "~/.emacs.d/vc/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda () (rinari-launch)))

;;haml-mode
(require 'haml-mode nil 't)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
;;sass-mode
(require 'sass-mode nil 't)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
