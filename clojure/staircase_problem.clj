(defn stairs [n]
 (cond
  (= n 0) 1
  (= n 1) 1
  (= n 2) 2
  :else (+ (+ (stairs (- n 3)) (stairs (- n 2))) (stairs (- n 1)))
 )
)

(stairs 2)
(stairs 3)
(stairs 4)
(stairs 5)
(stairs 6)

; n (2) -> 2
; n (3) -> 4
; n (4) -> 7
