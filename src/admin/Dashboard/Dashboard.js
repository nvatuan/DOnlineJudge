import React, { useState } from 'react';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import './Dashboard.scss';
function Dashboard(props) {
    const [name, SetName] = useState('admin');
    const [role, Setrole] = useState('Super Admin');
    const [image, setImage] = useState('https://www.pngitem.com/pimgs/m/128-1280822_check-mark-box-clip-art-blue-admin-icon.png')
    return (
        <div className="admin-content">
            <AdminNavbar />
            <Sidebar />
            <div className="dashboard" >
                <div className="admin-img">
                    <img src={image} alt="" width="100%" height="100%" />
                </div>
                <hr />
                <div className="admin-info">
                    <p className="admin-name"> {name} </p>
                    <p className="admin-role"> {role} </p>

                </div>

            </div >

        </div >
    )
}

Dashboard.propTypes = {

}

export default Dashboard

