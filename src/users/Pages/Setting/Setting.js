import React from 'react';
import Navbar from '../../Navbar';
import avatar from '../../../public/avatar.jpg';
import './Setting.scss'
function Setting() {
    return (
        <div>
            <Navbar/>
            <div className="sidebar">
                <center>
                    <img src={avatar} className="profile_img" alt="hiu"/>
                    <h4>Nagatoro</h4>
                </center>
                <a href="#"><i class="far fa-id-badge"></i><span>Profile</span></a>
                <a href="#"><i class="fas fa-history"></i><span>Submissions</span></a>

            </div>
        </div>
    )
}

export default Setting;
