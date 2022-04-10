import logo from './logo.svg';
import './App.css';

import React, { Component } from "react";
import AllRoutes from "./components/AllRoutes";

export default class App extends Component {
  render() {
    return <div>
      <nav className="navbar navbar-expand-lg navbar-dark primary-color">
  <a className="navbar-brand" href="#">Navbar</a>
  <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span className="navbar-toggler-icon"></span>
  </button>
  <div className="collapse navbar-collapse" id="navbarNav">
    <ul className="navbar-nav">
      <li className="nav-item active">
        <a className="nav-link" href="/">Home <span className="sr-only">(current)</span></a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="/nhl">NHL</a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="/nba">NBA</a>
      </li>
      <li className="nav-item">
        <a className="nav-link disabled" href="#">Disabled</a>
      </li>
    </ul>
  </div>
</nav>
      <AllRoutes />;
      </div>
  }
}
