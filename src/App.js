import React from 'react'
import './App.css';
import { BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';

import About from './users/Pages/About/About';
import Home from './users/Pages/Home/Home';
import Problem from './users/Pages/Problem/Problem';
import Status from './users/Pages/Status/Status';
import ProblemList from './admin/Problems/ProblemList/ProblemList';
import User from './admin/General/User/User';
import CreateUser from './admin/General/User/CreateUser';
import UserCreateionLog from './admin/General/User/UserCreationLog';

import Announcement from './admin/General/Announcement/Announcement';
import Dashboard from './admin/Dashboard/Dashboard';
import CreateProblem from './admin/Problems/CreateProblem/CreateProblem'
//test 
import EditAnnouncement from './admin/General/Announcement/EditAnnouncement';
import Problem_detail from './users/Pages/Problem/Problem_detail';
import News from './users/Pages/News/News';
//Private Route
import { PrivateRoute } from './helpers/PrivateRoute';
import { PrivateRouteSAdmin } from './helpers/PrivateRouteSAdmin';

//
import Status_detail from './users/Pages/Status/Status_detail';
import Setting from './users/Pages/Setting/Setting';
import EditUser from './admin/General/User/EditUser'
import NotFound from './users/Pages/NotFound/NotFound';
import JudgeServer from './admin/JudgeServer/JudgeServer';
import JudgeServerDetail from './admin/JudgeServer/JudgeServerDetail';
import NewJudgeServerForm from './admin/JudgeServer/NewJudgeServerForm';
import AdminSubmissionList from './admin/Submission/SubmissionList'
import AdminSubmissionDetail from './admin/Submission/SubmissionDetail'

function App() {
  return (
      <Router>
        <Switch>
          <Route path='/' exact component={Home}></Route>
          <Route path='/home' exact component={Home}></Route>
          <Route path='/about' exact component={About}></Route>
          <Route path='/problem' exact component={Problem}></Route>
          <Route path='/problem/:id' exact component={Problem_detail}></Route>
          <Route path='/status/' exact component={Status}></Route>
          <Route path='/status/:id' exact component={Status_detail}></Route>
          <Route path='/news' exact component={News} />
          <Route path='/profile' exact component={Setting} />

          <PrivateRoute exact component={Dashboard} path='/admin' />
          <PrivateRoute exact component={Dashboard} path='/admin/dashboard' />
          <PrivateRoute exact component={ProblemList} path='/admin/problem' />

          <PrivateRoute exact component={Announcement} path='/admin/announcement' />
          <PrivateRoute exact component={EditAnnouncement} path='/admin/announcement/new' />
          <PrivateRoute exact component={EditAnnouncement} path='/admin/announcement/:id' />

          <PrivateRoute exact component={CreateProblem} path='/admin/problem/create' />
          <PrivateRoute exact component={CreateProblem} path='/admin/problem/:id' />

          <PrivateRoute exact component={AdminSubmissionList} path='/admin/submission' />
          <PrivateRoute exact component={AdminSubmissionDetail} path='/admin/submission/:id' />
          <PrivateRoute exact component={JudgeServer} path='/admin/judgeserver'/>
          <PrivateRoute exact component={NewJudgeServerForm} path='/admin/judgeserver/new'/>
          <PrivateRoute exact component={JudgeServerDetail} path='/admin/judgeserver/:id' />

          <PrivateRouteSAdmin exact component={User} path='/admin/user' />
          <PrivateRouteSAdmin exact component={UserCreateionLog} path='/admin/user/create/log/:id' />
          <PrivateRouteSAdmin exact component={CreateUser} path='/admin/user/create' />
          <PrivateRouteSAdmin exact component={EditUser} path='/admin/user/:id' />

          <Route path='/404' component={NotFound}></Route>
          <Route component={NotFound}></Route>
        </Switch>
      </Router>    
  );
}

export default App;
