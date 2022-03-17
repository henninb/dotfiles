import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import Login from "./Login";

export default function AllRoutes() {
  return (
    <div>
      <BrowserRouter>
          <div>
          </div>
          <Routes>
            <Route path="/" element={<Login />} />
          </Routes>
      </BrowserRouter>
    </div>
  );
}
