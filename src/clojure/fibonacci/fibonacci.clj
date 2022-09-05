(defn fibonacci [n]
  "Compute the N'th fibonacci number."
  (cond
    (= n 0) 0
    (= n 1) 1
    :else (+ (fibonacci (dec n)) (fibonacci (- n 2))))
)

{ :3 (fibonacci 3)
 :4 (fibonacci 4)
 :5 (fibonacci 5)
 :6 (fibonacci 6)
 :10 (fibonacci 10) }
