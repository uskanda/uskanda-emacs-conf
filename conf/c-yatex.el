;;----------------------------------------------------------------------------;;
;; YaTeX (野鳥) Settings
;; tex編集の補助を行う。
;;----------------------------------------------------------------------------;;

; .texのファイル起動時にyatex-mode を起動させる設定
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))

(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq load-path (cons (expand-file-name "~/.emacs.d/provided/yatex") load-path))
;(setq YaTeX-kanji-code 3) ; euc-jp

(add-hook 'yatex-mode-hook
          (lambda ()
              (reftex-mode 1)
              (yas/minor-mode 1)))

; dvi2-commandで自動的に拡張子を補完してくれるようにする設定
(setq YaTeX-dvi2-command-ext-alist
  '(("xdvi\\|dvipdfmx" . ".dvi")
    ("ghostview\\|gv" . ".ps")
    ("acroread\\|pdf\\|Preview\\|TeXShop" . ".pdf")))

; to customize
; typesetter、previewerの設定
(setq tex-command "~/Dropbox/Scripts/platex2pdf"
      dvi2-command "open -a Preview.app")


;(defun flymake-get-tex-args (file-name)
;  (list "platex-euc" (list "-file-line-error" "-interaction=nonstopmode" file-name)))
;(add-hook 'yatex-mode-hook
;          '(lambda ()
;             (flymake-mode t)))
