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

function News() {
    // ## useState: announcement
    const [announcement, setAnnouncement] = useState([]);
    // ## useState: announcement filters 
    const [filters, setFilters] = useState({
        filter_by: [],
        sort_by: '',
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
    const [currentPage, setCurrentPage] = useState(1);
    const [maxPage, setMaxPage] = useState(1);

    // Paginate: Page click handler
    const handlePageClick = async (props) => {
        setCurrentPage(props.selected);
        setFilters({
            ...filters,
            page: props.selected+1,
        })
    };

    // search process
    function handleSearchForm(newValue) {
        setFilters({
            ...filters,
            contains: newValue,
        })
    };

    return (
        <div>
            <Navbar />
            <div className="pages-container">
                <div className="news-container">
                    <Card className="news-card">
                        <Card.Header as="h3" className="announcement-header">
                            Annoucement
                            <div className="news-feartures">
                                <div className="news-feartures__items">
                                    <Search onSubmit={handleSearchForm} />
                                </div>
                            </div>
                        </Card.Header>
                        <Card.Body>
                            <div className="card-container">
                                {
                                    announcement.map(annou => {
                                        return <Announcement title={annou.title}
                                            content={annou.content}
                                            creation_time={annou.creation_time}
                                            author={annou.author_name} key={annou.id}
                                            id={annou.id} />
                                    })
                                }
                            </div>
                            <div className='pagination-container'> <ReactPaginate 
                                pageCount={maxPage}
                                pageRangeDisplayed={5}
                                marginPagesDisplayed={2}
                                onPageChange={handlePageClick}
                                containerClassName={'pagination'}
                                activeClassName={'active'}
                                breakLabel={'...'}
                                breakClassName={'break-me'}
                            ></ReactPaginate> </div>
                        </Card.Body>
                    </Card>
                </div>
            </div>
        </div>
    )
}

export default News
