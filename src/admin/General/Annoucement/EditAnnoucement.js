import React, {useState, useEffect} from 'react'
import { Card, ListGroup, Button, Form } from 'react-bootstrap';
import Editor from '../../editor/Editor';
import { AiOutlineEdit } from 'react-icons/ai';
import './EditAnnoucement.scss';
import admin_announcementAPI from '../../../api/admin_announcementAPI';
import { useForm } from 'react-hook-form';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
function EditAnnoucement({match}) {
    const id = match.params.id;
    const [title, setTitle] = useState('');
    const [content, setContent] = useState('');
    const [show, setShow] = useState(true);
    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);

    const { register, handleSubmit, error } = useForm();
    const onSubmit = async (data) => {
        // try {
        //     const response = await admin_announcementAPI.(data);

        //     if (response) {
        //         history.push('admin/announcement/');
        //     }
        // } catch (error) {
        //     console.log("Fail to post problem: ", error);
        // }

    };
    const handleTitle = (e) =>{
        const value = e.target.value;
        setTitle(value);
    }
    useEffect(() => {
        const fetchAnnouncement = async () => {
            try {
                const response = await admin_announcementAPI.getById(id);
                console.log(response.data);
                setTitle(response.data.title);
                setContent(response.data.content);
            } catch (error) {
                console.log("fail to alter announcement: ", error);
            }
        };
        fetchAnnouncement();
    },[])
    return (
        <div className="announcements-container">
            <AdminNavbar />
            <Sidebar/>
            <div className="edit_form">
                <Card>
                    <Card.Header as="h3">Edit</Card.Header>
                    <Card.Body>
                        <Form >
                            <ListGroup.Item>
                                <i style={{ color: 'red' }}>*</i>
                                <span>Title</span> <br /> <br />
                                <input type="text" placeholder="" className="title-input" />
                            </ListGroup.Item>
                            <ListGroup.Item>
                                <i style={{ color: 'red' }}>*</i>
                                <span> Content</span> <br /> <br />
                                <Editor />
                            </ListGroup.Item>

                            <Button>Save</Button>
                        </Form>
                    </Card.Body>
                </Card>
                
            </div>
        </div>
    )
}


export default EditAnnoucement;

