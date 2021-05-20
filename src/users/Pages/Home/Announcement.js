import { useState } from 'react';
import { Button, Modal } from 'react-bootstrap'
import React from 'react'
import './Announcement.scss'
function Announcement(props) {
    const { title, author, creation_time, content, id } = props;
    const hanldeTime = (time) => {
        return new Date(time).toDateString();
    }
    const [show, setShow] = useState(false);

    const handleShow = () => setShow(true);
    const contentModal = (
        <div>
            <Modal
                show={show}
                onHide={() => setShow(false)}
                dialogClassName="modal-90w"
                aria-labelledby="example-custom-modal-styling-title"
                size = "xl"
                centered
            >
                <Modal.Header closeButton>
                    <Modal.Title id="example-custom-modal-styling-title">
                        Annoucement #{id}
                    </Modal.Title>
                </Modal.Header>
                <Modal.Body>
                    {content}
                </Modal.Body>
            </Modal>
        </div>
    )
    return (
            <div className="announcement-container">
                <article>
                    <div className="annou_head">
                    <h3>From:  {author}</h3>
                    <div className="creation_time">
                        <p>{hanldeTime(creation_time)}</p>
                    </div>
                    </div>
                    <div className="annou_detail">
                        <h3>{title}</h3>       
                    </div>

                    <div className="more-button">
                    <Button onClick={handleShow}>More...</Button>
                    {contentModal}
                    </div>
                </article>
            </div>
    )
}

export default Announcement
