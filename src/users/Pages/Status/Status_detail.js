import React, { useState, useEffect } from 'react'
import Navbar from '../../Navbar';
import oj_statusAPI from '../../../api/oj_statusAPI';
import './Status_detail.scss';

// StatusDetailComponent
import StatusDetailSource from './StatusDetailComponent/SDSource.js'
import StatusDetailSummary from './StatusDetailComponent/SDSummary.js';
import {StatusDetailSample, StatusDetailHidden} from './StatusDetailComponent/SDTestcase.js';
import { Card } from 'react-bootstrap';

//code mirror editor 
require('codemirror/lib/codemirror.css');
require('codemirror/theme/material.css');
require('codemirror/theme/neat.css');

function Status_detail({ match }) {
    const id = match.params.id;
    const [status_detail, setStatus_detail] = useState({
        "id": -1,
        "content": "",
        "language": "",
        "output": {
            "sample_test": [],
            "hidden_test": [],
        },
    });

    useEffect(() => {
        const fetchStatus_detail = async () => {
            const response = await oj_statusAPI.getById(id);
            setStatus_detail(response.data);
        };
        fetchStatus_detail();
    },[id])
    return (
        <div>
            <Navbar/>
            {
                status_detail.id===-1
                ? <div className="status_details-container pages-container">
                    <h2>Submission not found.</h2>
                    <hr />
                </div>
                : <div className="status_details-container pages-container">
                    <h2>Submission #{status_detail.id}</h2>
                    <hr />

                    <StatusDetailSource key={'sdsource'+status_detail.id} content={status_detail.content} language={status_detail.language}/>
                    <StatusDetailSummary key={'sdsummary'+status_detail.id} submission={status_detail}/>
                    <StatusDetailSample key={'sdsample'+status_detail.id} samples={status_detail.output.sample_test}/>
                    <StatusDetailHidden key={'sdhidden'+status_detail.id} hiddens={status_detail.output.hidden_test}/>
                </div>
            }
    </div>
    )
}

export default Status_detail
