export default async function HockeyScores(request, response) {
    // const token = request.headers.get('authorization')?.split(" ")[1] || '';
    // console.log(token);

    const url = new URL('https://statsapi.mlb.com/api/v1/schedule')

    const params = {
        startDate: "1/01/2022",
        endDate: "12/31/2022",
        gameTypes: "R",
        sportId: 1,
        teamId: 142,
        hydrate: "decisions"
    };

    url.search = new URLSearchParams(params).toString();
    const apiResponse = await fetch(url.toString(), {
        method: 'GET',
        redirect: 'follow',
        headers: {
            "Content-Type": "application/json",
        },
    });
    console.log('apiCall was made.');
    const json = await apiResponse.json();
    console.log(json);
    response.status(200).json(json)
}
