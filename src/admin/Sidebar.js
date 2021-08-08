import { ProSidebar, Menu, MenuItem, SubMenu } from 'react-pro-sidebar';
import 'react-pro-sidebar/dist/css/styles.css';
import React, { useState } from 'react'
import { Link } from 'react-router-dom';
import sidebarImage from './sidebar.png';
import './Sidebar.scss';
import { AiFillAppstore, AiOutlineBars, AiOutlineCode, AiFillHome, AiOutlineUser} from 'react-icons/ai';
import {BiServer} from 'react-icons/bi'
import {CgNotes} from 'react-icons/cg'

import Logo from '../public/logo.jpg'
import JudgeServer from './JudgeServer/JudgeServer';

function Sidebar() {
  const [collapsed, setCollapsed] = useState(() => {
    if (window.innerWidth <= 960) {
      return true;
    }
    else {
      return false;
    }
  });
  const handleCollapsed = () => {
    if (window.innerWidth <= 960) {
      setCollapsed(true);
    }
    else {
      setCollapsed(false);
    }

  }
  window.addEventListener('resize', handleCollapsed)
  return (
    <div className="sidebar-container">
      <ProSidebar className="menu-sidebar" collapsed={collapsed} image={sidebarImage}>
        <div className="logo" >
          <img src={Logo} alt="" className="sidebar__logo" />
        </div>
        <Menu iconShape="circle" >
          <MenuItem icon={<AiOutlineCode />}>
            Dashboard
            <Link to='/admin/dashboard' />
          </MenuItem>
          
          {
            localStorage.getItem('role') === 'Super Admin' ? 
              <MenuItem icon={<AiOutlineUser/>}>
                Users
                <Link to="/admin/user" />
              </MenuItem>
              :
              <></>
          }

          <MenuItem icon={<AiFillAppstore />}>
            Posts
            <Link to="/admin/announcement" />
          </MenuItem>

          <MenuItem icon={<AiOutlineBars />}>
            Problems 
            <Link to="/admin/problem" />
          </MenuItem>

          <MenuItem icon={<CgNotes/>}>
            Submissions 
            <Link to="/admin/Submission" />
          </MenuItem>

          <MenuItem icon={<BiServer/>}>
            Judge Servers <Link to="/admin/judgeserver" />
          </MenuItem>

        </Menu>
      </ProSidebar>

    </div>
  )
}

Sidebar.propTypes = {

}

export default Sidebar

