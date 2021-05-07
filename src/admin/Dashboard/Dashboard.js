import React from 'react'
import PropTypes from 'prop-types'
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
function Dashboard(props) {
    return (
        <div>
            <AdminNavbar />
            <Sidebar />
            DashBoard
        </div>
    )
}

Dashboard.propTypes = {

}

export default Dashboard

