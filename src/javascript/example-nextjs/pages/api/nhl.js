export default async function HockeyScores(request, response) {
    // const token = request.headers.get('authorization')?.split(" ")[1] || '';
    // console.log(token);

    const url = new URL('https://fixturedownload.com/feed/json/nhl-2021/minnesota-wild')

    const params = {};

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
