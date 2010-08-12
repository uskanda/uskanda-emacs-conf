;;; gnuserv の設定
(require 'gnuserv)
(gnuserv-start)
;; 新しいフレームを開かない
(setq gnuserv-frame (selected-frame))

;;; 日本語環境設定
(set-language-environment "Japanese")
;; (require 'un-define)
;; (require 'jisx0213)

;;; IMEの設定
(mw32-ime-initialize)
(setq default-input-method "MW32-IME")
(setq-default mw32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
(add-hook 'mw32-ime-on-hook
	  (function (lambda () (set-cursor-height 2))))
(add-hook 'mw32-ime-off-hook
	  (function (lambda () (set-cursor-height 4))))


;;; マウスカーソルを消す設定
(setq w32-hide-mouse-on-key t)
(setq w32-hide-mouse-timeout 5000)

;;; font-lockの設定
(global-font-lock-mode t)

(w32-add-font
 "fontset-meirio"
 '((strict-spec
	((:char-spec ascii :height any)
	 (w32-logfont "Courier New" 0 18 400 0 nil nil nil 0 1 3 49))
	((:char-spec ascii :height any :weight bold)
	 (w32-logfont "Courier New" 0 18 700 0 nil nil nil 0 1 3 49))
	((:char-spec ascii :height any :slant italic)
	 (w32-logfont "Courier New" 0 18 400 0	t nil nil 0 1 3 49))
	((:char-spec ascii :height any :weight bold :slant italic)
	 (w32-logfont "Courier New" 0 18 700 0	t nil nil 0 1 3 49))
	((:char-spec japanese-jisx0208 :height any)
	 (w32-logfont "メイリオ" 0 18 400 0 nil nil nil 128 1 3 49))
	((:char-spec japanese-jisx0208 :height any :weight bold)
	 (w32-logfont "メイリオ" 0 18 700 0 nil nil nil 128 1 3 49)
	 ((spacing . -1)))
	((:char-spec japanese-jisx0208 :height any :slant italic)
	 (w32-logfont "メイリオ" 0 18 400 0	t nil nil 128 1 3 49))
	((:char-spec japanese-jisx0208 :height any :weight bold :slant italic)
	 (w32-logfont "メイリオ" 0 18 700 0	t nil nil 128 1 3 49)
	 ((spacing . -1)))
	((:char-spec katakana-jisx0201 :height any)
	 (w32-logfont "メイリオ" 0 18 400 0 nil nil nil 128 1 3 49))
	((:char-spec katakana-jisx0201 :height any :weight bold)
	 (w32-logfont "メイリオ" 0 18 700 0 nil nil nil 128 1 3 49)
	 ((spacing . -1)))
	((:char-spec katakana-jisx0201 :height any :slant italic)
	 (w32-logfont "メイリオ" 0 18 400 0	t nil nil 128 1 3 49))
	((:char-spec katakana-jisx0201 :height any :weight bold :slant italic)
	 (w32-logfont "メイリオ" 0 18 700 0	t nil nil 128 1 3 49)
	 ((spacing . -1)))
)))

(setq default-frame-alist
	(append (list
	'(font . "fontset-meirio") ; フォントセット
	)
	default-frame-alist))

;; 初期フレームの設定
(setq default-frame-alist
      (append (list ;;'(ime-font . (w32-logfont "ＭＳ ゴシック"
;;					      0 16 400 0 nil nil nil
;;					      128 1 3 49)) ; TrueType のみ
;;		    '(font . "bdf-fontset")    ; BDF
;;		    '(font . "private-fontset"); TrueType
		    '(width . 80)
		    '(height . 40)
		    '(top . 100)
		    '(left . 100))
	      default-frame-alist))

;;; argument-editing の設定
(require 'mw32script)
(mw32script-init)

(modify-all-frames-parameters
 (list (cons 'alpha  '(90 70 50 30))))

 	

;;; tool-bar+.el --- Extensions to standard library tool-bar.el
;;
;; Filename: tool-bar+.el
;; Description: Extensions to standard library tool-bar.el
;; Author: Drew Adams
;; Maintainer: Drew Adams
;; Copyright (C) 2004, Drew Adams, all rights reserved.
;; Created: Tue Oct 05 17:02:16 2004
;; Version: 21.0
;; Last-Updated: Sun Oct 10 21:41:05 2004
;;           By: dradams
;;     Update #: 163
;; Keywords: tool-bar, convenience, mouse, button, frame
;; Compatibility: GNU Emacs 21.x
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary: Extensions to standard library tool-bar.el
;;
;;
;;  New commands defined here:
;;
;;    `show-tool-bar-for-one-command', `tool-bar-here-mode',
;;    `tool-bar-pop-up-mode'.
;;
;;
;;  New key bound here: [menu-bar pop-up-tool-bar]
;;
;;
;;  Usage:
;;
;;    Load this library: (require 'tool-bar+).
;;    Turn on tool-bar pop-up mode: M-x tool-bar-pop-up-mode.
;;
;;    Click "Buttons" in the menu-bar to access the tool-bar when you
;;    need it. This displays the tool-bar buttons just long enough for
;;    one command: after you click a tool-bar button, the tool-bar
;;    disappears again.
;;
;;    The advantage of `tool-bar-pop-up-mode' is that you do not lose
;;    frame real estate to the tool-bar -- you have it when you need
;;    it, at the cost of an extra click ("Buttons").
;;
;;    In addition to defining minor mode `tool-bar-pop-up-mode', this
;;    library defines minor mode `tool-bar-here-mode', which is the
;;    same as the global `tool-bar-mode' except that it affects only
;;    the current frame.
;;
;;    The advantage of `tool-bar-here-mode' is (again) that it saves
;;    real estate on frames other than the ones with the tool-bar.
;;
;;
;;  Put this in your initialization file (`~/.emacs'):
;;
;;  (require 'tool-bar+) ; load this library
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change log:
;;
;; 2004/10/10 dadams
;;
;;     Added condition-case in show-tool-bar-for-one-command.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;;; Local Tool Bar Mode -------------------------

(define-minor-mode tool-bar-here-mode
  "Toggle use of the tool bar on this frame only.
With numeric ARG, display the tool bar if and only if ARG is positive.

See `tool-bar-add-item' and `tool-bar-add-item-from-menu' for
conveniently adding tool bar items."
  :init-value nil :global t :group 'mouse :group 'frames
  (and (display-images-p)
       (let ((lines (if tool-bar-here-mode 1 0)))
         ;; Alter existing frame...
         (modify-frame-parameters (selected-frame) (list (cons 'tool-bar-lines
                                                               lines))))
       (if (and tool-bar-here-mode
                (display-graphic-p)
                (= 1 (length (default-value 'tool-bar-map)))) ; not yet set up
           (tool-bar-setup))))

(make-variable-frame-local 'tool-bar-here-mode)

;;; Pop-Up Tool Bar Mode ------------------------

;; If either of the normal tool-bar modes is turned on, then
;; `tool-bar-popup-mode' is not available.
(define-key global-map [menu-bar pop-up-tool-bar]
  '(menu-item
    "Buttons" show-tool-bar-for-one-command
    :visible (and tool-bar-pop-up-mode (not tool-bar-mode) (not
                                                            tool-bar-here-mode))
    :enable  (and tool-bar-pop-up-mode (not tool-bar-mode) (not
                                                            tool-bar-here-mode))
    :help "Use tool bar for one command"))

(setq menu-bar-final-items (append menu-bar-final-items (list
                                                         'pop-up-tool-bar)))

(define-minor-mode tool-bar-pop-up-mode
  "Toggle tool-bar pop-up.
With numeric ARG, turn on tool-bar pop-up if and only if ARG is positive.

Note: Command `tool-bar-pop-up-mode' functions as a toggle only
      if neither `tool-bar-mode' nor `tool-bar-here-mode' is on.

      If either of those modes is on, then command
      `tool-bar-pop-up-mode' turns them both off and turns
      `tool-bar-pop-up-mode' on."
  :init-value nil :global t :group 'mouse :group 'frames
  (when (or tool-bar-mode tool-bar-here-mode)
    (setq tool-bar-pop-up-mode t)
    (tool-bar-mode -99)
    (tool-bar-here-mode -99)))

;; Note: This treats mouse events specially: it scrolls the buffer
;; text (window) down to compensate for the disappearance of the
;; tool-bar.  That is, it replaces the tool-bar with an equivalent
;; number of lines of buffer text.
;;
;; This is so that the place where you click the mouse when the
;; tool-bar is visible corresponds to the place where the mouse is
;; after the tool-bar disappears. Otherwise, the buffer text moves up,
;; relative to the mouse, and a region is selected (without ever
;; physically moving the mouse).
;;
(defun show-tool-bar-for-one-command ()
  "Pop up the tool bar so you can click a button.
The tool bar stays visible until one command is executed
\(whether or not it was initiated by clicking a button)."
  (interactive)
  (unless tool-bar-pop-up-mode
    (error "You must turn on `tool-bar-pop-up-mode' to use this command"))
  (let (evnt tb-lines)
    (unwind-protect
        (progn
          (tool-bar-here-mode 99)       ; Show tool-bar
          (setq evnt (read-event))
          (push evnt unread-command-events))
      (when (and (consp evnt)
                 (member (event-basic-type (car evnt)) '(mouse-1 mouse-2
                                                                 mouse-3)))
        (setq tb-lines (cdr (assq 'tool-bar-lines (frame-parameters
                                                   (selected-frame)))))
        (condition-case nil
            (when tb-lines (scroll-down tb-lines))
          (error (tool-bar-here-mode -99)))) ; E.g. "Beginning of buffer"
      (tool-bar-here-mode -99))))       ; Hide tool-bar


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'tool-bar+)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; tool-bar+.el ends here
(tool-bar-pop-up-mode t)
