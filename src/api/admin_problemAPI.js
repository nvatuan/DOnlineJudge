import axiosClient from "./axiosClient";
const admin_problemAPI = {
    getAll: () => {
        const url = 'admin/problem/';
        return axiosClient.get(url);
    }
}

export default admin_problemAPI
