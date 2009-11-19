(defconst c++-keywords
  (sort
   (list "and" "bool" "compl" "do" "export" "goto" "namespace" "or_eq" "return"
         "struct" "try" "using" "xor" "and_eq" "break" "const" "double" "extern"
         "if" "new" "private" "short" "switch" "typedef" "virtual" "xor_eq" "asm"
         "case" "const_cast" "dynamic_cast" "false" "inline" "not" "protected"
         "signed" "template" "typeid" "void" "auto" "catch" "continue" "else"
         "float" "int" "not_eq" "public" "sizeof" "this" "typename" "volatile"
         "bitand" "char" "default" "enum" "for" "long" "operator" "register"
         "static" "throw" "union" "wchar_t" "bitor" "class" "delete" "explicit"
         "friend" "mutable" "or" "reinterpret_cast" "static_cast" "true"
         "unsigned" "while" ) #'(lambda (a b) (> (length a) (length b)))))

(defvar ac-source-c++
  '((candidates
     . (lambda ()
         (all-completions ac-target c++-keywords))))
  "Source for c++ keywords.")

(add-hook 'c++-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (setq ac-sources '(ac-source-yasnippet
                               ac-source-c++
                               ac-source-imenu
                               ))))

(provide 'auto-complete-cpp)
