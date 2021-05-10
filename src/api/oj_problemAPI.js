import axiosClient from './axiosClient';

const oj_problemAPI = {
    getAll: () => {
        const url = 'problem/';
        return axiosClient.get(url);
    },
    getById: (id) => {
        const url = `problem/${id}`;
        return axiosClient.get(url);  
    }
}

export default oj_problemAPI