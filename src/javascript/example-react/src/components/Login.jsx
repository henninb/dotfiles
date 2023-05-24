import axios from "axios";
export default function Login() {
    // const [state, setState] = useState({
    // email: "",
    // password: "",
  // });

  // const handleChange = (e) => {
  //   const { id, value } = e.target;
  //   setState((previousState) => ({
  //     ...previousState,
  //     [id]: value,
  //   }));
  // };
  const userLoginGet = async () => {
    let endpoint =  '/api/v1/login';

    console.log('pre axios get call');
    const response = await axios.get(endpoint, {
      timeout: 0,
      headers: {
        "Content-Type": "application/json",
      },
    });
    console.log('post axios call');
    return response.data;
  };

  const userLogin = async (payload) => {
    let endpoint =  '/api/login';

    console.log('pre axios post call');
    const response = await axios.post(endpoint, payload, {
      timeout: 0,
      headers: {
        "Content-Type": "application/json",
      },
    });
    console.log('post axios get call');


    // const expiryDate = new Date(new Date().getTime() + 6 * 60 * 60 * 1000).toUTCString();
    // document.cookie = `access-token=${response.data}; path=/; expires=${expiryDate}; secure; samesite=lax`;
    return response.data;
  };

  const handleClick = async (event) => {
    console.log("login submit was clicked");
    event.preventDefault();

    let email = document.getElementById("email").value;
    console.log(email);
    let password = document.getElementById("password").value;
    console.log(password);
    let data = {
      email: email,
      password: password,
    };
    console.log(data);
    // console.log(state);
    // console.log("send: " + JSON.stringify(data));

    try {
      let response_get = await userLoginGet();
      console.log("response: " + JSON.stringify(response_get));
      let response = await userLogin(data);
      console.log("response: " + JSON.stringify(response));
      window.location.href = '/'
    } catch (error) {
      console.log(error.data);
      window.location.href = '/login'
    }
  };

    return (
        <div className="login">
            <div className="form">
                <form name="login-form" className="login-form" action="/api/login" method="POST" data-bitwarden-watching="1">
                    <span className="material-icons">lock</span>
                    <div className="input-group mb-3">
                <div className="input-group-prepend">
                 <span className="input-group-text">
                  <i className="fa fa-user form-icon"></i>
                 </span>
                </div>
                <input type="text" className="form-control" placeholder="Email" id="email" name="email" />
             </div>
             <div className="input-group mb-3">
               <div className="input-group-prepend">
                 <span className="input-group-text">
                   <i className="fa fa-lock form-icon"></i>
                 </span>
               </div>
               <input type="password" className="form-control" placeholder="Password" id="password" name="password" />
             </div>
      <button type="submit" onClick={handleClick}>
            login
          </button>
                </form>
            </div>
        </div>
    );
};
