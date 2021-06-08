import React, {useState} from 'react';
import Navbar from '../../Navbar';
import avatar from '../../../public/avatar.jpg';
import Profile from '../Profile/Profile'
import './Setting.scss'
import { Link } from 'react-router-dom';
import EditProfile from '../EditProfile/EditProfile';
function Setting() {
    const [toAccount, setToAccount] = useState(false);
    const [toProfile, setToProfile] = useState(true);
    const openAccountPage = () =>{
        setToAccount(true);
        setToProfile(false);
    }
    const openProfilePage = () =>{
        setToProfile(true);
        setToAccount(false);
    }
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
                        <a href="#" onClick={() => { openProfilePage() }}><i className="far fa-id-badge"></i><span>Profile</span></a>
                        <a href="#" onClick={() => { openAccountPage() }}><i className="fas fa-user-cog"></i><span>Account</span></a>
                        <div className="sidebar-item">
                            <Link className="profile_submission" to={`status/?filter_by=author_id&author_id=${localStorage.getItem("userId")}`}>
                                <i className="fas fa-history"></i>
                                 Submission
                            </Link>
                        </div>
                    </div>
                    <div className="right_container ">
                        {toAccount ? <EditProfile/> : <Profile />}
                    </div>
                </div>
                
            </div>
        </div>
    )
}

export default Setting;
