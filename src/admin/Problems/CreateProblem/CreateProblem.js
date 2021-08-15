import React, { useState, useEffect } from 'react';
import { ListGroup, Button, Form } from 'react-bootstrap';
import './Createproblem.scss';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { useHistory } from 'react-router-dom';
import {Card} from 'react-bootstrap'
import { Link } from 'react-router-dom';
import { BiLeftArrowAlt } from 'react-icons/bi';
import {AiFillDelete} from 'react-icons/ai'
import {BsPlusCircle} from 'react-icons/bs'
import {FiSave} from 'react-icons/fi'
import admin_problemAPI from '../../../api/admin_problemAPI';

import { WithContext as ReactTags } from 'react-tag-input';
import { toast } from 'react-toastify';

function isAlphaNumeric(str) {
    var code, i, len;

    for (i = 0, len = str.length; i < len; i++) {
        code = str.charCodeAt(i);
        if (!(code > 47 && code < 58) && // numeric (0-9)
            !(code > 96 && code < 123)) { // lower alpha (a-z)
            return false;
        }
    }
    return true;
};

function Createproblem({ match }) {
    const id = match.params.id;
    var cardTitle = "Create New Problem";
    var formType = "CREATE";
    if (id !== undefined) {
        formType = "EDIT";
        cardTitle = "Edit Problem#"+id
    }

    const [display_id, setDisplay_id] = useState(() => {
        const initDisplay_id = localStorage.getItem('display_id') || '';
        return initDisplay_id;
    });
    const [title, setTitle] = useState(() => {
        const initTitle = localStorage.getItem('title') || '';
        return initTitle;
    });
    const [description, setDescription] = useState(() => {
        const initDescription = localStorage.getItem('description') || '';
        return initDescription;
    });
    const [input_description, setInput_description] = useState(() => {
        const initInput_description = localStorage.getItem('input_description') || '';
        return initInput_description;
    });
    const [output_description, setOutput_description] = useState(() => {
        const initOutput_description = localStorage.getItem('output_description') || '';
        return initOutput_description;
    });
    const [time_limit, setTime_limit] = useState(() => {
        const initTime_limit = localStorage.getItem('time_limit') || '1000';
        return initTime_limit;
    });
    const [memory_limit, setMemory_limit] = useState(() => {
        const initMemory_limit = localStorage.getItem('memory_limit') || '64';
        return initMemory_limit;
    });
    const [is_visible, setVisible] = useState(() => {
        const initVisible = localStorage.getItem('is_visible') || true;
        return initVisible;
    });
    const [difficulty, setDifficulty] = useState(() => {
        const initDifficulty = localStorage.getItem('difficulty') || 'Easy';
        return initDifficulty;
    });
    const [sample_test, setSample_test] = useState([]);

    const history = useHistory();
    const handleDisplay_id = (e) => {
        const value = e.target.value;
        setDisplay_id(value);
        localStorage.setItem('display_id', value);
    }
    const handleTitle = (e) => {
        const value = e.target.value;
        setTitle(value);
        localStorage.setItem('title', value);
    }
    const handleDescription = (e) => {
        const value = e.target.value;
        setDescription(value);
        localStorage.setItem('description', value);
    }
    const handleInput_description = (e) => {
        const value = e.target.value;
        setInput_description(value);
        localStorage.setItem('input_description', value);
    }
    const handleOutput_description = (e) => {
        const value = e.target.value;
        setOutput_description(value);
        localStorage.setItem('output_description', value);
    }
    const handleVisible = (e) => {
        const value = e.target.value;
        setVisible(value);
        localStorage.setItem('is_visible', value);
    }
    const handleTime_limit = (e) => {
        const value = e.target.value;
        setTime_limit(value);
        localStorage.setItem('time_limit', value);
    }
    const handleMemory_limit = (e) => {
        const value = e.target.value;
        setMemory_limit(value);
        localStorage.setItem('memory_limit', value);
    }
    const handleDifficulty = (e) => {
        const value = e.target.value;
        setDifficulty(value);
        localStorage.setItem('difficulty', value);
    }

    /** Hidden test zip file */
    const [currentTestZipFile, setCurrentTestZipFile] = useState(null)
    const [hiddenTestZip, setHiddenTestZip] = useState(null)
    const handleFileChange = (e) => {
        setHiddenTestZip(e.target.files[0])
    }
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
        if (formType === 'EDIT') {
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
                    setCurrentTestZipFile(response.data.test_zip)

                    // set tags
                    var tagIDs = response.data.tags;
                    var currTags = []
                    tagIDs.forEach((tag) => {
                        currTags.push({id: tag.tag_name, tag_name: tag.tag_name})
                    })
                    setTags(currTags)

                    // set sample_test
                    if (Array.isArray(response.data.sample_test)) {
                        setSample_test(response.data.sample_test)
                    } else {
                        setSample_test([])
                    }
                } catch (error) {
                    console.log("fail to alter problem: ", error);
                }
            };
            fetchProblem();
        }
        const fetchProblemTag = async() => {
            try {
                const response = await admin_problemAPI.getAllProblemTags();
                var tg = []
                response.data.forEach((suggestion) => {
                    tg.push({...suggestion, id: String(suggestion.id)})
                })
                setTagSuggestions(tg)
            } catch (error) {
                console.log("fail to alter problem: ", error);
            }
        }
        fetchProblemTag()
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

    const [tags, setTags] = useState([])
    const [tagSuggestions, setTagSuggestions] = useState([])
    const handleTagDelete = (i) => {
        setTags(tags.filter((tag, index) => index !== i));
    };
    
    const handleTagAddition = (tag) => {
        tag = {...tag, tag_name: tag.tag_name.toLowerCase()};
        if (isAlphaNumeric(tag.tag_name)) {
            setTags([...tags, tag]);
        } else {
            toast.error("Tag should contain alphanumeric characters only", {
                position: toast.POSITION.BOTTOM_CENTER,
                autoClose: 3000,
            });
            return false;
        }
    };
    
    const handleTagDrag = (tag, currPos, newPos) => {
        const newTags = [...tags].slice();
    
        newTags.splice(currPos, 1);
        newTags.splice(newPos, 0, tag);
    
        setTags(newTags);
    };
    
    const handleOnClearAll = () => {
        setTags([]);
    };

    const [deleteFileCheckbox, setDeleteFileCheckBox] = useState(false)
    const handleDeleteFileCheckbox = () => {
        setDeleteFileCheckBox(!deleteFileCheckbox)
    }

    const handleSubmit = async (e) => {
        e.preventDefault();

        const formData = new FormData()
        if (id !== undefined)
            formData.append('id', id);
        formData.append('display_id', display_id);
        formData.append('title', title);
        formData.append('is_visible', is_visible);
        formData.append('time_limit', time_limit);
        formData.append('memory_limit', memory_limit);
        formData.append('difficulty', difficulty);
        formData.append('statement', description + '\nInput\n' + input_description + '\nOutput\n' + output_description);

        // Prepare tag
        var taggings = []
        tags.forEach((tag) => {
            taggings.push(tag.tag_name)
        });
        formData.append('tags', JSON.stringify(taggings));

        // Prepare sample_test
        var sendingSampleTests = [];
        sample_test.forEach((sample) => {
            console.log(sample)
            sendingSampleTests.push(
                {"input": sample.input, "output": sample.output}
            )
        })
        formData.append('sample_test', JSON.stringify(sendingSampleTests));

        // FormData
        if (formType==='EDIT')
            formData.append('delete-test-zip', deleteFileCheckbox)
        
        if (hiddenTestZip !== null) // A file is selected
            formData.append('test_zip', hiddenTestZip);

        if (formType==='EDIT') { // PUT to /problem
            try {
                const response = await admin_problemAPI.updateById({ formData, id });

                console.log('Update:', response)
                window.location.reload()
            } catch (error) {
                console.log("Fail to put problem: ", error);
            }
        } else { // POST to /problem
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

    return (
        <div className="Edit-container">
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card>
                    <Card.Header as="h3">{cardTitle}
                        <div className="">
                            <Link to={`/admin/problem`}  className="card-header-btn"> <BiLeftArrowAlt/> Back </Link>
                        </div>
                    </Card.Header>
                    <Card.Body>
                    <Form onSubmit={handleSubmit}>
                        <ListGroup>
                            <ListGroup.Item className="cp-list cp-first">
                                <Form.Label className='lbl-required'>Display ID</Form.Label>
                                <Form.Control type="text" placeholder="Problem's unique name id"
                                    required value={display_id} onChange={(e)=>{handleDisplay_id(e)}}
                                />
                            </ListGroup.Item>

                            <ListGroup.Item className="cp-list">
                                <Form.Label className='lbl-required'>Title</Form.Label>
                                <Form.Control type="text" placeholder="Problem's Title"
                                    required value={title} onChange={(e)=>{handleTitle(e)}}
                                />
                            </ListGroup.Item>

                            <ListGroup.Item className="cp-list">
                                <Form.Label className='lbl-required'>Statement</Form.Label>
                                <Form.Control as="textarea" rows={10} cols={150} required
                                    value={description} onChange={(e) => { handleDescription(e) }}>
                                </Form.Control>
                                {/* <Editor></Editor> */}
                            </ListGroup.Item>

                            <ListGroup.Item className="cp-list">
                                <Form.Label className='lbl-required'>Input Description</Form.Label>
                                <Form.Control as="textarea" rows={10} cols={150} required
                                    value={input_description} onChange={(e) => { handleInput_description(e) }}>
                                </Form.Control>
                            </ListGroup.Item>

                            <ListGroup.Item className="cp-list">
                                <Form.Label className='lbl-required'>Output Description</Form.Label>
                                <Form.Control as="textarea" rows={10} cols={150} required
                                    value={output_description} onChange={(e) => { handleOutput_description(e) }}>
                                </Form.Control>
                            </ListGroup.Item>

                            <ListGroup.Item className="cp-list cp-first constraint-list">
                                <ListGroup.Item className="cp-list">
                                    <Form.Label className='lbl-required'>Time Limit (ms)</Form.Label>
                                    <Form.Control type="number" placeholder="Problem's Time Limit"
                                        required value={time_limit} onChange={(e)=>{handleTime_limit(e)}}
                                    />
                                </ListGroup.Item>

                                <ListGroup.Item className="cp-list">
                                    <Form.Label className='lbl-required'>Memory Limit (MB)</Form.Label>
                                    <Form.Control type="number" placeholder="Problem's Time Limit"
                                        required value={memory_limit} onChange={(e)=>{handleMemory_limit(e)}}
                                    />
                                </ListGroup.Item>

                                <ListGroup.Item className="cp-list">
                                    <Form.Label>Difficulty</Form.Label>
                                    <Form.Control as="select" size="sm" custom value={difficulty} onChange={(e) => { handleDifficulty(e) }} >
                                        <option value="Easy">Easy</option>
                                        <option value="Medium">Medium</option>
                                        <option value="Hard">Hard</option>
                                    </Form.Control>
                                </ListGroup.Item>

                                <ListGroup.Item className="cp-list">
                                    <Form.Label>Visibility</Form.Label>
                                    <Form.Control as="select" size="sm" custom value={is_visible} onChange={(e) => { handleVisible(e) }} >
                                        <option value={true}>true</option>
                                        <option value={false}>false</option>
                                    </Form.Control>
                                </ListGroup.Item>
                            </ListGroup.Item> {/* Time Mem Diff Visible */}

                            <ListGroup.Item className="cp-list">
                                <Form.Label>Sample Tests</Form.Label>
                                <div className="Sample" >
                                    {
                                        sample_test.map((sample, idx) => {
                                            return (
                                                <div key={`sample-test-${idx}`} className="cp-second">
                                                    <div className="cp-first">
                                                        <div className="textArea-2">
                                                            <Form.Label className='lbl-required'>Input #{idx+1}</Form.Label>
                                                            <Form.Control as="textarea" rows={5} cols={150}
                                                                className="textArea"
                                                                value={sample.input || ""}
                                                                onChange={e => handleInput(idx, e)}
                                                            >
                                                            </Form.Control>
                                                        </div>
                                                        <div className="textArea-2">
                                                            <Form.Label className='lbl-required'>Output #{idx+1}</Form.Label>
                                                            <Form.Control as="textarea" rows={5} cols={150}
                                                                className="textArea"
                                                                value={sample.output || ""}
                                                                onChange={e => handleOutput(idx, e)}
                                                            >
                                                            </Form.Control>
                                                        </div>
                                                    </div>
                                                    <div className="textArea-2">
                                                        <Button className="removeButton" onClick={() => handleRemove(idx)}>
                                                            <AiFillDelete/>
                                                        </Button>
                                                    </div>
                                                </div>
                                            );
                                        })}
                                    <Button className="addButton" onClick={() => handleAdd()}>
                                        Add <BsPlusCircle/>
                                    </Button>
                                </div>
                            </ListGroup.Item>
                            <ListGroup.Item className="cp-list">
                                <Form.Group className="hidden-test">
                                    <Form.Label>Hidden Test Zip</Form.Label>
                                    <Form.Control type="file" onChange={handleFileChange} name="test-zip"/>
                                    <div className='div-test-in-use-zip'>Current zip file: <span>{currentTestZipFile?currentTestZipFile:'None'}</span></div>

                                    <Form.Check type='checkbox' className={formType==='EDIT'?"chkbox-nothidden":"chkbox-hidden"} id="test-zip-chkbox"
                                        onChange={handleDeleteFileCheckbox}
                                        checked={deleteFileCheckbox} label="Delete current zip file?"/>
                                </Form.Group>
                            </ListGroup.Item>
                                
                            <ListGroup.Item className="cp-list cp-first">
                                <Form.Group className="tagging">
                                    <Form.Label>Tags</Form.Label>
                                    <div className='tag-container'>
                                        <ReactTags 
                                            tags={tags} handleDelete={handleTagDelete} handleAddition={handleTagAddition} handleDrag={handleTagDrag}
                                            onClearAll={handleOnClearAll} 
                                            labelField={'tag_name'}
                                            suggestions={tagSuggestions}
                                            minQueryLength={3}
                                            maxLength={32}
                                            autofocus={false}
                                            readOnly={false}
                                            allowUnique={true}
                                            allowDragDrop={true}
                                            inline={true}
                                            allowAdditionFromPaste={true}
                                            clearAll={true}
                                        />
                                        <Button className='tag-clearall-btn' onClick={handleOnClearAll}>Clear All</Button>
                                    </div>
                                </Form.Group>
                            </ListGroup.Item>
                            <hr/>
                            <Button type="submit" className="cp-btn">Save <FiSave/></Button>
                        </ListGroup>
                    </Form >
                    </Card.Body>
                </Card>
            </div >
        </div >
    );
}

export default Createproblem;