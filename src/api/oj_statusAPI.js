import axiosClient from './axiosClient';
import queryString from 'query-string';
const oj_statusAPI = {
    getAll: (data) => {
        const paramString = queryString.stringify(data);
        const url = `status/?${paramString}`;
        return axiosClient.get(url);
    },
    postProblem: (data) =>{
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        const url = 'status/';
        return axiosClient.post(url, data, config);
    },
    getById: (id) => {
        const url = `status/${id}`;
        return axiosClient.get(url);
    },
    getByAuthor: (authorId) => {
        const url = `status/${authorId}}`;
        return axiosClient.get(url);
    }

}

export default oj_statusAPI;