import { configureStore } from '@reduxjs/toolkit';
import { userSlice } from '../users/UserSlice';
import { adminSlice } from '../admin/AdminSlice';
export default configureStore({
    reducer: {
        user: userSlice.reducer,
        admin: adminSlice.reducer,
    },
});