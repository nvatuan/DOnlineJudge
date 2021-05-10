import axiosClient from './axiosClient';

const oj_statusAPI = {
    getAll: () => {
        const url = 'status/';
        return axiosClient.get(url);
    },
    postProblem: (data) =>{
        const url = 'status/';
        return axiosClient.post(url, {
            body: JSON.stringify(data)
        })
    }
}

export default oj_statusAPI;