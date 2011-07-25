(require 'ruby-electric)
;(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))

;;----------------------------------------------------------------------------;;
;;ruby-block
;;対応するendを表示する
;;----------------------------------------------------------------------------;;
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay);; オーバレイする
;;----------------------------------------------------------------------------;;


(require 'ruby-bracket)


;; Rinari
(add-to-list 'load-path "~/.emacs.d/vc/rinari")
(require 'rinari)

;;haml-mode
(require 'haml-mode nil 't)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
;;sass-mode
(require 'sass-mode nil 't)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))

