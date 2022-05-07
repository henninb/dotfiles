import Head from 'next/head'
import {useEffect, useState} from 'react'

export default function Hockey() {
    const [data, setData] = useState(null)

    function generateTable(games) {
        const rows = games.map((game, index) => {
            return (
             <tr>
                 <td>{index}</td>
                 <td>{game.HomeTeam}</td>
                 <td>{game.AwayTeam}</td>
             </tr>
            )
        })

        return (
            <div>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>HomeTeam</th>
                        <th>AwayTeam</th>
                    </tr>
                    {rows}
                </table>
            </div>
        )
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
    }


    useEffect(() => {
        if (!data) {
            loadSchedule();
        }
    }, [])

    return (
        <div>
            <Head>
                <title>Hockey</title>
                <meta name="description" content=""/>
            </Head>

            <main>
                <h1>Hockey Schedule</h1>
                { data ? generateTable(data) : null}
            </main>

        </div>
    )
}
