import React from 'react';
import { ListGroup, Button, Form } from 'react-bootstrap';
import Editor from '../../editor/Editor';
import Swit from '../../switch/Swit';
import './Createproblem.scss';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import Sample from '../../Sample/Sample'
function Createproblem(props) {
    return (
        <div className="Edit-container">
            <AdminNavbar />
            <Sidebar />
            <div className="cp">
                <ListGroup>
                    <ListGroup.Item className="cp-header cp-list" >
                        <h3>Add problem</h3>
                    </ListGroup.Item>
                    <ListGroup.Item className="cp-list">
                        <table>
                            <tr>
                                <td className="td-dis">
                                    <i style={{ color: 'red' }}>*</i>
                                    <span> Display ID</span> <br /> <br />
                                    <input type="text" autocomplete="off" placeholder="Display ID" className="cp-displayid" />
                                </td>
                                <td className="td-til">
                                    <i style={{ color: 'red' }}>*</i>
                                    <span> Title</span> <br /> <br />
                                    <input type="text" autocomplete="off" placeholder="Title" className="cp-title" />
                                </td>
                            </tr>
                        </table>

                    </ListGroup.Item>
                    <ListGroup.Item className="cp-list">
                        <i style={{ color: 'red' }}>*</i>
                        <span> Description</span> <br /> <br />
                        <Editor></Editor>
                    </ListGroup.Item>
                    <ListGroup.Item className="cp-list">
                        <i style={{ color: 'red' }}>*</i>
                        <span> Input Description</span> <br /> <br />
                        <Editor></Editor>
                    </ListGroup.Item>
                    <ListGroup.Item className="cp-list">
                        <i style={{ color: 'red' }}>*</i>
                        <span> Output Description</span> <br /> <br />
                        <Editor></Editor>
                    </ListGroup.Item>
                    <ListGroup.Item className="cp-list">
                        <table>
                            <tr>
                                <td className="td-time">
                                    <i style={{ color: 'red' }}>*</i>
                                    <span> Time Limit (ms)</span> <br /> <br />
                                    <input type="Number" autocomplete="off" placeholder="Time Limit" className="cp-time" />
                                </td>
                                <td className="td-mem">
                                    <i style={{ color: 'red' }}>*</i>
                                    <span> Memory limit (MB)</span> <br /> <br />
                                    <input type="Number" autocomplete="off" placeholder="Memory limit (MB)" className="cp-mem" />
                                </td>
                                <td className="td-dif">
                                    <i style={{ color: 'red' }}>*</i>
                                    <span> Difficult</span> <br /> <br />
                                    <select name="Difficulty" className="cp-dif">
                                        <option value="Low">Low</option>
                                        <option value="Mid">Mid</option>
                                        <option value="High">High</option>
                                    </select>
                                </td>
                            </tr>
                            <br />
                            <tr>
                                <td>
                                    <span> Visible</span> <br /> <br />
                                    <Swit></Swit></td>
                                <td>
                                    <i style={{ color: 'red' }}>*</i>
                                    <span> Language</span> <br /> <br />
                                    <input
                                        onChange="{handleLanguageChange}"
                                        type="checkbox"
                                        name="Language"
                                        value="C"
                                    />C
                                <input
                                        onChange="{handleLanguageChange}"
                                        type="checkbox"
                                        name="Language"
                                        value="C++"
                                    />C++
                                <input
                                        onChange="{handleLanguageChange}"
                                        type="checkbox"
                                        name="Language"
                                        value="Java"
                                    />Java
                                 <input
                                        onChange="{handleLanguageChange}"
                                        type="checkbox"
                                        name="Language"
                                        value="Python"
                                    />Python
                            </td>

                            </tr>
                        </table>

                    </ListGroup.Item>
                    <ListGroup.Item className="cp-list">
                        <i style={{ color: 'red' }}>*</i>
                        <span> Sample</span> <br /> <br />
                        <Sample></Sample>
                    </ListGroup.Item>
                    <ListGroup.Item className="cp-list">
                        <span> Hint</span> <br /> <br />
                        <Editor></Editor>
                    </ListGroup.Item >
                    <ListGroup.Item className="cp-list">
                        <table>
                            <tr>
                                <td className="td-type">
                                    <span> Type</span> <br /> <br />
                                    <input type="radio" name="type" value="ACM" />ACM
                                <br />
                                    <input inline type="radio" name="type" value="IO" />IO
                            </td>
                                <td className="td-test ">
                                    <span> Test Case</span> <br /> <br />
                                    <input type="file" />

                                </td>
                                <td className="td-io">
                                    <span> IO mode</span> <br /> <br />
                                    <input type="radio" name="io" value="standard" />Standard IO
                                <br />
                                    <input inline type="radio" name="io" value="file" />File IO
                            </td>
                            </tr>
                        </table>
                    </ListGroup.Item>
                    <ListGroup.Item className="cp-list">
                        <Button className="cp-btn" variant="save">Save</Button>{' '}
                    </ListGroup.Item>


                </ListGroup>
            </div >
        </div>
    );
}

export default Createproblem;