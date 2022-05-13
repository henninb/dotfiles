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
        //console.log("weather: " + JSON.stringify(json.observations));
        console.log("weather: " + JSON.stringify(json.observations[0]));
        //console.log("weather: " + JSON.stringify(json.observations.flat()));
        setData(json.observations[0]);

    }, []);

    function displayWeather(weather) {
        return (
            <div>
                Weather observation time: {weather.obsTimeLocal} <br />
                Weather temperature: {weather.imperial.temp} <br />
                Weather windchill: {weather.imperial.windChill} <br />
                Weather pressure: {weather.imperial.pressure} <br />

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


                <div className="container">
                    <div className="row mb-3">
                        <div className="col-md-6 mt-4">
                            <div className="card">
                                <h3 className="card-header text-center">
                                    Fahrenheit to Celsius
                                </h3>
                                <div className="card-body">
                                    <div className="row justify-content-center mt-3 mb-4">
                                        <a className="btn btn-lg btn-generate-uuid" href="/version1">Convert fahrenheit to celsius</a>
                                    </div>
                                    <hr />
                                        <div className="version-bulk-form indented">
                                            <form action="/api/weather" accept-charset="UTF-8" data-remote="true"
                                                  method="post">
                                                <div className="form-inline">
                                                    <div className="input-group col">
                                                        <input type="number" name="amount" id="amount1" min="-500"
                                                               max="500" placeholder="Temperature in fahrenheit"
                                                               className="form-control text-right" />
                                                            <div className="input-group-append">
                                                                <button className="btn btn-secondary" type="button"
                                                                        id="amount1-btn">Calculate
                                                                </button>
                                                            </div>
                                                    </div>

                                                </div>
                                            </form>
                                            <div id="version1-bulk-result">
                                            </div>
                                        </div>
                                </div>
                            </div>
                        </div>
                        <div className="col-md-6 mt-4">
                            <div className="card">
                                <h3 className="card-header text-center">
                                    Celsius to Fahrenheit
                                </h3>
                                <div className="card-body">
                                        <div className="version-bulk-form indented">
                                            <form name="temperature-to-fahrenheit" action="/api/weather" data-remote="true" method="post">
                                                <div className="form-inline">
                                                    <div className="input-group col">
                                                        <input type="number" name="celsius" id="celsius" min="1"
                                                               max="500" placeholder="degrees celsius"
                                                               className="form-control text-right"
                                                               onChange={handleCelsiusChange}
                                                        />
                                                            <div className="input-group-append">
                                                                <button className="btn btn-secondary" type="button" onClick={toFahrenheit}
                                                                        id="amount4-btn">Calculate
                                                                </button>
                                                            </div>
                                                    </div>
                                                </div>
                                            </form>
                                            <div id="version4-bulk-result">
                                            </div>
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>







                <div>
                    <form name="temperature-input">
                        <label>fahrenheit</label>
                        <input type="text" name="fahrenheit" id="fahrenheit" onChange={handleFahrenheitChange} />
                        <button onClick={toCelsius}>toCelsius</button>
                    </form>

                    <form name="temperature-input">
                        <label>celsius</label>
                        <input type="text" name="celsius" id="celsius" onChange={handleCelsiusChange} />
                        <button onClick={toFahrenheit}>toFahrenheit</button>
                    </form>
                </div>

                <h1>
                    Weather in Minneapolis
                </h1>
                { data ? displayWeather(data) : null}

            </main>

        </div>
    )
}
