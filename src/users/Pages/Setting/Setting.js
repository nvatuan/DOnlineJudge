import React, { useState, useEffect } from 'react';
import Navbar from '../../Navbar';
import { FaCloudUploadAlt } from 'react-icons/fa'
import Profile from '../Profile/Profile'
import './Setting.scss'
import { Link } from 'react-router-dom';
import EditProfile from '../EditProfile/EditProfile';
import oj_profileAPI from '../../../api/oj_profileAPI';
import { Button } from 'react-bootstrap';
function Setting() {
    const [userData, setUserData] = useState(JSON.parse(localStorage.getItem('userInformation')));
    const [toAccount, setToAccount] = useState(false);
    const [selectFile, setSelectFile] = useState(null);
    const openAccountPage = () => {
        setToAccount(true);
    }
    const openProfilePage = () => {
        setToAccount(false);
    }
    const onChangeUploadFile = (e) => {
        setSelectFile(e.target.files[0]);
    }
    const uploadFile = () => {
        const formData = new FormData();
        formData.append('profile_pic', selectFile);
        const updateAvatar = async () => {
            const response = await oj_profileAPI.uploadAvatar(formData);
            if (response) {
                setUserData(response.data);
                setSelectFile(null);
                window.location.reload();
            }
        }
        updateAvatar();
    }
    useEffect(() => {
        const fetchUserData = async () => {
            const response = await oj_profileAPI.getUserInformation(selectFile);
            setUserData(response.data);
        }
        fetchUserData();
        return () => {
        }
    }, [userData.profile_pic, selectFile])
    return (
        <div>
            <Navbar />
            <div className="setting_container">
                <div className="card_container">
                    <div className="sidebar pages-container">
                        <div className="save-button">
                            {selectFile === null ? <div style={{ padding: "10px 0" }}></div> : <Button variant="light" size="sm" onClick={() => uploadFile()}>save</Button>}
                        </div>
                        <center>
                            <div className="upload-img">
                                <div className="img-container">
                                    <div className="avatar-upload">
                                        <div className="avatar-edit">
                                            <input type='file' id="imageUpload" accept=".png, .jpg, .jpeg" onChange={(e) => { onChangeUploadFile(e) }} />
                                            <label htmlFor="imageUpload"><FaCloudUploadAlt /></label>
                                        </div>
                                        <div className="avatar-preview">
                                            <img src={userData.profile_pic} className="profile_img" style={{ style: "background-image" }} alt="error" />
                                        </div>
                                        <br />
                                        <h4>{localStorage.getItem("username")}</h4>
                                    </div>
                                </div>
                            </div>
                        </center>
                        <a href="#" onClick={() => { openProfilePage() }}><i className="far fa-id-badge"></i><span>Profile</span></a>
                        <a href="#" onClick={() => { openAccountPage() }}><i className="fas fa-user-cog"></i><span>Account</span></a>
                        <div className="sidebar-item">
                            <Link className="profile_submission" to={`status/?probem=&username=${userData.username}`}>
                                <i className="fas fa-history"></i>
                                Submission
                            </Link>
                        </div>
                    </div>
                    <div className="right_container ">
                        {toAccount ? <EditProfile /> : <Profile />}
                    </div>
                </div>

            </div>
        </div>
    )
}

export default Setting;