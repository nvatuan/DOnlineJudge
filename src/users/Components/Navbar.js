import React, { useState } from 'react';
import {Link} from 'react-router-dom';
import {FaBars, FaTimes} from 'react-icons/fa';
import {FcNightPortrait} from 'react-icons/fc'
import {Button} from './Button';
import Login from './Pages/Login/Login';
import './Navbar.css';
function Navbar() {
    const [click, setClick] = useState(false);
    const [button, setButton] = useState(true);
    const [showLoginModal, setShowLoginModal] = useState(false);

    const handleClick = () => setClick(!click);
    // const closeMobileMenu = () => setClick(false);

    const showButton = () =>{
        if(window.innerHeight <= 960){
            setButton(false);
        }else{
            setButton(true);
        }
    }
    window.addEventListener('resize', showButton)
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
                            <Link to='/problem' className='nav-links'> Problem</Link>
                        </li>
                        <li className="nav-item">
                            <Link to='/status' className='nav-links'> Status</Link>
                        </li>
                        <li className="nav-item">
                            <Link to='/about' className='nav-links'> About</Link>
                        </li>
                        <li className="nav-btn">
                            {button ? (
                                <Login/>
                            ) : (
                                    <Button buttonStyle='btn--outline' buttonSize='btn--mobile'>log out</Button>
                            )}
                        </li>
                    </ul>
                </div>
            </div>
        </>
    )
}

export default Navbar
