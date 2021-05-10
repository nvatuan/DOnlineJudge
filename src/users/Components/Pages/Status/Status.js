import React from 'react';
import PropTypes from 'prop-types';
import { Table } from 'react-bootstrap';
import Navbar from '../../Navbar';
Status.propTypes = {
    
};
const status = [
    {
        when: "2021-5-1 23:46:33",
        id: "1",
        status: "Accepted",
        Problem: "3",
        time: "1s",
        memory: '13kb',
        language: 'c++',
        author: 'root'
    }
]
function Status(props) {
    return (
        <div>
            <Navbar/>
            <Table striped bordered hover>
                <thead>
                    <tr>
                        <th>when</th>
                        <th>ID</th>
                        <th>Problem</th>
                        <th>Time</th>
                        <th>Memory</th>
                        <th>Language</th>
                        <th>Problem</th>
                    </tr>
                </thead>
                <tbody>
                    {
                        status.map(stat => {
                            return (
                                <tr key={stat.id}>
                                    <th>{stat.when}</th>
                                    <th>{stat.id}</th>
                                    <th>{stat.status}</th>
                                    <th>{stat.Problem}</th>
                                    <th>{stat.time}</th>
                                    <th>{stat.memory}</th>
                                    <th>{stat.language}</th>
                                    <th>{stat.author}</th>
                                </tr>
                            )
                        })
                    }
                </tbody>

            </Table>
        </div>
    );
}

export default Status;