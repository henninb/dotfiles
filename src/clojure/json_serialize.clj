;https://clojure.org/api/cheatsheet
(ns json.ns
  (:require [cheshire.core :refer :all]))
(generate-string {:foo "bar" :baz 5})

(def directory (clojure.java.io/file "json_in"))
(def files (file-seq directory))
(prn files)
(type files)

(def x (parse-string (slurp "json_in/amazon_store_brian.json")))
;(def x (parse-string (slurp "json_in/chase_kari.json")))
(type x)

(defn print-files [files]
  "print files"
  (doseq [idx files] (println (str idx))))

;(doseq [keyval (last x)] (prn keyval))
;(doseq [keyval (last x)] (prn (key keyval) (val keyval)))
;(map (fn [[k v]] (prn k) (prn v)) (last x))
;(def eager (doseq [x [1 2 3]] (println 'eager x)))

(defn parse-number
  "Reads a number from a string. Returns nil if not a number."
  [s]
  (if (re-find #"^-?\d+\.?\d*$" s)
    (read-string s)))

(defn print-record [x1]
  "print record for incomming data"
   (doseq [keyval x1] (do (prn keyval) (type keyval)))
   )
;(map (do (print-record x)))
(map print-record x)

(defn get-amount [x1] 
  "some comment"
  (get x1 "amount"))

(map get-amount x)

(defn get-amount-double [x1] 
  "some comment"
  (parse-number (get x1 "amount")))

(reduce + (map get-amount-double x))
(print-files files)
