// import { useState, useEffect, useCallback } from "react";
// import axios from "axios";
export default function Home() {
   // const [auth, setAuth] = useState(false);

  // const fetchIsAuthorized = useCallback(async (token) => {
   //     try {
   //      const response = await axios.post("/api/auth", token,
   //      {
   //        headers: { 'Content-Type': 'application/text', }
   //      }
   //      )
   //      console.log('apiCall was made.');
   //       console.log(response.data);
   //       setAuth(response.data);
   //     } catch(error) {
   //       if(error) {
   //         console.log(error.data);
   //       } else {
   //         console.log("error calling apiCall()");
   //       }
   //     }
   //    }, []);

  // useEffect(() => {
   //  const token = "1"
   //  fetchIsAuthorized(token);
  // }, [fetchIsAuthorized])

    return (
      <div>
      <h1>Home</h1>
      </div>
    );
};
