import { createSlice, createAsyncThunk } from "@reduxjs/toolkit";
import oj_profileAPI from '../../../api/oj_profileAPI';
import { userSlice } from "../../UserSlice";

export const userProfile = createAsyncThunk(
    '/profile',
    async(thunkAPI) => {
        try{
            const response = await oj_profileAPI.getUserInformation();
            return response;
        }catch( error ){
            thunkAPI.rejectWithValue(error.response.json());
        }
    }
);

export const profileSlice = createSlice({
    name: 'profile',
    initialState: {
        profile_pic: '',
        authored_problem: [],
        username: '',
        email: '',
        first_name: '',
        last_name: '',
        admin_type: '',
        last_login: '',
    },
    reducers:{
        clearState: (state) =>{
            state.profile_pic = '';
            state.authored_problem = [];
            state.username = '';
            state.email = '';
            state.first_name = '';
            state.last_name = '';
            state.admin_type = '';
            state.last_login = '';
            return state;
        }
    },
    extraReducers:{
        [userProfile.fulfilled]: (state, { payload }) =>{
            state.profile_pic = payload.data.profile_pic;
            state.authored_problem = payload.data.authored_problem;
            state.username = payload.data.username;
            state.email = payload.data.email;
            state.first_name = payload.data.first_name;
            state.last_name = payload.data.last_name;
            state.admin_type = payload.data.admin_type;
            state.last_login = payload.data.last_login
        },
        [userProfile.rejected]: () => {

        }
    }
})

export const { clearState } = userSlice.actions;
export const profileSelector = (state) => state.profile;