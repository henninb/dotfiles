#!/bin/sh

echo http://www.espn.com/nfl/schedulegrid
echo https://www.pro-football-reference.com/years/2019/games.htm

wget https://www.pro-football-reference.com/years/2019/games.htm -O nfl_games.html
wget https://projects.fivethirtyeight.com/2019-nfl-predictions/

exit 0
