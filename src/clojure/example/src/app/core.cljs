(ns app.core
  "comment"
  (:require [reagent.core :as r]
             [app.hello :refer [hello]]))

(defn about-page []
  (fn [] [:span.main
          [:h1 "About funky-cat"]]))

(defn home-page []
  (fn []
    [:span.main
     [:h1 "Funky Cat"]
     [:a {:href "https://www.google.com"} "Google"]
     ]))

(defn hello []
  [:div
   {:style {:text-align "center"}}
   [:h1 "test"]
   [:p "Clojurescript"]

   [:h2 "Counter"]
   [counter]])

(defn page-for [route]
  (case route
    :index #'home-page
    :about #'about-page
  ))

(defn app []
  [:span.main
    [:h1 "Hello World"]
    [:p "Hello World"]
    [:a {:href "https://www.google.com"} "Google"]
  ]
)

(defn ^:dev/after-load render
  "Render the toplevel component for this app."
  []
  (r/render [app] (.getElementById js/document "app")))

(defn ^:export main
  "Run application startup logic."
  []
  (render))
