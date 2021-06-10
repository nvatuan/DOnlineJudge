import React from 'react';
import Social_icon from '../../Components/Social_icons/Social_icon';
import './Profile.scss';
function Profile() {
    const userInformation = JSON.parse(localStorage.getItem('userInformation'));
    return (
        <div>
            <div className="wrapper pages-container">
                <div className="right">
                    <div className="info">
                        <h3>Information</h3>
                        <div className="info_data">
                            <div className="data">
                                <h4>Email</h4>
                                <p>{userInformation.email}</p>
                            </div>
                            <div className="data">
                                <h4>User ID</h4>
                                <p>{userInformation.id}</p>
                            </div>
                            <div className="data">
                                <h4>First name</h4>
                                <p>{userInformation.first_name}</p>
                            </div>
                            <div className="data">
                                <h4>Last name</h4>
                                <p>{userInformation.last_name}</p>
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
