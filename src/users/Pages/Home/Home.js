import React from 'react';
import Navbar from '../../Navbar';
import '../Page.scss';
import './Home.scss';
import {Card} from 'react-bootstrap';
function Home() {
    return (
        <div>
            <Navbar/>
            <div className="pages-container">
                <div className="home-container">
                    <div className="annoucement-container">
                        <Card>
                            <Card.Header as="h3">Annoucement</Card.Header>
                            <Card.Body>
                                <blockquote className="blockquote mb-0">
                                    <p>
                                    </p>
                                    <footer className="blockquote-footer">
                                        Someone famous in <cite title="Source Title">Source Title</cite>
                                    </footer>
                                </blockquote>
                            </Card.Body>
                        </Card>
                    </div>
                </div>
            </div>      
        </div>
    )
}

export default Home
