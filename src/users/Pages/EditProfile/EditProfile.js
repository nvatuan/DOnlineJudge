import React, { useState, useEffect } from 'react'
import { Form , Button} from 'react-bootstrap'
import oj_profileAPI from '../../../api/oj_profileAPI';
import './EditProfile.scss';
import { useForm } from 'react-hook-form';
import { useHistory } from 'react-router-dom';
import { logoutUser } from '../../UserSlice';
import { useDispatch } from 'react-redux';
import { toast } from 'react-toastify';

function EditProfile() {
    const [user, setUser] = useState([]);
    const { register, handleSubmit } = useForm();
    const history = useHistory();
    const dispatch = useDispatch();

    useEffect(() => {
        const fetchUserData = async () =>{
            const response = await oj_profileAPI.getUserInformation();
            setUser(response.data);
        }
        fetchUserData();
    }, [])
    const onSubmit = (data) =>{
        try {
            const fetchUserData = async () => {
                const response = await oj_profileAPI.editUserInformation(data);
                setUser(response.data);
                if(response){
                    localStorage.setItem('userInformation', JSON.stringify(response.data));
                    // window.location.reload();
                }
            }
            fetchUserData();
        } catch (error) {
            console.log("fail to change user data", error);
        }
    }
    
    const onSubmitPassword = data =>{
        try {
            const fetchUserData = async () => {
                const response = await oj_profileAPI.changePassword(data);
                if (response) {
                    dispatch(logoutUser());
                    toast.success('goodbye!', {
                        position: toast.POSITION.BOTTOM_CENTER,
                        autoClose: 1500
                    });
                    history.push('/');
                    localStorage.removeItem('token');
                    localStorage.removeItem('role');
                    localStorage.removeItem('username');
                    localStorage.removeItem('userId');
                    localStorage.removeItem('userInformation');
                }
                console.log(response.status);
            }
            fetchUserData();
        } catch (error) {
            console.log("fail to change user data", error.response);
        }
    }
    return (
        <div>
            <div className="panel pages-container">
                <div className="setting-main">
                    <div className="setting-container">
                        <div className="left">
                            <div className="left-items">
                                <p className="section-title">Change User Name</p>
                                <Form onSubmit={handleSubmit(onSubmit)}>
                                    <Form.Group >
                                        <Form.Label>User name</Form.Label>
                                        <Form.Control type="text" placeholder={user.username} {...register("username")}/>
                                    </Form.Group>

                                    <Form.Group>
                                        <Form.Label>First name</Form.Label>
                                        <Form.Control type="text" placeholder={user.first_name} {...register("first_name")}/>
                                    </Form.Group>

                                    <Form.Group>
                                        <Form.Label>Last name</Form.Label>
                                        <Form.Control type="text" placeholder={user.last_name} {...register("last_name")}/>
                                    </Form.Group>

                                    <Button variant="primary" type="submit">
                                        Save
                                    </Button>
                                </Form>
                            </div>  
                        </div>
                        <div className="middle">

                        </div>
                        <div className="right">
                            <div className="right-items">
                                <p className="section-title">Change Password</p>
                                <Form onSubmit={handleSubmit(onSubmitPassword)}>
                                    <Form.Group >
                                        <Form.Label>Current password</Form.Label>
                                        <Form.Control type="password" placeholder="Current password" {...register("old_password")}/>
                                    </Form.Group>

                                    <Form.Group >
                                        <Form.Label>New Password</Form.Label>
                                        <Form.Control type="password" placeholder="New Password" {...register("new_password1")}/>
                                    </Form.Group>

                                    <Form.Group >
                                        <Form.Label>Confirm New Password</Form.Label>
                                        <Form.Control type="password" placeholder="New Password" {...register("new_password2")}/>
                                    </Form.Group>
                                    <Button variant="primary" type="submit">
                                        Save
                                    </Button>
                                </Form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default EditProfile
