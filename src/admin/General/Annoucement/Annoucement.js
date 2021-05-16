import React, {useState, useEffect} from 'react'
import PropTypes from 'prop-types'
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { Card, Button , Form} from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDelete } from 'react-icons/ai';
import '../../Table.scss';
import EditAnnoucement from './EditAnnoucement';
import admin_annoucementAPI from '../../../api/annoucementAPI';
import axios from 'axios';
function Annoucement(props) {
    const [showModal, setShowModal] = useState(false);
    const [annoucements, setAnnoucements] = useState([]);

    const openModal = () => {
        setShowModal(!showModal);
    }
    useEffect(() =>{
        const fetchAnnoucement = async () => {
            try {
                const response = await admin_annoucementAPI.getAll();
                console.log(response);
                setAnnoucements(response);
            } catch (error) {
                console.log('Fail to fetch annoucements: ', error);

            }
        }
        fetchAnnoucement();
    },[])
    return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card>
                    <Card.Header as="h4">Annoucements</Card.Header>
                    <Card.Body>
                        <Card.Text>
                            < table >
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Create time</th>
                                        <th>Last update time</th>
                                        <th>Visible</th>
                                        <th>Option</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {
                                        annoucements.length > 0 ? (
                                            annoucements.map((annoucement) => (
                                                <tr key={annoucement.id}>
                                                    <td>{annoucement.id}</td>
                                                    <td>{annoucement.title}</td>
                                                    <td>{annoucement.creation_time}</td>
                                                    <td>{annoucement.last_update_time}</td>
                                                    <td>{annoucement.author}</td>
                                                    <td>
                                                        <Form.Check
                                                            type="switch"
                                                            id="custom-switch"
                                                        />
                                                    </td>
                                                    <td>
                                                        <div className="option-cell">
                                                            <div className="option-button">
                                                                <div className="option-button">
                                                                    <Button variant="light" onClick={openModal}>
                                                                        <AiOutlineEdit />
                                                                        <EditAnnoucement showModal={showModal} setShowModal={setShowModal}/>
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
                                                <td colSpan={6}>Nothing</td>
                                            </tr>
                                        )
                                    }
                                </tbody>
                            </table >
                        </Card.Text>
                        <Button variant="primary">Create</Button>
                    </Card.Body>
                </Card>
            </div>
        </div>
    )
}

Annoucement.propTypes = {

}

export default Annoucement

