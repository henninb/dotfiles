// import ReactSignupLoginComponent from 'react-signup-login-component';
import axios from 'axios';
import './style.css';

 function componentDidMount() {
    // axios.get(`https://jsonplaceholder.typicode.com/users`)
    axios.get("/test")
      .then(res => {
        const persons = res.data;
        alert(persons);
        // this.setState({ persons });
      })
  }

const LoginPage = (props) => {

    const signupWasClickedCallback = (data) => {
      console.log(data);
      // axios({
  // method: 'post',
  // url: '/login',
  // data: {
    // firstName: 'Finn',
    // lastName: 'Williams'
  // }
// });
      //alert('Signup callback, see log on the console to see the data.');
    };

    const loginWasClickedCallback = (data) => {
      console.log(data);
      componentDidMount();
      alert('Login callback, see log on the console to see the data.');
    };

    const recoverPasswordWasClickedCallback = (data) => {
      console.log(data);
      alert('Recover password callback, see log on the console to see the data.');
    };

    return (
             <div className="container">
        <div className="form-box">
          <div className="header-form">
            <h4 className="text-primary text-center"><i className="fa fa-user-circle" style={{fontSize:"110px"}}></i></h4>
            <div className="image">
            </div>
          </div>
          <div className="body-form">
           <form action="/test" method="GET">
              <div className="input-group mb-3">
                <div className="input-group-prepend">
                 <span className="input-group-text"><i className="fa fa-user"></i></span>
                </div>
                <input type="text" className="form-control" placeholder="Email" id="email" name="email" />
             </div>
             <div className="input-group mb-3">
               <div className="input-group-prepend">
                 <span className="input-group-text"><i className="fa fa-lock"></i></span>
               </div>
               <input type="password" className="form-control" placeholder="Password" id="password" name="password" />
             </div>
 <button type="submit" className="btn btn-secondary btn-block">LOGIN</button>
 <div className="message">
<div><input type="checkbox" /> Remember ME</div>
 <div><a href="#">Forgot your password</a></div>
 </div>
   </form>
          </div>
        </div>
       </div>
    );
};

export default LoginPage;
