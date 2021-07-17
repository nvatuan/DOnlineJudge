import React from 'react'
import './App.css';
import { HashRouter, BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';

import About from './users/Pages/About/About';
import Home from './users/Pages/Home/Home';
import Problem from './users/Pages/Problem/Problem';
import Status from './users/Pages/Status/Status';
import ProblemList from './admin/Problems/ProblemList/ProblemList';
import User from './admin/General/User/User';
import Announcement from './admin/General/Announcement/Announcement';
import Dashboard from './admin/Dashboard/Dashboard';
import CreateProblem from './admin/Problems/CreateProblem/CreateProblem'
//test 
import EditAnnouncement from './admin/General/Announcement/EditAnnouncement';
import Problem_detail from './users/Pages/Problem/Problem_detail';
import News from './users/Pages/News/News';
//Private Route
import { PrivateRouteSuperAdmin } from './helpers/PrivateRouteSuperAdmin';
import { PrivateRouteAdmin } from './helpers/PrivateRouteAdmin';

//
import Status_detail from './users/Pages/Status/Status_detail';
import Setting from './users/Pages/Setting/Setting';
import EditUser from './admin/General/User/EditUser'
import NotFound from './users/Pages/NotFound/NotFound';

function App() {
  return (
      <Router>
        <Switch>
          <Route path='/' exact component={Home}></Route>
          <Route path='/home' exact component={Home}></Route>
          <Route path='/about' exact component={About}></Route>
          <Route path='/problem' exact component={Problem}></Route>
          <Route path='/problem/:id' exact component={Problem_detail}></Route>
          <Route path='/status' exact component={Status}></Route>
          <Route path='/status/:id' exact component={Status_detail}></Route>
          <Route path='/news' exact component={News} />
          <Route path='/profile' exact component={Setting} />

          <PrivateRouteSuperAdmin exact component={Dashboard} path='/admin' />
          <PrivateRouteSuperAdmin exact component={Dashboard} path='/admin/dashboard' />
          <PrivateRouteSuperAdmin exact component={User} path='/admin/user' />
          <PrivateRouteSuperAdmin exact component={ProblemList} path='/admin/problem' />
          <PrivateRouteSuperAdmin exact component={Announcement} path='/admin/announcement' />
          <PrivateRouteSuperAdmin exact component={CreateProblem} path='/admin/problem/create' />
          <PrivateRouteSuperAdmin exact component={CreateProblem} path='/admin/problem/:id' />
          <PrivateRouteSuperAdmin exact component={EditAnnouncement} path='/admin/announcement/:id' />
          <PrivateRouteSuperAdmin exact component={EditAnnouncement} path='/admin/announcement/new' />
          <PrivateRouteSuperAdmin exact component={EditUser} path='/admin/users/:id' />
          <PrivateRouteSuperAdmin exact component={EditUser} path='/admin/users/new' />

          <PrivateRouteAdmin exact component={Dashboard} path='/admin' />
          <PrivateRouteAdmin exact component={Dashboard} path='/admin/dashboard' />
          <PrivateRouteAdmin exact component={ProblemList} path='/admin/problem' />
          <PrivateRouteAdmin exact component={Announcement} path='/admin/announcement' />
          <PrivateRouteAdmin exact component={CreateProblem} path='/admin/problem/create' />
          <PrivateRouteAdmin exact component={CreateProblem} path='/admin/problem/:id' />
          <PrivateRouteAdmin exact component={EditAnnouncement} path='/admin/announcement/:id' />
          <PrivateRouteAdmin exact component={EditAnnouncement} path='/admin/announcement/new' />

          <Route path='/404' component={NotFound}></Route>
          <Route component={NotFound}></Route>
        </Switch>
      </Router>    
  );
}

export default App;
