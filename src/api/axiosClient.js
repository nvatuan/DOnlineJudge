import axios from 'axios';
import queryString from 'query-string';
import { toast } from 'react-toastify';
import { useHistory } from 'react-router-dom';



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
    if (error.response.status === 401){
        if (error.response.data.detail == "Token has expired"){
            const history = useHistory();
            localStorage.removeItem('token');
            localStorage.removeItem('role');
            localStorage.removeItem('userInformation');
            history.push("/");
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