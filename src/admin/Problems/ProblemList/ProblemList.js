import React from 'react'
import PropTypes from 'prop-types'
import '../../Table.scss';
import { Card, Button, Form, Navbar} from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDownload, AiOutlineDelete} from 'react-icons/ai';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
function ProblemList(props) {
    const problems = [
        {
            id: 4,
            display: 4,
            title: "BDKNOJ_Bắn chim",
            author: "root",
            create_time: "2021-5-1 15:25:54",
            visible: true,
        }
    ]
    return (
        <div>
            <AdminNavbar/>
            <Sidebar/>
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
                                                    <td>{problem.display}</td>
                                                    <td>{problem.author}</td>
                                                    <td>{problem.title}</td>
                                                    <td>{problem.create_time}</td>
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
                                                                    <Button variant="light">
                                                                        <AiOutlineEdit />
                                                                    </Button>
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
                        <Button variant="primary">Create</Button>
                    </Card.Body>
                </Card>
            </div>
        </div>
    )
}

ProblemList.propTypes = {

}

export default ProblemList

