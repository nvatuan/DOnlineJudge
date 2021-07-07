import React, { useState, useEffect } from 'react'
import '../../Table.scss';
import { Card, Button, Form } from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDownload, AiOutlineDelete } from 'react-icons/ai';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import admin_problemAPI from '../../../api/admin_problemAPI';
import { Link } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { adminSelector, deleteProblem, clearState } from '../../AdminSlice';
import Switch from 'react-switch';
import { BsFillPlusCircleFill } from 'react-icons/bs';
import './ProblemList.scss';
function ProblemList(props) {
    const [problems, setProblems] = useState([]);
    //redux 
    const dispatch = useDispatch();
    const { deleteSusscess } = useSelector(adminSelector);
    //delete problem
    const handleDeleteProblem = (id) => {
        if (window.confirm("Are you sure?")) {
            dispatch(deleteProblem(id));
            dispatch(clearState)
        }
    }
    useEffect(() => {
        const fetchProblemList = async () => {
            try {
                const response = await admin_problemAPI.getAll();
                setProblems(response.data);
            } catch (error) {
                console.log("Fail to fetch problem list: ", error);
            }
        };
        fetchProblemList();
    }, [deleteSusscess])
    const handleVisible = (id, isVisible) => {
        const update = async () =>{
            const response = await admin_problemAPI.updateVisible(id, isVisible);
            const newProblem = response.data;
            setProblems(
                problems.map(
                    (problem) => {return newProblem.id === problem.id ? {...problem, visible: newProblem.visible} : problem}
                )
            )
        };
        update();
    }
    return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card>
                    <Card.Header as="h3" className="problemList-header">
                        Problem List
                        <div className="create_button">
                            <Link to={`/admin/problem/create`}  className="alter_announcement"> <BsFillPlusCircleFill /> New</Link>
                        </div>
                    </Card.Header>
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
                                                    <td>{problem.author_name}</td>
                                                    <td>{problem.title}</td>
                                                    <td>{problem.created}</td>
                                                    <td>
                                                        <Switch 
                                                            checked={problem.visible}
                                                            height={20} width={40}
                                                            onChange={() => handleVisible(problem.id, problem.visible)}
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
                                                                    <Button variant="light" onClick={() => handleDeleteProblem(problem.id)}>
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
                    </Card.Body>
                </Card>
            </div>
        </div >
    )
}

ProblemList.propTypes = {

}

export default ProblemList

