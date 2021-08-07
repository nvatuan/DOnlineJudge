import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { FaBars, FaTimes } from 'react-icons/fa';
import { FcNightPortrait } from 'react-icons/fc'
import { DropdownButton, Dropdown } from 'react-bootstrap';
import Login from './Pages/Login/Login';
import './Navbar.css';
import { useHistory } from 'react-router-dom';
import { logoutUser, userSelector } from './UserSlice';
import { useDispatch, useSelector } from 'react-redux';
import { toast } from 'react-toastify';
import Register from './Pages/Register/Register';
import logo from '../public/Logo_dhbkdn.jpg'
function Navbar() {
    const [check, setCheck] = useState(false);
    const { isSuccess } = useSelector(userSelector);
    useEffect(() => {
        if (localStorage.getItem('token') !== null) setCheck(true);
        else setCheck(false);
    }, [localStorage.getItem('token')])

    const [click, setClick] = useState(false);
    const [button, setButton] = useState(true);
    const handleClick = () => setClick(!click);
    const showButton = () => {
        if (window.innerHeight <= 960) {
            setButton(false);
        } else {
            setButton(true);
        }
    }
    window.addEventListener('resize', showButton)
    //logout process
    const dispatch = useDispatch();
    const history = useHistory();
    const onLogout = () => {
        dispatch(logoutUser());
        if(isSuccess){
            toast.success('goodbye!', {
                position: toast.POSITION.BOTTOM_CENTER,
                autoClose: 1500
            });
            history.push("/");
        }
    }
    return (
        <>
            <div className="navbar">
                <div className="navbar-container container">
                    <Link to='/home' className="navbar-logo">
                        <img className="navbar-logo__item" src={logo} alt="logo"/>
                        <h2 className="navbar-logo__item">DOnlineJudge</h2>
                    </Link>
                    <div className="menu-icon" onClick={handleClick}>
                        {click ? <FaTimes /> : <FaBars />}
                    </div>
                    <ul className={click ? 'nav-menu active' : 'nav-menu'}>
                        {/* <li className="nav-item">
                            <Link to='/home' className='nav-links'> Home</Link>
                        </li> */}
                        <li className="nav-item">
                            <Link to='/news' className='nav-links'> News</Link>
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
                        <li className="nav-btn ">
                            {!check ? (
                                <Login />
                            ) : <DropdownButton  variant="secondary" title={localStorage.getItem('username')}>
                                <Dropdown.Item><Link to='/profile' className="dropdown-items">Settings</Link></Dropdown.Item>
                                {localStorage.getItem('role') === "Super Admin" || localStorage.getItem('role') === "Admin" ?
                                        <Dropdown.Item><Link to='/admin' className="dropdown-items ">Admin page</Link></Dropdown.Item> : <></>}
                                <Dropdown.Divider />
                                <Dropdown.Item className="dropdown-items" onClick={onLogout} >Logout</Dropdown.Item>
                            </DropdownButton>}
                        </li>
                        <li className="nav-btn">
                            {!check ? (
                                <Register />
                            ) : <></>}
                        </li>
                    </ul>
                </div>
            </div>
        </>
    )
}

export default Navbar
