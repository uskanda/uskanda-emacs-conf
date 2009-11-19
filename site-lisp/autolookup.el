;;; autolookup.el --- On-the-fly lookup/sdic
;; Copyright (C) 2000 Lookup Development Team <lookup@ring.gr.jp>

;; Author: Masatake YAMATO <jet@gyve.org>

;; This file will be part of Lookup.

;; Lookup is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.

;; Lookup is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with Lookup; if not, write to the Free Software Foundation,
;; Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

;; ����:
;;
;; * autolookup.el�Ȥ�
;; ���Υץ����ϡ����̤�����ɬ�פȤ��뤳�Ȥʤ�(Emacs��)�ݥ���Ȳ��ˤ���ñ�������
;; ���������ꥢ��ɽ������ץ����Ǥ����桼����1�ôֲ��⥨�ǥ������򤷤ʤ���ñ�������
;; ɽ������ޤ������������ꥢ������ɽ������Τǡ�����ɽ���ˤ�äƥ�����ɥ��Υ쥤�����Ȥʤɤ�
;; �ѹ����Ƥ��ޤ�����Ϥ���ޤ���
;; 
;; * ���Ѥ�ɬ�פʤ��
;; ñ������μ������뤿��ˡ�lookup(http://openlab.ring.gr.jp/lookup)��
;; sdic(http://www-nagao.kuee.kyoto-u.ac.jp/member/tsuchiya/sdic/)��
;; ɬ�פǤ���
;; 
;; ��ȯ�ˤϡ�
;; emacs�ˤϡ�XEmacs21.1��
;; lookup��1.3��sdic��2.1.2��
;; ����ϡ�gene95�Τߤ��Ѥ��ޤ���������ʳ��μ�����Ѥ������䡤gene95��ʻ�Ѥ�����硤
;; �ˤĤ���Ĵ�٤Ƥ��ޤ���
;;
;; * �Ȥ���
;; �ޤ����ɥѥ����̤ä��ǥ��쥯�ȥ�ˤ��Υե������"autolookup.el"��̾������¸���ޤ���
;; lookup��Ȥ����ˤϡ�
;;
;; (setq auto-lookup-backend 'lookup)
;;
;; sdic��Ȥ����ˤϡ�
;;
;; (setq auto-lookup-backend 'sdic)
;;
;; ��.emacs���ɲä��ޤ��������.emacs�˼���4�Ԥ��ɲä��ơ�ɾ�����ޤ���
;;
;; (autoload 'auto-lookup-mode "autolookup" 
;;           "�ݥ���Ȳ���ñ�������ưŪ��ɽ������ޥ��ʡ��⡼��" t)
;; (autoload 'global-auto-lookup-mode "autolookup" 
;;           "�ݥ���Ȳ���ñ�������ưŪ��ɽ������ޥ��ʡ��⡼�ɤ򤹤٤ƤΥХåե��ǵ�ư���롥" t)
;;
;; ���Τɤ��餫�Υ��ޥ�ɤ�¹Ԥ��Ƶ�ư���ޤ���
;; M-x auto-lookup-mode
;; �ˤ�ä�ñ�������ưŪ��ɽ������ޥ��ʡ��⡼�ɤ�on/off���뤳�Ȥ��Ǥ��ޤ���
;; �ޥ��ʡ��⡼�ɤʤΤǥ��ޥ�ɤ�¹Ԥ����Хåե��ǤΤ�ñ�������ưŪ��ɽ�����ޤ���
;;
;; M-x global-auto-lookup-mode
;; ���٤ƤΥХåե���Ʊ����auto-lookup-mode��on/off���뤳�Ȥ��Ǥ��ޤ���
;;
;; * �������ޥ���
;; sdic��Ȥ���,lookup��Ȥ����ϡ�`auto-lookup-backend'�Ȥ���
;; �ѿ������椷�ޤ���
;; ñ�������ɽ������ޤǤ�
;; ���֤�`auto-lookup-interval'�Ȥ����ѿ��ˤ��Ĵ�����뤳�Ȥ��Ǥ��ޤ���
;; sdic��Хå�����ɤ˻Ȥ���硤���Ѳ�ǽ��(ʣ����)���Ƥμ�����Ѥ���ȸ���
;; �˻��֤��������礬����ޤ���Auto lookup�ǻ��Ѥ����������
;; `auto-lookup-backend:sdic-eiwa-dictionary-list'
;; ��`auto-lookup-backend:sdic-waei-dictionary-list'
;; �˻��ꤷ�ơ��������֤�û�̤Ǥ��ޤ���
;;
;; �ѹ�����:
;;
;; Release 9
;; * Hideyuki SHIRAI (��潨��)����<shirai at rdmg.mgcs.mei.co.jp>��
;;   patch�򤢤Ƥ���
;;   - ����ñ���椫�������ڼΤƤ�.
;;   - ���ܸ��ñ��ϣ�ʸ���ʾ�򸡺�����.
;;   - ����ñ���downward����.
;;
;; Release 8
;; * �ѿ�̾���ѹ�������
;;   auto-lookup-mode-backend->auto-lookup-backend.
;; * ��ʸ����ñ��ϸ������ʤ�(sdic)��
;; * sdic backend��syntax table���ѹ�����Τ��᤿��
;; * ����ܥ�̾���backend-lookup��backend-sdic
;;   ���줾��backend:lookup, backend:sdic���ѹ�������
;; * sdic��ʣ����ʬ�η�̤�ɽ������褦�ˤ�����
;; * okada at opaopa.org (���� ��� /Kenichi OKADA)������±Ѽ�������
;;   ����Υѥå������Ƥ���
;; * Hideyuki SHIRAI (��潨��)����<shirai at rdmg.mgcs.mei.co.jp>��
;;   sdic backend���Ф���ѥå��򤢤Ƥ���
;;   - auto-lookup-backend:sdic-word-input�Ǽ��Ф���ñ������ܸ�ʸ����
;;     �ޤ��äƤ��ʤ��������å����롥
;;   - ������α��¼���/���¼������ꤹ�뵡ǽ���ɲä�����
;; * Added etags backend (experimental).
;;
;; Release 7
;; * sdic��lookup��ξ����Ȥ���褦�ˤ�����
;; * GNU Emacs�Ǥ�ư����ǧ������
;;
;; Release 6
;; * Author�Υե�����ɤ��ѹ�������
;;
;; Release 5
;; * global-auto-lookup-mode�����äƤ���С��������ե�����򳫤����Ȥ��ˡ�
;;   ��ưŪ��global-auto-lookup-mode������褦�ˤ�����
;;
;; Release 4
;; * global mode������Ȥ��٤ƤΥХåե���AutoLookup��ɽ������褦�ˤ�����
;; * lookup�η�̤��������ؿ���ɽ������ؿ���ʬΥ������
;; * customize�Ǥ���褦�ˤ�����
;; * �ɥ�����Ȥ�񤤤���
;;
;; Release 3
;; * Added some documents.
;; * Avoid lookup if the cursor is in minibuffer.
;; * Avoid lookup if isearch is active.
;;
;; Release 2
;; * Added global-auto-lookup-mode

;; �ռ�:
;; autolookup.el�ϲ����˷Ǻܤ��줿��Keisuke Nishida<kxn30@po.cwru.edu> ����
;; �Υ����ɤ�������������ΤǤ���
;; http://news.ring.gr.jp/news/openlab.lookup-ja/1012

;; TODO:
;; * 1��ɽ���ʳ��⥵�ݡ��Ȥ��롥
;; * ¾�μ���Ǥ�ƥ��Ȥ���.
;; * ʣ���Υ���ȥ�η�̤򤫤����Ĥ�롥
;; * fset��ű�Ѥ��롥
;; * defcustom

;;; Code:
(require 'timer)

;;
;; Customizable variables
;; 
(defgroup auto-lookup nil
  "Lookup��ư�ƤӽФ�"
  :group 'lookup)

(defcustom auto-lookup-interval 1 
  "*��ưŪ��lookup��ƤӽФ����ֳִ�(��)"
  :type  'number
  :group 'auto-lookup)

(defcustom auto-lookup-mode-string " AutoLookup"
  "Auto lookup�⡼�ɤΥ⡼��ʸ����"
  :type 'string
  :group 'auto-lookup)

(defcustom auto-lookup-backend 'lookup
  "Auto lookup�⡼�ɤǻȤ��������󥿡��ե������μ���. lookup��sdic"
  :type '(choice (const lookup)
                 (const sdic)
                 (const etags))
  :group 'auto-lookup)

;;
;; Backend own custumize
;;
(defvar auto-lookup-backend:sdic-eiwa-dictionary-list 
  nil
  "Auto lookup�ΥХå�����ɤȤ���sdic��Ȥ���硤�ɤα��¼����Ȥ������ꤹ�롥
�������ˡ�ϡ�`sdic-eiwa-dictionary-list'��Ʊ�������Ǥ��롥nil�ξ��
`sdic-eiwa-dictionary-list'���ͤ򤽤Τޤ޻Ȥ���
��:
(setq auto-lookup-backend:sdic-eiwa-dictionary-list
      '((sdicf-client \"/usr/local/dict/gene.sdic\")))")

(defvar auto-lookup-backend:sdic-waei-dictionary-list 
  nil
  "Auto lookup�ΥХå�����ɤȤ���sdic��Ȥ���硤�ɤ��±Ѽ����Ȥ������ꤹ�롥
�������ˡ�ϡ�`sdic-waei-dictionary-list'��Ʊ�������Ǥ��롥nil�ξ��
`sdic-waei-dictionary-list'���ͤ򤽤Τޤ޻Ȥ���
��:
(setq auto-lookup-backend:sdic-waei-dictionary-list
      '((sdicf-client \"/usr/local/dict/edict.sdic\" 
        (add-keys-to-headword t))))")

;;
;; Core
;;
(defvar auto-lookup-history nil 
"�Ǹ��autolookup��ͳ�Ǹ������줿ñ��
Ʊ��ñ��򷫤��֤��������뤳�Ȥ��򤱤롥")
(defvar auto-lookup-function (lambda () (auto-lookup)))

(defun auto-lookup ()
  "�����ޡ�����ƤӽФ����lookup��¹Ԥ���ؿ�"
  (let (word)
  (if (and 
       ;; �ʲ��ξ��򸫤����ʤ��¤긡����Ԥʤ�ʤ���
       ;; ��������Ǥʤ�����
       (not isearch-mode)
       ;; �ޥ���¹���Ǥʤ�����
       (not executing-kbd-macro)
       ;; autolookup�⡼�ɤ����äƤ��뤳��
       auto-lookup-mode
       ;; ���ߤΥХåե���mini buffer�Ǥʤ�����
       ;; Stolen from skk-in-minibuffer-p in skk-foreword of skk-10.59.
       (not (window-minibuffer-p (selected-window)))
       ;; ���ߤΥХåե���lookup�δ��Ĥ���Хåե��ʤ�����
       (auto-lookup-do-backend 'check-buffer (current-buffer))
       ;; �����鸡�����褦�Ȥ���ñ�줬���뤳��
       (progn 
         (setq word (auto-lookup-do-backend 'input))
         (and
          word
          (stringp word)
          (< 0 (length word))           ; ñ���Ĺ����Ĵ�٤롥
          (or (not auto-lookup-history)
              (not (string= word auto-lookup-history)))
          (progn (setq auto-lookup-history word) t))))
      ;; ����
      (let ((result
             (if (auto-lookup-describe-word word)
                 (auto-lookup-do-backend 'get-result))))
        ;; ���ɽ��
        (if result
            (auto-lookup-show-result (car result) (cdr result))
        )))))

(defun auto-lookup-describe-word (word)
  "lookup���뤤�ϡ�sdic���Ѥ���WORD�򸡺����롥"
  ;; message���������Ū���֤������Ƹ�����ν��Ϥ��������롥
  (let ((message-backup (symbol-function 'message)))
    (unwind-protect
        (progn
          (defun message (fmt &rest args))
          (auto-lookup-do-backend 'describe word))
      (fset 'message message-backup))))


(defun auto-lookup-do-backend (task &optional arg)
  "lookup���뤤��sdic�δؿ���ƤӽФ�
TASK
  describe: ����. �����������������nil�ʳ����ͤ��֤���
  get-result: ������̤μ���. (ñ�� . ��̣)�Υڥ����֤���
  input: �ݥ���Ȱ��֤���ñ��μ���, 
         ñ���ʸ������֤��������оݤ����Ĥ���ʤ����nil���֤��Ƥ��ɤ���
  check-buffer: �Хå�����ɤǴ������Ƥ���Хåե����Ф���nil���֤���"
  (cond 
   ((eq auto-lookup-backend 'lookup)
    (require 'lookup)
    (cond 
     ((eq task 'describe)
      (auto-lookup-backend:lookup-describe-word arg))
     ((eq task 'get-result)
      (auto-lookup-backend:lookup-get-result))
     ((eq task 'input)
      (auto-lookup-backend:lookup-word-input))
     ((eq task 'check-buffer)
      (auto-lookup-backend:lookup-check-buffer arg))))
   ((eq auto-lookup-backend 'sdic)
    (require 'sdic)
    (cond
     ((eq task 'describe)
      (auto-lookup-backend:sdic-describe-word arg))
     ((eq task 'get-result)
      (auto-lookup-backend:sdic-get-result))
     ((eq task 'input)
      (auto-lookup-backend:sdic-word-input))
     ((eq task 'check-buffer)
      (auto-lookup-backend:sdic-check-buffer arg))
     ))
   ((eq auto-lookup-backend 'etags)
    (require 'etags)
    (cond
     ((eq task 'describe)
      (auto-lookup-backend:etags-describe-word arg))
     ((eq task 'get-result)
      (auto-lookup-backend:etags-get-result))
     ((eq task 'input)
      (auto-lookup-backend:etags-word-input))
     ((eq task 'check-buffer)
      (auto-lookup-backend:etags-check-buffer arg))
     )) 
   (t
    nil)))

(defun auto-lookup-show-result (word line)
  "lookup�η�̤򥨥������ꥢ��ɽ�����롥"
  (message "[%s] %s: %s" auto-lookup-backend word line))

;;
;; Sdic backend
;;
(defvar auto-lookup-backend:sdic-buffer-name " *Autolookup-sdic")
(defvar auto-lookup-backend:sdic-eiwa-symbol-list nil)
(defvar auto-lookup-backend:sdic-waei-symbol-list nil)

(defun auto-lookup-backend:sdic-word-input ()
  "sdic�Ǹ�������ñ�����Ф���"
  ;; û����ñ��򸡺����褦�Ȥ���ȡ������˻��֤�������Τ�
  ;; û����ñ��ϸ������ʤ��褦�ˤ��롥
  (let ((word (sdic-word-at-point)))
    ;; word��nil�Ǥʤ�����
    (if word
        ;; ����ե��٥åȤΤߤ���ʤ�ñ�줫���ܸ�ʸ����ޤ�ñ�줫
        (if (not (string-match "\\cj" word))
            ;; ����ե��٥åȤΤ�
 	    ;; 3ʸ���ʾ�ξ��Τ�word��ʸ���ˤ����ֵѤ���
	    (if (< 2 (length word)) (downcase word) nil)
          ;; ���ܸ�ʸ����ޤ�ñ��
          ;; ������ޤफ�ޤޤʤ���
          (if (string-match "\\cC+" word)
              ;; ������ޤ��������ʬ����Ф����ֵ�
              (save-match-data (match-string 0 word))
	    ;; �������ʤ�ޤ��祫��������ʬ�����
	    (if (string-match "\\cK+" word)
		(setq word (match-string 0 word)))
	    ;; �Ҥ餬��/�������ʰ�ʸ���ϸ������ʤ�
	    (if (> (length word) 1) word nil)))
      nil)))

(defun auto-lookup-backend:sdic-describe-word (word)
  "sdic��WORD�����"
  (save-excursion
    (save-match-data
      (set-buffer (get-buffer-create auto-lookup-backend:sdic-buffer-name))
      ;; ����ο���ʤ롥
      (let (;;; ���·�
            (sdic-eiwa-dictionary-list 
             ;; auto-lookup�����꤬����лȤ���
             (or auto-lookup-backend:sdic-eiwa-dictionary-list
                 ;; �ʤ���С��֤�����������롥
                 sdic-eiwa-dictionary-list))
            ;; sdic�������ѿ����֤������롥
            (sdic-eiwa-symbol-list auto-lookup-backend:sdic-eiwa-symbol-list)
            ;;; �±ѷ�
            (sdic-waei-dictionary-list 
             (or auto-lookup-backend:sdic-waei-dictionary-list
                 sdic-waei-dictionary-list))
            (sdic-waei-symbol-list auto-lookup-backend:sdic-waei-symbol-list)
            ;;; 
            (case-fold-search t))
        ;; mode-name��Ĵ�٤Ʒ����֤�sdic-mode������Τ��ɤ���
        ;; ��������(sdic-mode)���ƤӽФ��줿�Ȥ�����
        ;; sdic-eiwa-dictionary-list��
        ;; sdic-eiwa-symbol-list���֤����������Ѥ���.
        (or (string= mode-name sdic-mode-name) (sdic-mode))
        (setq buffer-read-only nil)
        (erase-buffer)
        (prog1
            (if (string-match "\\cj" word)
                (funcall 'sdic-search-waei-dictionary word)
              (funcall 'sdic-search-eiwa-dictionary word))
          ;; �֤�����ä������ѿ��򥭥�å��夷�Ƽ����(auto-lookup�ˤ��)
          ;; �������˻Ȥ���
          (setq auto-lookup-backend:sdic-eiwa-symbol-list sdic-eiwa-symbol-list
                auto-lookup-backend:sdic-waei-symbol-list sdic-waei-symbol-list))))))

(defun auto-lookup-backend:sdic-get-result ()
  "sdic�θ�����̤���Ф���
��̤ϡ�(ñ�� . ��)�Ȥ����ڥ��Ǥ��롥"
  (with-current-buffer  (get-buffer-create auto-lookup-backend:sdic-buffer-name)
    (goto-char sdic-buffer-start-point)
    (let (b e b0 word (line "") (flag t))
      ;;
      (setq b (point))
      (end-of-line)
      (setq e (point))
      (setq word (buffer-substring b e))
      (beginning-of-line)
      ;;
      (while flag
        (forward-line 1)
        (setq b0 (point))
        (back-to-indentation)
        (setq b (point))
        (end-of-line)
        (setq e (point))
        (if (not (eq b b0))
            (setq line (concat line (buffer-substring b e)))
          (setq flag nil)))
      (cons word line))))

(defun auto-lookup-backend:sdic-check-buffer (buffer)
"BUFFER��sdic�ˤ�äƴ�������Ƥ���Хåե����ɤ���Ĵ�٤롥
NIL�ξ���������Ƥ��롥"
  (not (eq buffer
           (get-buffer auto-lookup-backend:sdic-buffer-name))))

;;
;; Lookup backend
;;
;; current-prefix-arg��nil�ʳ����ͤ���ĤȤ���
;; lookup-word-input��module̾��ҤͤƤ���Τ�
;; �鷺��路����current-prefix-arg����Ū��nil�Ȥ��롥
(defun auto-lookup-backend:lookup-word-input ()
  "lookup�Ǹ�������ñ�����Ф���"
  (let* ((current-prefix-arg nil)
         (input (lookup-word-input)))
    (if (and input (car input) (stringp (car input)))
        (car input)
      nil)))

(defun auto-lookup-backend:lookup-describe-word (word)
  "lookup��ñ��������"
  ;; lookup-word�������ǸƤӽФ����ߤ����ʤ��ؿ����֤�����������
  ;; �Хå����åץ��åפ�������롥
  (let ((current-prefix-arg nil)
        (lookup-display-buffer-backup 
         (symbol-function 'lookup-display-buffer))
        (lookup-pop-to-buffer-backup
         (symbol-function 'lookup-pop-to-buffer))
        (result nil))
    (unwind-protect
        (condition-case nil
            (progn
              ;;
              ;; �ؿ����֤������롥
              ;;
              (defun lookup-display-buffer (buffer))
              (defun lookup-pop-to-buffer (buffer))
              ;;
              ;; lookup�θƤӽФ���
              ;;
              (call-interactively 'lookup-word)
              ;; ����
              (setq result t))
          (error nil))
      ;;
      ;; �֤��������ؿ����������롥
      ;;
      (fset 'lookup-display-buffer lookup-display-buffer-backup)
      (fset 'lookup-pop-to-buffer lookup-pop-to-buffer-backup))
    result))

;; ���δؿ����ѹ������Ǥ�դμ�����б��Ǥ���Ϥ���
(defun auto-lookup-backend:lookup-get-result ()
  "lookup�Τθ�����̤���Ф���
��̤ϡ�(ñ�� . ��)�Ȥ����ڥ��Ǥ��롥"
  (let (b e word (line ""))
    (with-current-buffer  (lookup-content-buffer)
      (goto-char (point-min))
      ;; ñ�����Ф���
      (setq b (point-min))
      (end-of-line)
      (setq e (point))
      (setq word (buffer-substring b e))
      (beginning-of-line)

      ;; ������Ф���
      (while (not (eobp))
        (forward-line 1)
        (back-to-indentation)
        (setq b (point))
        (end-of-line)
        (setq e (point))
        (setq line (concat line (buffer-substring b e)))))
    (cons word line)))

(defun auto-lookup-backend:lookup-check-buffer (buffer)
  "BUFFER��lookup�ˤ�äƴ�������Ƥ���Хåե����ɤ���Ĵ�٤롥
NIL�ξ���������Ƥ��롥"
  (not (memq buffer lookup-buffer-list)))

;;
;; Etags backend
;;
;;
;;; eltags.el --- electric tag search
;;
;; Copyright (C) 1999  Masatake YAMATO, Takaaki MORIYAMA
;;
;; Author: Masatake YAMATO<masata-y@is.aist-nara.ac.jp>
;;         Takaaki MORIYAMA<taka@airlab.cs.ritsumei.ac.jp>
;; Keywords: etags
;; Version: v0
;; Revision: 0

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

(defvar auto-lookup-backend:etags-data-cache nil)
(defvar auto-lookup-backend:etags-type-cache nil)
(defun auto-lookup-backend:etags-describe-word (symbol)
  (let (result b e)
    (setq result (condition-case ()
                     (find-tag-internal symbol)
                   (error nil)))
    (setq tags-loop-scan '(display-tag-info nil)
          tags-loop-operate nil)
    (if result
        (save-excursion
          (set-buffer (car result))
          (goto-char (cdr result))
          (beginning-of-line)
          ;;
          (setq auto-lookup-backend:etags-type-cache
                (cond
                 ((equal ?# (char-after))
                  ;;
                  ;; Macro
                  ;;
                  (setq b (point)
                        e (progn (next-line 1) (end-of-line) (point)))
                  "M")
                 ((save-match-data
                    (let ((colon -1)
                          (paren -1))
                      (save-excursion 
                        (if (re-search-forward ";\\|{" nil t)
                            (setq colon (point))))
                      (save-excursion 
                        (if (re-search-forward "(" nil t)
                            (setq paren (point))))
                      (if (or (eq -1 colon) (eq -1 paren))
                          nil
                        (if (< paren colon)
                            t
                          nil))))
                  ;;
                  ;; Function
                  ;;
                  (setq b (save-excursion (previous-line 1) (beginning-of-line) (point))
                        e (if (re-search-forward ")" nil t)
                              (point)
                            (next-line 1) (end-of-line) (point)))
                  "F")
                 (t
                  ;;
                  ;; typedef, struct, enum, variable...
                  ;;
                  (setq b (point)
                        e (progn (end-of-line) (point)))
                  "E"
                  )))
          (setq auto-lookup-backend:etags-data-cache
                (replace-in-string 
                 (replace-in-string (buffer-substring b e) "\n\\|\t" " ")
                 "  +" " "))
          t)
      nil)))

(defun auto-lookup-backend:etags-get-result ()
  (cons auto-lookup-backend:etags-type-cache
        auto-lookup-backend:etags-data-cache))

(defun auto-lookup-backend:etags-word-input ()
  (find-tag-default))

(defun auto-lookup-backend:etags-check-buffer (buffer)
  (not (string= "TAGS" (buffer-name buffer))))

;;
;; Minor mode
;;
(defvar auto-lookup-mode nil)
(make-variable-buffer-local 'auto-lookup-mode)

(defun auto-lookup-mode (&optional arg)
  "���ߤΥХåե���Auto lookup��¹Ԥ���. "
  (interactive "P")
  (setq auto-lookup-history nil)
  (setq auto-lookup-mode (if arg
                             (> (prefix-numeric-value arg) 0)
                           (not auto-lookup-mode)))
  (if auto-lookup-mode
      (auto-lookup-try-timer-start)
    (auto-lookup-try-timer-end)))

(if (fboundp 'add-minor-mode)
    (add-minor-mode 'auto-lookup-mode auto-lookup-mode-string)
  ;; Put this minor mode on the global minor-mode-alist.
  (or (assq 'auto-lookup-mode (default-value 'minor-mode-alist))
      (setq-default minor-mode-alist
                    (append (default-value 'minor-mode-alist)
                            '((auto-lookup-mode auto-lookup-mode-string))))))

;;
;; Global mode
;;
(defvar global-auto-lookup-mode nil)
(defun global-auto-lookup-mode (&optional arg)
  "���٤ƤΥХåե���Auto lookup��¹Ԥ���. "
  (interactive "P")
  (setq auto-lookup-history nil)
  (let ((on-p (if arg
                  (> (prefix-numeric-value arg) 0)
                (not global-auto-lookup-mode))))
    (setq global-auto-lookup-mode on-p)
    ;; From flyspell.el
    ;; ��������Хåե���auto-lookup-mode��ư, ��ߤ��롥
    (cond
     (on-p
      (add-hook 'find-file-hooks 'turn-on-auto-lookup-if-enabled)
      (add-hook 'first-change-hook 'turn-on-auto-lookup-if-enabled))
     (t
      (remove-hook 'find-file-hooks 'turn-on-auto-lookup-if-enabled)
      (remove-hook 'first-change-hook 'turn-on-auto-lookup-if-enabled)))
    ;; ����¸�ߤ��롤���٤ƤΥХåե���auto-lookup-mode��ư, ��ߤ��롥
    (mapcar
     (function 
      (lambda (buffer)
        (if (auto-lookup-do-backend 'check-buffer buffer)
            (with-current-buffer buffer
              (auto-lookup-mode (if on-p 1 -1))))))
     (buffer-list))))

(defun turn-on-auto-lookup-if-enabled ()
  (and global-auto-lookup-mode
       (not auto-lookup-mode)
       (auto-lookup-do-backend 'check-buffer (current-buffer))
       (auto-lookup-mode 1)))

;;
;; Timer
;;
(defvar auto-lookup-timer nil "Auto lookup�Υ����ޤ��ݻ������ѿ�")
(defun auto-lookup-try-timer-start ()
  "Auto lookup�Υ����ޤ򥹥����Ȥ��롥
ʣ����Auto lookup�Υ����ޤ����ꤷ�ʤ��褦��`auto-lookup-timer'���ͤ򻲾Ȥ��롥"
  (when (not auto-lookup-timer)
    (setq auto-lookup-timer (run-with-idle-timer 
                             auto-lookup-interval
                             t 
                             auto-lookup-function))))

(defun auto-lookup-try-timer-end ()
  "Auto lookup�Υ����ޤ���ߤ��롥
�����������٤ƤΥХåե���Auto lookup����ȴ�����Ȥ��Τ���ߤ��롤"
  (if auto-lookup-timer
      (let ((autolookuped-buffer nil))
        ;; Auto lookup mode�����äƤ���Хåե���
        ;; 1�Ĥ�ʤ���Ĵ�٤롥
        (mapcar
         (function 
          (lambda (buffer)
            (with-current-buffer buffer
              (if auto-lookup-mode
                  (setq autolookuped-buffer t)))))
         (buffer-list))
        ;; Auto lookup mode�����äƤ���Хåե���1�Ĥ�ʤ�
        ;; ��Х����ޤ���ߤ��롥
        (when (and autolookuped-buffer)
          (cancel-timer auto-lookup-timer)
          (setq auto-lookup-timer nil)))))

(provide 'autolookup)
;;; autolookup.el ends here
