import logo from './logo.svg';
import './App.css';

import React, { Component } from "react";
import AllRoutes from "./components/AllRoutes";

export default class App extends Component {
  render() {
    return <>
      <nav className="navbar navbar-expand-sm bg-secondary navbar-dark">
  <div className="container-fluid">
    <ul className="navbar-nav">
      <li className="nav-item">
        <a className="nav-link active" href="#">Active</a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="#">Link</a>
      </li>
      <li className="nav-item">
        <a className="nav-link" href="#">Link</a>
      </li>
      <li className="nav-item">
        <a className="nav-link disabled" href="#">Disabled</a>
      </li>
    </ul>
  </div>
</nav>
      <AllRoutes />;
      </>
  }
}
