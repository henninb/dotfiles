import Head from 'next/head'
import { useState, useEffect } from 'react'
export default function Baseball() {
  const [data, setData] = useState(null);



         // Object.entries(response.data.dates).forEach((entry) => {¬
   // 28            const [, value] = entry;¬
   // 29            // console.log(`${key}: ${JSON.stringify(value)}`);¬
   // 30            // console.log(value.date);¬
   // 31            // console.log(value.games);¬
   // 32            games.push(value.games);¬
   // 33          });¬
   // 34 ¬
   // 35          const games_flattened = games.flat();¬
   // 36          console.log(games_flattened);¬
   // 37          Object.entries(games_flattened).forEach((entry) => {¬
   // 38            const [, value] = entry;¬
   // 39            console.log(value.status);¬
   // 40          });¬
   // 41           setData(games_flattened);¬





   function generateTable(games) {
     let table = '<table border="1">';
     table += `<tr>
               <th>ID</th>
               <th>date</th>
               <th>HomeTeam</th>
               <th>AwayTeam</th>
               <th>Status</th>
               </tr>`;

     if( games ) {
      games.map((game, index) => {
           table = table + `<tr>`;
           table = table + `<td>${index}</td>`;
           table = table + `<td>${game.gameDate}</td>`;
           table = table + `<td>${game.teams.away.team.name}</td>`;
           table = table + `<td>${game.teams.home.team.name}</td>`;
           table = table + `<td>${game.status.abstractGameState}</td>`;
           table += `</tr>`;
        });
      }
      table += "</table>";
      document.getElementById("games-div").innerHTML = table;
    }

  const loadSchedule = async () => {
    console.log('handle click');

    const apiResponse = await fetch('/api/mlb', {
          method: 'GET',
          redirect: 'follow',
          headers: {
            "Content-Type": "application/json",
          },
    });
    console.log('apiCall was made.');
    const json = await apiResponse.json();
    let games = [];
    //let games: any[] = [];
    Object.entries(json.dates).forEach((entry) => {
         const [, value] = entry;
         games.push(value["games"])
         });
    console.log(games.flat());
    setData(games.flat());
    generateTable(games.flat())

  }

  useEffect(() => {
      if( !data) {
        loadSchedule();
      }
  }, [])

  return (
    <div>
      <Head>
        <title>Baseball</title>
        <meta name="description" content="" />
      </Head>

      <main>
        <h1>Baseball Schedule</h1>

        <div id="games-div" />
      </main>

    </div>
  )
}
