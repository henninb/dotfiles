import { useState, useEffect, useCallback } from 'react';
import axios from 'axios';
import { Outlet } from "react-router-dom";

export default function ProtectedRoutes() {
  const [auth, setAuth] = useState(null);

  async function getCookies() {
      console.log('getCookies');
      let cookies = document.cookie.split(';');
      let authTokens = {
          'access-token': null
      };

      for (const cookie of cookies) {
          let cookiePair = cookie.split('=');

          if (authTokens.hasOwnProperty(cookiePair[0].trim().toLowerCase())) {
              authTokens[cookiePair[0].trim()] = decodeURIComponent(cookiePair[1]);
          }
      }

      return authTokens;
  }

  const authApiCall = async (payload) => {
    console.log('authApiCall');

    try {
    const response = await axios.get("/api/auth", {
      timeout: 0,
      headers: {
        "Content-Type": "application/text",
        "Authorization": "Bearer " + payload
      },
    });

    return response.data;
    } catch ( error ) {
      console.log(error.data);
      window.location.href = '/login'
    }
    return false
  };

  const fetchUserAuth = useCallback(async () => {

    console.log('fetchUserAuth');
    const token = await getCookies();
    if( token && token["access-token"] ) {
      const authBoolean = await authApiCall(token["access-token"]);
      if( authBoolean === true ) {
        setAuth(true)
        return true
      }
    }
    setAuth(false)
    window.location.href = '/login'
    return false
  }, []);

  useEffect(() => {
    if( !auth ) {
      fetchUserAuth();
    }
  }, [fetchUserAuth, auth])

  //pass the auth token to the Outlet
    //auth ? <Outlet /> : <Navigate to="/login" />
  return (
    auth ? <Outlet /> : null
  )
}
