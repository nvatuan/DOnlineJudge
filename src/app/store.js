import { configureStore } from '@reduxjs/toolkit';
import { userSlice } from '../users/UserSlice';
import { adminSlice } from '../admin/AdminSlice';
import { profileSlice } from '../users/Pages/Profile/profileSlice';
export default configureStore({
    reducer: {
        user: userSlice.reducer,
        admin: adminSlice.reducer,
        profile: profileSlice.reducer,
    },
});