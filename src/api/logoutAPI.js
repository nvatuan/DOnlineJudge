import axiosClient from './axiosClient';

const logoutAPI = {
    logout: () => {
        const url = 'logout/';
        return axiosClient(url);
    }
}
export default logoutAPI;