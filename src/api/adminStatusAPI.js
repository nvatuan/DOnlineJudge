import axiosClient from './axiosClient'
import queryString from 'query-string';

const adminStatusAPI = {
    getAll: (data) => {
        const paramString = queryString.stringify(data);
        const url = `admin/status/?${paramString}`;
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.get(url, config);
    },
    getById: (id) => {
        const url = `admin/status/${id}/`;
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.get(url, config);
    },
    deleteById: (id) =>{
        const url = `admin/status/${id}/`;
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.delete(url, config);
    },
    putById: (id, putType) =>{
        const url = `admin/status/${id}/`;
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.put(url, {put_type: putType}, config);
    },
}

export default adminStatusAPI;
