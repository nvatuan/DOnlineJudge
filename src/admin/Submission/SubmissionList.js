import React, { useState, useEffect } from 'react'
import { Card, Button, Form } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import AdminNavbar from '../AdminNavbar';
import Sidebar from '../Sidebar';

import { BsChevronDown } from "react-icons/bs"; //react-icon
import { AiOutlineEdit, AiOutlineDelete, AiOutlineControl } from 'react-icons/ai';
import { toast } from 'react-toastify';

import ReactPaginate from 'react-paginate';
import Collapsible from 'react-collapsible';

import adminStatusAPI from '../../api/adminStatusAPI';
import './SubmissionList.scss'

import {V2C, VS} from '../../constant/SubmissionVerdict'
import '../../css/SubmissionVerdict.css'

function AdminSubmissionList(props) {
    let href = window.location.href;
    var url = new URL(href);
    var problem_title = url.searchParams.get('problem');
    var username = url.searchParams.get('username');
    const [status, setStatus] = useState([]);
    const [filters, setFilters] = useState(() => {
        let filter = []
        if (username !== null) filter.push('author_name');
        if (problem_title !== null) filter.push('problem_title');
        return {
            // sort_by: '-submit_time',
            filter_by: filter,
            author_name: username,
            problem_title: problem_title,
            page: 1,
        }
    })

    // -- paginate
    const [maxPage, setMaxPage] = useState(1);

    // -- sorting
    const [sortBy, setSortBy] = useState('-id');
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
    useEffect(() => {
        setFilters({
            ...filters,
            sort_by: sortBy
        })
    }, [sortBy])
    // ReactPaginate: handle page change
    const handlePageClick = async (props) => {
        setFilters({
            ...filters,
            page: props.selected+1,
        })
    };

    // -- Fetch data : Fetch when fitlers changes
    useEffect(() => {
        const fetchStatus = async () => {
            try {
                const response = await adminStatusAPI.getAll(filters);
                setStatus(response.data);
                setMaxPage(response.maxpage);
            } catch (error) {
               console.log('Fail to fetch status: ', error); 
            }
        }
        fetchStatus();
    }, [filters])

    // Filtering
    const [searchContent, setSearchContent] = useState('')
    const [searchAuthor, setSearchAuthor] = useState('')
    const [searchVerdict, setSearchVerdict] = useState('')
    const [searchLanguage, setSearchLanguage] = useState('')
    // -- handleFilterFormSubmit : Form Submit button
    const handleFilterFormSubmit = (e) => {
        if (e !== undefined) e.preventDefault()
        let newFilter = {...filters, filter_by:[]};
        delete newFilter['contains']
        delete newFilter['author_name']
        delete newFilter['verdict']
        delete newFilter['language']

        if (searchContent !== ''){
            newFilter = {...newFilter, contains: searchContent}
        }
        if (searchAuthor !== '') {
            newFilter.filter_by.push('author_name')
            newFilter = {...newFilter, author_name: searchAuthor}
        } 
        if (searchVerdict !== '') {
            newFilter.filter_by.push('verdict')
            newFilter = {...newFilter, verdict: searchVerdict}
        }
        if (searchLanguage !== '') {
            newFilter.filter_by.push('language')
            newFilter = {...newFilter, language: searchLanguage}
        }
        setFilters(newFilter);
    }
    // -- handleFilterFormSubmit : Form Submit button
    const handleFilterFormReset = (e) => {
        setSearchContent(''); setSearchAuthor(''); setSearchVerdict(''); setSearchLanguage('');
        let newFilter = {...filters, filter_by:[]};
        delete newFilter['contains']
        delete newFilter['author_name']
        delete newFilter['verdict']
        delete newFilter['language']
        setFilters(newFilter);
    }

    // -- handleSubmission
    const handleDeleteSubmission = async (id) => {
        try {
            if (window.confirm("Are you sure you want to delete Submission#"+id+"?")) {
                const resp = await adminStatusAPI.deleteById(id);
                if (resp) {
                    setStatus(
                        status.filter((stat) => {return stat.id!==id})
                    )
                }
            }
        } catch (error) {
            console.log(error)
        }
    }

    return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card className='admin-card'>
                    <div className="admin-status-container pages-container">
                        <Collapsible trigger={["Search/Filter", <BsChevronDown/>]} easing='ease'>
                            <Form className="filter_form">
                                <div className="filter_form_items">
                                    <Form.Group className="search-content">
                                        <Form.Label>Search content</Form.Label>
                                        <Form.Control type="text" placeholder="Content" onChange={(e)=>setSearchContent(e.target.value)}/>
                                    </Form.Group>

                                    <Form.Group className="search-authorname">
                                        <Form.Label>Search for author</Form.Label>
                                        <Form.Control type="text" placeholder="Author name" onChange={(e)=>setSearchAuthor(e.target.value)}/>
                                    </Form.Group>

                                    <Form.Group className="search-verdict">
                                        <Form.Label>Verdict</Form.Label>
                                        <Form.Control as="select" className="verdict_filter_by" onChange={(e)=>setSearchVerdict(e.target.value)}>
                                            <option value="">All</option> 
                                            <option value="Accepted">Accepted</option>
                                            <option value="Wrong Answer">Wrong answer</option>
                                            <option value="Runtime Error">Runtime error</option>
                                            <option value="New">New</option>
                                            <option value="Compilation Error">Compile Error</option>
                                            <option value="System Error">System error</option>
                                            <option value="Skipped">Skipped</option>
                                            <option value="Judged">Judged</option>
                                            <option value="Judging">Judging</option>
                                            <option value="Rejected">Rejected</option>
                                        </Form.Control>
                                    </Form.Group>

                                    <Form.Group className="search-language">
                                        <Form.Label>Language</Form.Label>
                                        <Form.Control as="select" className="lang_filter_by" onChange={(e)=>setSearchLanguage(e.target.value)}>
                                            <option value="">All</option>
                                            <option value="Python3">Python3</option>
                                            <option value="Python2">Python2</option>
                                            <option value="C">C</option>
                                            <option value="Cpp">C++</option>
                                            <option value="Java">Java</option>
                                        </Form.Control>
                                    </Form.Group>
                                </div>
                                <Button variant="primary" type="submit" onClick={handleFilterFormSubmit}>Submit</Button>
                                <Button variant="light" type="reset" onClick={handleFilterFormReset}>Reset</Button>
                            </Form>
                        </Collapsible>
                        <Card>
                        <Card.Header as="h3" className="admin-status-header">
                            Submissions
                        </Card.Header>
                        <Card.Body>
                            <table>
                                <thead>
                                    <tr>
                                        <th onClick={() => setSortByCriteria('id')}>ID</th>
                                        <th onClick={() => setSortByCriteria('problem_title')}>Problem</th>
                                        <th onClick={() => setSortByCriteria('author_name')}>Author</th>
                                        <th onClick={() => setSortByCriteria('verdict')}>Status</th>
                                        <th onClick={() => setSortByCriteria('language')}>Language</th>
                                        <th onClick={() => setSortByCriteria('time')}>Time</th>
                                        <th onClick={() => setSortByCriteria('memory')}>Memory</th>
                                        <th onClick={() => setSortByCriteria('submit_time')}>When</th>
                                        <th>Options</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {
                                        status.length === 0
                                        ? <p className="empty-result-msg">Nothing to show..</p>
                                        : status.map(stat => {
                                            return (
                                                <tr key={"table-row"+stat.id}>
                                                    <td>{stat.id}</td>
                                                    <td>
                                                        <div className="table-cell">
                                                            <Link to={`problem/${stat.problem_id}`} >{stat.problem_title}</Link>
                                                        </div>
                                                    </td>
                                                    <td>{stat.author_name}</td>
                                                    <td>
                                                        <div className="table-cell">
                                                            <div className={`result-container ${V2C(stat.verdict)}`}>
                                                                <div className="result-text">
                                                                    {VS(stat.verdict)}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>{stat.language}</td>
                                                    <td>{stat.time} ms</td>
                                                    <td>{Math.floor(stat.memory/1000)} MB</td>
                                                    <td>{(new Date(stat.submit_time)).toDateString()}</td>
                                                    <td>
                                                        <div className="option-cell">
                                                            <div className="option-button">
                                                                <div className="option-button">
                                                                    <Link to={`/admin/submission/${stat.id}`} >
                                                                        <Button variant="light">
                                                                            <AiOutlineControl />
                                                                        </Button>
                                                                    </Link>
                                                                </div>

                                                                <div className="option-button">
                                                                    <Button variant="light" onClick={() => handleDeleteSubmission(stat.id)}>
                                                                        <AiOutlineDelete />
                                                                    </Button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            )
                                        })
                                    }
                                </tbody>
                            </table>
                            <div className='pagination-container'>
                                {maxPage === 0
                                ? <></>
                                : <ReactPaginate 
                                    pageCount={maxPage}
                                    pageRangeDisplayed={5}
                                    marginPagesDisplayed={2}
                                    onPageChange={handlePageClick}
                                    containerClassName={'pagination'}
                                    activeClassName={'active'}
                                    breakLabel={'...'}
                                    breakClassName={'break-me'}
                                ></ReactPaginate>}
                            </div>
                        </Card.Body>
                    </Card>
                </div>
                </Card>
            </div>
        </div>
    );
}

export default AdminSubmissionList;

