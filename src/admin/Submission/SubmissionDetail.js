import React, { useState, useEffect } from 'react'
import { Card, Button, Form } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import { useHistory } from 'react-router';


import { MdLoop } from 'react-icons/md'
import { ImCross } from 'react-icons/im'
import { BiLeftArrowAlt } from 'react-icons/bi'
import { AiFillDelete } from 'react-icons/ai'

// StatusDetailComponent
import StatusDetailSource from './StatusDetailComponent/SDSource.js'
import StatusDetailSummary from './StatusDetailComponent/SDSummary.js';
import {StatusDetailSample, StatusDetailHidden} from './StatusDetailComponent/SDTestcase.js';

import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import adminStatusAPI from '../../api/adminStatusAPI';
import './SubmissionDetail.scss';
import { toast } from 'react-toastify';

//code mirror editor 
require('codemirror/lib/codemirror.css');
require('codemirror/theme/material.css');
require('codemirror/theme/neat.css');

function AdminSubmissionDetail({ match }) {
	const id = match.params.id;
	const [subDetail, setSubDetail] = useState({
		"id": -1,
		"content": "",
		"language": "",
		"output": {
			"sample_test": [],
			"hidden_test": [],
		},
	});

    const sendPut = async (type) => {
        try {
            const resp = await adminStatusAPI.putById(id, type)
            setSubDetail(resp.data)
        } catch (err) {
            console.log(err)
        }
    }

    const history = useHistory();
    const sendDelete = async () => {
        try {
            if (window.confirm("Are you sure you want to delete this submission?")) {
                const resp = await adminStatusAPI.deleteById(id)
                history.push('/admin/submission')
            }
        } catch (err) {
            console.log(err)
        }
    }

	useEffect(() => {
		const fetchStatus_detail = async () => {
			const response = await adminStatusAPI.getById(id);
			setSubDetail(response.data);
		};
		fetchStatus_detail();
	},[id])
	return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card>
                    <Card.Header as='h2'>
                        Submission #{subDetail.id}
                        <div className="">
                            <Link to={`/admin/submission`}  className="card-header-btn"> <BiLeftArrowAlt/> Back </Link>
                        </div>
                    </Card.Header>
                    <Card.Body>
                        <div className="admin-status-details-container pages-container">
                            <div className="admin-status-control-panel">
                                <Button className='rejudge-btn' onClick={() => sendPut('rejudge')}
                                    disabled={id===-1||subDetail.verdict==='Rejudging'}><MdLoop/> Rejudge</Button>
                                <Button className='reject-btn' onClick={() => sendPut('reject')}
                                    disabled={id===-1||subDetail.verdict==='Rejected'}><ImCross/> Reject</Button>
                                <Button className='delete-btn' onClick={() => sendDelete()}
                                    disabled={id===-1}><AiFillDelete/> Delete</Button>
                            </div>
                            <StatusDetailSummary key={'sdsummary'+subDetail.id} submission={subDetail}/>
                            <StatusDetailSource key={'sdsource'+subDetail.id} content={subDetail.content} language={subDetail.language}/>
                            <StatusDetailSample key={'sdsample'+subDetail.id} samples={subDetail.output.sample_test}/>
                            <StatusDetailHidden key={'sdhidden'+subDetail.id} hiddens={subDetail.output.hidden_test}/>
                        </div>
                    </Card.Body>
                </Card>
            </div>
	</div>
	)
}

export default AdminSubmissionDetail
