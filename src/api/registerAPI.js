import axiosClient from './axiosClient';

const registerAPI = {
    register: (data) => {
        const url = 'register/';
        return axiosClient.post(url,data);
    }
};

export default registerAPI;