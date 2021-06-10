import React from 'react'
import {Button} from 'react-bootstrap';
import { FiLogOut } from 'react-icons/fi';
import './AdminNavbar.scss';
function AdminNavbar(props) {
    return (
        <>
            <div className="navbar">
                <div className="nav-container">
                    <div className="btn-item">
                        <Button variant="light"  >
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

