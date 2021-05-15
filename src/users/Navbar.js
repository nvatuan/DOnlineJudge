import React, { useState, useEffect } from 'react';
import {Link} from 'react-router-dom';
import {FaBars, FaTimes} from 'react-icons/fa';
import {FcNightPortrait} from 'react-icons/fc'
import {Button} from 'react-bootstrap';
import Login from './Pages/Login/Login';
import './Navbar.css';
import { useHistory } from 'react-router-dom';
import { clearState, userSelector, logoutUser } from './UserSlice';
import { useDispatch, useSelector } from 'react-redux';
import { toast } from 'react-toastify';
import Register from './Pages/Register/Register';
function Navbar() {
    const [click, setClick] = useState(false);
    const [button, setButton] = useState(true);
    const handleClick = () => setClick(!click);
    const showButton = () =>{
        if(window.innerHeight <= 960){
            setButton(false);
        }else{
            setButton(true);
        }
    }
    window.addEventListener('resize', showButton)
    //logout process
    const dispatch = useDispatch();
    const history = useHistory();
    const onLogout = () => {
        dispatch(logoutUser());
        dispatch(clearState());
        localStorage.removeItem('token');
        toast.success('bai baii', {
            position: toast.POSITION.BOTTOM_CENTER,
            autoClose: 1500
        });
        history.push('/');
    }

    return (
        <>
            <div className="navbar">
                <div className="navbar-container container">
                    <Link to='/home' className="navbar-logo">
                        <FcNightPortrait className='navbar-icon'></FcNightPortrait>
                        WIBU Code
                    </Link>
                    <div className="menu-icon" onClick={handleClick}>
                    {click ? <FaTimes/> : <FaBars/>}
                    </div>
                    <ul className={click ? 'nav-menu active' : 'nav-menu'}>
                        <li className="nav-item">
                            <Link to='/home' className='nav-links'> Home</Link>
                        </li>
                        <li className="nav-item">
                            <Link to='/problem/' className='nav-links'> Problem</Link>
                        </li>
                        <li className="nav-item">
                            <Link to='/status' className='nav-links'> Status</Link>
                        </li>
                        <li className="nav-item">
                            <Link to='/about' className='nav-links'> About</Link>
                        </li>
                        <li className="nav-btn">
                            {localStorage.getItem('token') === null ? <Login/> :
                            <Button
                            variant="outline-dark" size="lg" variant="dark"
                            onClick={onLogout}>
                                    Logout
                            </Button>}
                        </li>

                    </ul>
                </div>
            </div>
        </>
    )
}

export default Navbar
