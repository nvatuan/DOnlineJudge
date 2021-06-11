import React, { useEffect, useState } from 'react'
import { Button, Card, Form, ListGroup } from 'react-bootstrap';
import { useForm } from 'react-hook-form';
import './Problem_detail.scss';
import oj_statusAPI from '../../../api/oj_statusAPI';
import oj_problemAPI from '../../../api/oj_problemAPI';
import Navbar from '../../Navbar'
import { AiOutlineAlignLeft } from 'react-icons/ai'
import { GrCircleInformation } from 'react-icons/gr'
import { Link, useHistory } from 'react-router-dom';
import { render } from '@testing-library/react';

function Problem_detail({ match }) {
    // console.log("render")

    const id = match.params.id;
    const [problem, setProblem] = useState([]);
    const history = useHistory();
    //check login
    const [checkLogin, setCheckLogin] = useState(false);
    //check content
    const [content, setContent] = useState('');
    const { register, handleSubmit, error } = useForm();
    const [sample_test, setSample_test] = useState([])

    function onChangeUploadFile(e) {
        let files = e.target.files;
        let reader = new FileReader();
        reader.readAsText(files[0]);
        reader.onload = (e) => {
            setContent(e.target.result);
        }

    }
    function onChangeTextarea(e) {
        setContent(e.target.value);
    }
    const onSubmit = async (data) => {
        data.content = content;
        data.problem_id = parseInt(data.problem_id);
        // alert(JSON.stringify(data))
        try {
            const response = await oj_statusAPI.postProblem(data);

            if (response) {
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
            if (JSON.stringify(response.data.sample_test) === JSON.stringify({})) {
                setSample_test([])
            }
            else {
                setSample_test(response.data.sample_test)
            }
            //check login
            if (localStorage.getItem('token') !== null) setCheckLogin(true);
            else setCheckLogin(false);
        };
        fetchProblem_detail();
    }, [])

    useEffect(() => {
        return () => console.log('unmounting...');
    }, [content])
    function getDescription(str) {
        str = String(str)
        let i = str.indexOf('Input')
        if (i >= 0) {
            return str.slice(0, i)
        }
        else return str
    }
    function getInput_description(str) {
        str = String(str)
        let i = str.indexOf('Input')
        let o = str.indexOf('Output')
        if (i >= 0 && o > i) {
            return str.slice(i + 6, o)
        }
        else return ''
    }
    function getOutput_description(str) {
        str = String(str)
        let o = str.indexOf('Output')
        if (o >= 0) {
            return str.slice(o + 7)
        }
        else return ''
    }



    return (
        <div>
            <Navbar />
            <div className="problem_detail-flex-container pages-container">
                <div className="problem-main">
                    <Card className="problem-main__item">
                        <Card.Header as="h3">{problem.title}</Card.Header>
                        <Card.Body>
                            <h2 className="title">{problem.title}</h2>
                            <p className="time_limit"><strong>Time limit:</strong> {problem.time_limit} ms</p>
                            <p className="memory_limit"><strong>Memory limit:</strong> {problem.memory_limit} mb</p>
                            <br />
                            <strong>Problem Description:</strong>
                            <p className="description">{getDescription(problem.statement)}</p>
                            <br /> <br />
                            <strong>Input Description:</strong>
                            <br />
                            <p className="input_description">{getInput_description(problem.statement)}</p>
                            <br /> <br />
                            <strong>Output Description:</strong>
                            <br />
                            <p className="output_description">{getOutput_description(problem.statement)}</p>
                            <br /> <br />
                            <strong>Sample Test:</strong>
                            <br />
                            {
                                sample_test.map((sample, idx) => {
                                    return (

                                        <div key={`${sample}-${idx}`}>

                                            <tr>
                                                <td>
                                                    <i style={{ color: 'red' }}>*</i>
                                                    <span> Input</span> <br />
                                                    <Form.Control as="textarea" rows={5} cols={150}
                                                        className="textArea"
                                                        value={sample.input || ""}
                                                    >
                                                    </Form.Control>
                                                </td>
                                                <td>
                                                    <i style={{ color: 'red' }}>*</i>
                                                    <span> Output</span> <br />
                                                    <Form.Control as="textarea" rows={5} cols={150}
                                                        className="textArea"
                                                        value={sample.output || ""}
                                                    >
                                                    </Form.Control>
                                                </td>

                                            </tr>

                                        </div>
                                    );
                                })}




                        </Card.Body>
                    </Card>
                    <Card className="problem-main__item">
                        <Card.Body>
                            <Form onSubmit={handleSubmit(onSubmit)}>
                                <div className='submit-nav'>
                                    <div className="dropdown-languege submit-nav__item">
                                        <label htmlFor="languege">Language: </label>
                                        <Form.Control as="select" size="sm" custom {...register("language")}>
                                            <option value="Python3">Python3</option>
                                            <option value="Python2">Python2</option>
                                            <option value="Java">Java</option>
                                            <option value="C">C</option>
                                        </Form.Control>
                                        <br /><br />
                                    </div>
                                    <div className="problem-id submit-nav__item">
                                        <Form.Label>Problem </Form.Label>
                                        <Form.Control
                                            type="text"
                                            size="sm"
                                            value={id}
                                            {...register("problem_id")}
                                        />
                                    </div>
                                    <div className="upload_file">
                                        <Form.File id="formcheck-api-regular">
                                            <Form.File.Input onChange={(e) => { onChangeUploadFile(e) }} />
                                        </Form.File>
                                    </div>

                                </div>
                                <Form.Control as="textarea" rows={10} cols={5} {...register("content")} value={content} onChange={(e) => { onChangeTextarea(e) }}>
                                </Form.Control>

                                <br />
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
                                <AiOutlineAlignLeft /><p>Submissions</p>
                            </Link>
                        </Card.Body>
                    </Card>
                    <div className="problem-information">
                        <Card className="right-column__item">
                            <Card.Header><GrCircleInformation /><p> Imformation</p></Card.Header>
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

