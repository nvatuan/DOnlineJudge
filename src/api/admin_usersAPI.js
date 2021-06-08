import axiosClient from './axiosClient'

const admin_users = {
    getAll: () =>{
        const url = 'admin/users';
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.get(url,config);
    }
}
export default admin_users;