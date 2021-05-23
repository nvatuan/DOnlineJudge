import React, { useState } from 'react'
import './App.css';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';

import About from './users/Pages/About/About';
import Home from './users/Pages/Home/Home';
import Problem from './users/Pages/Problem/Problem';
import Status from './users/Pages/Status/Status';
import Login from './users/Pages/Login/Login';
import Register from './users/Pages/Register/Register'
import ProblemList from './admin/Problems/ProblemList/ProblemList';
import User from './admin/General/User/User';
import Annoucement from './admin/General/Annoucement/Annoucement';
import Dashboard from './admin/Dashboard/Dashboard';
import CreateProblem from './admin/Problems/CreateProblem/Createproblem'
//test 
import EditAnnoucement from './admin/General/Annoucement/EditAnnoucement';
import Problem_detail from './users/Pages/Problem/Problem_detail';
import Announcement from './users/Pages/Home/Announcement'
//Private Route
import { PrivateRoute } from './helpers/PrivateRoute';
import Status_detail from './users/Pages/Status/Status_detail';


function App() {
  return (
    <Router>
      <Switch>
        //oj
        <Route path='/' exact component={Home}></Route>
        <Route path='/home' exact component={Home}></Route>
        <Route path='/about' exact component={About}></Route>
        <Route path='/problem/' exact component={Problem}></Route>
        <Route path='/problem/:id' exact component={Problem_detail}></Route>
        <Route path='/status' exact component={Status}></Route>
        <Route path='/status/:id' exact component={Status_detail}></Route>
        <Route path='/announcement' exact component={Announcement}/>
        //admin
        <PrivateRoute exact component={Dashboard} path='/admin/'/>
        <PrivateRoute exact component={Dashboard} path='/admin/dashboard'/>
        <PrivateRoute exact component={User} path='/admin/user'/>
        <PrivateRoute exact component={ProblemList} path='/admin/problems'/>
        <PrivateRoute exact component={Annoucement} path='/admin/annoucement'/>
        <PrivateRoute exact component={CreateProblem} path='/admin/problem/create'/>
      </Switch>
    </Router>
  );
}

export default App;
