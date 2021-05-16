import React, {useState, useEffect} from 'react';
import Navbar from '../../Navbar';
import '../Page.scss';
import './Home.scss';
import {Card} from 'react-bootstrap';
import oj_announcementAPI from '../../../api/oj_announcementAPI';

function Home() {
    const [announcement, setAnnouncement] = useState([]);
    useEffect(() => {
        const fetchAnnouncement = async () =>{
            try {
                const response = await oj_announcementAPI.getAll();
                setAnnouncement(response);
            } catch (error) {
                console.log('fail to announcement: ', error);
            }
        }
        fetchAnnouncement();
    },[])
    return (
        <div>
            <Navbar/>
            <div className="pages-container">
                <div className="home-container">
                    <div className="annoucement-container">
                        <Card>
                            <Card.Header as="h3">Annoucement</Card.Header>
                            <Card.Body>
                                <table>
                                    <thead>

                                    </thead>
                                    <tbody>
                                        {
                                            announcement.map(annou => {
                                                return (
                                                    <tr key={annou.id}>
                                                        <td>{annou.title}</td>
                                                        <td>{annou.creation_time}</td>
                                                        <td>{annou.author}</td>
                                                    </tr>
                                                )
                                            })
                                        } 
                                    </tbody>
                                </table>
                            </Card.Body>
                        </Card>
                    </div>
                </div>
            </div>      
        </div>
    )
}

export default Home
