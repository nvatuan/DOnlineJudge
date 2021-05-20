import React, { useState, useEffect } from 'react';
import { Button, Form, Modal } from 'react-bootstrap';
import Register from '../Register/Register';
import { useForm } from 'react-hook-form';
import { useDispatch, useSelector } from 'react-redux';
import { useHistory } from 'react-router-dom';
import { userSelector, clearState, loginUser } from '../../UserSlice';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
function Signin(props) {
    //toast 
    toast.configure();
    //for Modal
    const [show, setShow] = useState(false);
    const [showRegis, setShowRegis] = useState(false);
    const handleClose = () => setShow(false);
    const handleShow = () => { 
        console.log(show);
        setShow(true);
    };
    const handleOnClickRegister = () => {
        setShowRegis(!showRegis);
    };

    //for redux
    const dispatch = useDispatch();
    const history = useHistory();
    const { isLoginSuccess, isLoginError, errorMessage } = useSelector(userSelector);


    const { register, handleSubmit } = useForm();
    const onSubmit = (data) => {
        dispatch(loginUser(data));
    }

    useEffect(() => {
        return () => {
            console.log('login unmount');
            dispatch(clearState());
        }
    }, []);

    useEffect(() => {
        if (isLoginError) {
            toast.error(errorMessage, {
                position: toast.POSITION.BOTTOM_CENTER,
                autoClose: 1500
            });
            dispatch(clearState());
        }
        if (isLoginSuccess){
            toast.success('Ohayo onii-chan', {
                position: toast.POSITION.BOTTOM_CENTER,
                autoClose: 1500 
            });
            dispatch(clearState());
            history.push('/problem/');
        }
    }, [isLoginSuccess, isLoginError]);

    const LoginModal = (
        <div>
            <Modal show={show} onHide={handleClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Login</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    <Form onSubmit={handleSubmit(onSubmit)}>
                        <Form.Group controlId="formBasicEmail">
                            <Form.Label>Username </Form.Label>
                            <Form.Control type="text" placeholder="Username" {...register("username")} />
                            <Form.Text className="text-muted">
                            </Form.Text>
                        </Form.Group>

                        <Form.Group controlId="formBasicPassword">
                            <Form.Label>Password</Form.Label>
                            <Form.Control type="password" placeholder="Password" {...register("password")} />
                        </Form.Group>
                        <Button variant="primary" type="submit">
                            Login
                            </Button>
                    </Form>
                </Modal.Body>

                {/* <Modal.Footer>
                    <Button onClick={handleOnClickRegister}>No account? Register now!</Button>
                </Modal.Footer> */}
            </Modal>

        </div>
    );
    return (
        <>
            <Button variant="outline-dark" size="lg" variant="light" onClick={handleShow}>Login</Button>
            {showRegis ? <Register setShowRegis={setShowRegis}/> : LoginModal}
        </>
    );
}

export default Signin;