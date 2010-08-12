(load "env-utf-8")
(setenv "PATH"
	(concat "/opt/local/bin:~/Scripts:/Applications/pTeX.app/teTeX/bin:" (getenv "PATH")))
(setq exec-path (append '("/opt/local/bin:/Applications/pTeX.app/teTeX/bin") exec-path))
;;----------------------------------------------------------------------------;;
;; window settings
;; 全画面化・ツールバー及びスクロールバー削除。
;;----------------------------------------------------------------------------;;
(toggle-scroll-bar nil)
(tool-bar-mode)
(add-hook 'window-setup-hook
            (lambda ()
              (set-frame-parameter nil 'fullscreen 'fullboth)))
(setq mac-autohide-menubar-on-maximize t)
(set-frame-parameter nil 'alpha 100) ;透過率設定
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; mac keybind settings
;;----------------------------------------------------------------------------;;
;(mac-key-mode 1) ;;ComnmandキーをMacアプリケーションの動作と同様にする
(setq mac-command-modifier 'meta) ;;CommandキーをControlキーにする
(setq mac-option-modifier 'meta) ;;option(alt)をMetaキーにする
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; mac font settings
;; ヒラギノ丸ゴを使用。
;;----------------------------------------------------------------------------;;
(require 'carbon-font)
;(fixed-width-set-fontset "Hiram's" 12)
;(fixed-width-set-fontset "hirakaku_w3" 20)
(fixed-width-set-fontset "hirakaku_w3" 12)
;(fixed-width-set-default-fontset "fontset-hiraginokaku2")
;;----------------------------------------------------------------------------;;

(setq carbon-font-encode-family-list-hiraginokaku2
  `((ascii . "arial")
    (japanese-jisx0208 . "ヒラギノ角ゴ*")
    (katakana-jisx0201 . "ヒラギノ角ゴ*")
    (japanese-jisx0212 . "hiragino kaku gothic pro")
    (thai-tis620 . "ayuthaya")
    (chinese-gb2312 . ,(if (x-list-fonts "*华文细黑*") "华文细黑*" "华文黑体*"))
    (chinese-big5-1 . "儷黑*")
    (korean-ksc5601 . "applegothic*")))

(carbon-font-create-fontset "hiraginokaku2"
                            carbon-font-defined-sizes
                            carbon-font-encode-family-list-hiraginokaku2)


(setq default-input-method "MacOSX")
