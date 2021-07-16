import axiosClient from './axiosClient';
import queryString from 'query-string';

const oj_problemAPI = {
    getAll: (data) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        const paramString = queryString.stringify(data);
        const url = `problem/?${paramString}`;
        if (token === null) return axiosClient.get(url);
        return axiosClient.get(url, config);
    },
    getById: (id) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        const url = `problem/${id}`;
        if (token === null) return axiosClient.get(url);
        return axiosClient.get(url, config);
    }
    
}

export default oj_problemAPI