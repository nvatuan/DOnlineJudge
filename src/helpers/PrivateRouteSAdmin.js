import React, { useState, useEffect } from 'react'
import { Redirect, Route } from 'react-router-dom';
export const PrivateRouteSAdmin = ({ component: Component, ...rest }) => {
    return (
        <Route
            {...rest}
            render={(props) =>
                localStorage.getItem('role') === "Super Admin" ? (
                    <Component {...props} />
                ) : (
                    <Redirect to={{ pathname: '404', state: { from: props.location } }} />
                )
            }
        />
    )
}
