import axiosClient from './axiosClient';
import queryString from 'query-string';

const oj_problemAPI = {
    getAll: (data) => {
        const paramString = queryString.stringify(data);
        const url = `problem/?${paramString}`;
        console.log(url);
        return axiosClient.get(url);
    },
    getById: (id) => {
        const url = `problem/${id}`;
        return axiosClient.get(url);  
    }
    
}

export default oj_problemAPI