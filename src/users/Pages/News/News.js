import React, { useState, useEffect } from 'react';
import Navbar from '../../Navbar';
import '../Page.scss';
import './News.scss';
import { Card } from 'react-bootstrap';
import oj_announcementAPI from '../../../api/oj_announcementAPI';
import Announcement from '../Home/Announcement';
import Search from '../../Components/Search';

function News() {
    const [announcement, setAnnouncement] = useState([]);
    const [filters, setFilters] = useState({
        filter_by: [],
        sort_by: '',

    });
    useEffect(() => {
        const fetchAnnouncement = async () => {
            try {
                const response = await oj_announcementAPI.getAll(filters);
                setAnnouncement(response.data);
            } catch (error) {
                console.log('fail to announcement: ', error);
            }
        }
        fetchAnnouncement();
    }, [filters])
    //serach process
    function handleSearchForm(newValue) {
        setFilters({
            ...filters,
            contains: newValue,
        })
    }
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
                                            author={annou.author} key={annou.id}
                                            id={annou.id} />
                                    })
                                }
                            </div>
                        </Card.Body>
                    </Card>
                </div>
            </div>
        </div>
    )
}

export default News
