import react from 'react';
import axios from 'axios';
import './style.css';

const LoginPage = (props) => {
    // const signupWasClickedCallback = (data) => {
    //   console.log(data);
    //   alert('Signup callback, see log on the console to see the data.');
    // };
    // const loginWasClickedCallback = (data) => {
    //   console.log(data);
    //   alert('Login callback, see log on the console to see the data.');
    // };
    // const recoverPasswordWasClickedCallback = (data) => {
    //   console.log(data);
    //   alert('Recover password callback, see log on the console to see the data.');
    // };
                    // <input type="text" name="email" id="email" placeholder="email" required="" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" />
                    // <input type="password" name="password" id="password" placeholder="password" required="" />

    return (
        <div className="login">
            <div className="form">
                <form name="login-form" className="login-form" action="/login" method="GET" data-bitwarden-watching="1">
                    <span class="material-icons">lock</span>
                    <div className="input-group mb-3">
                <div className="input-group-prepend">
                 <span className="input-group-text"><i className="fa fa-user form-icon"></i></span>
                </div>
                <input type="text" className="form-control" placeholder="Email" id="email" name="email" />
             </div>
             <div className="input-group mb-3">
               <div className="input-group-prepend">
                 <span className="input-group-text"><i className="fa fa-lock form-icon"></i></span>
               </div>
               <input type="password" className="form-control" placeholder="Password" id="password" name="password" />
             </div>
                    <button type="submit">login</button>
                </form>
            </div>
        </div>
    );
};

export default LoginPage;
