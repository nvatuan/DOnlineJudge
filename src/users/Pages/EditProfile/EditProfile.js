import React, { useState, useEffect } from 'react'
import { Form , Button} from 'react-bootstrap'
import oj_profileAPI from '../../../api/oj_profileAPI';
import './EditProfile.scss';
import { useForm } from 'react-hook-form';
function EditProfile() {
    const [user, setUser] = useState([]);
    const { register, handleSubmit } = useForm();
    useEffect(() => {
        const fetchUserData = async () =>{
            const response = await oj_profileAPI.getUserInformation();
            setUser(response.data);
        }
        fetchUserData();
        return () => {
        }
    }, [])
    const onSubmit = (data) =>{
        try {
            const fetchUserData = async () => {
                const response = await oj_profileAPI.editUserInformation(data);
                setUser(response.data);
                if(response){
                    window.location.reload();
                }
            }
            fetchUserData();
        } catch (error) {
            console.log("fail to change user data", error);
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
                                <Form>
                                    <Form.Group >
                                        <Form.Label>Current password</Form.Label>
                                        <Form.Control type="password" placeholder="Current password" />
                                    </Form.Group>

                                    <Form.Group >
                                        <Form.Label>New Password</Form.Label>
                                        <Form.Control type="password" placeholder="New Password" />
                                    </Form.Group>

                                    <Form.Group >
                                        <Form.Label>Confirm New Password</Form.Label>
                                        <Form.Control type="password" placeholder="New Password" />
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
