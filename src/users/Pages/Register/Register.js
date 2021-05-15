import React, {useState, useEffect} from 'react';
import {Button} from 'react-bootstrap';
import {Modal} from 'react-bootstrap';
import {Form} from 'react-bootstrap';
import { useForm } from 'react-hook-form';
import { useDispatch, useSelector } from 'react-redux';
import { userSelector, clearState,  registerUser } from '../../UserSlice';
import { toast } from 'react-toastify';
import { useHistory } from 'react-router-dom';

function Register(props) {
    //Modal handling
    const [show, setShow] = useState(true);
    const handleClose = () => setShow(false);
    const handleShow = () => setShow(true);


    //redux 

    const dispatch = useDispatch();
    const history = useHistory();
    const { isSuccess, isError, errorMessage } = useSelector(userSelector);

    //form handling
    const { register, handleSubmit } = useForm();
    const onSubmit = (data) => {
        console.log(data);
        dispatch(registerUser(data));
    }

    useEffect(() => {
        return () => {
            dispatch(clearState());
        }
    }, []);

    useEffect(() => {
        if (isError) {
            toast.error(errorMessage, {
                position: toast.POSITION.BOTTOM_CENTER,
                autoClose: 1500
            });
            dispatch(clearState());
        }
        if (isSuccess) {
            toast.success('kanseishitayoo onii-chan', {
                position: toast.POSITION.BOTTOM_CENTER,
                autoClose: 1500
            });
            dispatch(clearState());
            history.push('/');
        }
    }, [isError, isSuccess]);
    const registerModal = (<div>
        <Modal show={show} onHide={handleClose}>
            <Modal.Header closeButton>
                <Modal.Title>Register</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <Form onSubmit={handleSubmit(onSubmit)}>
                    <Form.Group controlId="formBasicEmail">
                        <Form.Control type="text" placeholder="Username" {...register("username")} />
                        <Form.Text className="text-muted">
                        </Form.Text>
                    </Form.Group>
                    <Form.Group controlId="formBasicEmail">
                        <Form.Control type="email" placeholder="Enter email" {...register("email")}/>
                        <Form.Text className="text-muted">
                        </Form.Text>
                    </Form.Group>

                    <Form.Group controlId="formBasicPassword">
                        <Form.Control type="password" placeholder="Password" {...register("password")}/>
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
    </div>);
    return (
        <>
            <Button variant="outline-dark" size="lg" variant="light" onClick={handleShow}>Register</Button>
            {registerModal}
        </>
    );
}

export default Register;