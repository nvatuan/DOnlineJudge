import React, {useEffect} from 'react';
import { useSelector } from 'react-redux';
import Social_icon from '../../Components/Social_icons/Social_icon';
import { userSelector } from '../../UserSlice';
import './Profile.scss';
function Profile() {
    const { userInformation } = useSelector(userSelector)
    console.log(userInformation);
    return (
        <div>
            <div className="wrapper">
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