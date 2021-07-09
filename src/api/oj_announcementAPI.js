import axiosClient from './axiosClient';
import queryString from 'query-string';

const oj_announcementAPI = {
    getAll: (data) => {
        // const token = localStorage.getItem('token');
        // let config = {
        //     headers: {
        //         'Authorization': 'Token ' + token,
        //     }
        // }
        const paramString = queryString.stringify(data);
        const url = `/announcement/?${paramString}`;
        return axiosClient.get(url);
    },
}
export default oj_announcementAPI;