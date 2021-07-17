import React, {useState, useEffect} from 'react'
import { Redirect, Route } from 'react-router-dom';

export const PrivateRouteAdmin = ({ component: Component, ...rest }) => {
    return (
        <Route
            {...rest}
            render={(props) =>
                localStorage.getItem('role') === "Admin" ? (
                    <Component {...props} />
                ) : (
                    <Redirect to={{ pathname: '404', state: { from: props.location } }} />
                )
            }
        />
    )
}
