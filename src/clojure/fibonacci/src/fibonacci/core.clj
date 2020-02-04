(ns fibonacci.core
  (:require [org.httpkit.server :as server]
            [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer :all]
            [clojure.pprint :as pp]
            [clojure.string :as str]
            [clojure.data.json :as json])
  (:gen-class))

(defn fibonacci [n]
  "Compute the N'th fibonacci number."
  (cond
    (= n 0) 0
    (= n 1) 1
    :else (+ (fibonacci (dec n)) (fibonacci (- n 2))))
)

; (json/write-str { :3 (fibonacci 3) :4 (fibonacci 4) :5 (fibonacci 5) :6 (fibonacci 6) :10 (fibonacci 10) })
; { :3 (fibonacci 3) :4 (fibonacci 4) :5 (fibonacci 5) :6 (fibonacci 6) :10 (fibonacci 10) }

(defn simple-body-page [req]
  "simple body page"
  {:status  200
   ;:headers {"Content-Type" "text/html"}
   :headers {"Content-Type" "application/json"}
   ;:body    (str (fibonacci 4))})
   :body    (json/write-str { :3 (fibonacci 3) :4 (fibonacci 4) :5 (fibonacci 5) :6 (fibonacci 6) :10 (fibonacci 10) })})

(defn request-example [req]
  "request example"
     {:status  200
      :headers {"Content-Type" "text/html"}
      :body    (->>
                (pp/pprint req)
                (str "Request Object: " req))})

(defroutes app-routes
  (GET "/" [] simple-body-page)
  (GET "/get-example" [] request-example)
;  (POST "/post-example" [] "post-example")
  (POST "/post-example" {params :params} "post-example")
  (route/not-found "Error, page not found!"))

(defn -main
  "This is our main entry point"
  [& args]
  (let [port (Integer/parseInt (or (System/getenv "PORT") "3000"))]
    ; Run the server with Ring.defaults middleware
    (server/run-server (wrap-defaults #'app-routes site-defaults) {:port port})
    ; Run the server without ring defaults
    ;(server/run-server #'app-routes {:port port})
    (println (str "Running webserver at http:/127.0.0.1:" port "/"))))

