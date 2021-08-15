import axiosClient from './axiosClient';

const logoutAPI = {
    logout: () => {
        const url = 'logout/';
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        localStorage.removeItem('token');
        localStorage.removeItem('role');
        localStorage.removeItem('userInformation');
        return axiosClient.get(url,config);
    }
}
export default logoutAPI;
