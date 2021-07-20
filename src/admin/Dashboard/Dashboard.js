import React, { useEffect } from 'react';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import './Dashboard.scss';
import { AiOutlineUser, AiOutlineLogin, AiOutlineCode, AiOutlineDashboard } from "react-icons/ai";
import { useSelector, useDispatch } from 'react-redux';
import { profileSelector, userProfile  } from '../../users/Pages/Profile/profileSlice'; 
import { RiAdminLine } from "react-icons/ri";
function Dashboard() {
    const dispatch = useDispatch();
    const {username, admin_type, profile_pic, last_login} = useSelector(profileSelector);
    useEffect(() => {
        dispatch(userProfile());
    }, [])
    return (
        <div className="admin-content">
            <AdminNavbar />
            <Sidebar />
            <div className="admin-dashboard pages-container">
                <h2 className="dashboard__title"> <AiOutlineDashboard className="dashboard__title-icon"></AiOutlineDashboard> Dashboard</h2>
                <div className="dashboard__list">
                    <div className="dashboard__item dashboard__item--admin-name">
                        <div className="item__icon item__icon--first">
                            <AiOutlineUser className="item__icon-font"></AiOutlineUser>
                        </div>
                        <div className="item__title">Admin Name</div>
                        <div className="item__content">{username}</div>
                    </div>
                    <div className="dashboard__item dashboard__item--admin-type">
                        <div className="item__icon item__icon--second">
                            <RiAdminLine className="item__icon-font"></RiAdminLine>
                        </div>
                        <div className="item__title">Admin Type</div>
                        <div className="item__content">{admin_type}</div>
                    </div>
                    <div className="dashboard__item dashboard__item--last-login">
                        <div className="item__icon item__icon--third">
                            <AiOutlineLogin className="item__icon-font"></AiOutlineLogin>
                        </div>
                        <div className="item__title">Last Login</div>
                        <div className="item__content">{last_login}</div>
                    </div>
                    <div className="dashboard__item dashboard__item--problems">
                        <div className="item__icon item__icon--fourth">
                            <AiOutlineCode className="item__icon-font"></AiOutlineCode>
                        </div>
                        <div className="item__title">Problems</div>
                        <div className="item__content"></div>
                    </div>
                </div>

                <div className="Admin_profile">
                    <div className="admin_header">
                        <img src={profile_pic} className="admin_image"alt="error" />
                    </div>
                    <div className="admin_information">
                        <h4>Introduction</h4>
                        <hr />
                        <p>Thuốc đắng giả tật, nhạc giật lên luôn</p>
                    </div>
                </div >
            </div>
            
        </div>
    )
}
export default Dashboard

