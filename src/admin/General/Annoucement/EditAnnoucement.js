import React, { useState, useEffect, useRef} from 'react'
import { Card, ListGroup, Button, Form, FormControl } from 'react-bootstrap';
import './EditAnnoucement.scss';
import admin_announcementAPI from '../../../api/admin_announcementAPI';
import { useForm } from 'react-hook-form';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { useHistory } from 'react-router-dom'; 

//
function EditAnnoucement({match}) {
    const id = match.params.id;
    const [title, setTitle] = useState('');
    const [content, setContent] = useState('');
    const { register, handleSubmit } = useForm();
    const history = useHistory();

    const handleTitle = (e) =>{
        const value = e.target.value;
        setTitle(value);
    }
    const handleContent = (e) =>{
        const value = e.target.value;
        setContent(value);
    }
    const onSubmit = async (formData) => {
        formData.title = title;
        formData.content = content;
        if(!isNaN(id)){
            try {
                const response = await admin_announcementAPI.updateById({ formData, id });

                if (response) {
                    history.push('/admin/announcement/');
                }
            } catch (error) {
                console.log("Fail to put problem: ", error);
            }
        }
        else{
            try {
                const response = await admin_announcementAPI.createAnnouncemt(formData);
                if (response) {
                    history.push('/admin/announcement/');
                }
            } catch (error) {
                console.log("Fail to post problem: ", error);
            }
        }

    };
    useEffect(() => {
        if(!isNaN(id)){
            const fetchAnnouncement = async () => {
                try {
                    const response = await admin_announcementAPI.getById(id);
                    setTitle(response.data.title);
                    setContent(response.data.content);
                } catch (error) {
                    console.log("fail to alter announcement: ", error);
                }
            };
            fetchAnnouncement();
        }
    },[])
    return (
        <div className="announcements-container">
            <AdminNavbar />
            <Sidebar/>
            <div className="edit_form">
                <Card>
                    <Card.Header as="h3">Edit</Card.Header>
                    <Card.Body>
                        <Form onSubmit={handleSubmit(onSubmit)} className="announForm">
                            <ListGroup.Item className="announForm-items">
                                <i style={{ color: 'red' }}>*</i>
                                <span>Title</span> <br /> <br />
                                {/* <input type="text" placeholder="" className="title-input" v /> */}
                                <FormControl
                                    aria-label="Default"
                                    aria-describedby="inputGroup-sizing-default"
                                    {...register("title")}
                                    value={title}
                                    onChange={(e) => { handleTitle(e) }}
                                />
                            </ListGroup.Item>
                            <ListGroup.Item className="announForm-items">
                                <i style={{ color: 'red' }}>*</i>
                                <span> Content</span> <br /> <br />
                                <Form.Control as="textarea" rows={10} cols={150} {...register("content")} 
                                    value={content} onChange={(e) => { handleContent(e) }}>
                                </Form.Control>
                            </ListGroup.Item>
                            <br />
                            <Button type="submit" className="save_button">Save</Button>
                        </Form>
                    </Card.Body>
                </Card>
                
            </div>
        </div>
    )
}


export default EditAnnoucement;

