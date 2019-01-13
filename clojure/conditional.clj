(def n 2)

(cond
     (> n 65) "I'll enjoy walking at a park."
     (> n 45) "temp is great than 45"
     (> n 35) "temp is great than 35"
     (= n 2) "temp equals 2"
     :else "invalid number"
)


(def x 2)
(cond 
  (= x 0) "some test0"
  (= x 1) "some text1"
  (= x 2) "some test2"
  :else "3"
)

(def x1 2)
(cond 
  (= x1 0) 1
  (= x1 1) 1
  (= x1 2) 2
  :else 3
)
