;;load-path configuration
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
           (add-to-list 'load-path path))
        (mapcar 'expand-file-name paths)))
(add-to-load-path "~/.emacs.d/provided" "~/.emacs.d/conf" "~/.emacs.d/misc" "~/.emacs.d/env")

(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/provided")

;;設定ファイルを読み込む
;;外したい設定は該当する行をコメントアウトすればよい
(setq conf-files
      '(
        env            ;;実行環境ごとに適切な設定を読み込む
        fundamental    ;;基本的な設定
        yasnippet      ;;スニペットによる補完を行う
        abbrev         ;;基本的な補完設定
        autosave       ;;バッファに変更があれば即座にセーブする
;        ecb            ;;Emacsを統合開発環境っぽくする
        line-highlight ;;現在行/列をハイライトする
        outputz        ;;Outputzに文字数を送る
        macro          ;;動的マクロを含むマクロ設定
        yatex          ;;YaTeXを使う
        shell          ;;Emacs上でのシェル利用の設定
        prog-c         ;;Cなどのプログラムに関する設定
        ruby           ;;rubyに関する設定
        versioncontrol ;;バージョン管理(svn,git)との連携を行う
        buffer         ;;バッファに関する設定
        minibuffer     ;;ミニバッファ(画面下の情報表示)に関する設定
        region         ;;範囲選択に関する設定
        anything       ;;anythingを使用
        auto-complete  ;;auto-completeを使用
        keybind        ;;キーの割り当てを変更する
        key-chord      ;;キーの同時押しにコマンドを割り振る
        ))


;load each settings
(defun load-each-settings (lisp-names)
  (mapc (lambda (x)(load (concat "c-" (symbol-name x)))) lisp-names))
(load-each-settings conf-files)
