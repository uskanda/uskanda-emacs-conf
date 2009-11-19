(eval-when-compile (require 'cl))

(defun ruby-bracket-re-search-without-string(func regex limit)
  (let ((check t)(point 0))
    (save-excursion
      (while check
        (if (funcall func regex limit t)
            (when (not (eq (get-text-property (point) 'face)
                           'font-lock-string-face))
              (setq point (point)
                    check nil))
          (setq check nil
                point nil)))
        (symbol-value 'point))))

(defun ruby-bracket-re-search-backward-without-string(regex limit)
  (ruby-bracket-re-search-without-string
   're-search-backward regex limit))

(defun ruby-bracket-re-search-forward-without-string(regex limit)
  (ruby-bracket-re-search-without-string
   're-search-forward regex limit))

(defun ruby-bracket-replace-branket(searchfunc regex limit pat)
  "search regexp "
  (let ((count 1)(point 0)(check t)(face "")(deletef nil)(charf nil))
    (if (eq searchfunc 're-search-forward)
        (setq charf 'char-before)
      (setq charf 'char-after))
    (save-excursion
      (while check
        (if (funcall searchfunc regex limit t)
            (setq face   (get-text-property (point) 'face))
            (setq count -2
                  face ""
                  check nil
                  point -1))
        (when (not (eq face 'font-lock-string-face))
          (if (char-equal (funcall charf) pat)
              (setq count (1- count))
              (setq count (1+ count))))
        (when (= count 0)
          (setq check nil
                point (point))))
          point)))

(defun ruby-brankets-branket-replace(point delete str)
  (let ((diff 0))
    (goto-char point)
    (delete-char delete)
    (when (not (char-equal (preceding-char) ?\ ))
      (insert " ")
      (setq diff (1+ diff)))
    (insert str)
    (setq diff (+ diff (length str)))))

(defun ruby-bracket()
  (interactive)
  (let ((line-start (save-excursion (beginning-of-line)
                           (point)))
        (line-end  (save-excursion (end-of-line)
                           (point)))
        (right-point 0)(left-point 0)(bar-point 0)(diff 0))
        (when (and (/= (setq right-point (ruby-bracket-replace-branket
                        're-search-forward "{\\|}" line-end  ?\} )) -1)
                  (/= (setq left-point (ruby-bracket-replace-branket
                       're-search-backward "{\\|}" line-start  ?\{ )) -1))
          (ruby-brankets-branket-replace right-point -1 "end")
          (setq diff (ruby-brankets-branket-replace left-point 1 "do"))
          (goto-char (+ right-point diff -3 1))
          (newline-and-indent)
          (if (setq bar-point (ruby-bracket-re-search-backward-without-string "\|" line-start))
              (progn (goto-char (1+ bar-point))
                     (newline-and-indent))
            (progn (goto-char (+ left-point diff))
                   (newline-and-indent)))
          )))

(define-key ruby-mode-map "\C-c\C-m" 'ruby-bracket)

(provide 'ruby-bracket)
