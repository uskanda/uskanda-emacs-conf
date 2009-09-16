;;----------------------------------------------------------------------------;;
;; hl-line Settings
;; 現在行を目立たせる．
;;----------------------------------------------------------------------------;;
(require 'hl-line)
(global-hl-line-mode)
(hl-line-mode 1)
(defface my-hl-line-face 
  '((((class color) (background dark))  ; カラーかつ, 背景が dark ならば,
     (:background "gray14" t))   ; 背景を黒に.
    ;(((class color) (background light)) ; カラーかつ, 背景が light ならば,
    ; (:background "Medium Aquamarine" t))     ; 背景を ForestGreen に.
    (t (:bold t)))
  "hl-line's my face" :group 'my-faces)
(setq hl-line-face 'my-hl-line-face)
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; vline Settings
;; 現在列も目立たせる.
;;----------------------------------------------------------------------------;;
(require 'vline)
(vline-global-mode t)
(setq vline-face 'my-hl-line-face)
(setq vline-current-window-only t)
(defadvice vline-show (around vline-show-disable-in-visual-line activate)
   (if (< (current-column) (- (window-width) 1))
       ad-do-it
     (vline-clear))
  )
;;----------------------------------------------------------------------------;;

(current-column)