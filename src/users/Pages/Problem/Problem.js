import React, { useState, useEffect } from 'react';
import axios from 'axios';
import Navbar from '../../Navbar';
import Pagination from '../../Pagination/Pagination';
import { Card } from 'react-bootstrap';
import './Problem.scss';
import oj_problemAPI from '../../../api/oj_problemAPI';
import { Link } from 'react-router-dom';
function Problem() {
    const [problems, setProblems] = useState([]);
    const [search, setSearch] = useState('');
    const [pagination, setPagination] = useState({
        page: 1
    })
    const [currentPage, setCurrentPage] = useState(1);
    const [coinsPerPage, setcoinsPerPage] = useState(9);


    const [filters, setFilters] = useState({
        page: 1
    })
    useEffect(() => {
        const fectchProblems = async () => {
            const response = await oj_problemAPI.getAll();
            console.log(response);
            setProblems(response.data);
            setPagination(filters);
        }
        fectchProblems();
    }, [filters])
    const handleChange = (e) => {
        setSearch(e.target.value);
    }
    const handlePageChange = (newPage) => {
        console.log('New page: ', newPage);
        setFilters({
            ...filters,
            page: newPage
        })
    }
    //serach feature
    // const filteredProblem = problems.filter(problem => (
    //     problem.name.toLowerCase().includes(search.toLowerCase())
    // ))
    //get current page 
    // const indexOfLastProblem = currentPage * problemsPerPage;
    // const indexOfFirstProblem = indexOfLastProblem - problemsPerPage;
    // const currentProblem = problems.slice(indexOfFirstProblem, indexOfLastProblem);
    //page change
    const paginate = pageNumber => setCurrentPage(pageNumber);
    return (
        <div>
            <Navbar />
            <div className="problems-container">
                <Card>
                    <Card.Header as="h4">Problem List</Card.Header>
                    <Card.Body>
                        <Card.Text>
                            < table >
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tille</th>
                                        <th>Level</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {
                                        problems.length > 0 ? (
                                            problems.map((problem) => (
                                                <tr key={problem.id}>
                                                    <td>{problem.id}</td>
                                                    <Link to={`/problem/${problem.id}`}>{problem.title}</Link>
                                                    <td>{problem.difficulty}</td>
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
        </div>
    );
}

export default Problem;