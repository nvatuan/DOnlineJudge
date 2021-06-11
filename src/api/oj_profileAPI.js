import axiosClient from './axiosClient';

const oj_profileAPI = {
    getUserInformation: () =>{
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = '/profile/';
        return axiosClient.get(url,config);
    },
    editUserInformation: (data) =>{
        Object.assign(data, { email: "", "profile_pic": "",});
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = '/profile/';
        return axiosClient.put(url,data,config);
    },
    uploadAvatar: (data) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = '/profile/';
        return axiosClient.put(url,data,config);
    },
    changePassword: (data) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = '/profile/change-password/';
        return axiosClient.put(url,data,config);
    }
}
export default oj_profileAPI;