import React, {useState} from 'react';
import PropTypes from 'prop-types';
import {Button} from 'react-bootstrap';
import {Modal} from 'react-bootstrap';
import {Form} from 'react-bootstrap';
import Register from '../Register/Register';

function Signin(props) {
    
    const [show, setShow] = useState(false);
    const [showRegis, setShowRegis] = useState(false);
    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);
    const handleOnClickRegister = () => {
        setShowRegis(!showRegis);
        console.log(showRegis);
    };

    return (
        showRegis ? <Register/> : 
    <div>
        <Button variant="outline-dark" size="lg" variant="light" onClick={handleShow}>Login</Button>
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Login</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <Form>
                    <Form.Group controlId="formBasicEmail">
                        <Form.Label>Email address</Form.Label>
                        <Form.Control type="email" placeholder="Enter email" />
                        <Form.Text className="text-muted">
                        </Form.Text>
                    </Form.Group>

                    <Form.Group controlId="formBasicPassword">
                        <Form.Label>Password</Form.Label>
                        <Form.Control type="password" placeholder="Password" />
                    </Form.Group>
                    <Button variant="primary" type="submit">
                        Login
                    </Button>
                </Form>
            </Modal.Body>

            <Modal.Footer>
                <Button onClick={handleOnClickRegister}>No account? Register now!</Button>
            </Modal.Footer>
        </Modal>

    </div>
    );
}

export default Signin;