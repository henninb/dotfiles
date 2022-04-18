import { useState, useEffect, useCallback } from 'react';
import axios from 'axios';
import { DataGrid } from '@mui/x-data-grid';
import { v4 as uuidv4 } from 'uuid';

export default function HockeyScores() {
  const [data, setData] = useState(null)


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

  //const rows = [
  //    //{ id: 1, MatchNumber: 1307, RoundNumber: 28, DateUtc: "2022-04-30 00:00:00Z", Location: "Xcel Energy Center", HomeTeam: "Minnesota Wild", AwayTeam: "Colorado Avalanche", Group: null, HomeTeamScore: null, AwayTeamScore: null },
  //    { MatchNumber: 1307, RoundNumber: 28, DateUtc: "2022-04-30 00:00:00Z", Location: "Xcel Energy Center", HomeTeam: "Minnesota Wild", AwayTeam: "Colorado Avalanche", Group: null, HomeTeamScore: null, AwayTeamScore: null },
//];

  async function showSchedule(_event) {
    console.log('showSchedule was called #1.');
  }

  const fetchHockeySchedule = useCallback(async () => {
       try {
        const response = await axios.get("/feed/json/nhl-2021/minnesota-wild")
        console.log('apiCall was made.');
         console.log(response.data);
         setData(response.data);
       } catch(error) {
         if(error) {
           console.log(error.data);
         } else {
           console.log("error calling apiCall()");
         }
       }
      }, []);

  useEffect(() => {
    fetchHockeySchedule();
  }, [fetchHockeySchedule])

    return (
      <div>
       <h1>Wild Hockey Scores</h1>
      <button onClick={showSchedule}>Show Schedule</button>

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
      </div>
    )
}
