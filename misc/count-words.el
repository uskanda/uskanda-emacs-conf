;;----------------------------------------------------------------------------;;
;;  文字数カウント
;;----------------------------------------------------------------------------;;
(defun count-lines-and-words (start end)
  (interactive "r")
  (save-excursion
    (save-restriction
      (let ((lf-num 0)) ;;改行文字の個数用、初期化している。
        (goto-char start) ;;指定領域の先頭に行く。
        (while (re-search-forward "[\n\C-m]" end t) ;;改行文字のカウント
          (setq lf-num (+ 1 lf-num))) ;;(つまり、 search できる度に 1 足す)
        (message "指定領域は%d 文字 (除改行文字) 、%d 行、%d 文字 (含改行文字) "
                 (- end start lf-num) (count-lines start end) (- end start))))))
(global-set-key "\C-cw" 'count-lines-and-words)
;;----------------------------------------------------------------------------;;

(provide 'count-words)
