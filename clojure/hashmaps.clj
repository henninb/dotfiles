{:a 1
 :b 2
 :c 3}

{:a (+ 1 1)
 :b (+ 2 1)
 :c (+ 3 1)}

(hash-map :a 1 :b 2)

(eval '{10 :ten (+ 1 1) :two (* 7 2) :fourteen})

;hashmap in a vector
(def north [
            {:place "Grand Marais", :mile-marker 110}
            {:place "Silver Bay", :mile-marker 55}
            {:place "Duluth", :mile-marker 0}
            ])

(north 0)
