import { configureStore } from '@reduxjs/toolkit';
import { userSlice } from '../users/UserSlice';

export default configureStore({
    reducer: {
        user: userSlice.reducer
    },
});