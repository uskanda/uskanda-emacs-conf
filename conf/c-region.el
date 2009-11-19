;;----------------------------------------------------------------------------;;
;; リージョンがアクティブな時はバックスペースでリージョン削除
;;----------------------------------------------------------------------------;;
(defadvice backward-delete-char-untabify
  (around ys:backward-delete-region activate)
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; sense-region Settings
;;   http://Taiyuan.org/elisp/sense-region/
;; 範囲選択を改良する。
;; C-SC。
;;----------------------------------------------------------------------------;;
(autoload 'sense-region-on "sense-region"
  "System to toggle region and rectangle." t nil)
(sense-region-on)
;;----------------------------------------------------------------------------;;

