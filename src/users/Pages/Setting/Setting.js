import React from 'react';
import Navbar from '../../Navbar';
import avatar from '../../../public/avatar.jpg';
import Profile from '../Profile/Profile'
import './Setting.scss'
import { Link } from 'react-router-dom';

function Setting() {
    return (
        <div>
            <Navbar/>
            <div className="setting_container">
                <div className="card_container">
                    <div className="sidebar pages-container">
                        <center>
                            <img src={avatar} className="profile_img" alt="hiu" />
                            <h4>Nagatoro</h4>
                        </center>
                        <a href="#"><i className="far fa-id-badge"></i><span>Profile</span></a>
                        <a href="#"><i className="fas fa-history"></i><Link className="profile_submission" to={`status/?filter_by=author_id&author_id=${localStorage.getItem("userId")}`}>Submission</Link></a>
                    </div>
                    <div className="right_container">
                            <Profile/>  
                    </div>
                </div>
                
            </div>
        </div>
    )
}

export default Setting;
