import ReactSignupLoginComponent from 'react-signup-login-component';
import axios from 'axios';

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
        <div>
            <ReactSignupLoginComponent
                title="Brian's World"
                handleSignup={signupWasClickedCallback}
                handleLogin={loginWasClickedCallback}
                handleRecoverPassword={recoverPasswordWasClickedCallback}
            />
        </div>
    );
};

export default LoginPage;
