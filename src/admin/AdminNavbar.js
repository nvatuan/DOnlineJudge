import React, { useEffect } from 'react'
import {Button} from 'react-bootstrap';
import { FiLogOut } from 'react-icons/fi';
import { useHistory } from 'react-router';
import logoutAPI from '../api/logoutAPI';
import './AdminNavbar.scss';
function AdminNavbar() {
    const history = useHistory();
    function handlelogout(){
        const logout = async () => {
            const response = await logoutAPI.logout();
            if(response){
                localStorage.removeItem('token');
                localStorage.removeItem('role');
                localStorage.removeItem('username');
                localStorage.removeItem('userId');
                localStorage.removeItem('userInformation');
                history.push('/');
            }
        }
        logout();
    }
    return (
        <>
            <div className="navbar">
                <div className="nav-container">
                    <div className="btn-item">
                        <Button variant="light"  onClick={() => handlelogout()}>
                            <FiLogOut />
                            Log out
                        </Button>
                    </div>
                </div>
            </div>
        </>
    )
}

AdminNavbar.propTypes = {

}

export default AdminNavbar

