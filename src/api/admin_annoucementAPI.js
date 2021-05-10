import React from 'react'
import axiosClient from './'
const admin_annoucementAPI = {
    getAll:  () =>{
        const url = 'admin/announcement/';
        return axiosClient.get(url);
    }
}

export default admin_annoucementAPI
