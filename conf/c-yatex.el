;;----------------------------------------------------------------------------;;
;; YaTeX (�쒹) Settings
;; tex�ҏW�̕⏕���s���B
;;----------------------------------------------------------------------------;;

; .tex�̃t�@�C���N������yatex-mode ���N��������ݒ�
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))

(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq load-path (cons (expand-file-name "~/.emacs.d/provided/yatex") load-path))
;(setq YaTeX-kanji-code 3) ; euc-jp

(add-hook 'yatex-mode-hook
          (lambda ()
              (reftex-mode 1)
              (yas/minor-mode 1)))

; dvi2-command�Ŏ����I�Ɋg���q��⊮���Ă����悤�ɂ���ݒ�
(setq YaTeX-dvi2-command-ext-alist
  '(("xdvi\\|dvipdfmx" . ".dvi")
    ("ghostview\\|gv" . ".ps")
    ("acroread\\|pdf\\|Preview\\|TeXShop" . ".pdf")))

; to customize
; typesetter�Apreviewer�̐ݒ�
(setq tex-command "~/Dropbox/Scripts/platex2pdf"
      dvi2-command "open -a Preview.app")


;(defun flymake-get-tex-args (file-name)
;  (list "platex-euc" (list "-file-line-error" "-interaction=nonstopmode" file-name)))
;(add-hook 'yatex-mode-hook
;          '(lambda ()
;             (flymake-mode t)))
