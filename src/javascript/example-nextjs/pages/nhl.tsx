import Head from 'next/head'
import { DataGrid } from '@mui/x-data-grid';
import { v4 as uuidv4 } from 'uuid';

export default function Hockey() {

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
