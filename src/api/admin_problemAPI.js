import axiosClient from "./axiosClient";
const admin_problemAPI = {
    getAll: () => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        const url = 'admin/problem/';
        return axiosClient.get(url,config);
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
    updateVisible: (id, isVisible) =>{
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = `admin/problem/${id}/`;
        const visible = {is_visible: !isVisible};
        return axiosClient.put(url,visible,config);
    }
}

export default admin_problemAPI
