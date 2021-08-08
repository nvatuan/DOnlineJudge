import axiosClient from './axiosClient';
import queryString from 'query-string';

const oj_announcementAPI = {
    getAll: (data) => {
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
}
export default oj_announcementAPI;