import React, { useState, useEffect } from 'react';
import { ListGroup, Button, Form } from 'react-bootstrap';
import Editor from '../../editor/Editor';
import Swit from '../../switch/Swit';
import './Createproblem.scss';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { useForm } from 'react-hook-form'
import { useHistory } from 'react-router-dom';

function Createproblem(props) {
    const { register, handleSubmit } = useForm();
    const [displayID, setDisplayID] = useState('');
    const [title, setTitle] = useState('');
    const history = useHistory();
    const onSubmit = async (formData) => {
        console.log(formData);
        formData.displayID = displayID;
        formData.title = title;
        if (!isNaN(id)) {
            try {
                const response = await admin_announcementAPI.updateById({ formData, id });

                if (response) {
                    history.push('/admin/announcement/');
                }
            } catch (error) {
                console.log("Fail to put problem: ", error);
            }
        }
        else {
            try {
                const response = await admin_announcementAPI.createAnnouncemt(formData);
                if (response) {
                    history.push('/admin/popblem/');
                }
            } catch (error) {
                console.log("Fail to post problem: ", error);
            }
        }

    };
    useEffect(() => {
        if (!isNaN(id)) {
            const fetchAnnouncement = async () => {
                try {
                    const response = await admin_announcementAPI.getById(id);
                    setDisplayID(response.data.)
                    setTitle(response.data.title);
                    
                } catch (error) {
                    console.log("fail to alter announcement: ", error);
                }
            };
            fetchAnnouncement();
        }
    }, [])
    const [fields, setFields] = useState([{ value: null }]);

    function handleChange(i, event) {
        const values = [...fields];
        values[i].value = event.target.value;
        setFields(values);
    }

    function handleAdd() {
        const values = [...fields];
        values.push({ value: null });
        setFields(values);
    }

    function handleRemove(i) {
        const values = [...fields];
        values.splice(i, 1);
        setFields(values);
    }
    return (
        <div className="Edit-container">
            <AdminNavbar />
            <Sidebar />
            <div className="cp">
                <Form onSubmit={handleSubmit(onSubmit)}>
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
                                        <input type="text" autocomplete="off" placeholder="Display ID" className="cp-displayid" {...register("displayID")} required />
                                    </td>
                                    <td className="td-til">
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Title</span> <br /> <br />
                                        <input type="text" autocomplete="off" placeholder="Title" className="cp-title" {...register("title")} required />
                                    </td>
                                </tr>
                            </table>

                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <i style={{ color: 'red' }}>*</i>
                            <span> Description</span> <br /> <br />
                            <Form.Control as="textarea" rows={10} cols={150} {...register("description")} required>
                            </Form.Control>
                            {/* <Editor></Editor> */}
                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <i style={{ color: 'red' }}>*</i>
                            <span> Input Description</span> <br /> <br />
                            <Form.Control as="textarea" rows={10} cols={150} {...register("inputDescription")} required>
                            </Form.Control>
                            {/* <Editor></Editor> */}
                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <i style={{ color: 'red' }}>*</i>
                            <span> Output Description</span> <br /> <br />
                            <Form.Control as="textarea" rows={10} cols={150} {...register("outputDescription")} required>
                            </Form.Control>
                            {/* <Editor></Editor> */}
                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <table>
                                <tr>
                                    <td className="td-time">
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Time Limit (ms)</span> <br /> <br />
                                        <input type="Number" autocomplete="off" placeholder="Time Limit" className="cp-time" {...register("timeLimit")} required />
                                    </td>
                                    <td className="td-mem">
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Memory limit (MB)</span> <br /> <br />
                                        <input type="Number" autocomplete="off" placeholder="Memory limit (MB)" className="cp-mem" {...register("memoryLimit")} required />
                                    </td>
                                    <td className="td-dif">
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Difficult</span> <br /> <br />
                                        <select name="Difficulty" className="cp-dif" {...register("difficult")}>
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
                                        <Swit {...register("visible")} ></Swit></td>
                                    <td>
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Language</span> <br /> <br />
                                        <input className="cp-language"
                                            onChange="{handleLanguageChange}"
                                            type="checkbox"
                                            name="Language"
                                            value="C"
                                            {...register("languages")}
                                        />C
                                         <input className="cp-language"
                                            onChange="{handleLanguageChange}"
                                            type="checkbox"
                                            name="Language"
                                            value="C++"
                                            {...register("languages")}
                                        />C++
                                        <input className="cp-language"
                                            onChange="{handleLanguageChange}"
                                            type="checkbox"
                                            name="Language"
                                            value="Java"
                                            {...register("languages")}
                                        />Java
                                         <input className="cp-language"
                                            onChange="{handleLanguageChange}"
                                            type="checkbox"
                                            name="Language"
                                            value="Python"
                                            {...register("languages")}
                                        />Python
                                    </td>

                                </tr>
                            </table>

                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <i style={{ color: 'red' }}>*</i>
                            <span> Sample</span> <br /> <br />
                            <div className="Sample" >
                                {fields.map((field, idx) => {
                                    return (
                                        <div key={`${field}-${idx}`}>
                                            <Form.Control as="textarea" rows={5} cols={150}
                                                {...register("sample" + idx)}
                                                className="textArea"
                                                placeholder="Enter sample..."
                                                value={field.value || ""}
                                                required
                                                onChange={e => handleChange(idx, e)}

                                            >
                                            </Form.Control>
                                            <Button className="removeButton" onClick={() => handleRemove(idx)}>
                                                X
                                            </Button>
                                        </div>
                                    );
                                })}
                                <Button className="addButton" onClick={() => handleAdd()}>
                                    +
                                </Button>
                            </div>
                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <span> Hint</span> <br /> <br />
                            <Form.Control as="textarea" rows={10} cols={150} {...register("hint")}>
                            </Form.Control>
                            {/* <Editor></Editor> */}
                        </ListGroup.Item >
                        <ListGroup.Item className="cp-list">
                            <table>
                                <tr>
                                    <td className="td-type">
                                        <span> Type</span> <br /> <br />
                                        <input type="radio" name="type" value="ACM" {...register("type")} /> ACM <br />
                                        <input type="radio" name="type" value="IO" {...register("type")} /> IO
                                    </td>
                                    <td className="td-test ">
                                        <span> Test Case</span> <br /> <br />
                                        <input type="file" {...register("testCase")} />

                                    </td>
                                    <td className="td-io">
                                        <span> IO mode</span> <br /> <br />
                                        <input type="radio" name="io" value="standard" {...register("ioMode")} /> Standard IO <br />
                                        <input type="radio" name="io" value="file" {...register("ioMode")} /> File IO
                                    </td>
                                </tr>
                            </table>
                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <Button type="submit" className="cp-btn" variant="save">Save</Button>{' '}
                        </ListGroup.Item>
                    </ListGroup>
                </Form>

            </div >
        </div>
    );
}

export default Createproblem;