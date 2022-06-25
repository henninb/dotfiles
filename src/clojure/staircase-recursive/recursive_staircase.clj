(defn recursive-staircase [x]
  "recursive-staircase"
   (loop [n x f 1]
     (if (= n 1)
       f
       (recur (dec n) (* f n)))))
(recursive-staircase 3)
; n (2) -> 2
; n (4) -> 7
; n (3) -> 4
