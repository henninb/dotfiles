heroku create
git push heroku main

heroku logs --tail

heroku run printenv

npm outdated

## fix memory issues
heroku config:set NODE_OPTIONS="--max_old_space_size=2560" -a stark-thicket-53850
