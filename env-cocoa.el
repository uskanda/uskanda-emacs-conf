(setenv "PATH"
	(concat "/opt/local/bin:~/Scripts:" (getenv "PATH")))
(setq exec-path (append '("/opt/local/bin") exec-path))
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote meta))
(define-key global-map [ns-drag-file] 'ns-find-file)
(setq ns-pop-up-frames nil)
;(setq line-move-visual nil)

(setq my-font "-*-*-medium-r-normal--12-*-*-*-*-*-fontset-hiramaru")
(setq fixed-width-use-QuickDraw-for-ascii t)
(setq mac-allow-anti-aliasing t)
(set-default-font my-font)
(add-to-list 'default-frame-alist `(font . ,my-font))
  (set-fontset-font
   (frame-parameter nil 'font)
   'japanese-jisx0208
   '("Hiragino Maru Gothic Pro" . "iso10646-1"))
  (setq face-font-rescale-alist
	'(("^-apple-hiragino.*" . 1.2)
	  (".*osaka-bold.*" . 1.2)
	  (".*osaka-medium.*" . 1.2)
	  (".*courier-bold-.*-mac-roman" . 1.0)
	  (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
	  (".*monaco-bold-.*-mac-roman" . 0.9)
	  ("-cdac$" . 1.3)))

