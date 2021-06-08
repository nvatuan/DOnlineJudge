import {createSlice, createAsyncThunk} from '@reduxjs/toolkit'
import admin_users from '../api/admin_usersAPI';
import admin_announcementAPI from '../api/admin_announcementAPI';
import { userSlice } from '../users/UserSlice';
export const UserList = createAsyncThunk(
    '/admin/users',
    async(thunkAPI) => {
        try {
            const response = await admin_users.getAll();
            return response;
        } catch (error) {
            console.log("fail to get user list");
            thunkAPI.rejectWithValue(error.response.json());
        }
    }
);

export const AnnouncementList = createAsyncThunk(
    '/admin/announcements',
    async(thunkAPI) =>{
        try {
            const response = await admin_announcementAPI.getAll();
            return response;
        } catch (error) {
            console.log("fail to get problem list");
            thunkAPI.rejectWithValue(error.response.json());
        }
    }
)
export const deleteAnnouncement = createAsyncThunk(
    '/deleteAnnouncement',
    async(id,thunkAPI) => {
        try {
            await admin_announcementAPI.deleteById(id);
        } catch (error) {
            console.log("fail to get user list");
            thunkAPI.rejectWithValue(error.response.json());
        }
    }
)
export const adminSlice = createSlice({
    name: 'admin',
    initialState: {
        admin_announcements: {},
        admin_users: {},
        admin_problems: {},
        //users
        isFetchUsersSuccess: false,
        //annoucement
        isFetchAnnouncementsSuccess: false,
            //delete
        deleteSusscess: false,
    },
    reducers:{
        clearState: (state) => {
            state.deleteSusscess = false;
            state.isFetchAnnouncementsSuccess = false;
        }
    },
    extraReducers: {
        [UserList.fulfilled]: (state, action) =>{
            // state.users = payload;
            state.isFetchUsersSuccess = true;
            return state;
        },
        [UserList.rejected]: () =>{
            console.log("failt to fetch userList");
           
        },
        //announcements
        [AnnouncementList.fulfilled]: (state, {payload}) =>{
            state.admin_announcements = payload.data;
            state.isFetchAnnouncementsSuccess = true;
        },
        [AnnouncementList.rejected]: (state) =>{
            state.isFetchAnnouncementsSuccess = false;
            console.log("failt to fetch announcements");
        },
        //delete announcement
        [deleteAnnouncement.fulfilled]: (state) =>{
            state.deleteSusscess = true;
        },
        [deleteAnnouncement.rejected]: (state) =>{
            state.deleteSusscess = false;
            console.log("failt to delete announcement");
        }
    }

})

export const { clearState } = adminSlice.actions;
export const adminSelector = (state) => state.admin;