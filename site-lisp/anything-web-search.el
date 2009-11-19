;;; anything-web-search.el

;; Copyright (C) 2009  kitokitoki

;; Version: 1.0.1
;; Author: kitokitoki  <morihenotegami@gmail.com>
;; Keywords: anything

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;; Anything-web-search is a branch project of serch-web.el
;; search-web.el is written by Tomoya Otake
;; http://github.com/tomoya/search-web.el/tree/master

;; Change Log
;; 1.0.1: action 一覧を変数化, その他微修正。
;; 1.0.0: 新規作成

;;; Code:

(require 'anything)

(defvar search-engines
  '(("sitepoint" . "http://reference.sitepoint.com/search?q=%s")
  ("google" . "http://www.google.com/search?q=%s")
  ("google ja" . "http://www.google.com/search?hl=ja&q=%s")
  ("google en" . "http://www.google.com/search?hl=en&q=%s")
  ("google maps" . "http://maps.google.co.jp/maps?hl=ja&q=%s")
  ("youtube" . "http://www.youtube.com/results?search_type=&search_query=%s&aq=f")
  ("twitter" . "http://search.twitter.com/search?q=%s")
  ("goo" . "http://dictionary.goo.ne.jp/srch/all/%s/m0u/")
  ("answers" . "http://www.answers.com/topic/%s")
  ("emacswiki" . "http://www.google.com/cse?cx=004774160799092323420%%3A6-ff2s0o6yi&q=%s&sa=Search")
  ("amazon" . "http://www.amazon.com/s/url=search-alias%%3Daps&field-keywords=%s")
  ("amazon jp" . "http://www.amazon.co.jp/gp/search?index=blended&field-keywords=%s")
  ("yahoo" . "http://search.yahoo.com/search?p=%s")
  ("yahoo jp" . "http://search.yahoo.co.jp/search?p=%s")
  ("wikipedia en" . "http://www.wikipedia.org/search-redirect.php?search=%s&language=en")
  ("wikipedia ja" . "http://www.wikipedia.org/search-redirect.php?search=%s&language=ja")
  ("alc" . "http://eow.alc.co.jp/%s/UTF-8/?ref=sa"))
  "A list is search engines list. keys engines nick, and value is search engine query.
Search word %s. In formatting url-hexify. Use %% to put a single % into output.")

(defun aws-web-search (engine word)
  (browse-url (format (cdr (assoc engine search-engines))
                      (url-hexify-string word))))

(defun anything-web-search ()
  "anything-to-web-engine-function"
  (interactive)
  (let ((region-string
         (if (and transient-mark-mode mark-active)
             (buffer-substring-no-properties
              (region-beginning) (region-end)))))
    (setq aws-candidate-list nil)
    (and region-string (add-to-list 'aws-candidate-list region-string))
    (add-to-list 'aws-candidate-list (thing-at-point 'symbol))
    (add-to-list 'aws-candidate-list (thing-at-point 'word))
    (anything (list anything-c-source-web-search anything-c-source-aws-candidate-not-found) nil nil
              nil nil "*web search*")))

(defvar anything-c-source-aws-candidate-not-found
  '((name . "Create Search Word")
    (dummy)
    (action .   (("Google" . (lambda (candidate) (aws-web-search "google" candidate)))
                 ("google ja" . (lambda (candidate) (aws-web-search "google ja" candidate)))
                 ("google en" . (lambda (candidate) (aws-web-search "google en" candidate)))
                 ("google maps" . (lambda (candidate) (aws-web-search "google maps" candidate)))
                 ("youtube" . (lambda (candidate) (aws-web-search "youtube" candidate)))
                 ("twitter" . (lambda (candidate) (aws-web-search "twitter" candidate)))
                 ("goo" . (lambda (candidate) (aws-web-search "goo" candidate)))
                 ("answers" .(lambda (candidate) (aws-web-search "answers" candidate)))
                 ("emacswiki" . (lambda (candidate) (aws-web-search "emacswiki" candidate)))
                 ("amazon" . (lambda (candidate) (aws-web-search "amazon" candidate)))
                 ("amazon jp" . (lambda (candidate) (aws-web-search "amazon jp" candidate)))
                 ("yahoo" . (lambda (candidate) (aws-web-search "yahoo" candidate)))
                 ("yahoo jp" . (lambda (candidate) (aws-web-search "yahoo jp" candidate)))
                 ("wikipedia en" . (lambda (candidate) (aws-web-search "wikipedia en" candidate)))
                 ("wikipedia ja" . (lambda (candidate) (aws-web-search "wikipedia ja" candidate)))
                 ("sitepoint" . (lambda (candidate) (aws-web-search "sitepoint" candidate)))))
    (type . command)))

(defvar anything-c-source-web-search
  '((name             . "Chose Search Word")
    (candidates       . aws-candidate-list)
    (action .   (("Google" . (lambda (candidate) (aws-web-search "google" candidate)))
                 ("google ja" . (lambda (candidate) (aws-web-search "google ja" candidate)))
                 ("google en" . (lambda (candidate) (aws-web-search "google en" candidate)))
                 ("google maps" . (lambda (candidate) (aws-web-search "google maps" candidate)))
                 ("youtube" . (lambda (candidate) (aws-web-search "youtube" candidate)))
                 ("twitter" . (lambda (candidate) (aws-web-search "twitter" candidate)))
                 ("goo" . (lambda (candidate) (aws-web-search "goo" candidate)))
                 ("answers" .(lambda (candidate) (aws-web-search "answers" candidate)))
                 ("emacswiki" . (lambda (candidate) (aws-web-search "emacswiki" candidate)))
                 ("amazon" . (lambda (candidate) (aws-web-search "amazon" candidate)))
                 ("amazon jp" . (lambda (candidate) (aws-web-search "amazon jp" candidate)))
                 ("yahoo" . (lambda (candidate) (aws-web-search "yahoo" candidate)))
                 ("yahoo jp" . (lambda (candidate) (aws-web-search "yahoo jp" candidate)))
                 ("wikipedia en" . (lambda (candidate) (aws-web-search "wikipedia en" candidate)))
                 ("wikipedia ja" . (lambda (candidate) (aws-web-search "wikipedia ja" candidate)))
                 ("sitepoint" . (lambda (candidate) (aws-web-search "sitepoint" candidate)))
                 ("alc" . (lambda (candidate) (aws-web-search "alc" candidate)))))
    (type             . command)
    (volatile)))

(provide 'anything-web-search)
;;; anything-web-search.el ends here
