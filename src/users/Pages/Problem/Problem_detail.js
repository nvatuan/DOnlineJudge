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
import { UnControlled as CodeMirror } from 'react-codemirror2';
import 'katex/dist/katex.min.css'
import Latex from 'react-latex-next'
import { toast } from 'react-toastify';
require('codemirror/lib/codemirror.css');
require('codemirror/theme/material.css');
require('codemirror/theme/neat.css');
require('codemirror/mode/xml/xml.js');
require('codemirror/mode/python/python.js');
require('codemirror/mode/clike/clike.js');
require('codemirror/mode/javascript/javascript.js');

function Problem_detail({ match }) {
    const id = match.params.id;
    const [problem, setProblem] = useState([]);
    const history = useHistory();
    //check login
    const [checkLogin, setCheckLogin] = useState(false);
    //check content
    const [content, setContent] = useState('');
    const { register, handleSubmit, error } = useForm();
    const [sample_test, setSample_test] = useState([])
    //
    const [language, setLanguage] = useState('Python3');
    function onChangeUploadFile(e) {
        let files = e.target.files;
        let reader = new FileReader();
        reader.readAsText(files[0]);
        reader.onload = (e) => {
            setContent(e.target.result);
        }

    }
    function onChangeTextarea(editor, data, value) {
        setContent(value);
    }
    const onSubmit = async (data) => {
        data.content = content;
        data.problem_id = parseInt(data.problem_id);
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

    function copyToClipboard(element) {
        let copyText = document.getElementById(element);
        copyText.select();
        document.execCommand("copy");
        toast.success('Copied', {
            position: toast.POSITION.BOTTOM_CENTER,
            autoClose: 1000,
        });
    }
    const LaTeX = 'We give illustrations for the three processes $e^+e^-$, gluon-gluon and $\\gamma\\gamma \\to W t\\bar b$.'
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
                            <br />
                            <Latex className="description">{getDescription(problem.statement)}</Latex>
                            <br /> <br />
                            <strong>Input Description:</strong>
                            <br />
                            <Latex className="input_description">{getInput_description(problem.statement)}</Latex>
                            <br /> <br />
                            <strong>Output Description:</strong>
                            <br />
                            <Latex className="output_description">{getOutput_description(problem.statement)}</Latex>
                            <br /> <br />
                            <strong>Sample Test:</strong>
                            <br />
                            {
                                sample_test.map((sample, idx) => {
                                    return (

                                        <div className="pd__sample" key={`${sample}-${idx}`}>

                                            <div className="input-header">
                                                <div>Input {idx + 1}</div>
                                                <Form.Control id={`input_${idx}`} as="textarea" cols={150} readOnly
                                                    className="textArea"
                                                    value={sample.input || ""}
                                                >
                                                </Form.Control>
                                                <button className="copy-btn" onClick={() => copyToClipboard(`input_${idx}`)}>copy</button>
                                            </div>



                                            <div className="input-header">
                                                <div>Output {idx + 1}</div>
                                                <Form.Control id={`output_${idx}`} as="textarea" cols={150} readOnly
                                                    className="textArea"
                                                    value={sample.output || ""}
                                                >
                                                </Form.Control>
                                                <button className="copy-btn" onClick={() => copyToClipboard(`output_${idx}`)}>copy</button>
                                            </div>
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
                                        <Form.Control as="select" size="sm" custom {...register("language")} onChange={(e) => setLanguage(e.target.value)}>
                                            <option value="Python3">Python3</option>
                                            <option value="Python2">Python2</option>
                                            <option value="Java">Java</option>
                                            <option value="Cpp">C++</option>
                                            <option value="C">C</option>
                                        </Form.Control>
                                        <br /><br />
                                    </div>
                                    <div className="problem-id submit-nav__item">
                                        <Form.Label></Form.Label>
                                        <Form.Control
                                            type="hidden"
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
                                <div className="editor-container">
                                    <CodeMirror
                                        value={content}
                                        onChange={(editor, data, value) => { onChangeTextarea(editor, data, value) }}
                                        options={{
                                            matchBrackets: true,
                                            styleActiveLine: true,
                                            theme: "material",
                                            mode: {
                                                'Python3': 'python',
                                                'Python2': 'python',
                                                'Java': 'text/x-java',
                                                'C': 'text/x-csrc',
                                                'Cpp': 'text/x-c++src',
                                            }[language],
                                            lineNumbers: true,
                                        }}
                                    />
                                </div>

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
                                <AiOutlineAlignLeft className="to_statusPage_card-item " />
                                <p>Submissions</p>
                            </Link>
                        </Card.Body>
                    </Card>
                    <div className="problem-information">
                        <Card className="right-column__item">
                            <Card.Header className="problem-information_header"><GrCircleInformation /><p> Information</p></Card.Header>
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

