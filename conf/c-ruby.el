(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
;;----------------------------------------------------------------------------;;
;;ruby-block
;;対応するendを表示する
;;----------------------------------------------------------------------------;;
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle 'overlay);; オーバレイする
;;----------------------------------------------------------------------------;;


(require 'ruby-bracket)


;; Rinari
(add-to-list 'load-path "~/.emacs.d/vc/rinari")
(require 'rinari)

;;; rhtml-mode
(add-to-list 'load-path "~/.emacs.d/vc/rhtml")
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
    (lambda () (rinari-launch)))

;;haml-mode
(require 'haml-mode nil 't)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
;;sass-mode
(require 'sass-mode nil 't)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))


;; (defvar rsense-program "rsense")
;; (defvar rsense-process nil)
;; (defvar rsense-command-result nil)
;; (defvar rsense-command-timeout 10)

;; (defun rsense-process ()
;;   (if (and rsense-process
;;            (eq (process-exit-status rsense-process) 0))
;;       rsense-process
;;     (let ((process (start-process "rsense" "*RSense*" rsense-program)))
;;       (setq rsense-process process)
;;       (set-process-filter process 'rsense-process-filter)
;;       process)))

;; (defun rsense-delete-process ()
;;   (delete-process (rsense-process))
;;   (setq rsense-process nil))

;; (defun rsense-process-filter (process string)
;;   (with-current-buffer (process-buffer process)
;;     (goto-char (point-max))
;;     (insert string)

;;     ;; try to parse result
;;     (when (and (goto-char (point-min))
;;                (search-forward "\n" nil t))
;;       (goto-char (point-min))
;;       (let* ((continue nil)
;;              (line (buffer-substring (point) (line-end-position)))
;;              (args (split-string line " "))
;;              (command (pop args)))
;;         (cond
;;          ((equal command "candidates")
;;           (let ((prefix (nth 1 args))
;;                 (num (string-to-number (nth 0 args)))
;;                 candidates)
;;             (if (/= (save-excursion (forward-line num)) 0)
;;                 (setq continue t)
;;               (while (and (>= (setq num (1- num)) 0)
;;                           (eq (forward-line 1) 0))
;;                 (push (buffer-substring (line-beginning-position) (line-end-position)) candidates))
;;               (rsense-command-result-update `((candidates . ,candidates)
;;                                               (prefix . ,prefix))))))
;;          (t
;;           (rsense-command-result-update '(error))
;;           (message "RSense error")))
;;         (unless continue (erase-buffer))))))

;; (defun rsense-process-buffer ()
;;   (process-buffer (rsense-process)))

;; (defun rsense-command (name args &optional body)
;;   (let ((process (rsense-process)))
;;     (setq rsense-command-result nil)
;;     (with-current-buffer (process-buffer process)
;;       (erase-buffer))
;;     (process-send-string process
;;                          (format "%s %s\n"
;;                                  name
;;                                  (mapconcat (lambda (a) (format "%s" a)) args " ")))
;;     (if body
;;         (process-send-string process body))
;;     (process-send-eof process)))

;; (defun rsense-command-result (&optional timeout error-on-timeout)
;;   (let ((process (rsense-process))
;;         (elapsed 0.0)
;;         (sleep 0.1))
;;     (while (and (null rsense-command-result)
;;                 (or (null timeout)
;;                     (< elapsed timeout)))
;;       (setq elapsed (+ elapsed sleep))
;;       (accept-process-output process sleep)))
;;   (if (and (null rsense-command-result) error-on-timeout)
;;       (error "RSense command timeout"))
;;   rsense-command-result)

;; (defun rsense-error-p (result)
;;   (eq (car result) 'error))

;; (defun rsense-command-result-update (result)
;;   (setq rsense-command-result result))

;; (defun rsense-suggest-synchronously ()
;;   (rsense-command "suggest" (list "<buffer>" (1- (point)) (buffer-size)) (buffer-string))
;;   (rsense-command-result rsense-command-timeout t))

;; (defvar ac-rsense-candidates-cache nil)

;; (defun ac-rsense-setup ()
;;   (push '("\\." ac-source-rsense) ac-omni-completion-sources))

;; (defvar ac-source-rsense
;;   `((init
;;      . (lambda ()
;;          (setq ac-rsense-candidates-cache
;;                (let ((result (rsense-suggest-synchronously)))
;;                  (unless (rsense-error-p result)
;;                    (assoc-default 'candidates result))))))
;;     (candidates . (lambda () (all-completions ac-prefix ac-rsense-candidates-cache)))))

;; (defun ac-rsense-initialize ()
;;   (add-hook 'ruby-mode-hook 'ac-rsense-setup)
;;   t)

;;  (add-hook 'ruby-mode-hook
;;            (lambda ()
;;              (setq ac-omni-completion-sources '(("\\." ac-source-rsense)))
;;              ))
