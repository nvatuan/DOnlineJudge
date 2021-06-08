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
}

export default admin_announcementAPI;
