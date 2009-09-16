;;----------------------------------------------------------------------;;
;; key-chord Settings
;; ������Ʊ�������ˤ��Ǥ�դΥ��ޥ�ɤμ¹Ԥ���ǽ��
;;----------------------------------------------------------------------;;
(require 'key-chord)
(setq key-chord-two-keys-delay 0.03)
(key-chord-mode 1)

;; l,d��prefixŪ��
;;l+����
(key-chord-define-global "lf" 'find-file)
(key-chord-define-global "lb" 'anything-select-buffer-command)
(key-chord-define-global "lx" 'anything-execute-emacs-commands-command)
(key-chord-define-global "lt" 'anything-gtags-select)
(key-chord-define-global "ls" 'anything-search-reference-command)
;;d+����
(key-chord-define-global "do" 'anything-c-moccur-occur-by-moccur)
(key-chord-define-global "dp" 'anything-c-moccur-dmoccur)
(key-chord-define-global "dy" 'anything-c-yas-complete)
(key-chord-define-global "ds" 'anything-dabbrev-expand)

;; �ۡ���ݥ���������
(key-chord-define-global "jk" 'view-mode)
(key-chord-define-global "lk" 'anything)
(key-chord-define-global ",." 'query-replace)
;(key-chord-define-global "cv" ')
;(key-chord-define-global "we" ')
;(key-chord-define-global "io" ')

;; ���������Ϣ�ۤˤ�����ꤷ��chord
(key-chord-define-global "cx" 'Control-X-prefix) ;'C'-'x'
;;(key-chord-define-global "er" 'eval-region)      ;'E'val 'R'egion
(key-chord-define-global "cd" 'comment-dwim)     ;'C'omment 'D'wim
(key-chord-define-global "gl" 'goto-line)        ;'G'o to 'L'ine
(key-chord-define-global "ui" 'shell-toggle-cd)  ;go to C'UI' shell
(key-chord-define-global "gj" 'anything-gtags-select) ;gtags jump

;; a,;�Ȥ�key-chord�ǰ��� Meta���ޥ��
(key-chord-define-global "ah" 'mark-paragraph)


(key-chord-define-global "tr" 'indent-region)


;;----------------------------------------------------------------------;;

;;----------------------------------------------------------------------;;
;; IME�ڤ��ؤ�����key-chord�������ʤ��ʤ�����ؤ��н�
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
;; ���ޤ� key-chord �� ����� �� ����
;;----------------------------------------------------------------------;;
(defun key-chord-recover-from-stack (arg) "" (interactive "P")
  (progn
    (key-chord-mode arg) (key-chord-mode arg))
)
;;----------------------------------------------------------------------;;
