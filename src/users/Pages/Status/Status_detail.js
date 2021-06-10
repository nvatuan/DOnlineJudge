import React, { useState, useEffect } from 'react'
import Navbar from '../../Navbar';
import { Card } from 'react-bootstrap';
import oj_statusAPI from '../../../api/oj_statusAPI';
import './Status_detail.scss';
//code mirror editor 
import { UnControlled  as CodeMirror } from 'react-codemirror2';
require('codemirror/lib/codemirror.css');
require('codemirror/theme/material.css');
require('codemirror/theme/neat.css');
require('codemirror/mode/xml/xml.js');
require('codemirror/mode/javascript/javascript.js');


function Status_detail({ match }) {
    const id = match.params.id;
    const [status_detail, setStatus_detail] = useState({});
    useEffect(() => {
        const fetchStatus_detail = async () => {
            const response = await oj_statusAPI.getById(id);
            setStatus_detail(response.data);
        };
        fetchStatus_detail();
    },[])
    return (
        <div>
            <Navbar/>
            <div className="status_details-container pages-container">
                <h2>Submission #{id}</h2>
                <hr />
                <div className="source-code status_details-container__item">
                    <Card>
                        <Card.Header as="h3">Source code</Card.Header>
                        <Card.Body>
                            <div className="editor-container">
                                <CodeMirror
                                    value={status_detail.content}
                                    options={{
                                        mode: 'xml',
                                        theme: 'default',
                                        lineNumbers: true,
                                        readOnly: true,
                                        readOnly: 'nocursor'
                                    }}
                                />
                            </div>
                        </Card.Body>
                    </Card>
                </div>
                <div className="sumitssion_infor status_details-container__item">
                    <Card>
                        <Card.Header as="h3" >Submission Info</Card.Header>
                        <Card.Body>
                            <table>
                                <tbody>
                                    <tr>
                                        <td>Submission Time</td>
                                        <td>{status_detail.submit_time}</td>
                                    </tr>
                                    <tr>
                                        <td>Task</td>
                                        <td>{status_detail.problem}</td>
                                    </tr>
                                    <tr>
                                        <td>Language</td>
                                        <td>{status_detail.language}</td>
                                    </tr>
                                    <tr>
                                        <td>Status</td>
                                        <td>{status_detail.verdict}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </Card.Body>
                    </Card>
                </div>
            </div>
        </div>
    )
}

export default Status_detail
