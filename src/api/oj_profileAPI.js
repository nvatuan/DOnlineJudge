import axiosClient from './axiosClient';
import axioiClent from './axiosClient';

const oj_profileAPI = {
    getUserInformation: () =>{
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = '/profile/';
        return axioiClent.get(url,config);
    },
    editUserInformation: (data) =>{
        Object.assign(data, { email: "", "profile_pic": "",});
        console.log(data);
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = '/profile/';
        return axiosClient.put(url,data,config);
    }
}
export default oj_profileAPI;