;emacs -Q --script example.el
(print "hello world")
     (newline)

(defun insert-p-tag ()
  "Insert <p></p> at cursor point."
  (interactive)
  (insert "<p></p>")
  (backward-char 4))

(insert-p-tag)

(defun main ()
  (print (format "Called with %s" command-line-args))
  (print (format "I did it. you passed in %s" command-line-args-left)))

(when (member "-scriptload" command-line-args)
  (main))

; print( (+ 2 3));
