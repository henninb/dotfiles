import Head from 'next/head'
import {useCallback, useEffect, useState} from 'react'

export default function Temperature() {
    const [data, setData] = useState(null);
    const [fahrenheitState, setFahrenheitState] = useState({
        fahrenheit: 0,
        celsius: 0
    });

    const [celsiusState, setCelsiusState] = useState({
        fahrenheit: 0,
        celsius: 0
    });

    function handleFahrenheitChange(event: any) {
        if (event.target.files) {
            setFahrenheitState({...fahrenheitState, [event.target.name]: event.target.files[0]});
        } else {
            setFahrenheitState({...fahrenheitState, [event.target.name]: event.target.value});
        }
    }

    function handleCelsiusChange(event: any) {
        if (event.target.files) {
            setCelsiusState({...celsiusState, [event.target.name]: event.target.files[0]});
        } else {
            setCelsiusState({...celsiusState, [event.target.name]: event.target.value});
        }
    }

    async function toFahrenheit(event: any) {
        event.preventDefault()
        console.log(`fahrenheit=${JSON.stringify(celsiusState)}`);

        const apiResponse = await fetch('/api/fahrenheit', {
            method: 'POST',
            body: JSON.stringify(celsiusState),
            headers: {
                "Content-Type": "application/json",
            },
        });

        const result = await apiResponse.text();
        console.log(result);
    }

    async function toCelsius(event: any) {
        event.preventDefault()
        //let formData = new FormData();

        console.log(`fahrenheit=${JSON.stringify(fahrenheitState)}`);

        const apiResponse = await fetch('/api/celsius', {
            method: 'POST',
            body: JSON.stringify(fahrenheitState),
            headers: {
                "Content-Type": "application/json",
            },
        });

        const result = await apiResponse.text();
        console.log(result);
    }

    const fetchWeather = useCallback(async () => {
        const apiResponse = await fetch('/api/weather', {
            method: 'GET',
            headers: {
                "Content-Type": "application/json",
            },
        });
        const json = await apiResponse.json();
        //console.log("weather: " + JSON.stringify(json));
        console.log("weather: " + JSON.stringify(json.observations));
        console.log("weather: " + JSON.stringify(json.observations.flat()));
        setData(json);

    }, []);

    function displayWeather(weather) {
        return (
            <div>
                Weather observation time: {weather.obsesrvations}
            </div>
        )
    }


    useEffect(() => {
        fetchWeather()
    }, [])

    return (
        <div>
            <Head>
                <title>Temperature</title>
                <meta name="description" content=""/>
            </Head>

            <main>
                <h1>Temperature</h1>

                <div>
                    <form name="temperature-input">
                        <label>fahrenheit</label>
                        <input type="text" name="fahrenheit" id="fahrenheit" onChange={handleFahrenheitChange}/>
                        <button onClick={toCelsius}>toCelsius</button>
                    </form>

                    <form name="temperature-input">
                        <label>celsius</label>
                        <input type="text" name="celsius" id="celsius" onChange={handleCelsiusChange}/>
                        <button onClick={toFahrenheit}>toFahrenheit</button>
                    </form>
                </div>

                <h1>
                    Weather
                </h1>
                { data ? displayWeather(data) : null}

            </main>

        </div>
    )
}
