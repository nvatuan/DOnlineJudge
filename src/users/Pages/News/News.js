import React, { useState, useEffect } from 'react';
import Navbar from '../../Navbar';
import '../Page.scss';
import './News.scss';
import { Card } from 'react-bootstrap';
import oj_announcementAPI from '../../../api/oj_announcementAPI';
import Announcement from '../Home/Announcement';
import Search from '../../Components/Search';

import ReactPaginate from 'react-paginate';
import '../../Components/Pagination/Paginate.css'
import TextFieldForm from '../../Components/TextFieldForm';

function News() {
    // ## useState: announcement
    const [announcement, setAnnouncement] = useState([]);
    // ## useState: announcement filters 
    const [filters, setFilters] = useState({
        filter_by: [],
        sort_by: '-id',
        page: 1,
    });

    // ## USE EFFECT
    useEffect(() => {
        const fetchAnnouncement = async () => {
            try {
                const response = await oj_announcementAPI.getAll(filters);
                setAnnouncement(response.data);
                setMaxPage(response.maxpage);
            } catch (error) {
                console.log('Fail to fetch announcement: ', error);
            }
        }
        fetchAnnouncement();
    }, [filters])

    // ## useState: paginate
    const [maxPage, setMaxPage] = useState(0);

    // Paginate: Page click handler
    const handlePageClick = async (props) => {
        setFilters({
            ...filters,
            page: props.selected+1,
        })
    };

    // search process
    function handleSearchContentForm(newValue) {
        var newFilter = {...filters}
        delete newFilter['contains']
        if (newValue!=='') {
            newFilter.contains=newValue
        }
        setFilters(newFilter)
    };
    function handleSearchAuthorForm(newValue) {
        var newFilter = {...filters}
        delete newFilter['author_name']
        if (newValue!=='') {
            newFilter.filter_by=['author_name']
            newFilter.author_name=newValue
        }
        setFilters(newFilter)
    };

    return (
        <div>
            <Navbar />
            <div className="pages-container">
                <div className="news-container">
                    <Card className="news-card">
                        <Card.Header as="h3" className="announcement-header">
                            Announcement
                            <div className="news-features">
                                <div className="news-features__items">
                                    <Search onSubmit={handleSearchContentForm} />
                                </div>
                                <div className="news-features__items">
                                    <TextFieldForm onSubmit={handleSearchAuthorForm} placeHolder={"Author"}/>
                                </div>
                            </div>
                        </Card.Header>
                        <Card.Body>
                            <div className="card-container">
                                {
                                    announcement.length === 0 
                                    ? <p>Nothing</p>
                                    : announcement.map(annou => {
                                        return <Announcement title={annou.title}
                                            content={annou.content}
                                            creation_time={annou.creation_time}
                                            author={annou.author_name} key={annou.id}
                                            id={annou.id}
                                            is_visible={annou.is_visible}
                                        />
                                    })
                                }
                            </div>
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
                                    breakClassName={'break-me'}
                                ></ReactPaginate> 
                            }</div>
                        </Card.Body>
                    </Card>
                </div>
            </div>
        </div>
    )
}

export default News
