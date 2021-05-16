import React, { useEffect, useState } from 'react'
import { Button, Card, Form } from 'react-bootstrap';
import styled from 'styled-components';
import {useForm} from 'react-hook-form';
import './Problem_detail.scss';
import oj_statusAPI from '../../../api/oj_statusAPI';
import oj_problemAPI from '../../../api/oj_problemAPI';
import Navbar from '../../Navbar'
const Flex_container = styled.div`
    display: flex;
    width: 100%;
    max-width: 100%;
    justify-content: space-around;
    align-items: flex-start;
    flex-flow: row nowrap;    
`;

const Problem_main = styled.div`
    flex: auto;
    margin-right: 18px;
`;

const Problem_imformation = styled.div`
    flex: auto;
    margin-right: 18px;
`;

const Submit_container = styled.div`
    margin-top: 20px;
    margin-bottom: 20px;
`;
function Problem_detail({ match }) {
    const id = match.params.id;
    const [problem, setProblem] = useState([]);    
    const {register, handleSubmit, error} = useForm();

    const onSubmit = async (data) => {
        data.problem_id = parseInt(data.problem_id);
        try {
            const response = await oj_statusAPI.postProblem(data);
        } catch (error) {
            console.log("Fail to post problem: ", error);
        }

    };


    useEffect(() => {
        const fetchProblem_detail = async () => {
            const response = await oj_problemAPI.getById(id);
            setProblem(response.data);
        };
        fetchProblem_detail();
    }, [])
    return (
        <div>
            <Navbar/>
            <Flex_container>
                <Problem_main>
                    <Problem_imformation>
                        <Card>
                            <Card.Header as="h3">{problem.title}</Card.Header>
                            <Card.Body>
                                {problem.statement}
                            </Card.Body>
                        </Card>
                    </Problem_imformation>
                    <Submit_container>
                        <Card>
                            <Card.Body>
                                <Form onSubmit={handleSubmit(onSubmit)}>
                                    <div className="mb-3" className='submit-nav'>
                                        <div className="dropdown-languege">
                                            <label htmlFor="languege">Language:</label>
                                            <select name="languege" id="languege" {...register("language")}>
                                                <option value="Python3">Python3</option>
                                                <option value="Python2">Python2</option>
                                                <option value="Java">Java</option>
                                                <option value="C">C</option>
                                            </select>
                                            <br /><br />
                                        </div>
                                        <div className="problem-id">
                                            <label>Problem id: </label>
                                            <input type="text" placeholder="Problem id" value={id} {...register("problem_id")} />
                                        </div>
                                        <Form.File id="formcheck-api-regular">
                                            <Form.File.Input />
                                        </Form.File>

                                    </div>
                                    <div className="submit-textarea">
                                        <textarea rows="4" cols="150" {...register("content")}>

                                        </textarea>
                                    </div>
                                    <Button variant="primary" type="submit">
                                        Submit
                                </Button>
                                </Form>
                            </Card.Body>
                        </Card>
                    </Submit_container>
                </Problem_main>
            </Flex_container>
        </div>
    )
}


export default Problem_detail

