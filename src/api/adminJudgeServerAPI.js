import axiosClient from './axiosClient'
const adminJudgeServerAPI = {
    getAll:  () =>{
        const url = 'admin/judgeserver/';
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.get(url, config);
    },
    getById: (id) => {
        const url = `admin/judgeserver/${id}`;
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        }
        return axiosClient.get(url, config);
    },
    deleteById:(id) => {
        const url = `admin/judgeserver/${id}`;
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
        const url = `admin/judgeserver/${data.id}/`;
        return axiosClient.put(url, data.formData ,config)
    },
    addJudgeServer: (data) => {
        const token = localStorage.getItem('token');
        let config = {
            headers: {
                'Authorization': 'Token ' + token,
            }
        };
        const url = 'admin/judgeserver/';
        return axiosClient.post(url, data, config);
    },
}

export default adminJudgeServerAPI;
