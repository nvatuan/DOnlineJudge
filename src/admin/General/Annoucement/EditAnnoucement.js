import React, {useState} from 'react'
import {Modal, ListGroup, Button} from 'react-bootstrap';
import Editor from '../../editor/Editor';
import './EditAnnoucement.scss';
function EditAnnoucement(props) {
    const {showModal, setShowModal} = props;
    // const [show, setShow] = useState(false);

    const handleClose = () => setShowModal(false);
    const handleShow = () => setShowModal(true);
    return (
        <div>
            <Modal show={showModal} onHide={handleClose} size="lg">
                <Modal.Header closeButton>
                    <Modal.Title>Edit annoucement</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <ListGroup variant="flush">
                        <ListGroup.Item>
                            <i style={{ color: 'red' }}>*</i>
                            <span>Title</span> <br /> <br />
                            <input type="text" autocomplete="off" placeholder="" className="title-input"/>
                        </ListGroup.Item>
                        <ListGroup.Item>
                            <i style={{ color: 'red' }}>*</i>
                            <span> Content</span> <br /> <br />
                            <Editor/>
                        </ListGroup.Item>
                    </ListGroup>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleClose}>
                        Close
          </Button>
                    <Button variant="primary" onClick={handleClose}>
                        Save 
          </Button>
                </Modal.Footer>
            </Modal>
        </div>
    )
}


export default EditAnnoucement

