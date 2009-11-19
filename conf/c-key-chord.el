;;----------------------------------------------------------------------;;
;; key-chord Settings
;; キーの同時押しによる任意のコマンドの実行が可能。
;;----------------------------------------------------------------------;;
(require 'key-chord)
(setq key-chord-two-keys-delay 0.03)
(key-chord-mode 1)

;; l,dをprefix的に
;;l+左手
(key-chord-define-global "lf" 'find-file)
(key-chord-define-global "lb" 'anything-select-buffer-command)
(key-chord-define-global "lx" 'anything-execute-emacs-commands-command)
(key-chord-define-global "lt" 'anything-gtags-select)
(key-chord-define-global "ls" 'anything-search-reference-command)
;;d+右手
(key-chord-define-global "do" 'anything-c-moccur-occur-by-moccur)
(key-chord-define-global "dp" 'anything-c-moccur-dmoccur)
(key-chord-define-global "dy" 'anything-c-yas-complete)
(key-chord-define-global "ds" 'anything-dabbrev-expand)

;; ホームポジション近辺
(key-chord-define-global "jk" 'view-mode)
(key-chord-define-global "lk" 'anything)
(key-chord-define-global ",." 'query-replace)
;(key-chord-define-global "cv" ')
;(key-chord-define-global "we" ')
;(key-chord-define-global "io" ')

;; キーからの連想により設定したchord
(key-chord-define-global "cx" 'Control-X-prefix) ;'C'-'x'
;;(key-chord-define-global "er" 'eval-region)      ;'E'val 'R'egion
(key-chord-define-global "cd" 'comment-dwim)     ;'C'omment 'D'wim
(key-chord-define-global "gl" 'goto-line)        ;'G'o to 'L'ine
(key-chord-define-global "ui" 'shell-toggle-cd)  ;go to C'UI' shell
(key-chord-define-global "gj" 'anything-gtags-select) ;gtags jump

;; a,;とのkey-chordで一部 Metaコマンド
(key-chord-define-global "ah" 'mark-paragraph)


(key-chord-define-global "tr" 'indent-region)


;;----------------------------------------------------------------------;;

;;----------------------------------------------------------------------;;
;; IME切り替え時にkey-chordが効かなくなる問題への対処
;;----------------------------------------------------------------------;;
(defadvice toggle-input-method (around toggle-input-method-around activate)
  (let ((input-method-function-save input-method-function))
    ad-do-it
    (setq input-method-function input-method-function-save)))
(defadvice mac-toggle-input-method (around toggle-input-method-around activate)
  (let ((input-method-function-save input-method-function))
    ad-do-it
    (setq input-method-function input-method-function-save)))
;----------------------------------------------------------------------;;


;;----------------------------------------------------------------------;;
;; たまに key-chord が 壊れる の を修正
;;----------------------------------------------------------------------;;
(defun key-chord-recover-from-stack (arg) "" (interactive "P")
  (progn
    (key-chord-mode arg) (key-chord-mode arg))
)
;;----------------------------------------------------------------------;;
