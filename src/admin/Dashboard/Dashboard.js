import React from 'react';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import './Dashboard.scss';
function Dashboard(props) {

    return (
        <div className="admin-content">
            <AdminNavbar />
            <Sidebar />
            <div className="admin-dashboard">
                <div className="dashboard__list">
                    <div className="dashboard__item dashboard__item--admin-name">
                        <div className="item__icon item__icon--first"></div>
                        <div className="item__title">Admin Name</div>
                        <div className="item__content">{"admin"}</div>
                    </div>
                    <div className="dashboard__item dashboard__item--admin-type">
                        <div className="item__icon item__icon--second"></div>
                        <div className="item__title">Amin Type</div>
                        <div className="item__content">{"Regular"}</div>
                    </div>
                    <div className="dashboard__item dashboard__item--last-login">
                        <div className="item__icon item__icon--third"></div>
                        <div className="item__title">Last Login</div>
                        <div className="item__content"></div>
                    </div>
                    <div className="dashboard__item dashboard__item--problems">
                        <div className="item__icon item__icon--fourth"></div>
                        <div className="item__title">Problems</div>
                        <div className="item__content"></div>
                    </div>
                </div>
            </div>
        </div >
    )
}

export default Dashboard

