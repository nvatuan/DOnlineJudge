import React, { useEffect, useState } from 'react';
import { Card, Button } from 'react-bootstrap';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';
import { BsFillPlusCircleFill } from 'react-icons/bs';
import '../Table.scss';

import adminJudgeServerAPI from '../../api/adminJudgeServerAPI';

import { Link } from 'react-router-dom';
import Collapsible from 'react-collapsible';

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
	console.log(jservers);

	return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card>
                    <Card.Header as="h3" className="problemList-header">
						Judge Server
                        <div className="create_button">
                            <Link to={`/admin/judgeserver/add`}  className="js-add-btn"> <BsFillPlusCircleFill /> Add </Link>
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
									<th></th>
								</tr>
							</thead>
							<tbody>
								{
									jservers.map((jserver) => (
										<tr>
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
												<Link to={`/admin/judgeserver/${jserver.id}`}>Detail</Link>
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

