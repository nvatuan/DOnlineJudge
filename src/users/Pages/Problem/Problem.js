import React, { useState, useEffect } from 'react';
import Navbar from '../../Navbar';
import { Card, Form } from 'react-bootstrap';
import './Problem.scss';
import oj_problemAPI from '../../../api/oj_problemAPI';
import { Link } from 'react-router-dom';

import '../../Components/Pagination/Paginate.css';
import ReactPaginate from 'react-paginate';
import Collapsible from 'react-collapsible';
import { BsChevronDown } from "react-icons/bs"; //react-icon
import {Button} from 'react-bootstrap';

function Problem() {
    const [problems, setProblems] = useState([])
    const [filters, setFilters] = useState({
        filter_by: [],
        sort_by: '',
        page: 1,
    });

    // -- paginate
    const [maxPage, setMaxPage] = useState(1);

    // -- sorting
    const [sortBy, setSortBy] = useState('');
    const setSortByCriteria = (crit) => {
        if (sortBy === '') setSortBy(crit);
        else
        if (sortBy.charAt[0] === '-') {
            setSortBy(crit);
        } else {
            if (sortBy === crit) setSortBy('-'+crit);
            else setSortBy(crit);
        }
    }
    // Update filters when sortBy is changed
    useEffect(() => {
        setFilters({
            ...filters,
            sort_by: sortBy
        })
    }, [sortBy])

    // -- ReactPaginate: handle page change
    const handlePageClick = async (props) => {
        setFilters({
            ...filters,
            page: props.selected+1,
        })
    };
    // Fetching data when filters is changed
    useEffect(() => {
        const fetchProblems = async () => {
            try {
                const response = await oj_problemAPI.getAll(filters);
                setProblems(response.data);
                setMaxPage(response.maxpage);
            } catch (error) {
               console.log('Fail to fetch status: ', error); 
            }
        }
        fetchProblems();
    }, [filters])

    // -- Filtering
    const [searchContent, setSearchContent] = useState('')
    const [searchAuthor, setSearchAuthor] = useState('')
    const [searchDifficulty, setSearchDifficulty] = useState('')
    // -- handleFilterFormSubmit : Form Submit button
    const handleFilterFormSubmit = (e) => {
        if (e !== undefined) e.preventDefault()
        let newFilter = {...filters, filter_by:[]};
        delete newFilter['contains']
        delete newFilter['author_name']
        delete newFilter['difficulty']

        if (searchContent !== '') {
            newFilter = {...newFilter, contains: searchContent}
        }
        if (searchAuthor !== '') {
            newFilter.filter_by.push('author_name')
            newFilter = {...newFilter, author_name: searchAuthor}
        } 
        if (searchDifficulty !== '') {
            newFilter.filter_by.push('difficulty')
            newFilter = {...newFilter, difficulty: searchDifficulty}
        }
        setFilters(newFilter);
    }
    // -- handleFilterFormSubmit : Form Submit button
    const handleFilterFormReset = (e) => {
        setSearchContent(''); setSearchAuthor(''); setSearchDifficulty('');
        let newFilter = {...filters, filter_by:[]};
        delete newFilter['contains']
        delete newFilter['author_name']
        delete newFilter['difficulty']
        setFilters(newFilter);
    }

    return (
        <div>
            <Navbar />
            <div className="problems-container pages-container">
                <Collapsible trigger={["Search/Filter", <BsChevronDown key={'chevron-down'}/>]} easing='ease'>
                    <Form className="filter_form">
                        <div className="filter_form_items">
                            <Form.Group className="search-content">
                                <Form.Label>Search content</Form.Label>
                                <Form.Control type="text" placeholder="Content" onChange={(e)=>{setSearchContent(e.target.value)}}/>
                            </Form.Group>

                            <Form.Group className="search-authorname">
                                <Form.Label>Search for author</Form.Label>
                                <Form.Control type="text" placeholder="Author name" onChange={(e)=>{setSearchAuthor(e.target.value)}}/>
                            </Form.Group>

                            <Form.Group className="filter-difficulty">
                                <Form.Label>Difficulty</Form.Label>
                                <Form.Control as="select" className="diff_filter_by" onChange={(e)=>{setSearchDifficulty(e.target.value)}}>
                                    <option value="">All</option>
                                    <option value="Easy">Easy</option>
                                    <option value="Medium">Medium</option>
                                    <option value="Hard">Hard</option>
                                </Form.Control>
                            </Form.Group>
                        </div>
                        <Button variant="primary" type="submit" onClick={handleFilterFormSubmit}>Submit</Button>
                        <Button variant="light" type="reset" onClick={handleFilterFormReset}>Reset</Button>
                    </Form>
                </Collapsible>
                <Card>
                    <Card.Header as="h3" className="problem-header">
                        Problem
                    </Card.Header>
                    <Card.Body >
                        < table >
                            <thead>
                                <tr>
                                    <th onClick={() => setSortByCriteria('display_id')}>Display ID</th>
                                    <th onClick={() => setSortByCriteria('title')}>Title</th>
                                    <th onClick={() => setSortByCriteria('author_name')}>Author</th>
                                    <th onClick={() => setSortByCriteria('difficulty')}>Level</th>
                                    <th onClick={() => setSortByCriteria('total_submission')}>Tries</th>
                                    <th onClick={() => setSortByCriteria('correct_submission')}>Correct</th>
                                </tr>
                            </thead>
                            <tbody className="pages-container">
                                {
                                    problems.length === 0 
                                    ? <tr><td className='empty-result-msg'> Nothing to show.. </td></tr>
                                    : (
                                        problems.map((problem) => (
                                            <tr key={problem.id}>
                                                <td>{problem.display_id}</td>
                                                <td><Link to={`/problem/${problem.id}`}>{problem.title}</Link></td>
                                                <td>{problem.author_name}</td>
                                                <td>
                                                    <div className="table-cell">
                                                        <div className={`difficulty-container ${problem.difficulty}`}>
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
                                    )
                                }
                            </tbody>
                        </table >

                        <div className='pagination-container'> 
                            {
                                maxPage === 0
                                ? <></>
                                : <ReactPaginate 
                                    pageCount={maxPage}
                                    pageRangeDisplayed={5}
                                    marginPagesDisplayed={2}
                                    onPageChange={handlePageClick}
                                    containerClassName={'pagination'}
                                    activeClassName={'active'}
                                    breakLabel={'...'}
                                    breakClassName={'break-me'}>
                                </ReactPaginate> 
                            }
                        </div>
                    </Card.Body>
                </Card>
            </div>
        </div>
    );
}

export default Problem;