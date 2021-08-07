import axiosClient from './axiosClient'
import queryString from 'query-string';

const admin_usersAPI = {
    getAll: (data) =>{
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        const paramString = queryString.stringify(data);
        const url = `admin/users/?${paramString}`;
        return axiosClient.get(url, config);
    },
    getById: (id)=>{
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = `admin/users/${id}`;
        return axiosClient.get(url,config);
    },
    deleteById: (id) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = `admin/users/${id}`;
        return axiosClient.delete(url,config);
    },
    createUser: (data) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = '/admin/users/';
        return axiosClient.post(url,data,config);
    },
    editUser: (data, id) =>{
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = `/admin/users/${id}`;
        return axiosClient.put(url,data,config)
    }
}
export default admin_usersAPI;