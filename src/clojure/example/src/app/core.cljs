(ns app.core
  "comment"
  (:require
    [reagent.core :as r]
             ; [app.hello :refer [hello]]
             ))

(defn about-page []
  (fn [] [:span.main
          [:h1 "About"]]))

(defn app []
  [:div
   {:style {:text-align "center"}}
   [:h1 "test"]
   [:p "Clojurescript"]

   [:h2 "Counter"]
   [:a {:href "https://www.google.com"} "Google"]
   ]
  )

(defn page-for [route]
  (case route
    :index #'app
    :about #'about-page
  ))

(defn ^:dev/after-load render
  "Render the toplevel component for this app."
  []
  (r/render [app] (.getElementById js/document "app")))

(defn ^:export main
  "Run application startup logic."
  []
  (render))
