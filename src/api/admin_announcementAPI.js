import axiosClient from './axiosClient'
const admin_announcementAPI = {
    getAll:  () =>{
        const url = 'admin/announcement/';
        return axiosClient.get(url);
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
        return axiosClient.put(url, data.formData ,config)
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
    }
}

export default admin_announcementAPI;