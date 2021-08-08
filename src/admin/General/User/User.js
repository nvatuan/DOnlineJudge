import React, { useEffect, useState } from 'react';
import { Card, Button } from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDelete } from 'react-icons/ai';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import '../../Table.scss';
import './User.scss';
import { Link } from 'react-router-dom';
import { BsChevronDown, BsFillPlusCircleFill } from 'react-icons/bs';
import ReactPaginate from 'react-paginate';
import admin_usersAPI from '../../../api/admin_usersAPI';
import {Form} from 'react-bootstrap';
import Collapsible from 'react-collapsible';

function User(props) {
    const [users, setUsers] = useState([]);

    //delete
    const handleDeleteUser = async (id) => {
        if (window.confirm("Are you sure you want to delete this User?")) {
            const resp = await admin_usersAPI.deleteById(id);
            if (resp) {
                setUsers(users.filter((user) => {return user.id !==id}))
            }
        }
    }
    // ---------------------------------------------------------------------
    const [filters, setFilters] = useState({
        filter_by: [],
        sort_by: '-id',
        page: 1,
    });
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

    // --------------- useEffect to fetch users list
    useEffect(() => {
        const fetchAll = async() => {
            try {
                const resp = await admin_usersAPI.getAll(filters)
                setUsers(resp.data)
                setMaxPage(resp.maxpage)
            } catch (error) {
                console.log(error)
            }
        }
        fetchAll()
    }, [filters])

    // 
    const [searchContent, setSearchContent] = useState('')
    const [searchUserType, setSearchUserType] = useState('')

    // Search&Filter form event hanlder
    const handleFilterFormSubmit = (e) => {
        e.preventDefault();
        let newFilter = {...filters, filter_by: []};
        delete newFilter['contains'];
        delete newFilter['admin_type'];
        if (searchContent !== '') 
            newFilter['contains'] = searchContent
        if (searchUserType !== '') {
            newFilter.filter_by.push('admin_type')
            newFilter.admin_type = searchUserType
        }
        setFilters(newFilter)
    }
    const handleFilterFormReset = () => {
        setSearchContent(''); setSearchUserType('');
        let newFilter = {...filters, filter_by:[]};
        delete newFilter['contains']
        delete newFilter['admin_type']
        setFilters(newFilter);
    }

    return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="admin-user table-view">
                <Card className='admin-card'>
                    <Collapsible trigger={["Search/Filter", <BsChevronDown key='chevron-admin-user'/>]} easing='ease'>
                        <Form className="filter_form">
                            <div className="filter_form_items">
                                <Form.Group className="search-content">
                                    <Form.Label>Search</Form.Label>
                                    <Form.Control type="text" placeholder="Content" onChange={(e)=>{setSearchContent(e.target.value)}}/>
                                </Form.Group>

                                <Form.Group className="filter-user-type">
                                    <Form.Label>User Type</Form.Label>
                                    <Form.Control as="select" className="user-type-filter-by" onChange={(e)=>{setSearchUserType(e.target.value)}}>
                                        <option value="">All</option>
                                        <option value="Regular User">User</option>
                                        <option value="Admin">Admin</option>
                                        <option value="Super Admin">Super Admin</option>
                                    </Form.Control>
                                </Form.Group>
                            </div>
                            <Button variant="primary" type="submit" onClick={handleFilterFormSubmit}>Submit</Button>
                            <Button variant="light" type="reset" onClick={handleFilterFormReset}>Reset</Button>
                        </Form>
                    </Collapsible>
                    <Card.Header as="h4" className="user-header">
                        Users
                        <div className="create_button">
                            <Link to={`/admin/user/create`} className="alter_announcement"> <BsFillPlusCircleFill /> Create </Link>
                        </div>
                    </Card.Header>
                    <Card.Body>
                            < table >
                                <thead>
                                    <tr>
                                        <th onClick={() => setSortByCriteria('id')}>ID</th>
                                        <th onClick={() => setSortByCriteria('username')}>Username</th>
                                        <th onClick={() => setSortByCriteria('create_time')}>Created</th>
                                        <th onClick={() => setSortByCriteria('last_login')}>Last Login</th>
                                        <th onClick={() => setSortByCriteria('admin_type')}>User Type</th>
                                        <th>Option</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {
                                        users.length > 0 ? (
                                            users.map((user) => (
                                                <tr key={user.id}>
                                                    <td>{user.id}</td>
                                                    <td>{user.username}</td>
                                                    <td>{user.create_time}</td>
                                                    <td>{user.last_login}</td>
                                                    <td>{user.admin_type}</td>
                                                    <td>
                                                        <div className="option-cell">
                                                            <div className="option-button">
                                                                <div className="option-button__items">
                                                                        <Link to={`/admin/user/${user.id}`} className="alter-user-button"><AiOutlineEdit /></Link>
                                                                </div>
                                                                <div className="option-button__items">
                                                                    <Button variant="light" onClick={() => { handleDeleteUser(user.id)}}>
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
                                                <td colSpan={5}>No user</td>
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
        </div>
    )
}

export default User;

