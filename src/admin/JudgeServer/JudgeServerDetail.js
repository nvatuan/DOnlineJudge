import React, { useEffect, useState } from 'react';
import { Form, Card, Button, ListGroup } from 'react-bootstrap';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import '../Table.scss';
import { useHistory } from 'react-router-dom';
import { BiCog, BiSpreadsheet } from 'react-icons/bi';

import adminJudgeServerAPI from '../../api/adminJudgeServerAPI';
import './JudgeServerDetail.scss'

function JudgeServer({match}) {
	const id = match.params.id;
	const [jserver, setJserver] = useState({})
	useEffect(() => {
		const fetch = async(id) => {
			try {
				const resp = await adminJudgeServerAPI.getById(id);
				setJserver(resp.data);
			} catch (error) {
				console.log(error)
			}
		}
		fetch(id);
	}, [])

	const history = useHistory();
	const onSubmitHandler = async(e) => {
		e.preventDefault();
		const resp = await adminJudgeServerAPI.updateById({id:id,formData:jserver})
		if (resp.error==='none') {
			history.push('/admin/judgeserver')
		} else {
			console.log("Err",resp.error)
			console.log("ErrMsg", resp.data)
		}
	}

	return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card>
                    <Card.Header as="h3" className="judge-server-card">
						Judge Server # {id}
                    </Card.Header>
                    <Card.Body>
						{
							jserver === {}
							? <div className="not-fetched">Please wait...</div>
							: <div className="jserver-detail">
								<Card id="readonly-card">
									<Card.Header as="h4" className="jserver-readonly"><BiSpreadsheet/> Read-only</Card.Header>
									<Card.Body>
										<ListGroup className="list-group-flush">
											<ListGroup.Item>
												<div className="jserver-readonly-item">
													ID <span>{jserver.id}</span>
												</div>
											</ListGroup.Item>
											<ListGroup.Item>
												<div className="jserver-readonly-item">
													Token: <span>{jserver.token}</span>
												</div>
											</ListGroup.Item>
											<ListGroup.Item>
												<div className="jserver-readonly-item">
													Status: <span>{jserver.status} </span>
												</div>
											</ListGroup.Item>
											<ListGroup.Item>
												<div className="jserver-readonly-item">
													Pending Tasks: <span>{jserver.pending_tasks} </span>
												</div>
											</ListGroup.Item>
											<ListGroup.Item>
												<div className="jserver-readonly-item">
													Last Heartbeat: <span>{jserver.last_heartbeat}</span>
												</div>
											</ListGroup.Item>
											<ListGroup.Item>
												<div className="jserver-readonly-item">
													Added On: <span>{jserver.added_time}</span>
												</div>
											</ListGroup.Item>
										</ListGroup>
									</Card.Body>
								</Card>
								<Card id="form-card">
									<Card.Header as="h4" className="jserver-form"><BiCog/> Config</Card.Header>
									<Card.Body>
										<Form id="jserver-form" onSubmit={(e)=>(onSubmitHandler(e))}>
											<Form.Group className="mb-3" controlId="jserver-form-Hostname">
												<Form.Label>Hostname</Form.Label>
												<Form.Control type="text" placeholder="Judge Server's name"
													value={jserver.hostname} onChange={(e)=>(setJserver({...jserver, hostname:e.target.value}))}/>
											</Form.Group>
											<Form.Group className="mb-3" controlId="jserver-form-address">
												<Form.Label>Address</Form.Label>
												<Form.Control type="text" placeholder="Judge Server's socket address" 
													value={jserver.socketaddress} onChange={(e)=>(setJserver({...jserver, socketaddress:e.target.value}))}/>
											</Form.Group>

											<Form.Group className="mb-3" controlId="jserver-form-activation">
												<Form.Label>Activation</Form.Label>
												<Form.Check
													checked={!jserver.is_disabled} label="Enable" name="group1" type="radio" id={`radio-1`}
													onChange={()=>(setJserver({...jserver, is_disabled:false}))}
												/>
												<Form.Check
													checked={jserver.is_disabled} label="Disable" name="group2" type="radio" id={`radio-2`}
													onChange={()=>(setJserver({...jserver, is_disabled:true}))}
												/>
											</Form.Group>

											<Form.Group className="mb-3" controlId="jserver-form-mptask">
												<Form.Label>Max pending tasks allowed</Form.Label>
												<Form.Control type="number" placeholder="Server's max number of pending tasks" 
													value={jserver.max_pending_tasks}
													onChange={(e)=>(setJserver({...jserver, max_pending_tasks:e.target.value}))}
												/>
											</Form.Group>
											<Button variant="primary" type="submit" className='form-submit-btn'>
												Submit
											</Button>
										</Form>
									</Card.Body>
								</Card>
							</div>
						}
                    </Card.Body>
                </Card>
            </div>
        </div >
	)
}

export default JudgeServer;

