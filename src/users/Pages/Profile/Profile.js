import React, { useEffect } from 'react';
import Social_icon from '../../Components/Social_icons/Social_icon';
import './Profile.scss';
import { useDispatch, useSelector } from 'react-redux';
import { profileSelector, userProfile } from './profileSlice';
function Profile() {
    const dispatch = useDispatch();
    const { username, email, first_name, last_name } = useSelector(profileSelector);
    useEffect(() => {
        dispatch(userProfile());
    },[])
    return (
        <div>
            <div className="wrapper pages-container">
                <div className="right">
                    <div className="info">
                        <h3>Information</h3>
                        <div className="info_data">
                            <div className="data">
                                <h4>Email</h4>
                                <p>{email}</p>
                            </div>
                            <div className="data">
                                <h4>Username</h4>
                                <p>{username}</p>
                            </div>
                            <div className="data">
                                <h4>First name</h4>
                                <p>{first_name}</p>
                            </div>
                            <div className="data">
                                <h4>Last name</h4>
                                <p>{last_name}</p>
                            </div>
                        </div>
                    </div>
                    <div className="Social">
                        <h3>Social</h3>
                        <div className="social_media">
                            <Social_icon/>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    )
}

export default Profile
