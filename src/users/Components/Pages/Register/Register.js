import React, {useState} from 'react';
import {Button} from 'react-bootstrap';
import {Modal} from 'react-bootstrap';
import {Form} from 'react-bootstrap';
import { AiOutlineUser } from "react-icons/ai";

function Register(props) {
    
    const [show, setShow] = useState(true);

    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);
    return (
        <div>
            <Modal show={show} onHide={handleClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Register</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                <Form>
                    <Form.Group controlId="formBasicEmail">
                        <Form.Control type="text" placeholder="Username" />
                        <Form.Text className="text-muted">
                        </Form.Text>
                    </Form.Group>
                    <Form.Group controlId="formBasicEmail">
                        <Form.Control type="email" placeholder="Enter email" />
                        <Form.Text className="text-muted">
                        </Form.Text>
                    </Form.Group>

                    <Form.Group controlId="formBasicPassword">
                        <Form.Control type="password" placeholder="Password" />
                    </Form.Group>
                    <Form.Group controlId="formBasicPassword">
                        <Form.Control type="password" placeholder="Password Again" />
                    </Form.Group>
                    <Button variant="primary" type="submit">
                        Register
                    </Button>

                </Form>

                </Modal.Body>
                <Modal.Footer>
                    <Button variant="outline-primary" >
                        Already registed? Login now!
                    </Button>
                </Modal.Footer>
            </Modal>
            
        </div>

    );
}

export default Register;