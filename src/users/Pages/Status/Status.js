import React, {useState, useEffect} from 'react';
import { Card } from 'react-bootstrap';
import oj_statusAPI from '../../../api/oj_statusAPI';
import Navbar from '../../Navbar';
import './status.scss';
function Status(props) {
    const [status, setStatus] = useState([]);

    useEffect(() => {
        const fetchStatus = async () => {
            try {
                const response = await oj_statusAPI.getAll();
                setStatus(response.data);
            } catch (error) {
               console.log('fail to fetch status: ', error); 
            }
        }
        fetchStatus();
    }, [])
    const hanldeTime = (time) => {
        return new Date(time).toDateString();  
    }
    return (
        <div>
            <Navbar/>
            <div className="status-container">
                  <Card>
                <Card.Header as="h3">Status</Card.Header>
                <Card.Body>
                    
                        <table>
                            <thead>
                                <tr>
                                    <th>when</th>
                                    <th>ID</th>
                                    <th>Status</th>
                                    <th>Problem</th>
                                    <th>Time</th>
                                    <th>Memory</th>
                                    <th>Language</th>
                                    <th>Author</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    status.map(stat => {
                                        return (
                                            <tr key={stat.id}>
                                                <td>{hanldeTime(stat.submit_time)}</td>
                                                <td>{stat.id}</td>
                                                <td>{stat.verdict}</td>
                                                <td>{stat.problem}</td>
                                                <td>{stat.time}</td>
                                                <td>{stat.memory}</td>
                                                <td>{stat.language}</td>
                                                <td>{stat.author}</td>
                                            </tr>
                                        )
                                    })
                                }
                            </tbody>
                        </table>
                </Card.Body>
            </Card>
            </div>
        </div>


    );
}

export default Status;