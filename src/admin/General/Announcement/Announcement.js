import React, { useState, useEffect } from 'react'
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { Card, Button, Form } from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDelete } from 'react-icons/ai';
import { BsFillPlusCircleFill } from 'react-icons/bs';
import '../../Table.scss';
import './Announcement.scss';
import { useDispatch, useSelector } from 'react-redux';
import { adminSelector, AnnouncementList, deleteAnnouncement, clearState } from '../../AdminSlice';
import { Link } from 'react-router-dom';
import Switch from "react-switch";
import admin_announcementAPI from '../../../api/admin_announcementAPI';
function Announcement(props) {
    const [announcements, setAnnouncements] = useState([]);
    //for redux
    const dispatch = useDispatch();
    const { admin_announcements, isFetchAnnouncementsSuccess, deleteSusscess } = useSelector(adminSelector);
    //delete announcement
    const HandleDeleteAnnouncement = (id) => {
        if (window.confirm("Are you sure?")) {
            dispatch(deleteAnnouncement(id));
        }
    }
    useEffect(() => {
        dispatch(AnnouncementList());
    }, [])
    useEffect(() => {
        if (isFetchAnnouncementsSuccess) {
            setAnnouncements(admin_announcements);
        }
        return dispatch(clearState());
    }, [isFetchAnnouncementsSuccess]);
    useEffect(() => {
        if (deleteSusscess) {
            dispatch(AnnouncementList());
        }
    }, [deleteSusscess])
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
    return (
        <div className="">
            <AdminNavbar />
            <Sidebar />
            <div className="announcements-container">
                <div className="table-view">
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
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Create time</th>
                                        <th>Author</th>
                                        <th>Visible</th>
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
                        </Card.Body>
                    </Card>
                </div>
            </div>
        </div>
    )
}

Announcement.propTypes = {

}

export default Announcement

