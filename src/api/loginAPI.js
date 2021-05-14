import axiosClient from'./axiosClient';

const loginAPI = {
    login: (data) => {
        const url = 'login/';
        return axiosClient.post(url, data);
    }
}

export default loginAPI;