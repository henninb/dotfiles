import { useState, useEffect, useCallback } from 'react';
import axios from 'axios';
// import cheerio from 'cheerio';

export default function Temperature() {

  async function toFahrenheit(event) {
     event.preventDefault()
     let celsius = document.getElementById("celsius").value;
     console.log(celsius);
     let data = {
        celsius: celsius,
     };
       try {
        const response = await axios.post("/api/fahrenheit", data,
        {
          headers: { 'Content-Type': 'application/json', }
        }
        )
        console.log('apiCall was made.');
         console.log(response.data);
       } catch(error) {
         if(error) {
           console.log(error.data);
         } else {
           console.log("error calling apiCall()");
         }
       }
  }

  async function toCelsius(event) {
     event.preventDefault()

     let fahrenheit = document.getElementById("fahrenheit").value;
     console.log(fahrenheit);
     let data = {
        fahrenheit: fahrenheit,
     };
     // const formData = new FormData(event.target);
     // console.log("f=" + formData.get('fahrenheit'));
     // Now you can use formData.get('foo'), for example.

       try {
        const response = await axios.post("/api/celsius", data,
        {
          headers: { 'Content-Type': 'application/json', }
        }
        )
        console.log('apiCall was made.');
         console.log(response.data);
       } catch(error) {
         if(error) {
           console.log(error.data);
         } else {
           console.log("error calling apiCall()");
         }
       }
  }


      const fetchWeather = useCallback(async () => {

      const params = {
        apiKey: "e1f10a1e78da46f5b10a1e78da96f525",
        units: "e",
        stationId:"KMNCOONR65",
        format:"json"
      };
         try {
          const response = await axios.get("/v2/pws/observations/current", {params})
          //const response = await axios.get("/v2/pws/observations/current")
          console.log('/v2/pws/observations/current call was made.');

           // Object.entries(response.data.dates).forEach((entry) => {
           //   const [, value] = entry;
           //   // console.log(`${key}: ${JSON.stringify(value)}`);
           //   // console.log(value.date);
           //   // console.log(value.games);
           //   games.push(value.games);
           // });

           // const games_flattened = games.flat();
           // console.log(games_flattened);
           // Object.entries(games_flattened).forEach((entry) => {
           //   const [, value] = entry;
           //   console.log(value.status);
           // });
           //  setData(games_flattened);
           console.log(response.data);
         } catch(error) {
           if(error) {
             console.log(error.data);
           } else {
             console.log("error calling apiCall()");
           }
         }
        }, []);

    useEffect(() => {
      fetchWeather();
    }, [fetchWeather])

    return (
        <div>
           <form name="temperature-input">
           <label>fahrenheit</label>
           <input type="text" name="fahrenheit" id="fahrenheit" />
           <button onClick={toCelsius}>toCelsius</button>
           </form>

           <form name="temperature-input">
           <label>celsius</label>
           <input type="text" name="celsius" id="celsius" />
           <button onClick={toFahrenheit}>toFahrenheit</button>
           </form>
        </div>
    )
};
