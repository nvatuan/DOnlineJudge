import React, {useState, useEffect} from 'react';
import { Card } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import oj_statusAPI from '../../../api/oj_statusAPI';
import Navbar from '../../Navbar';
import './status.scss';
function Status(props) {
    const [status, setStatus] = useState([]);
    const result = {
        "Accepted": "Accepted",
        "Wrong Answer": "Wrong_answer",
        "Runtime Error": "Runtime_error",
        "New": "New",
        "Compilation Error": "Compile_error",
        "System Error": "System_error",
        "Judged": "Judged",
        "Judging": "Judging"

    }
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
            <div className="status-container pages-container">
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
                                                <td >
                                                    <div className="table-cell">
                                                        <div className={`result-container ${result[stat.verdict]}`}>
                                                            <div className="result-text">
                                                                {stat.verdict}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div className="table-cell">
                                                        <Link to={`problem/${stat.problem}`} >{stat.problem}</Link>
                                                    </div>
                                                </td>
                                                <td>{stat.time}</td>
                                                <td>{stat.memory}</td>
                                                <td>{stat.language}</td>
                                                <td>{stat.author}</td>
                                                <td><Link to={`status/${stat.id}`}>detail</Link></td>
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