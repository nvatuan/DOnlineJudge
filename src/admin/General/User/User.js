import React, { useEffect, useState } from 'react';
import PropTypes from 'prop-types';
import { Card, Button } from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDelete } from 'react-icons/ai';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import '../../Table.scss';
//
// import admin_users from '../../../api/admin_usersAPI';

//
import {useDispatch, useSelector} from 'react-redux';
import {adminSelector, clearState, UserList} from '../../AdminSlice';
function User(props) {
    const [users, setUsers] = useState([]);

    //for redux
    const dispatch = useDispatch();
    const { admin_users, isFetchUsersSuccess } = useSelector(adminSelector);
    useEffect(() => {
        dispatch(UserList());
    },[])
    useEffect(() => {
        if(isFetchUsersSuccess){
            setUsers(admin_users);
            dispatch(clearState);
        }
    })
    
    return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card>
                    <Card.Header as="h4">Users</Card.Header>
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
                                                    <td>{user.user_type}</td>
                                                    <td>
                                                        <div className="option-cell">
                                                            <div className="option-button">
                                                                <div className="option-button">
                                                                    <Button variant="light">
                                                                        <AiOutlineEdit />
                                                                    </Button>
                                                                </div>
                                                                <div className="option-button">
                                                                    <Button variant="light">
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

