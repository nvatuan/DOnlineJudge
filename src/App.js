import React from 'react'
import './App.css';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';

import About from './users/Pages/About/About';
import Home from './users/Pages/Home/Home';
import Problem from './users/Pages/Problem/Problem';
import Status from './users/Pages/Status/Status';
import ProblemList from './admin/Problems/ProblemList/ProblemList';
import User from './admin/General/User/User';
import Annoucement from './admin/General/Annoucement/Annoucement';
import Dashboard from './admin/Dashboard/Dashboard';
import CreateProblem from './admin/Problems/CreateProblem/CreateProblem'
//test 
import EditAnnoucement from './admin/General/Annoucement/EditAnnoucement';
import Problem_detail from './users/Pages/Problem/Problem_detail';
import Announcement from './users/Pages/Home/Announcement'
//Private Route
import { PrivateRoute } from './helpers/PrivateRoute';
//
import Status_detail from './users/Pages/Status/Status_detail';
import Setting from './users/Pages/Setting/Setting';
import EditUser from './admin/General/User/EditUser'

function App() {
  return (
    <Router>
      <Switch>
        <Route path='/' exact component={Home}></Route>
        <Route path='/home' exact component={Home}></Route>
        <Route path='/about' exact component={About}></Route>
        <Route path='/problem/' exact component={Problem}></Route>
        <Route path='/problem/:id' exact component={Problem_detail}></Route>
        <Route path='/status' exact component={Status}></Route>
        <Route path='/status/:id' exact component={Status_detail}></Route>
        <Route path='/announcement' exact component={Announcement} />
        <Route path='/profile' exact component={Setting} />

        <PrivateRoute exact component={Dashboard} path='/admin/' />
        <PrivateRoute exact component={Dashboard} path='/admin/dashboard' />
        <PrivateRoute exact component={User} path='/admin/user' />
        <PrivateRoute exact component={ProblemList} path='/admin/problem' />
        <PrivateRoute exact component={Annoucement} path='/admin/announcement' />
        <PrivateRoute exact component={CreateProblem} path='/admin/problem/create' />
        <PrivateRoute exact component={CreateProblem} path='/admin/problem/:id' />
        <PrivateRoute exact component={EditAnnoucement} path='/admin/announcement/:id' />
        <PrivateRoute exact component={EditAnnoucement} path='/admin/announcement/new' />
        <PrivateRoute exact component={EditUser} path='/admin/users/:id' />
        <PrivateRoute exact component={EditUser} path='/admin/users/new' />
      </Switch>
    </Router>
  );
}

export default App;
