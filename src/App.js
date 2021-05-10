import React, { useState } from 'react'
import './App.css';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import About from './users/Components/Pages/About/About';
import Home from './users/Components/Pages/Home/Home';
import Problem from './users/Components/Pages/Problem/Problem';
import Status from './users/Components/Pages/Status/Status';
import Login from './users/Components/Pages/Login/Login';
import Register from './users/Components/Pages/Register/Register'
import ProblemList from './admin/Problems/ProblemList/ProblemList';
import User from './admin/General/User/User';
import Annoucement from './admin/General/Annoucement/Annoucement';
import Dashboard from './admin/Dashboard/Dashboard';
import CreateProblem from './admin/Problems/CreateProblem/Createproblem'
//test 
import EditAnnoucement from './admin/General/Annoucement/EditAnnoucement';
import Problem_detail from './users/Components/Pages/Problem/Problem_detail';
const usersData = [
  { id: 1, name: 'Tania', username: 'floppydiskette' },
  { id: 2, name: 'Craig', username: 'siliconeidolon' },
  { id: 3, name: 'Ben', username: 'benisphere' },
];


function App() {
  const [users, setUsers] = useState(usersData);
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
        <Route path='/login' exact component={Login}></Route>
        <Route path='/Register' exact component={Register}></Route>
        //admin
        <Route path='/admin/' exact> <Dashboard users={users} /> </Route>
        <Route path='/admin/dashboard' exact> <Dashboard users={users} /> </Route>
        <Route path='/admin/user' exact> <User /> </Route>
        <Route path='/admin/problems' exact> <ProblemList users={users} /> </Route>
        <Route path='/admin/user' exact> <User/> </Route>
        <Route path='/admin/annoucement' exact component={Annoucement}></Route>
        <Route path='/admin/problem/create' exact component={CreateProblem}></Route>

        <Route path='/123' exact component={EditAnnoucement}></Route>
      </Switch>
    </Router>
  );
}

export default App;
