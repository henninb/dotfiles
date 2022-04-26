import Head from 'next/head'
import { useState, useEffect } from 'react'

export default function Hockey() {
  const [data, setData] = useState(null)

  const handleClick = async () => {
    console.log('handle click');


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

    json.forEach(function(item, index){
      console.log(index);
  // div.innerHTML = div.innerHTML + ("Name:" + item.name + " URL:" + item.url + "<br>");
    });
  }

  useEffect(() => {
    handleClick();
  }, [])

  return (
    <div>
      <Head>
        <title>Hockey</title>
        <meta name="description" content="" />
      </Head>

      <main>
        <h1>Hockey Schedule</h1>
         <button onClick={handleClick}>click</button>

    <ul>
      { data ?
      data.map((item) => (
        <li key={item.id}>{item.Location}</li>
      )) : <p>nothing</p>
      }
    </ul>


      </main>

      <footer>
       footer
      </footer>
    </div>
  )
}
