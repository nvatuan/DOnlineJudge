import React, { useState, useEffect } from 'react'
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { Card, Button, Form } from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDelete } from 'react-icons/ai';
import { BsFillPlusCircleFill } from 'react-icons/bs';
import '../../Table.scss';
import './Announcement.scss';
import { useDispatch, useSelector } from 'react-redux';
import { adminSelector, deleteAnnouncement} from '../../AdminSlice';
import { Link } from 'react-router-dom';
import Switch from "react-switch";
import admin_announcementAPI from '../../../api/admin_announcementAPI';
import Collapsible from 'react-collapsible';
import {BsChevronDown} from 'react-icons/bs';
import ReactPaginate from 'react-paginate';

function Announcement(props) {
    const [filters, setFilters] = useState({
        filter_by: [],
        sort_by: '-id',
        page: 1,
    });
    const [announcements, setAnnouncements] = useState([]);
    //for redux
    const dispatch = useDispatch();
    const { deleteSusscess } = useSelector(adminSelector);
    //delete announcement
    const HandleDeleteAnnouncement = (id) => {
        if (window.confirm("Are you sure?")) {
            dispatch(deleteAnnouncement(id));
        }
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

    useEffect (() => {
        const fetchProblemByFilters = async() => {
            try {
                const resp = await admin_announcementAPI.getAll(filters);
                setAnnouncements(resp.data)
                setMaxPage(resp.maxpage)
            } catch (error) {
                console.log(error);
            }
        }
        fetchProblemByFilters();
    }, [filters, deleteSusscess])

    //set Visible
    const handleVisible = async (id, is_visible) => {
        try {
            const res = await admin_announcementAPI.updateVisible(id, is_visible);
            const newann = res.data;
            setAnnouncements(
                announcements.map(
                    (ann) => ann.id === newann.id ? { ...ann, is_visible: newann.is_visible } : ann
                )
            )
            console.log("Update announcements")
        } catch (error) {
            console.log("Fail to set visibility:", error);
        }
    }

    const [searchContent, setSearchContent] = useState('')
    const [searchAuthor, setSearchAuthor] = useState('')
    const handleFilterFormSubmit = (e) => {
        if (e !== undefined) e.preventDefault()
        let newFilter = {...filters, filter_by:[]};
        delete newFilter['contains']
        delete newFilter['author_name']

        if (searchContent !== '') {
            newFilter = {...newFilter, contains: searchContent}
        }
        if (searchAuthor !== '') {
            newFilter.filter_by.push('author_name')
            newFilter = {...newFilter, author_name: searchAuthor}
        } 
        setFilters(newFilter);
    }
    const handleFilterFormReset = (e) => {
        setSearchContent(''); setSearchAuthor('');
        let newFilter = {...filters, filter_by:[]};
        delete newFilter['contains']
        delete newFilter['author_name']
        setFilters(newFilter);
    }

    return (
        <div className="">
            <AdminNavbar />
            <Sidebar />
            <div className="announcements-container">
                <div className="table-view admin-announcement">
                    <Card className='admin-card'>
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
                                </div>
                                <Button variant="primary" type="submit" onClick={handleFilterFormSubmit}>Submit</Button>
                                <Button variant="light" type="reset" onClick={handleFilterFormReset}>Reset</Button>
                            </Form>
                        </Collapsible>
                        <Card>
                            <Card.Header as="h3" className="announcement-header">
                                Announcements
                                <div className="create_button">
                                    <Link to={`/admin/announcement/new`} className="alter_announcement"> <BsFillPlusCircleFill /> New</Link>
                                </div>
                            </Card.Header>
                            <Card.Body>
                                < table >
                                    <thead>
                                        <tr>
                                            <th onClick={() => setSortByCriteria('id')}>ID</th>
                                            <th onClick={() => setSortByCriteria('title')}>Title</th>
                                            <th onClick={() => setSortByCriteria('creation_time')}>Create Time</th>
                                            <th onClick={() => setSortByCriteria('author_name')}>Author</th>
                                            <th onClick={() => setSortByCriteria('is_visible')}>Visibility</th>
                                            <th>Option</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {
                                            announcements.length > 0 ? (
                                                announcements.map((announcement) => (
                                                    <tr key={announcement.id}>
                                                        <td>{announcement.id}</td>
                                                        <td>{announcement.title}</td>
                                                        <td>{announcement.creation_time}</td>
                                                        <td>{announcement.author_name}</td>
                                                        <td>
                                                            <Switch onChange={() => handleVisible(announcement.id, announcement.is_visible)} checked={announcement.is_visible} height={20} width={40} />
                                                        </td>
                                                        <td>
                                                            <div className="option-cell">
                                                                <div className="option-button">
                                                                    <div className="option-button__items">
                                                                        <Link to={`/admin/announcement/${announcement.id}`} className="alter_announcement"> <AiOutlineEdit /></Link>
                                                                    </div>
                                                                    <div className="option-button__items">
                                                                        <Button variant="light" onClick={() => { HandleDeleteAnnouncement(announcement.id) }}>
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
                                                    <td colSpan={6}>Nothing</td>
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
                    </Card>
                </div>
            </div>
        </div>
    )
}

Announcement.propTypes = {

}

export default Announcement

