import React, { useEffect, useState } from 'react';
import { Card, Button } from 'react-bootstrap';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import { BsFillPlusCircleFill } from 'react-icons/bs';
import '../Table.scss';
import './JudgeServer.scss'

import { Link } from 'react-router-dom';
import Collapsible from 'react-collapsible';

import { useDispatch, useSelector } from 'react-redux';
import { AiOutlineEdit, AiOutlineDelete } from 'react-icons/ai';

import adminJudgeServerAPI from '../../api/adminJudgeServerAPI';


function JudgeServer(props) {
	const [jservers, setJServers] = useState([])
	useEffect(() => {
		const fetch = async() => {
			try {
				const response = await adminJudgeServerAPI.getAll();
				setJServers(response.data)
			} catch (error) {
				console.log(error)
			}
		}
		fetch();
	}, [])

    const dispatch = useDispatch();
    const OnDeleteHandler = async (id) => {
        if (window.confirm(`Are you sure you want to delete Judge Server#${id}?`)) {
            const resp = await adminJudgeServerAPI.deleteById(id);
			if (resp.status==204) {
				setJServers(jservers.filter((jserver) => {return jserver.id !== id}))
			} else {
				console.log('Error when Deleting a Judge Server:', resp)
			}
        }
    }

	return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card className="jserver-list">
                    <Card.Header as="h3" className="problemList-header">
						Judge Server
                        <div className="create_button">
                            <Link to={`/admin/judgeserver/new`}  className="alter_announcement"> <BsFillPlusCircleFill /> Add </Link>
                        </div>
                    </Card.Header>
                    <Card.Body>
						{jservers.length === 0 
						? <p> Nothing to show at the moment </p>
						: <table>
							<thead>
								<tr>
									<th>ID</th>
									<th>Hostname</th>
									<th>Socket Address</th>
									<th>Status</th>
									<th>Pending Tasks</th>
									<th>Options</th>
								</tr>
							</thead>
							<tbody>
								{
									jservers.map((jserver) => (
										<tr key={`jserver-list-tr-${jserver.id}`}>
											<td>{jserver.id}</td>
											<td>{jserver.hostname}</td>
											<td>{jserver.socketaddress}</td>
											<td>
												{
													jserver.status==="Normal"
													?<div className="jserver-status-normal">Normal</div>
													:<div className="jserver-status-abnormal">{jserver.status}</div>
												}
											</td>
											<td>{jserver.pending_tasks}</td>
											<td>
												<div className="js-option-cell">
													<div className="option-button__items">
														<Link to={`/admin/judgeserver/${jserver.id}`}
															className='op-btn'>
														<AiOutlineEdit/></Link>
													</div>
													<div className="option-button__items">
														<Button variant="light" onClick={() => {OnDeleteHandler(jserver.id)}}>
															<AiOutlineDelete />
														</Button>
													</div>
												</div>
											</td>
										</tr>
									))
								}
							</tbody>
						</table >
						}
                    </Card.Body>
                </Card>
            </div>
        </div >
	)
}

export default JudgeServer;

