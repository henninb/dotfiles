;https://clojure.org/api/cheatsheet
(ns json.ns
  (:require [cheshire.core :refer :all]))

(defn list-sources [path]
  (map #(str path "/" (second (re-matches #"^(\w+)\.json$" (.getName %))) ".json" )
       (filter #(.isFile %) (file-seq path))))

(defn load-files [dir]
  (doseq [f (file-seq (java.io.File. dir))
          :when (.isFile f)]
    (load-file (.getAbsolutePath f))))

(def files (list-sources (java.io.File. "json_in")))

(defn slurp-json-files [files]
  "slurp-json-files"
  (doseq [idx files] (slurp (str idx))))

(defn parse-number
  "Reads a number from a string. Returns nil if not a number."
  [s]
  (if (re-find #"^-?\d+\.?\d*$" s)
    (read-string s)))

(defn print-record [x1]
  "print record for incomming data"
   (doseq [keyval x1] (do (prn keyval) (type keyval))))

(defn get-amount-double [x1] 
  "some comment"
  (parse-number (get x1 "amount")))

(slurp-json-files files)
