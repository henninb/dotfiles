import logo from './logo.svg';
import './App.css';

function App() {
  return (
    <div>
      <header>
        <form>
        <div>
            <label>Username : </label>
            <input type="text" placeholder="Enter Username" name="username" required />
            <label>Password : </label>
            <input type="password" placeholder="Enter Password" name="password" required />
            <button type="submit">Login</button>
            <button type="button">Cancel</button>
        </div>
    </form>
      </header>
    </div>
  );
}

export default App;
