import Head from 'next/head'
import { useState, useEffect } from 'react'

export default function Hockey() {
  const [data, setData] = useState(null)

  function generateTable(games) {
   let table = '<table>';
   table += `<tr><th>ID</th><th>HomeTeam</th><th>AwayTeam</th></tr>`;

   if( games ) {
     games.map((game, index) => {
         table = table + `<tr>`;
         table = table + `<td>${index}</td>`;
         table = table + `<td>${game.HomeTeam}</td>`;
         table = table + `<td>${game.AwayTeam}</td>`;
         table += `</tr>`;
      });
    }
    table += "</table>";
    document.getElementById("games-div").innerHTML = table;
  }

  const loadSchedule = async () => {
    console.log('loadSchedule called');

    // const url = new URL('/api/nhl')

    // const params = {
    // };

    // url.search = new URLSearchParams(params).toString();
    const apiResponse = await fetch('/api/nhl', {
          method: 'GET',
          redirect: 'follow',
          headers: {
            "Content-Type": "application/json",
          },
    });
    console.log('apiCall was made.');
    const json = await apiResponse.json();
    console.log(json);
    setData(json);
    generateTable(json);

    // json.forEach(function(item, index){
    //   console.log(index);
    // });
  }


  useEffect(() => {
    if( !data) {
      loadSchedule();
    }
    // if (data) {
    //   generateTable();
    // }
  }, [])

  return (
    <div>
      <Head>
        <title>Hockey</title>
        <meta name="description" content="" />
      </Head>

      <main>
        <h1>Hockey Schedule</h1>


   <div id="games-div" />


      </main>

    </div>
  )
}
