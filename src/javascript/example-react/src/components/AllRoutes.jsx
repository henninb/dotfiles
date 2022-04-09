import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Login from "./Login";
import HockeyScores from "./HockeyScores";

export default function AllRoutes() {
  return (
    <div>
      <BrowserRouter>
          <div>
          </div>
          <Routes>
            <Route path="/" element={<Login />} />
            <Route path="/nhl" element={<HockeyScores />} />
          </Routes>
      </BrowserRouter>
    </div>
  );
}
