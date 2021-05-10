import React, { useEffect, useState } from 'react'
import { Button, Card, Form } from 'react-bootstrap';
import styled from 'styled-components';
import oj_problemAPI from '../../../../api/oj_problemAPI';
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
    useEffect(() => {
        const fetchProblem_detail = async () => {
            const response = await oj_problemAPI.getById(id);
            console.log(response.data);
            setProblem(response.data);
        };
        fetchProblem_detail();
    }, [])
    return (
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
                            <Form>
                                <div className="mb-3" className='submit-nav'>
                                    <div className="dropdown-languege">
                                        <form action>
                                            <label htmlFor="languege">Language:</label>
                                            <select name="languege" id="languege">
                                                <option value="Python3">Python3</option>
                                                <option value="Python2">Python2</option>
                                                <option value="Java">Java</option>
                                                <option value="C">C</option>
                                            </select>
                                            <br /><br />
                                        </form>
                                    </div>

                                    <Form.File id="formcheck-api-regular">
                                        <Form.File.Input />
                                    </Form.File>
                                    <div className="submit-textarea">
                                        <Form.Group controlId="exampleForm.ControlTextarea1">
                                            <Form.Control as="textarea" rows={4} />
                                        </Form.Group>
                                    </div>
                                </div>
                            </Form>
                        </Card.Body>
                    </Card>
                </Submit_container>
            </Problem_main>
        </Flex_container>
    )
}


export default Problem_detail

