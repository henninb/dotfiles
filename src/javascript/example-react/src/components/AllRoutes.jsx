import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Login from "./Login";
import HockeyScores from "./HockeyScores";
import Temperature from "./Temperature";
import Home from "./Home";

export default function AllRoutes() {
  return (
    <div>
      <BrowserRouter>
          <div>
          </div>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/nhl" element={<HockeyScores />} />
            <Route path="/login" element={<Login />} />
            <Route path="/temperature" element={<Temperature />} />
          </Routes>
      </BrowserRouter>
    </div>
  );
}
