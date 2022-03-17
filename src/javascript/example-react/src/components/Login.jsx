import ReactSignupLoginComponent from 'react-signup-login-component';
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

    return (
        <div class="login">
            <div class="form">
                <form name="login-form" class="login-form" action="/login" method="GET" data-bitwarden-watching="1">
                    <span class="material-icons">lock</span>
                    <input type="text" name="email" id="email" placeholder="email" required="" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" />
                    <input type="password" name="password" id="password" placeholder="password" required="" />
                    <button type="submit">login</button>
                </form>
            </div>
        </div>
    );
};

export default LoginPage;
