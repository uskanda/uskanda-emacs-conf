(setq load-path (cons "~/.emacs.d/sdic/lisp" load-path))
(autoload 'sdic-describe-word "sdic" "英単語の意味を調べる" t nil)
(autoload 'sdic-describe-word-at-point "sdic" "カーソルの位置の英単語の意味を調べる" t nil)
(setq sdic-eiwa-dictionary-list
'((sdicf-client "~/.emacs.d/sdic/gene.sdic")))
(setq sdic-waei-dictionary-list
'((sdicf-client "~/.emacs.d/sdic/jedict.sdic"
(add-keys-to-headword t))))
(setq auto-lookup-backend 'sdic)
(autoload 'auto-lookup-mode "autolookup"
          "ポイント下の単語の訳を自動的に表示するマイナーモード" t)
(autoload 'global-auto-lookup-mode "autolookup" 
          "ポイント下の単語の訳を自動的に表示するマイナーモードをすべてのバッファで起動する．" t)
(setq auto-lookup-interval 0.5)

