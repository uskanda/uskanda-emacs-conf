(tool-bar-mode nil)
(server-start)
(if window-system
  (progn
    (cond
      ((eq system-type 'gnu/linux)
       (set-default-font "Bitstream Vera Sans Mono-10")
       (set-fontset-font (frame-parameter nil 'font) 'japanese-jisx0208
                        '("VL ゴシック" . "unicode-bmp"))))))

