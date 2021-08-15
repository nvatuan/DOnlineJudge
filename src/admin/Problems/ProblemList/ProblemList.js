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

import ReactPaginate from 'react-paginate';
import Collapsible from 'react-collapsible';
import { BsChevronDown } from "react-icons/bs"; //react-icon

function ProblemList(props) {
    const [filters, setFilters] = useState({
        filter_by: [],
        sort_by: '',
        page: 1,
    });

    const [problems, setProblems] = useState([]);
    const handleVisible = (id) => {
        const update = async () =>{
            try {
                const response = await admin_problemAPI.updateVisible(id);
                console.log(response)
                if (response) {
                    const newProblem = response.data;
                    setProblems(
                        problems.map(
                            (problem) => {return newProblem.id === problem.id ? {...problem, is_visible: newProblem.is_visible} : problem}
                        )
                    )
                }
            } catch (err) {
                return;
            }
        };
        update();
    }
    // -- paginate
    const [maxPage, setMaxPage] = useState(0);

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

    //redux 
    const dispatch = useDispatch();
    const { deleteSusscess } = useSelector(adminSelector);

    //delete problem
    const handleDeleteProblem = (id) => {
        if (window.confirm("Are you sure you want to delete Problem#"+id+"?")) {
            dispatch(deleteProblem(id));
            dispatch(clearState)
        }
    }

    // Fetching data when filters is changed
    useEffect(() => {
        const fetchProblems = async () => {
            try {
                const response = await admin_problemAPI.getAll(filters);
                setProblems(response.data);
                setMaxPage(response.maxpage);
            } catch (error) {
               console.log('Fail to fetch status: ', error); 
            }
        }
        fetchProblems();
    }, [filters, deleteSusscess])

    return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card className='admin-card'>
                    <div className="admin-problem-container pages-container">
                        <Collapsible trigger={["Search/Filter", <BsChevronDown/>]} easing='ease'>
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
                            <Card.Header as="h3" className="problemList-header">
                                Problem List
                                <div className="create_button">
                                    <Link to={`/admin/problem/create`}  className="alter_announcement"> <BsFillPlusCircleFill /> New</Link>
                                </div>
                            </Card.Header>
                            <Card.Body>
                                < table >
                                    <thead>
                                        <tr>
                                            <th onClick={() => setSortByCriteria('id')}>ID</th>
                                            <th onClick={() => setSortByCriteria('title')}>Title</th>
                                            <th onClick={() => setSortByCriteria('display_id')}>Display ID</th>
                                            <th onClick={() => setSortByCriteria('author_name')}>Author</th>
                                            <th onClick={() => setSortByCriteria('difficulty')}>Level</th>
                                            <th onClick={() => setSortByCriteria('created')}>Create Time</th>
                                            <th onClick={() => setSortByCriteria('is_visible')}>Visibility</th>
                                            <th>Options</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {
                                            problems.length > 0 ? (
                                                problems.map((problem) => (
                                                    <tr key={problem.id}>
                                                        <td>{problem.id}</td>
                                                        <td>{problem.title}</td>
                                                        <td>{problem.display_id}</td>
                                                        <td>{problem.author_name}</td>
                                                        <td>{problem.difficulty}</td>
                                                        <td>{problem.created}</td>
                                                        <td>
                                                            <Switch 
                                                                checked={problem.is_visible}
                                                                height={20} width={40}
                                                                onChange={() => handleVisible(problem.id, problem.is_visible)}
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
                                                                    {/* <div className="option-button">
                                                                        <Button variant="light">
                                                                            <AiOutlineDownload />
                                                                        </Button>
                                                                    </div> */}
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
                </Card>
           </div>
        </div >
    )
}

ProblemList.propTypes = {

}

export default ProblemList

