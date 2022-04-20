import './App.css';

import React, { Component } from "react";
import AllRoutes from "./components/AllRoutes";
export default class App extends Component {
  render() {
    return <div>
      <nav className="navbar navbar-expand-lg navbar-dark primary-color">
     <div className="collapse navbar-collapse" id="navbarNav">
      <ul className="navbar-nav">
      <li className="nav-item active">
        <a className="nav-link" href="/">Home</a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="/nhl">NHL</a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="/mlb">MLB</a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="/temperature">Temperature</a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="/login">Login</a>
      </li>
    </ul>
  </div>
</nav>
      <AllRoutes />
      </div>
  }
}
