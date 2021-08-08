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
    // console.log("Error", error.response)
    const invalidTokenMsgs = ["Invalid token", "Token has expired"];
    // console.log(invalidTokenMsgs.includes(error.response.data.detail))

    if (error.response.status === 401){
        if (invalidTokenMsgs.includes(error.response.data.detail)){
            localStorage.removeItem('token');
            localStorage.removeItem('role');
            localStorage.removeItem('userInformation');
            localStorage.setItem('force-logout', true);

            window.location.href="/";
            return;
        }
    }
    var error_messsage = error.response.data.data;
    if (typeof error.response.data.data === 'object'){
        for (let key in error_messsage){
            toast.error(error_messsage[key], {
                position: toast.POSITION.BOTTOM_CENTER,
                autoClose: 2500,
            })
        }
    } else {
        var error_messsage = error.response.data.data;
        toast.error(error_messsage, {
            position: toast.POSITION.BOTTOM_CENTER,
            autoClose: 2500,
        })
    }
    throw error;
});
export default axiosClient;