import React, { useEffect, useState } from 'react';
import { Form, Card, Button } from 'react-bootstrap';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import '../Table.scss';
import { useHistory } from 'react-router-dom';
import adminJudgeServerAPI from '../../api/adminJudgeServerAPI';
import './NewJudgeServerForm.scss'

function NewJudgeServerForm() {
    const history = useHistory();
	const [hostname, setHostname] = useState('')
	const [saddress, setSAddress] = useState('')
	const [mptasks, setMPTasks] = useState(8)
	const [active, setActive] = useState(false)

	const onSubmitHandler = () => {
		const data = {
			'hostname': hostname,
			'socketaddress': saddress,
			'max_pending_tasks': mptasks,
			'is_disabled': !active
		}
		try {
			const rsp = adminJudgeServerAPI.addJudgeServer(data)
			if (rsp) history.push('/admin/judgeserver')
		} catch (error) {
			console.log('NewJudgeServerForm', error);
		}
	}


	return (
		<div>
			<AdminNavbar />
			<Sidebar />
			<div className="table-view">
				<Card className='njs-form'>
					<Card.Header as="h3" className="judge-server-card">
						*New Judge Server
					</Card.Header>
					<Card.Body>
						<Form id="jserver-form" onSubmit={onSubmitHandler}>
							<Form.Group className="mb-3" controlId="jserver-form-Hostname">
								<Form.Label>Hostname</Form.Label>
								<Form.Control type="text" placeholder="Name for the server" onChange={(e)=>{setHostname(e.target.value)}} required/>
							</Form.Group>
							<Form.Group className="mb-3" controlId="jserver-form-address">
								<Form.Label>Address</Form.Label>
								<Form.Control type="text" placeholder=" xxx.xxx.xxx.xxx:pppp" 
									onChange={(e)=>{setSAddress(e.target.value)}} required
								/>
							</Form.Group>

							<Form.Group className="mb-3" controlId="jserver-form-activation">
								<Form.Label>Server Active Status</Form.Label>
								<Form.Check
									label="Enable" name="group1" type="radio" id={`radio-1`} onChange={()=>{setActive(true)}}
									required
								/>
								<Form.Check
									label="Disable" name="group1" type="radio" id={`radio-2`} onChange={()=>{setActive(false)}}
									required
								/>
							</Form.Group>

							<Form.Group className="mb-3" controlId="jserver-form-mptask">
								<Form.Label>Max pending tasks allowed</Form.Label>
								<Form.Control type="number" value={mptasks} required onChange={(e)=>{setMPTasks(e.target.value)}}/>
							</Form.Group>
							<Button variant="primary" type="submit">
								Add
							</Button>
						</Form>
					</Card.Body>
				</Card>
			</div>
		</div >
	)
}

export default NewJudgeServerForm;


