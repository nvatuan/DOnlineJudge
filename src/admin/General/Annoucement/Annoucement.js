import React, {useState, useEffect} from 'react'
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { Card, Button, Form} from 'react-bootstrap';
import { AiOutlineEdit, AiOutlineDelete } from 'react-icons/ai';
import { BsFillPlusCircleFill } from 'react-icons/bs';
import '../../Table.scss';
import './Annoucement.scss';
import { useDispatch, useSelector } from 'react-redux';
import { adminSelector, AnnouncementList, deleteAnnouncement, clearState } from '../../AdminSlice';
import { Link } from 'react-router-dom';
import Switch from "react-switch";
import admin_announcementAPI from '../../../api/admin_announcementAPI';
function Annoucement(props) {
    const [annoucements, setAnnoucements] = useState({});
    //for redux
    const dispatch = useDispatch();
    const { admin_announcements, isFetchAnnouncementsSuccess, deleteSusscess } = useSelector(adminSelector);
    //delete announcement
    const HandleDeleteAnnouncement = (id) => {
        if(window.confirm("Are you sure?")){
            dispatch(deleteAnnouncement(id));
        }
    }
    useEffect(()=>{
        dispatch(AnnouncementList());
    }, [])
    useEffect(()=>{
        if (isFetchAnnouncementsSuccess){
            setAnnoucements(admin_announcements);
        }
        return dispatch(clearState());
    }, [isFetchAnnouncementsSuccess])
    useEffect(() =>{
        if (deleteSusscess){
            dispatch(AnnouncementList());
        }
    }, [deleteSusscess])
    //get visible data
    const [visible, setVisible] = useState([]);
    useEffect(() =>{
        const getVisibleList =  () =>{
            const visibleList = [];
            for (let i = 0; i < admin_announcements.length; i++) {
                let announ = admin_announcements[i];
                console.log(announ);
                console.log('ok');
                console.log({ [announ.id]: announ.is_visible });
                visibleList.push({ [announ.id]: announ.is_visible })
            }
            console.log(visibleList);
            setVisible([...visible, visibleList])
        };
        getVisibleList();
    },[])
    //set Visible
    const handleVisible = async (id, is_visible) => {
        try {
            await admin_announcementAPI.updateVisible(id, is_visible);
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
                            Annoucements
                            <div className="create_button">
                                <Link to={`/admin/announcement/new`} className="alter_announcement"> <BsFillPlusCircleFill/> New</Link>
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
                                        annoucements.length > 0 ? (
                                            annoucements.map((annoucement) => (
                                                <tr key={annoucement.id}>
                                                    <td>{annoucement.id}</td>
                                                    <td>{annoucement.title}</td>
                                                    <td>{annoucement.creation_time}</td>
                                                    <td>{annoucement.author_name}</td>
                                                    <td>
                                                        <Switch onChange={() => handleVisible(annoucement.id, annoucement.is_visible)} checked={annoucement.is_visible} height={20} width={40}/>
                                                    </td>
                                                    <td>
                                                        <div className="option-cell">
                                                            <div className="option-button">
                                                                <div className="option-button__items">
                                                                    <Link to={`/admin/announcement/${annoucement.id}`} className="alter_announcement"> <AiOutlineEdit /></Link>
                                                                </div>
                                                                <div className="option-button__items">
                                                                    <Button variant="light" onClick={() => { HandleDeleteAnnouncement(annoucement.id)}}>
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

Annoucement.propTypes = {

}

export default Annoucement

