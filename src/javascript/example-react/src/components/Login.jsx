import react from 'react';
import axios from 'axios';
import './style.css';

// export default const LoginPage = (props) => {
export default function Login(props) {

    return (
        <div className="login">
            <div className="form">
                <form name="login-form" className="login-form" action="/login" method="GET" data-bitwarden-watching="1">
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
                    <button type="submit">login</button>
                </form>
            </div>
        </div>
    );
};
