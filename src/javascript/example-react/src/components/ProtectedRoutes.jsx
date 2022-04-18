import axios from 'axios';
import { Navigate, Outlet } from "react-router-dom";

// delete a cookie
// document.cookie = 'access-token=; Max-Age=0'

function getCookies() {
    console.log('getCookies');
    let cookies = document.cookie.split(';');
    let authTokens = {
        'access-token': null
    };

    for (const cookie of cookies) {
        let cookiePair = cookie.split('=');

        if (authTokens.hasOwnProperty(cookiePair[0].trim().toLowerCase()))
            authTokens[cookiePair[0].trim()] = decodeURIComponent(cookiePair[1]);
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
  } catch (error ) {
    console.log(error.data);
    window.location.href = '/login'
  }
  return false
  //return response.data.toLowerCase() === 'true'
};

const useAuth = async () => {
  console.log('useAuth');
  const token = getCookies();
  if( token && token["access-token"] ) {
    const authBoolean = await authApiCall(token["access-token"]);
    if( authBoolean === true ) {
      //console.log("true: " + token["access-token"]);
      return true
    }
  }
  return false
};

export default async function ProtectedRoutes() {
  const isAuth = await useAuth();
  //console.log('is auth: ' + isAuth);
  console.log('isAuth: ' + JSON.stringify(isAuth));
  //pass the auth token to the Outlet
  return isAuth ? <Outlet /> : <Navigate to="/login" />;
}
