import React, { useEffect, useState } from 'react';
import { Card, Button } from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDelete } from 'react-icons/ai';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import '../../Table.scss';
import './User.scss';
import {useDispatch, useSelector} from 'react-redux';
import {adminSelector, clearState, deleteUser, UserList} from '../../AdminSlice';
import { Link } from 'react-router-dom';
import { BsFillPlusCircleFill } from 'react-icons/bs';
function User(props) {
    const [users, setUsers] = useState([]);

    //for redux
    const dispatch = useDispatch();
    const { admin_users, isFetchUsersSuccess, deleteSusscess } = useSelector(adminSelector);
    //delete
    const handleDeleteUser = (id) => {
        if (window.confirm("Are you sure?")) {
            dispatch(deleteUser(id));   
        }
    }
    //
    useEffect(() => {
        dispatch(UserList());
    },[])
    useEffect(() => {
        if(isFetchUsersSuccess){
            setUsers(admin_users);
            dispatch(clearState());
        }
    },[isFetchUsersSuccess]);
    useEffect(() => {
        if (deleteSusscess){
            dispatch(UserList())
        }
    },[deleteSusscess])

    return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card>
                    <Card.Header as="h4" className="user-header">
                        Users
                        {/* <div className="create_button">
                            <Link to={`/admin/users/new`} className="alter_announcement"> <BsFillPlusCircleFill /> New</Link>
                        </div> */}
                    </Card.Header>
                    <Card.Body>
                            < table >
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Username</th>
                                        <th>Create time</th>
                                        <th>Last login</th>
                                        <th>Email</th>
                                        <th>User type</th>
                                        <th>Option</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {
                                        users.length > 0 ? (
                                            users.map((user) => (
                                                <tr key={user.id}>
                                                    <td>{user.id}</td>
                                                    <td>{user.username}</td>
                                                    <td>{user.create_time}</td>
                                                    <td>{user.last_login}</td>
                                                    <td>{user.email}</td>
                                                    <td>{user.admin_type}</td>
                                                    <td>
                                                        <div className="option-cell">
                                                            <div className="option-button">
                                                                <div className="option-button__items">
                                                                        <Link to={`/admin/users/${user.id}`} className="alter-user-button"><AiOutlineEdit /></Link>
                                                                </div>
                                                                <div className="option-button__items">
                                                                    <Button variant="light" onClick={() => { handleDeleteUser(user.id)}}>
                                                                        <AiOutlineDelete />
                                                                    </Button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            ))
                                        ) : (
                                            <tr>
                                                <td colSpan={5}>No user</td>
                                            </tr>
                                        )
                                    }
                                </tbody>
                            </table >
                    </Card.Body>
                </Card>
            </div>
        </div>
    )
}

User.propTypes = {

}

export default User

