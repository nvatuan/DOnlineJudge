import React, {useState} from 'react'
import PropTypes from 'prop-types'
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { Card, Button , Form} from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDelete } from 'react-icons/ai';
import '../../Table.scss';
import EditAnnoucement from './EditAnnoucement';
function Annoucement(props) {
    const [showModal, setShowModal] = useState(false);
    const Annoucements = [
        {
            id: 1,
            title: "Alo",
            create_time: "2021-5 - 1 15: 35: 50",
            last_update_time: "2021-5-1 15:35:50",
            author: "root",
            visible: true,
        }
    ]

    const openModal = () => {
        setShowModal(!showModal);
    }
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
                                        Annoucements.length > 0 ? (
                                            Annoucements.map((Annoucement) => (
                                                <tr key={Annoucement.id}>
                                                    <td>{Annoucement.id}</td>
                                                    <td>{Annoucement.title}</td>
                                                    <td>{Annoucement.create_time}</td>
                                                    <td>{Annoucement.last_update_time}</td>
                                                    <td>{Annoucement.author}</td>
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

