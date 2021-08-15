import axiosClient from './axiosClient'
import queryString from 'query-string';

const admin_announcementAPI = {
    getAll: (data) =>{
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        const paramString = queryString.stringify(data);
        const url = `/announcement/?${paramString}`;
        if(token === null) return axiosClient.get(url);
        return axiosClient.get(url, config);
    },
    getById: (id) => {
        const url = `admin/announcement/${id}`;
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.get(url, config);
    },
    deleteById:(id) => {
        const url = `admin/announcement/${id}`;
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.delete(url,config);
    },
    updateById: (data) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        const url = `admin/announcement/${data.id}/`;
        return axiosClient.put(url, data.formData, config)
    },
    createAnnouncemt: (data) => {
        const token = localStorage.getItem('token');
        console.log(data);
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = 'admin/announcement/';
        return axiosClient.post(url,data,config);
    },
    updateVisible: (id, visible) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            },
        }
        const url = `/admin/announcement/${id}/`;
        const setVisible = { "is_visible": !visible, };
        return axiosClient.put(url, setVisible,config);
    }
}

export default admin_announcementAPI;
