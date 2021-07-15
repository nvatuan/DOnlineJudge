import React, {useState, useEffect}from 'react';
import oj_profileAPI from '../../api/oj_profileAPI';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import './Dashboard.scss';
function Dashboard() {
    const [userData, setUserData] = useState([]);
    useEffect(() =>{
        const fetchAdminInformation = async () =>{
            const response = await oj_profileAPI.getUserInformation();
            if(response){
                setUserData(response.data);
            }
        };
        fetchAdminInformation();
    },[])
    console.log(userData);
    return (
        <div className="admin-content">
            <AdminNavbar />
            <Sidebar />
            <div className="Admin_profile">
                <div className="admin_image">
                    <img src={userData.profile_pic} alt="error"/>
                </div>
                <div className="admin_information">
                <h4>Quote</h4>
                </div>
            </div>
        </div >
    )
}

export default Dashboard

