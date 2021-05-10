import axiosClient from "./axiosClient";

const annoucementAPI = {
    getAll: () => {
        const url = 'admin/announcement/';
        return axiosClient.get(url);
    }
}

export default annoucementAPI;