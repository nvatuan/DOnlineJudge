import React, { useState, useEffect } from 'react'
import { Card, ListGroup, Button, Form, FormControl } from 'react-bootstrap';
import './EditAnnouncement.scss';
import admin_announcementAPI from '../../../api/admin_announcementAPI';
import { useForm } from 'react-hook-form';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { useHistory } from 'react-router-dom';
import Switch from 'react-switch';
import { Link } from 'react-router-dom';
import { BiLeftArrowAlt } from 'react-icons/bi';

//
function EditAnnouncement({ match }) {
    const id = match.params.id;
    var cardTitle = (id===undefined?'New Announcement':'Edit Announcement #'+id)

    const [title, setTitle] = useState(() => {
        const initTitle = localStorage.getItem('ann_title') || '';
        return initTitle;
    });
    const [content, setContent] = useState(() => {
        const initCotent = localStorage.getItem('ann_content') || '';
        return initCotent;
    });
    const [visible, setVisible] = useState(true);
    const { register, handleSubmit } = useForm();
    const history = useHistory();

    const handleTitle = (e) => {
        const value = e.target.value;
        setTitle(value);
        localStorage.setItem('ann_title', value)
    }
    const handleContent = (e) => {
        const value = e.target.value;
        setContent(value);
        localStorage.setItem('ann_content', value)
    }
    const onSubmit = async (formData) => {
        formData.title = title;
        formData.content = content;
        formData.is_visible = visible;
        if (!isNaN(id)) {
            try {
                const response = await admin_announcementAPI.updateById({ formData, id });

                if (response) {
                    history.push('/admin/announcement/');
                }
            } catch (error) {
                console.log("Fail to put problem: ", error);
            }
        }
        else {
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
        if (!isNaN(id)) {
            const fetchAnnouncement = async () => {
                try {
                    const response = await admin_announcementAPI.getById(id);
                    setTitle(response.data.title);
                    setContent(response.data.content);
                    setVisible(response.data.is_visible);
                } catch (error) {
                    console.log("fail to alter announcement: ", error);
                }
            };
            fetchAnnouncement();
        }
    }, [id])
    const updateVisibility = () => {
        setVisible(!visible);
    }
    return (
        <div className="announcements-container">
            <AdminNavbar />
            <Sidebar />
            <div className="edit_form">
                <Card>
                    <Card.Header as="h3">
                        {cardTitle}
                        <div className="">
                            <Link to={`/admin/announcement`}  className="card-header-btn"> <BiLeftArrowAlt/> Back </Link>
                        </div>
                    </Card.Header>
                    <Card.Body>
                        <Form onSubmit={handleSubmit(onSubmit)} className="announForm">
                            <ListGroup.Item className="announForm-items">
                                <i style={{ color: 'red' }}>*</i>
                                <span>Title</span> <br /> <br />
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
                            <label htmlFor="">Visible</label>
                            <br />
                            <Switch checked={visible} onChange={() => updateVisibility()} />
                            <br />
                            <hr />
                            <Button type="submit" className="save_button">Save</Button>
                        </Form>
                    </Card.Body>
                </Card>

            </div>
        </div>
    )
}


export default EditAnnouncement;

