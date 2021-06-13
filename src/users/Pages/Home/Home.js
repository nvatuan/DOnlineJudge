import React, { useState, useEffect } from 'react';
import Navbar from '../../Navbar';
import '../Page.scss';
import './Home.scss';
import { Card } from 'react-bootstrap';
import oj_announcementAPI from '../../../api/oj_announcementAPI';
import Announcement from './Announcement';
function Home() {
    const [announcement, setAnnouncement] = useState([]);
    useEffect(() => {
        const fetchAnnouncement = async () => {
            try {
                const response = await oj_announcementAPI.getAll();
                setAnnouncement(response.data);
            } catch (error) {
                console.log('fail to announcement: ', error);
            }
        }
        fetchAnnouncement();
    }, [])
    return (
        <div>
            <Navbar />
            <div className="pages-container">
                <div className="home-container">
                    <div className="left-part home-container__items">
                        <h1>Welcome</h1>
                    </div>
                    <div className="right-part home-container__items">
                        <h1>News</h1>
                        <div className="annoucement-container">
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
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Home
