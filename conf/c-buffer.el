;;----------------------------------------------------------------------------;;
;; loading misc elisps
;;----------------------------------------------------------------------------;;
(require 'count-words);;$BJ8;z?t%+%&%s%H5!G=!#(B C-c w $B$G;XDjNN0h$NJ8;z?t$H9T?t$rI=<((B
(require 'view-extend);;$B1\Mw@lMQ%b!<%I$G(Bvi$B%i%$%/$J0\F0$r2DG=$K$9$k(B 
(require 'zombie-scratch);;*scratch*$B$r<+F0E*$KI|85$9$k(B
(require 'query-replace-auto-highlight)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; windmove Settings
;; $B%&%#%s%I%&$rJ,3d;~!"(BShift+$B%+!<%=%k%-!<$G0\F02DG=$K$9$k(B
;;----------------------------------------------------------------------------;;
(windmove-default-keybindings)
(setq windmove-wrap-around t) ;$B%H!<%i%9$K$9$k(B
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; Windows & Session Settings
;; Windows$B$O%&%#%s%I%&J,3d>uBV$r5-21$9$k!#(B
;; Session$B$O(Bemacs$B=*N;;~$K3+$$$F$$$?%P%C%U%!72$rJ]B8$9$k!#(B
;; C-x F$B$G:F5/F08e$KA4%P%C%U%!$rI|85$G$-$k!#(B
;; save sassion : C-x S
;; restore session : C-x F
;; kill session : C-x K
;;----------------------------------------------------------------------------;;
 (require 'windows)
 (setq win:use-frame nil)
 (win:startup-with-window)
 (define-key ctl-x-map "C" 'see-you-again)

 (when (require 'session nil t)
   (add-hook 'after-init-hook 'session-initialize))
 (autoload 'save-current-configuration "revive" "Save status" t)
 (autoload 'resume "revive" "Resume Emacs" t)
 (autoload 'wipe "revive" "Wipe emacs" t)
 (define-key ctl-x-map "F" 'resume)                        ;; C-x F $B$GI|85(B
 (define-key ctl-x-map "K" 'wipe)                          ;; C-x K $B$G(B Kill
 (add-hook 'kill-emacs-hook 'save-current-configuration)   ;; $B=*N;;~$KJ]B8(B
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; $BF10l%U%!%$%kL>$N;~!"%P%C%U%!L>$K%G%#%l%/%H%jL>$rIU2C(B
;;----------------------------------------------------------------------------;;
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; develock Settings : $B%?%V!"A43Q%9%Z!<%9!"9TKv$N%9%Z!<%9$K?'$rIU$1$k(B
;;; http://www.bookshelf.jp/soft/meadow_26.html#SEC313
;;; http://homepage1.nifty.com/blankspace/emacs/color.html
;;----------------------------------------------------------------------------;;
(require 'develock)
(if (featurep 'develock)
    (progn
      (setq develock-max-column-plist
            (list 'java-mode  120
                  'jde-mode   120
                  'emacs-lisp-mode 120
                  'lisp-interaction-mode 120
                  'c++-mode 120
                  'html-mode  nil
                  'html-helper-mode nil
                  'cperl-mode 120
                  'perl-mode  120
                  'c-mode 120))
      (let ((elem (copy-sequence (assq 'message-mode develock-keywords-alist))))
        (setcar elem 'html-helper-mode)
        (setq develock-keywords-alist
              (cons elem (delq (assq 'html-helper-mode develock-keywords-alist)
                               develock-keywords-alist))))))

(defface my-face-r-1 '((t (:background "gray15"))) nil :group 'my-faces)
(defface my-face-b-1 '((t (:background "gray26"))) nil :group 'my-faces)
(defface my-face-b-2 '((t (:background "gray70"))) nil :group 'my-faces)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil :group 'my-faces)
(defvar my-face-r-1 'my-face-r-1)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("$B!!(B" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append)
     ;;("[\r]*\n" 0 my-face-r-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

(defun toggle-colorful-space()
  "toggle while space font-lock"
  (interactive)
  (if my-face-b-1
      (progn
        (setq my-face-b-1 nil)
        (setq my-face-b-2 nil)
        (setq my-face-u-1 nil)
        (if (featurep 'develock)
            (develock-mode 0)))
    (progn
      (setq my-face-b-1 'my-face-b-1)
      (setq my-face-b-2 'my-face-b-2)
      (setq my-face-u-1 'my-face-u-1))))
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; $B%]%C%W%"%C%W$NI=<(<jK!$rJQ99(B
;;----------------------------------------------------------------------------;;
(setq split-height-threshold 100)
(setq pop-up-windows t)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; recentf Settings
;; "$B:G6a;H$C$?%U%!%$%k$r3+$/(B"$B!#(B
;; anything.el$B$G$bMxMQ$G$-$k!#(B
;;----------------------------------------------------------------------------;;
(setq recentf-auto-cleanup 'never)
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(setq recentf-max-saved-items 300)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; $B%U%!%$%k$N@hF,$,(B"#!"$B$N$H$-!"(B $B<+F0$G(B chmod +x $B$9$k!#(B
;; $B%9%/%j%W%HMQ!#(B
;;----------------------------------------------------------------------------;;
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; .emacs.el$B$rJ]B8$7$?$i%P%$%H%3%s%Q%$%k(B
;; $B%3%s%Q%$%k:Q@_Dj%U%!%$%k(B.emacs.elc$B$r@8@.$7!"(B
;; emacs$B$N=i4|5/F0$,9bB.$K$J$k!#(B
;; M-x byte-compile-file$B$GG$0U$N%?%$%_%s%0$G%P%$%H%3%s%Q%$%k2DG=(B
;;----------------------------------------------------------------------------;;
(add-hook 'after-save-hook
          (function (lambda ()
                      (if (string= (expand-file-name "~/.emacs.el")
                                   (buffer-file-name))
                          (save-excursion
                            (byte-compile-file "~/.emacs.el"))))))
;;----------------------------------------------------------------------------;;

;;----------------------------------------------------------------------------;;
;; skeleton settings
;; $BBP1~$9$k3g8L$r<+F0A^F~$9$k!#(B
;;----------------------------------------------------------------------------;;
(require 'skeleton)
(setq skeleton-pair-on-word t)
(setq skeleton-pair t)
(global-set-key "(" 'skeleton-pair-insert-maybe)
(global-set-key "[" 'skeleton-pair-insert-maybe)
(global-set-key "{" 'skeleton-pair-insert-maybe)
(global-set-key "`" 'skeleton-pair-insert-maybe)
(global-set-key "\"" 'skeleton-pair-insert-maybe)

(add-hook 'c-mode-common-hook
          #'(lambda ()
(local-set-key "(" 'skeleton-pair-insert-maybe)
(local-set-key "[" 'skeleton-pair-insert-maybe)
(local-set-key "{" 'skeleton-pair-insert-maybe)
(local-set-key "`" 'skeleton-pair-insert-maybe)
(local-set-key "\"" 'skeleton-pair-insert-maybe)
              ))
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; occur & moccur Setting : $B%U%!%$%kFb(Bgrep$B!#(Bmoccur$B$OJ#?t%U%!%$%k$X$N(Boccur$B!#(B
;; moccur$B$r;H$&$H!"%G%#%l%/%H%j0J2<$NA4%U%!%$%k$+$i8!:w$7$FCV49!"$J$I$,2DG=!#(B
;; C-c C-s$B$G(Bmoccur,
;; C-c C-g$B$G(Bmoccur-grep-find
;;----------------------------------------------------------------------------;;
(require 'color-moccur)
(require 'moccur-edit)
(autoload 'moccur-grep "color-moccur" nil t)
(autoload 'moccur-grep-find "color-moccur" nil t)
(global-set-key "\C-c\C-s" 'moccur)
(global-set-key "\C-c\C-g" 'moccur-grep-find)
(setq dmoccur-exclusion-mask
      (append '("\\~$" "\\.o$" "\\.git\*" "\\.svn\\/\*") dmoccur-exclusion-mask))
;;;occur$B$r(Bmigemo$BBP1~$5$;$k(B
;(defvar migemo-occur t)
;(defadvice occur
;  (around migemo-occur activate)
;  (if migemo-occur
;      (setq regexp (migemo-get-pattern regexp))
;    ())
;  ad-do-it)
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; linum settings
;; $B9T?t$r3F9T$N:8B&$KI=<($9$k!#(B
;;----------------------------------------------------------------------------;;
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d")
;;----------------------------------------------------------------------------;;


;;----------------------------------------------------------------------------;;
;; popwin settings
;; dependencies: anything.el
;;----------------------------------------------------------------------------;;
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq anything-samewindow nil)
(push '("*anything*" :height 20) popwin:special-display-config)
;;----------------------------------------------------------------------------;;