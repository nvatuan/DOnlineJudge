import React, { useEffect, useState } from 'react'
import { Button, Card, Form, ListGroup} from 'react-bootstrap';
import {useForm} from 'react-hook-form';
import './Problem_detail.scss';
import oj_statusAPI from '../../../api/oj_statusAPI';
import oj_problemAPI from '../../../api/oj_problemAPI';
import Navbar from '../../Navbar'
import { AiOutlineAlignLeft } from 'react-icons/ai'
import { GrCircleInformation } from 'react-icons/gr'
import { Link, Redirect, useHistory } from 'react-router-dom';

//code mirror editor 
import { UnControlled as CodeMirror } from 'react-codemirror2';
require('codemirror/lib/codemirror.css');
require('codemirror/theme/material.css');
require('codemirror/theme/neat.css');
require('codemirror/mode/xml/xml.js');
require('codemirror/mode/javascript/javascript.js');

function Problem_detail({ match }) {
    const id = match.params.id;
    const [problem, setProblem] = useState([]); 
    const history = useHistory();   
    //check login
    const [checkLogin, setCheckLogin] = useState(false);
    
    const {register, handleSubmit, error} = useForm();

    const onSubmit = async (data) => {
        data.problem_id = parseInt(data.problem_id);
        try {
            const response = await oj_statusAPI.postProblem(data);
            if(response) {
                history.push('/status');
            }
        } catch (error) {
            console.log("Fail to post problem: ", error);
        }

    };

    useEffect(() => {
        const fetchProblem_detail = async () => {
            const response = await oj_problemAPI.getById(id);
            setProblem(response.data);
            //check login
            if(localStorage.getItem('token') !== null) setCheckLogin(true);
            else setCheckLogin(false);
        };
        fetchProblem_detail();
    }, [])
    return (
        <div>
            <Navbar/>
            <div className="problem_detail-flex-container">
                <div className="problem-main">
                <Card className="problem-main__item">
                    <Card.Header as="h3">{problem.title}</Card.Header>
                    <Card.Body>
                        {problem.statement}
                    </Card.Body>
                </Card>
                <Card className="problem-main__item">
                    <Card.Body>
                        <Form onSubmit={handleSubmit(onSubmit)}>
                            <div className='submit-nav'>
                                <div className="dropdown-languege submit-nav__item">
                                    <label htmlFor="languege">Language: </label>
                                    <select name="languege" id="languege" {...register("language")}>
                                        <option value="Python3">Python3</option>
                                        <option value="Python2">Python2</option>
                                        <option value="Java">Java</option>
                                        <option value="C">C</option>
                                    </select>
                                    <br /><br />
                                </div>
                                    <div className="problem-id submit-nav__item">
                                    <label>Problem id: </label>
                                    <input type="text" placeholder="Problem id" value={id} {...register("problem_id")} />
                                    </div>
                                    <Form.File id="formcheck-api-regular" className="submit-nav__item">
                                        <Form.File.Input />
                                    </Form.File>
                            </div>
                            <Form.Control as="textarea" rows={5} cols={5} {...register("content")}/>
                                    
                            <br/>
                            <div className="problem-main__footer">
                                   {checkLogin === true ? (
                                        <Button variant="primary" type="submit" id="submit-button" >Submit</Button>
                                   ) : 
                                   (
                                            <Button href="#" variant="secondary" disabled id="disable-button">
                                            Submit
                                        </Button>
                                   )}
                            </div>
                        </Form>
                    </Card.Body>
                </Card>
               </div>
               <div className="right-column">
                    <Card className="submit-card right-column__item">
                        <Card.Body>
                            <Link to='/status' className='to_statusPage_card'>
                                <AiOutlineAlignLeft /><h7>Submissions</h7>
                            </Link>
                        </Card.Body>
                    </Card>
                    <div className="problem-information">
                        <Card className="right-column__item">
                            <Card.Header><GrCircleInformation /><h7> Imformation</h7></Card.Header>
                            <ListGroup variant="flush">
                                <ListGroup.Item className="problem-information__item">
                                    <p>Id</p>
                                    <p>{problem.id}</p>
                                </ListGroup.Item>
                                <ListGroup.Item className="problem-information__item">
                                    <p>Time Limit</p>
                                    <p>{problem.time_limit} ms</p>
                                </ListGroup.Item>
                                <ListGroup.Item className="problem-information__item">
                                    <p>Memory Limit</p>
                                    <p>{problem.memory_limit} mb</p>
                                </ListGroup.Item>
                                <ListGroup.Item className="problem-information__item">
                                    <p>Create by</p>
                                    <p>{problem.author}</p>
                                </ListGroup.Item>
                                <ListGroup.Item className="problem-information__item">
                                    <p>Level</p>
                                    <p>{problem.difficulty}</p>
                                </ListGroup.Item>
                            </ListGroup>
                        </Card>
                    </div>
               </div>
            </div>
        </div>
    )
}


export default Problem_detail

