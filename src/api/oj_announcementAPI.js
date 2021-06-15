import axiosClient from './axiosClient';
import queryString from 'query-string';

const oj_announcementAPI = {
    getAll: (data) => {
        const paramString = queryString.stringify(data);
        const url = `/announcement/?${paramString}`;
        return axiosClient.get(url);
    },
}
export default oj_announcementAPI;