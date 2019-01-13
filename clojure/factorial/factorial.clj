(defn factorial [n]
  "Compute the N'th factorial number."
  (if (or (= n 0) (= n 1))
      1
    (* (factorial(- n 1)) n)
  )
)

{ :3 (factorial 3)
 :4 (factorial 4)
 :5 (factorial 5)
 :6 (factorial 6)
 :10 (factorial 10) }

