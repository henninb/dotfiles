import Head from 'next/head'
import { DataGrid } from '@mui/x-data-grid';
import { v4 as uuidv4 } from 'uuid';
// import Hockey from '../api/nhl'


// export default async function HockeyScores(request, response) {
export const getStaticProps = async() => {
    const url = new URL('https://fixturedownload.com/feed/json/nhl-2021/minnesota-wild')

    const params = {
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
    console.log('apiCall was made.');
    return {
      props: {games: json}
    }
}

//export default async function Hockey({games}) {
export default async function Hockey() {

  // const [data, setData] = useState(null)


  const columns = [
  // { field: 'id', headerName: 'id' },
  {
    field: 'DateUtc',
    headerName: 'date',
    width: 175,
    editable: true,
  },
  {
    field: 'Location',
    headerName: 'location',
    width: 150,
    editable: true,
  },
  {
    field: 'HomeTeam',
    headerName: 'home',
    // type: 'number',
    width: 150,
    editable: true,
  },
  {
    field: 'HomeTeamScore',
    headerName: 'score',
    // type: 'number',
    width: 75,
    editable: true,
  },
  {
    field: 'AwayTeam',
    headerName: 'away',
    // type: 'number',
    width: 150,
    editable: true,
  },
  {
    field: 'AwayTeamScore',
    headerName: 'score',
    width: 75,
    editable: true,
  },
];

  const data = [
      //{ id: 1, MatchNumber: 1307, RoundNumber: 28, DateUtc: "2022-04-30 00:00:00Z", Location: "Xcel Energy Center", HomeTeam: "Minnesota Wild", AwayTeam: "Colorado Avalanche", Group: null, HomeTeamScore: null, AwayTeamScore: null },
      { MatchNumber: 1307, RoundNumber: 28, DateUtc: "2022-04-30 00:00:00Z", Location: "Xcel Energy Center", HomeTeam: "Minnesota Wild", AwayTeam: "Colorado Avalanche", Group: null, HomeTeamScore: null, AwayTeamScore: null },
];

  return (
    <div>
      <Head>
        <title>Wild Hockey Schedule</title>
        <meta name="description" content="" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main>
        <h1>Wild Hockey Schedule</h1>
              <div style={{ height: 800, width: '100%' }}>
      <DataGrid
        getRowId={() => uuidv4()}
        rows={data ? data :[]}
        columns={columns}
        pageSize={100}
        rowsPerPageOptions={[100]}
        checkboxSelection
        disableSelectionOnClick
      />
      </div>
      </main>

    </div>
  )
}
