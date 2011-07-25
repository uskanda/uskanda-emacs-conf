(setenv "PATH"
	(concat "/opt/local/bin:~/Scripts:" (getenv "PATH")))
(setq exec-path (append '("/opt/local/bin") exec-path))
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote meta))
(define-key global-map [ns-drag-file] 'ns-find-file)
(setq ns-pop-up-frames nil)
;(setq line-move-visual nil)

;; http://d.hatena.ne.jp/setoryohei/20110117
;; 設定例2
(let* ((size 12) ; ASCIIフォントのサイズ [9/10/12/14/15/17/19/20/...]
       (asciifont "Menlo") ; ASCIIフォント
       ;; (jpfont "TakaoExGothic")             ; 日本語フォント
       (jpfont "Hiragino Kaku Gothic ProN") ; 日本語フォント
       (h (* size 10))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  ;; http://sakito.jp/moin/moin.cgi/EmacsFont を参考にして必要そうなものを追加
  (set-fontset-font nil 'jisx0201                 jp-fontspec)
  (set-fontset-font nil 'latin-jisx0201           jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0208        jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0208-1978   jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0212        jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-1      jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2      jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-a      jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'katakana-sjis            jp-fontspec)
  (set-fontset-font nil 'cp932-2-byte             jp-fontspec)
  (set-fontset-font nil 'cp932                    jp-fontspec)
  (set-fontset-font nil '(#x3040 . #x309f)        jp-fontspec) ; ひらがな
  (set-fontset-font nil '(#x30a0 . #x30ff)        jp-fontspec) ; カタカナ
  (set-fontset-font nil '(#xff00 . #xffef)        jp-fontspec) ; 半角・全角系
  (set-fontset-font nil '(#x0370 . #x03FF)        fontspec)    ; ギリシャ文字 
)
