import React, { useState, useEffect } from 'react';
import Navbar from '../../Navbar';
import { Card, Form } from 'react-bootstrap';
import './Problem.scss';
import oj_problemAPI from '../../../api/oj_problemAPI';
import { Link } from 'react-router-dom';
import Search from '../../Components/Search';

function Problem() {
    const [problems, setProblems] = useState([])
    const [filters, setFilters] = useState({
        filter_by: [],
        
    })
    //difficulty
    const difficulty = {
        "Easy": "Easy",
        "Medium": "Medium",
        "Hard": "Hard"
    }

    useEffect(() => {
        const fectchProblems = async () => {
            const response = await oj_problemAPI.getAll(filters);
            setProblems(response.data);
            // setPagination(filters);
        }
        fectchProblems();
    }, [filters])
    //serach process
    function handleSearchForm(newValue) {
        setFilters({
            ...filters,
            contains: newValue,
        })
    }

    function handleFilterDiff(e) {
        const value = e.target.value;
        filters.filter_by.push('difficulty');
        if (value === '') {
            filters.filter_by = filters.filter_by.filter((item) => item !== 'difficulty');
            setFilters({
                ...filters,
                filter_by: filters.filter_by,
                difficulty: '',
            })
        }
        else {
            setFilters({
                ...filters,
                difficulty: value,

            })
        }
    }
    return (
        <div>
            <Navbar />
            <div className="problems-container pages-container">
                <Card>
                    <Card.Header as="h3" className="problem-header">
                        Problem
                    <div className="problem-feartures">
                            <div className="problem-feartures__items">
                                <Search onSubmit={handleSearchForm} />
                            </div>
                            <div className="problem-feartures__items">
                                <p>Difficulty</p>
                                <Form className="filter_by" onChange={(e) => { handleFilterDiff(e)}}>
                                    <Form.Control as="select" className="filter_by">
                                        <option value="">All</option>
                                        <option value="Easy">Easy</option>
                                        <option value="Medium">Medium</option>
                                        <option value="Hard">Hard</option>
                                    </Form.Control>
                                </Form>
                            </div>

                        </div>
                    </Card.Header>
                    <Card.Body >
                        < table >
                                <thead>
                                    <tr>
                                        <th>Display ID</th>
                                        <th>Tille</th>
                                        <th>Level</th>
                                        <th>Total</th>
                                        <th>AC Rate</th>
                                    </tr>
                                </thead>
                            <tbody className="pages-container">
                                    {
                                        problems.length > 0 ? (
                                            problems.map((problem) => (
                                                <tr key={problem.id}>
                                                    <td>{problem.display_id}</td>
                                                    <td><Link to={`/problem/${problem.id}`}>{problem.title}</Link></td>
                                                    <td>
                                                        <div className="table-cell">
                                                            <div className={`difficulty-container ${difficulty[problem.difficulty]}`}>
                                                                <div className="difficulty-text">
                                                                    {problem.difficulty}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>{problem.total_submission}</td>
                                                    <td>{problem.correct_submission}</td>
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
                    </Card.Body>
                </Card>
            </div>
        </div>
    );
}

export default Problem;