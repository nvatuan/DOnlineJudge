import axios from 'axios';
import queryString from 'query-string';
import { toast } from 'react-toastify';


const axiosClient = axios.create({
baseURL: process.env.REACT_APP_API_URL,
headers: {
    'content-type': 'application/json',
    // 'Access-Control-Allow-Origin': '*',
},
paramsSerializer: params => queryString.stringify(params),
});

axiosClient.interceptors.request.use(async (config) => {
    // Handle token here ...
    return config;
})
axiosClient.interceptors.response.use((response) => {
    if (response && response.data) {
        return response.data;
    }
    return response;
    }, (error) => {
    toast.error(JSON.stringify(error.response.data), {
        position: toast.POSITION.BOTTOM_CENTER,
        autoClose: 1500
    })
    throw error;
});
export default axiosClient;