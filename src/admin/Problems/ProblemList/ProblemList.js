import React, { useState, useEffect } from 'react'
import '../../Table.scss';
import { Card, Button, Form } from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDownload, AiOutlineDelete } from 'react-icons/ai';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import admin_problemAPI from '../../../api/admin_problemAPI';
import { Link } from 'react-router-dom';
function ProblemList(props) {
    const [problems, setProblems] = useState([]);
    useEffect(() => {
        const fetchProblemList = async () => {
            try {
                const response = await admin_problemAPI.getAll();
                console.log(response);
                setProblems(response.data);
            } catch (error) {
                console.log("Fail to fetch problem list: ", error);
            }
        };
        fetchProblemList();
    }, [])
    return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card>
                    <Card.Header as="h4">Problem List</Card.Header>
                    <Card.Body>
                        <Card.Text>
                            < table >
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Display ID</th>
                                        <th>Author</th>
                                        <th>Tille</th>
                                        <th>Create time</th>
                                        <th>Visible</th>
                                        <th>Operation</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {
                                        problems.length > 0 ? (
                                            problems.map((problem) => (
                                                <tr key={problem.id}>
                                                    <td>{problem.id}</td>
                                                    <td>{problem.display_id}</td>
                                                    <td>{problem.author}</td>
                                                    <td>{problem.title}</td>
                                                    <td>{problem.created}</td>
                                                    <td>
                                                        <Form.Check
                                                            type="switch"
                                                            id="custom-switch"
                                                        />
                                                    </td>
                                                    <td>
                                                        <div className="option-cell">
                                                            <div className="option-button">
                                                                <div className="option-button">
                                                                    <Link to={`/admin/problem/${problem.id}`} >
                                                                        <Button variant="light">
                                                                            <AiOutlineEdit />
                                                                        </Button>
                                                                    </Link>

                                                                </div>
                                                                <div className="option-button">
                                                                    <Button variant="light">
                                                                        <AiOutlineDownload />
                                                                    </Button>
                                                                </div>
                                                                <div className="option-button">
                                                                    <Button variant="light">
                                                                        <AiOutlineDelete />
                                                                    </Button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            ))
                                        ) : (
                                            <tr>
                                                <td colSpan={5}>Nothing</td>
                                            </tr>
                                        )
                                    }
                                </tbody>
                            </table >
                        </Card.Text>
                        <Link to={`/admin/problem/create`} >
                            <Button variant="primary">Create</Button>
                        </Link>

                    </Card.Body>
                </Card>
            </div>
        </div >
    )
}

ProblemList.propTypes = {

}

export default ProblemList

