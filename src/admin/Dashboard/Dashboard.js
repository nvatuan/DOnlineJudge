import React, { useEffect } from 'react';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import './Dashboard.scss';
import { AiOutlineUser, AiOutlineLogin, AiOutlineDashboard } from "react-icons/ai";
import { HiOutlineIdentification } from 'react-icons/hi';
import { useSelector, useDispatch } from 'react-redux';
import { profileSelector, userProfile } from '../../users/Pages/Profile/profileSlice';
import { RiAdminLine } from "react-icons/ri";
function Dashboard() {
    const dispatch = useDispatch();
    const { id, username, admin_type, profile_pic, last_login, authored_problem, solved_problem } = useSelector(profileSelector);
    useEffect(() => {
        dispatch(userProfile());
    }, [])
    const hanldeTime = (time) => {
        return new Date(time).toString().replace("Indochina", "Hanoi");
    }
    return (
        <div className="admin-content">
            <AdminNavbar />
            <Sidebar />
            <div className="admin-dashboard pages-container">
                <h2 className="dashboard__title"> <AiOutlineDashboard className="dashboard__title-icon"></AiOutlineDashboard> Dashboard</h2>
                <div className="dashboard__list">
                    <div className="dashboard__item dashboard__item--admin-name">
                        <div className="item__icon item__icon--first">
                            <AiOutlineUser className="item__icon-font"></AiOutlineUser>
                        </div>
                        <div className="item__title">Admin Name</div>
                        <div className="item__content">{username}</div>
                    </div>
                    <div className="dashboard__item dashboard__item--admin-type">
                        <div className="item__icon item__icon--second">
                            <RiAdminLine className="item__icon-font"></RiAdminLine>
                        </div>
                        <div className="item__title">Admin Type</div>
                        <div className="item__content">{admin_type}</div>
                    </div>
                    <div className="dashboard__item dashboard__item--last-login">
                        <div className="item__icon item__icon--third">
                            <AiOutlineLogin className="item__icon-font"></AiOutlineLogin>
                        </div>
                        <div className="item__title">Last Login</div>
                        <div className="item__content item__last-login">{hanldeTime(last_login)}</div>
                    </div>
                    <div className="dashboard__item dashboard__item--problems">
                        <div className="item__icon item__icon--fourth">
                            <HiOutlineIdentification className="item__icon-font"></HiOutlineIdentification>
                        </div>
                        <div className="item__title">ID</div>
                        <div className="item__content">{id}</div>
                    </div>
                </div>
                <div className="Admin_profile">
                    <div className="admin_header">
                        <img src={profile_pic} className="admin_image" alt="error" />
                    </div>
                    <div className="admin_information">
                        <h4>Introduction</h4>
                        <hr />
                        <p>Thuốc đắng giả tật, nhạc giật lên luôn</p>
                    </div>
                </div >
                <div className="admin__section">

                    <div className="admin__my-problems">
                        <h4>Created Problems</h4>
                        < table >
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Display ID</th>
                                    <th>Tille</th>
                                    <th>difficulty</th>

                                </tr>
                            </thead>
                            <tbody>
                                {
                                    authored_problem.length > 0 ? (
                                        authored_problem.map((problem) => (
                                            <tr key={problem.id}>
                                                <td>{problem.id}</td>
                                                <td>{problem.display_id}</td>
                                                <td>{problem.title}</td>
                                                <td>{problem.difficulty}</td>

                                            </tr>
                                        ))
                                    ) : (
                                        <tr>
                                            <td colSpan={5}>Nothing</td>
                                        </tr>
                                    )
                                }
                            </tbody>
                        </table >
                    </div>

                    <div className="admin__my-problems">
                        <h4>Sovled Problems</h4>
                        < table >
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Display ID</th>
                                    <th>Tille</th>
                                    <th>difficulty</th>

                                </tr>
                            </thead>
                            <tbody>
                                {
                                    solved_problem.length > 0 ? (
                                        solved_problem.map((problem) => (
                                            <tr key={problem.id}>
                                                <td>{problem.id}</td>
                                                <td>{problem.display_id}</td>
                                                <td>{problem.title}</td>
                                                <td>{problem.difficulty}</td>

                                            </tr>
                                        ))
                                    ) : (
                                        <tr>
                                            <td colSpan={5}>Nothing</td>
                                        </tr>
                                    )
                                }
                            </tbody>
                        </table >
                    </div>
                </div>
            </div>

        </div>
    )
}
export default Dashboard

