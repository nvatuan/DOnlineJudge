import React from 'react'
import {Button} from 'react-bootstrap';
import { FiLogOut } from 'react-icons/fi';
import { AiFillHome } from 'react-icons/ai'
import { useHistory } from 'react-router';
import logoutAPI from '../api/logoutAPI';
import './AdminNavbar.scss';

import {ToastContainer} from 'react-toastify';

function AdminNavbar() {
    const history = useHistory();
    function handlelogout(){
        const logout = async () => {
            const response = await logoutAPI.logout();
            localStorage.removeItem('token');
            localStorage.removeItem('role');
            history.push('/');
            if(response){
            }
        }
        logout();
    }
    const uname = localStorage.getItem('username');

    return (
        <>
            <div className="navbar">
                <div className="nav-container">
                    <div className="btn-item">
                        {uname===null?<></>
                        :<Button variant="light" disabled>
                            <span className='icon-w-text'>
                                <span className='text'>Hello, <strong>{uname}</strong>!</span>
                            </span>
                        </Button>
                        }
                    </div>
                    <div className="btn-item">
                        <Button variant="light"  onClick={() => {history.push('/')}}>
                            <span className='icon-w-text'>
                                <span className='icon'><AiFillHome/></span>
                                <span className='text'>Homepage</span>
                            </span>
                        </Button>
                    </div>
                    <div className="btn-item">
                        <Button variant="light"  onClick={() => handlelogout()}>
                            <span className='icon-w-text'>
                                <span className='icon'><FiLogOut/></span>
                                <span className='text'>Log out</span>
                            </span>
                        </Button>
                    </div>
                </div>
                <ToastContainer/>
            </div>
        </>
    )
}

AdminNavbar.propTypes = {

}

export default AdminNavbar

