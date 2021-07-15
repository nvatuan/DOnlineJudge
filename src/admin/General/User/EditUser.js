import React, { useEffect, useState } from 'react'
import AdminNavbar from '../../AdminNavbar'
import Sidebar from '../../Sidebar'
import { Card, ListGroup, Button, Form, FormControl } from 'react-bootstrap';
import { useForm } from 'react-hook-form';
import './EditUser.scss';
import admin_usersAPI from '../../../api/admin_usersAPI';
import { useHistory } from 'react-router';
function EditUser({match}) {
    const id = match.params.id;
    const { register, handleSubmit } = useForm();
    const [userData, setUserData] = useState([])
    const history = useHistory();
    //sent data
    const onSubmit = async (data) => {
        if(!isNaN(id)){
            try {
                const response = await admin_usersAPI.editUser(data, id);
                if (response) {
                    history.push('/admin/users/');
                }
            } catch (error) {
                console.log("Fail to put problem: ", error);
            }
        }
        else{
            try {
                const response = await admin_usersAPI.createUser(data);
                if (response) {
                    history.push('/admin/users/');
                }
            } catch (error) {
                console.log("Fail to post problem: ", error);
            }
        }
    }
    //
    useEffect(() => {
        if (!isNaN(id)) {
            const fetchAnnouncement = async () => {
                try {
                    const response = await admin_usersAPI.getById(id);
                    setUserData(response.data);
                } catch (error) {
                    console.log("fail to alter announcement: ", error);
                }
            };
            fetchAnnouncement();
        }
    }, [])
    return (
        <div className="user-conatiner">
            <AdminNavbar/>
            <Sidebar/>
            <div className="edit-form">
                <Card>
                    <Card.Header as="h3" >
                        Edit
                    </Card.Header>
                    <Card.Body>
                        <Form className="UserForm" onSubmit={handleSubmit(onSubmit)}>
                            <ListGroup.Item className="UserForm-items">
                                <i style={{ color: 'red' }}>*</i>
                                <span>User name</span> <br /> <br />
                                <FormControl
                                    aria-label="Default"
                                    aria-describedby="inputGroup-sizing-default"
                                    value={userData.username}
                                    {...register("username")}
                                />
                            </ListGroup.Item>
                            <ListGroup.Item className="UserForm-items">
                                <i style={{ color: 'red' }}>*</i>
                                <span>Email</span> <br /> <br />
                                <FormControl
                                    aria-label="Default"
                                    aria-describedby="inputGroup-sizing-default"
                                    value={userData.email}
                                    {...register("email")}
                                />
                            </ListGroup.Item>
                            <ListGroup.Item className="UserForm-items">
                                <i style={{ color: 'red' }}>*</i>
                                <span>password</span> <br /> <br />
                                <FormControl
                                    aria-label="Default"
                                    aria-describedby="inputGroup-sizing-default"
                                    {...register("password")}
                                />
                            </ListGroup.Item>
                            <div className="UserForm-items" >
                                <div className="user-select">
                                    <label htmlFor="Admin type">Admin type: </label>
                                    <Form.Control as="select" size="sm" custom {...register("admin_type")} >
                                        <option value="none" defaultValue disabled hidden >{userData.admin_type}</option>
                                        <option value="Regular Users">Regular Users</option>
                                        <option value="Admin">Admin</option>
                                        <option value="Super Admin">Super Admin</option>
                                    </Form.Control>
                                </div>
                                <div className="user-select">
                                    <label htmlFor="Is staff">Is staff: </label>
                                    <Form.Control as="select" size="sm" custom {...register("is_staff")}>
                                        <option value="none" defaultValue disabled hidden >{userData.is_staff}</option>
                                        <option value="true">True</option>
                                        <option value="false">Flase</option>
                                    </Form.Control>
                                </div>
                                <div className="user-select">
                                    <label htmlFor="Problem permission">Problem permission: </label>
                                    <Form.Control as="select" size="sm" custom {...register("problem_permission")}>
                                        <option value="none" defaultValue disabled hidden >{userData.problem_permission}</option>
                                        <option value="None">None</option>
                                        <option value="Own">Own</option>
                                        <option value="All">All</option>
                                    </Form.Control>
                                </div>
           
                            </div>
            
                            <br />
                            <Button type="submit" className="save_button UserForm-items">Save</Button>
                        </Form>
                    </Card.Body>
                </Card>
            </div>
        </div>
    )
}

export default EditUser;
// chưa css