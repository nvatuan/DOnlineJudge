import React, { useEffect, useState } from 'react';
import { Form, Card, Button, ListGroup } from 'react-bootstrap';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import '../Table.scss';
import { Link } from 'react-router-dom';
import { BsFillPlusCircleFill } from 'react-icons/bs';
import { BiCog, BiSpreadsheet, BiServer } from 'react-icons/bi';

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
								<Card id="form-card">
									<Card.Header as="h4" className="jserver-form"><BiCog/> Config</Card.Header>
									<Card.Body>
										<Form id="jserver-form">
											<Form.Group className="mb-3" controlId="jserver-form-Hostname">
												<Form.Label>Hostname</Form.Label>
												<Form.Control type="text" placeholder="Server's human-readable hostname" value={jserver.hostname}/>
											</Form.Group>
											<Form.Group className="mb-3" controlId="jserver-form-address">
												<Form.Label>Address</Form.Label>
												<Form.Control type="text" placeholder="Server's socket address" value={jserver.socketaddress} />
											</Form.Group>

											<Form.Group className="mb-3" controlId="jserver-form-activation">
												<Form.Label>Activation</Form.Label>
												<Form.Check
													checked={!jserver.is_disabled} label="Enable" name="group1" type="radio" id={`radio-2`}
												/>
												<Form.Check
													checked={jserver.is_disabled} label="Disable" name="group1" type="radio" id={`radio-2`}
												/>
											</Form.Group>

											<Form.Group className="mb-3" controlId="jserver-form-mptask">
												<Form.Label>Max pending tasks allowed</Form.Label>
												<Form.Control type="number" placeholder="Server's max number of pending tasks" value={jserver.max_pending_tasks} />
											</Form.Group>
											<Button variant="primary" type="submit">
												Submit
											</Button>
										</Form>
									</Card.Body>
								</Card>
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
							</div>
						}
                    </Card.Body>
                </Card>
            </div>
        </div >
	)
}

export default JudgeServer;

