import axiosClient from "./axiosClient";
import queryString from 'query-string';

const admin_problemAPI = {
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
        const url = `admin/problem/${id}`;
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.get(url, config);
    },
    deleteById: (id) => {
        const url = `admin/problem/${id}`;
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.delete(url, config);
    },
    updateById: (data) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        const url = `admin/problem/${data.id}/`;
        return axiosClient.put(url, data.formData, config)
    },
    createProblem: (data) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = 'admin/problem/';
        return axiosClient.post(url, data, config);
    },
    updateVisible: (id) =>{
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = `admin/problem/${id}/`;
        const payload = {'toggle_visibility':'true'}
        return axiosClient.put(url, payload,config);
    },

    getAllProblemTags: () => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        const url = 'problem_tag/';
        return axiosClient.get(url,config);
    }
}

export default admin_problemAPI
