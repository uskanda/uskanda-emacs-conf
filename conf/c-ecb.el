;;----------------------------------------------------------------------------;;
;; ECB Settings
;; Emacsを統合開発環境っぽくする。
;; メソッドリストだけでも出しておくと便利。
;; 注意 : ウィンドウ構造保存系elisp(windows.el,elscreen.el等)
;;        との相性は最悪で、ほぼ排他的である。
;;----------------------------------------------------------------------------;;
(add-to-list 'load-path "~/.emacs.d/elisp/ecb-2.32")
(load-file "~/.emacs.d/elisp/cedet-1.0pre4/common/cedet.el")
(require 'ecb)
(setq ecb-auto-activate nil)
(setq ecb-windows-width 0.16)
(setq ecb-tip-of-the-day nil)
(defun ecb-toggle ()
    (interactive)
      (if ecb-minor-mode
                (ecb-deactivate)
            (ecb-activate)))
(global-set-key [f2] 'ecb-toggle)
(setq ecb-layout-name "left9") ;メソッドリストだけ表示

(require 'semantic)
(setq semantic-load-turn-everything-on t)
(semantic-load-enable-code-helpers)
(global-semantic-idle-completions-mode 0)
(global-semantic-idle-scheduler-mode 0)
(global-semantic-decoration-mode 1)
(custom-set-variables
'(semantic-idle-scheduler-idle-time 0.3))
(setq semantic-load-turn-everything-on t)
;;----------------------------------------------------------------------------;;
