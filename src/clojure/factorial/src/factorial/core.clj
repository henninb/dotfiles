(ns factorial.core
  (:require [org.httpkit.server :as server]
            [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer :all]
            [clojure.pprint :as pp]
            [clojure.string :as str]
            [clojure.data.json :as json])
  (:gen-class))

(defn factorial [n]
  "Compute the N'th factorial number."
  (if (or (= n 0) (= n 1))
      1
    (* (factorial(- n 1)) n)
  )
)

; (json/write-str { :3 (factorial 3) :4 (factorial 4) :5 (factorial 5) :6 (factorial 6) :10 (factorial 10) })
; { :3 (factorial 3) :4 (factorial 4) :5 (factorial 5) :6 (factorial 6) :10 (factorial 10) }

(defn simple-body-page [req]
  "simple body page"
  {:status  200
   ;:headers {"Content-Type" "text/html"}
   :headers {"Content-Type" "application/json"}
   ;:body    (str (factorial 4))})
   :body    (json/write-str { :3 (factorial 3) :4 (factorial 4) :5 (factorial 5) :6 (factorial 6) :10 (factorial 10) })})

(defn request-example [req]
  "request example"
     {:status  200
      :headers {"Content-Type" "text/html"}
      :body    (->>
                (pp/pprint req)
                (str "Request Object: " req))})

(defroutes app-routes
  (GET "/" [] simple-body-page)
  (GET "/request" [] request-example)
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

