(use '[clojure.string :only (split)])
(require '[clojure.string :as str])

(defn parse-number
  "Reads a number from a string. Returns nil if not a number."
  [s]
  (if (re-find #"^-?\d+\.?\d*$" s)
    (read-string s)))

(def north-keys [:mile-marker :name])

(def conversions {:mile-marker parse-number
                  :name identity})

(defn convert
  [north-key value]
  ((get conversions north-key) value))

(defn mapify
  "Return a seq of maps like {:name \"Edward Cullen\" :glitter-index 10}"
  [rows]
  (map (fn [unmapped-row]
         (reduce (fn [row-map [north-key value]]
                   (assoc row-map north-key (convert north-key value)))
                 {}
                 (map vector north-keys unmapped-row)))
       rows))

(pr "foo")
(split "Some    words   with\tother whitespace      \n" #"\s+")

(type {:a 1 :b 2 :c 3 :d 4 :e 5 :f 6 :g 7 :h 8 :i 9})

(defn parse
  "Convert a pipe delim into rows of columns"
  [string]
  (map #(split % #"\|")
       (split string #"\n")))
(def lis (parse (slurp "input")))
(println lis)

(first (mapify lis))
(last (mapify lis))
(nth (mapify lis) 2)
(nth (mapify lis) 3)
