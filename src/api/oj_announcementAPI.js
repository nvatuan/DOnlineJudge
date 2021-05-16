import axiosClient from './axiosClient';

const oj_announcementAPI = {
    getAll: () => {
        const url = 'announcement/';
        return axiosClient.get(url);
    },
}
export default oj_announcementAPI;