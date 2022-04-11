import { useState, useEffect, useCallback } from 'react';
import axios from 'axios';
import { DataGrid } from '@mui/x-data-grid';

export default function HockeyScores() {
  const [login, setLogin] = useState(null)


  const columns = [
  { field: 'id', headerName: 'ID', width: 90 },
  {
    field: 'DateUtc',
    headerName: 'date',
    // width: 150,
    editable: true,
  },
  {
    field: 'Location',
    headerName: 'location',
    // width: 150,
    editable: true,
  },
  {
    field: 'HomeTeam',
    headerName: 'home',
    // type: 'number',
    // width: 110,
    editable: true,
  },
  {
    field: 'AwayTeam',
    headerName: 'away',
    // type: 'number',
    // width: 110,
    editable: true,
  },
  // {
  //   field: 'fullName',
  //   headerName: 'Full name',
  //   description: 'This column has a value getter and is not sortable.',
  //   sortable: false,
  //   width: 160,
  //   valueGetter: (params) =>
  //     `${params.row.firstName || ''} ${params.row.lastName || ''}`,
  // },
];

  const rows = [
      { id: 1, MatchNumber: 1307, RoundNumber: 28, DateUtc: "2022-04-30 00:00:00Z", Location: "Xcel Energy Center", HomeTeam: "Minnesota Wild", AwayTeam: "Colorado Avalanche",
    Group: null, HomeTeamScore: null, AwayTeamScore: null
  }
  // { id: 1, lastName: 'Snow', firstName: 'Jon', age: 35 },
  // { id: 2, lastName: 'Lannister', firstName: 'Cersei', age: 42 },
  // { id: 3, lastName: 'Lannister', firstName: 'Jaime', age: 45 },
  // { id: 4, lastName: 'Stark', firstName: 'Arya', age: 16 },
  // { id: 5, lastName: 'Targaryen', firstName: 'Daenerys', age: null },
  // { id: 6, lastName: 'Melisandre', firstName: null, age: 150 },
  // { id: 7, lastName: 'Clifford', firstName: 'Ferrara', age: 44 },
  // { id: 8, lastName: 'Frances', firstName: 'Rossini', age: 36 },
  // { id: 9, lastName: 'Roxie', firstName: 'Harvey', age: 65 },
];


  async function showSchedule(e) {

    console.log('showSchedule was called #1.');
    if( login ) {
      // console.log("size: " login.length);
      console.log("size: " + Object.keys(login).length);
      console.log(login);

      Object.entries(login).forEach(([_key, value]) => {
        console.log(`${JSON.stringify(value)}`);
      });

      // login.map( (_data) => {
      //   // console.log(_data.id);
      //   return "empty"
      // })
    } else {

    // login.map( (_data) => {
    //   if( _data.HomeTeamScore === null ) {
    //     if( _data.HomeTeam === 'Minnesota Wild' ) {
    //        console.log(data.DateUtc + " - vs " + _data.AwayTeam)
    //     }
    //     if( data.AwayTeam === 'Minnesota Wild' ) {
    //       console.log(_data.DateUtc + " - at " + _data.HomeTeam)
    //     }
    //   }
    //   return "empty"
    // })
      console.log("failed list");
    }
  }

  const fetchMyAPI = useCallback(async () => {
       try {
        const response = await axios.get("/feed/json/nhl-2021/minnesota-wild")
        console.log('apiCall was made.');
         console.log(response.data);
         setLogin(response.data);
       } catch(error) {
         if(error) {
           console.log(error.data);
         } else {
           console.log("error calling apiCall()");
         }
       }
      }, []);

  useEffect(() => {
    fetchMyAPI();
  }, [fetchMyAPI])
       // <MaterialTable
      // title="Wild Hockey"
      // columns={[
       //    {
       //      title: "MatchNumber",
       //      field: "MatchNumber",
       //      type: "date",
       //    },
       //    {
       //      title: "HomeTeam",
       //      field: "HomeTeam",
       //      type: "string",
       //    },
      // ]}
      // data={login ? login : []}
      // />

    return (
      <div>
       <h1>Wild Hockey Scores</h1>
      <button onClick={showSchedule}>Show Schedule</button>
      <div>begin</div>
      <div>end</div>

      <div style={{ height: 400, width: '100%' }}>
      <DataGrid
        rows={rows}
        columns={columns}
        pageSize={5}
        rowsPerPageOptions={[5]}
        checkboxSelection
        disableSelectionOnClick
      />
      </div>
      </div>

    )
}
