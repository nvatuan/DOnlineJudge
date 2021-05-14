import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';
import loginAPI from '../api/loginAPI';

export const loginUser = createAsyncThunk(
    '/login',
    async ({username, password }, thunkAPI) => {
        console.log('access to redux thunk');
        try {
            const response = await loginAPI.login({username, password});
            if(response.token !== null){
                console.log('set Token');
                localStorage.setItem('token', response.token);
                return response;
            }else{
                return thunkAPI.rejectWithValue(response);
            }
        } catch (error) {
            console.log('Fail to login: ', error);
            thunkAPI.rejectWithValue(error.response.response);
        }
    }
);

export const userSlice = createSlice({
    name: 'user',
    initialState: {
        username: '',
        isSuccess: '',
        isError: '',
    },
    reducers:{
        clearState: (state) => {
            state.isError = false;
            state.isSuccess = false;

            return state;
        }
    },

    extraReducers:{
        [loginUser.fulfilled]: (state, { payload }) =>{
            state.username = payload.username;
            state.isSuccess = true;
            return state;
        },
        [loginUser.rejected]: (state, {payload}) => {
            state.isError = true;
        }
    },
})

export const { clearState } = userSlice.actions;

export const userSelector = (state) => state.user;