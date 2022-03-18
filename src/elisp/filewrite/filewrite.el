(defun my-append-string-to-file (s filename)
  (with-temp-buffer
    (insert s)
    (write-region (point-min) (point-max) filename t)))

(my-append-string-to-file output.txt)
