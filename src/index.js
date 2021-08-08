import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import { Provider } from 'react-redux';
import store from './app/store';

import { ToastContainer } from 'react-toastify';

ReactDOM.render(
  <React.StrictMode>
      <Provider store={store}>
        <ToastContainer/>
        <App />
      </Provider>
  </React.StrictMode>,
  document.getElementById('root')
);
