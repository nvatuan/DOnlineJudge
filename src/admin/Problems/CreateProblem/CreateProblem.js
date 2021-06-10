import React, { useState, useEffect } from 'react';
import { ListGroup, Button, Form } from 'react-bootstrap';
import './Createproblem.scss';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { useForm } from 'react-hook-form'
import { useHistory } from 'react-router-dom';
import admin_problemAPI from '../../../api/admin_problemAPI';

function Createproblem({ match }) {
    const { register, handleSubmit } = useForm();
    const id = match.params.id;
    const [display_id, setDisplay_id] = useState('');
    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('');
    const [input_description, setInput_description] = useState('');
    const [output_description, setOutput_description] = useState('');
    const [time_limit, setTime_limit] = useState('');
    const [memory_limit, setMemory_limit] = useState('');
    const [visible, setVisible] = useState('');
    const [difficulty, setDifficulty] = useState('');
    const [sample_test, setSample_test] = useState([]);

    const history = useHistory();
    const handleDisplay_id = (e) => {
        const value = e.target.value;
        setDisplay_id(value);
    }
    const handleTitle = (e) => {
        const value = e.target.value;
        setTitle(value);
    }
    const handleDescription = (e) => {
        const value = e.target.value;
        setDescription(value);
    }
    const handleInput_description = (e) => {
        const value = e.target.value;
        setInput_description(value);
    }
    const handleOutput_description = (e) => {
        const value = e.target.value;
        setOutput_description(value);
    }
    const handleVisible = (e) => {
        const value = e.target.value;
        setVisible(value);
    }
    const handleTime_limit = (e) => {
        const value = e.target.value;
        setTime_limit(value);
    }
    const handleMemory_limit = (e) => {
        const value = e.target.value;
        setMemory_limit(value);
    }
    const handleDifficulty = (e) => {
        const value = e.target.value;
        setDifficulty(value);
    }
    const onSubmit = async (formData) => {
        console.log(formData);
        formData.display_id = display_id;
        formData.title = title;
        formData.visible = true;
        formData.time_limit = time_limit;
        formData.memory_limit = memory_limit;
        formData.difficulty = "Easy";
        formData.tags = [1, 2];
        formData.statement = description + '\nInput\n' + input_description + '\nOutput\n' + output_description;
        formData.sample_test = sample_test;
        if (!isNaN(id)) {
            try {
                const response = await admin_problemAPI.updateById({ formData, id });

                if (response) {
                    history.push('/admin/problem/');
                }
            } catch (error) {
                console.log("Fail to put problem: ", error);
            }
        }
        else {
            try {
                const response = await admin_problemAPI.createProblem(formData);
                if (response) {
                    history.push('/admin/problem/');
                }
            } catch (error) {
                console.log("Fail to post problem: ", error);
            }
        }

    };
    function getDescription(str) {
        const i = str.indexOf('\nInput\n')
        if (i >= 0) {
            return str.slice(0, i)
        }
        else return str
    }
    function getInput_description(str) {
        const i = str.indexOf('\nInput\n')
        const o = str.indexOf('\nOutput\n')
        if (i >= 0 && o > i) {
            return str.slice(i + 7, o)
        }
        else return ''
    }
    function getOutput_description(str) {
        const o = str.indexOf('\nOutput\n')
        if (o >= 0) {
            return str.slice(o + 8)
        }
        else return ''
    }
    useEffect(() => {
        if (!isNaN(id)) {
            const fetchProblem = async () => {
                try {
                    const response = await admin_problemAPI.getById(id);
                    setDisplay_id(response.data.display_id)
                    setTitle(response.data.title);
                    setDescription(getDescription(response.data.statement))
                    setInput_description(getInput_description(response.data.statement))
                    setOutput_description(getOutput_description(response.data.statement))
                    setTime_limit(response.data.time_limit)
                    setMemory_limit(response.data.memory_limit)
                    setVisible(response.data.visible)
                    setDifficulty(response.data.difficulty)
                    setSample_test(response.data.sample_test)

                } catch (error) {
                    console.log("fail to alter problem: ", error);
                }
            };
            fetchProblem();
        }
    }, [])

    function handleInput(i, event) {
        const values = [...sample_test];
        values[i].input = event.target.value;
        setSample_test(values);
    }
    function handleOutput(i, event) {
        const values = [...sample_test];
        values[i].output = event.target.value;
        setSample_test(values);
    }

    function handleAdd() {
        const values = [...sample_test];
        values.push({ input: null, output: null });
        setSample_test(values);
    }

    function handleRemove(i) {
        const values = [...sample_test];
        values.splice(i, 1);
        setSample_test(values);
    }
    return (
        <div className="Edit-container">
            <AdminNavbar />
            <Sidebar />
            <div className="cp">
                <Form onSubmit={handleSubmit(onSubmit)}>
                    <ListGroup>
                        <ListGroup.Item className="cp-header cp-list" >
                            <h3>Edit problem</h3>
                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <table>
                                <tr>
                                    <td className="td-dis">
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Display ID</span> <br /> <br />
                                        <input type="text" autocomplete="off" placeholder="Display ID" className="cp-displayid" required
                                            value={display_id} onChange={(e) => { handleDisplay_id(e) }} />
                                    </td>
                                    <td className="td-til">
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Title</span> <br /> <br />
                                        <input type="text" autocomplete="off" placeholder="Title" className="cp-title" required
                                            value={title} onChange={(e) => { handleTitle(e) }} />
                                    </td>
                                </tr>
                            </table>

                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <i style={{ color: 'red' }}>*</i>
                            <span> Description</span> <br /> <br />
                            <Form.Control as="textarea" rows={10} cols={150} required
                                value={description} onChange={(e) => { handleDescription(e) }}>
                            </Form.Control>
                            {/* <Editor></Editor> */}
                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <i style={{ color: 'red' }}>*</i>
                            <span> Input Description</span> <br /> <br />
                            <Form.Control as="textarea" rows={10} cols={150} required
                                value={input_description} onChange={(e) => { handleInput_description(e) }}>
                            </Form.Control>
                            {/* <Editor></Editor> */}
                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <i style={{ color: 'red' }}>*</i>
                            <span> Output Description</span> <br /> <br />
                            <Form.Control as="textarea" rows={10} cols={150} required
                                value={output_description} onChange={(e) => { handleOutput_description(e) }}>
                            </Form.Control>
                            {/* <Editor></Editor> */}
                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <table>
                                <tr>
                                    <td className="td-time">
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Time Limit (ms)</span> <br /> <br />
                                        <input type="Number" autocomplete="off" placeholder="Time Limit" className="cp-time" required
                                            value={time_limit} onChange={(e) => { handleTime_limit(e) }} />
                                    </td>
                                    <td className="td-mem">
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Memory limit (MB)</span> <br /> <br />
                                        <input type="Number" autocomplete="off" placeholder="Memory limit (MB)" className="cp-mem" required
                                            value={memory_limit} onChange={(e) => { handleMemory_limit(e) }} />
                                    </td>
                                    <td className="td-dif">
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Difficult</span> <br /> <br />
                                        <Form.Control as="select" size="sm" custom value={difficulty} onChange={(e) => { handleDifficulty(e) }} >
                                            <option value="Easy">Easy</option>
                                            <option value="Medium">Medium</option>
                                            <option value="Hard">Hard</option>
                                        </Form.Control>
                                    </td>
                                </tr>
                                <br />
                                <tr>
                                    <td>
                                        <span> Visible</span> <br /> <br />
                                        <Form.Control className="cp-visible" as="select" size="sm" custom value={visible} onChange={(e) => { handleVisible(e) }} >
                                            <option value={true}>true</option>
                                            <option value={false}>false</option>
                                        </Form.Control>
                                    </td>
                                    <td>
                                        <i style={{ color: 'red' }}>*</i>
                                        <span> Language</span> <br /> <br />
                                        <input className="cp-language"
                                            onChange="{handleLanguageChange}"
                                            type="checkbox"
                                            name="Language"
                                            checked="true"
                                            value="C"
                                        />C
                                        <input className="cp-language"
                                            onChange="{handleLanguageChange}"
                                            type="checkbox"
                                            name="Language"
                                            value="C++"
                                            checked="true"
                                        />C++
                                        <input className="cp-language"
                                            onChange="{handleLanguageChange}"
                                            type="checkbox"
                                            name="Language"
                                            value="Java"
                                            checked="true"
                                        />Java
                                        <input className="cp-language"
                                            onChange="{handleLanguageChange}"
                                            type="checkbox"
                                            name="Language"
                                            value="Python"
                                            checked="true"
                                        />Python
                                    </td>
                                </tr>
                            </table>
                        </ListGroup.Item>
                        <ListGroup.Item className="cp-list">
                            <i style={{ color: 'red' }}>*</i>
                            <span> Sample</span> <br /> <br />
                            <div className="Sample" >
                                {sample_test.map((sample, idx) => {
                                    return (
                                        <div key={`${sample}-${idx}`}>
                                            <tr>
                                                <td>
                                                    <i style={{ color: 'red' }}>*</i>
                                                    <span> Input</span> <br />
                                                    <Form.Control as="textarea" rows={5} cols={150}
                                                        className="textArea"
                                                        placeholder="Enter input..."
                                                        value={sample.input || ""}
                                                        required
                                                        onChange={e => handleInput(idx, e)}
                                                    >
                                                    </Form.Control>
                                                </td>
                                                <td>
                                                    <i style={{ color: 'red' }}>*</i>
                                                    <span> Output</span> <br />
                                                    <Form.Control as="textarea" rows={5} cols={150}
                                                        className="textArea"
                                                        placeholder="Enter output..."
                                                        value={sample.output || ""}
                                                        required
                                                        onChange={e => handleOutput(idx, e)}
                                                    >
                                                    </Form.Control>
                                                </td>
                                                <td>
                                                    <Button className="removeButton" onClick={() => handleRemove(idx)}>
                                                        X
                                                    </Button>
                                                </td>

                                            </tr>



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
                            <Form.Control as="textarea" rows={10} cols={150} >
                            </Form.Control>
                            {/* <Editor></Editor> */}
                        </ListGroup.Item >
                        <ListGroup.Item className="cp-list">
                            <table>
                                <tr>
                                    <td className="td-type">
                                        <span> Type</span> <br /> <br />
                                        <input type="radio" name="type" value="ACM" /> ACM <br />
                                        <input type="radio" name="type" value="IO" /> IO
                                    </td>
                                    <td className="td-test ">
                                        <span> Test Case</span> <br /> <br />
                                        <input type="file" />

                                    </td>
                                    <td className="td-io">
                                        <span> IO mode</span> <br /> <br />
                                        <input type="radio" name="io" value="standard" /> Standard IO <br />
                                        <input type="radio" name="io" value="file" /> File IO
                                    </td>
                                </tr>
                            </table>
                        </ListGroup.Item>
                        <Button type="submit" className="cp-btn">Save</Button>

                    </ListGroup>
                </Form>
            </div >
        </div>
    );
}

export default Createproblem;