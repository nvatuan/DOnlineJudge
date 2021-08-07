import React, { useState } from 'react';
import { Card, Button, Form } from 'react-bootstrap';
import AdminNavbar from '../../AdminNavbar';
import Sidebar from '../../Sidebar';
import { Link } from 'react-router-dom';
import { BiLeftArrowAlt } from 'react-icons/bi';

import {BiLinkExternal} from 'react-icons/bi'
import {FiSend} from 'react-icons/fi'

import { toast } from 'react-toastify';

import admin_usersAPI from '../../../api/admin_usersAPI';

const LS_ACC_CREATION_DATA = 'admin-usercreation-data'
const LS_PREFIX_LIST = 'admin-cu-ltcf-'

function ListTypeCreationForm ({formSubmitHandler}) {
	const formUnListChange = (e) => {
		localStorage.setItem(LS_PREFIX_LIST+'unlist', e.target.value)
	}

	const formEmListChange = (e) => {
		localStorage.setItem(LS_PREFIX_LIST+'emlist', e.target.value)
	}

	const formFnListChange = (e) => {
		localStorage.setItem(LS_PREFIX_LIST+'fnlist', e.target.value)
	}

	const formLnListChange = (e) => {
		localStorage.setItem(LS_PREFIX_LIST+'lnlist', e.target.value)
	}

	const getFormData = (e) => {
		e.preventDefault();

		const splitByLine = (string) => {return string.split(/\r\n|\r|\n/)};
		const splitByLineNoEmpty = (string) => {
			var arr = string.split(/[\r\n]+/)
			return arr.filter((a) => {return a!==''})
		};
		const data = {
			user_gen_type: 'list',
			username_list: splitByLineNoEmpty((localStorage.getItem(LS_PREFIX_LIST+'unlist') || '')),
			email_list: splitByLine((localStorage.getItem(LS_PREFIX_LIST+'emlist') || '')),
			fname_list: splitByLine((localStorage.getItem(LS_PREFIX_LIST+'fnlist') || '')),
			lname_list: splitByLine((localStorage.getItem(LS_PREFIX_LIST+'lnlist') || '')),
		};

		['unlist', 'emlist', 'fnlist', 'lnlist'].forEach((x) => (
			localStorage.removeItem(LS_PREFIX_LIST+x)
		))

		return data
	}

	return (
		<Form>
			<Form.Group className='user-list-info'>
				<Form.Label className='user-list-lbl'>Username List</Form.Label>
				<Form.Control className='user-list-ta' as='textarea' rows={3} cols={100}
					onChange={(e)=>formUnListChange(e)}
				/>
			</Form.Group>
			<Form.Group className='user-list-info'>
				<Form.Label className='user-list-lbl'>Corresponding Email List (can be empty line)</Form.Label>
				<Form.Control className='user-list-ta' as='textarea' rows={3} cols={100}
					onChange={(e)=>formEmListChange(e)}
				/>
			</Form.Group>
			<Form.Group className='user-list-info'>
				<Form.Label className='user-list-lbl'>Corresponding First name List (can be empty line)</Form.Label>
				<Form.Control className='user-list-ta' as='textarea' rows={3} cols={100}
					onChange={(e)=>formFnListChange(e)}
				/>
			</Form.Group>
			<Form.Group className='user-list-info'>
				<Form.Label className='user-list-lbl'>Corresponding Last name List (can be empty line)</Form.Label>
				<Form.Control className='user-list-ta' as='textarea' rows={3} cols={100}
					onChange={(e)=>formLnListChange(e)}
				/>
			</Form.Group>

			<Form.Group className='user-list-control'>
				<Button className='user-list-submit-btn' onClick={(e) => formSubmitHandler(getFormData(e))}>Submit <FiSend/></Button>
			</Form.Group>
		</Form>
	)
}

function getRandomInteger(a, b) {
	const mn = Math.min(a, b);
	const mx = Math.max(a, b);
	return Math.round(mn + (Math.random() * (mx-mn)))
}

function MacroTypeCreationForm({formSubmitHandler}) {
	const [prefix, setPrefix] = useState('')
	const [postfix, setPostfix] = useState('')
	const [userCnt, setUserCnt] = useState(1)
	const formUserCntChange = (e) => {
		try {
			const i = parseInt(e.target.value)
			if (i < 1) return;
			setUserCnt(i);
		} catch (err) {
			console.log(err);
		}
	}

	const getFormData = (e) => {
		e.preventDefault();
		const data = {
			user_gen_type: 'macro',
			username_prefix: prefix,
			username_postfix: postfix,
			create_count: userCnt,
		}
		return data;
	}

	return (
		<Form>
			<Form.Group className='user-prefix'>
				<Form.Label className='user-prefix-lbl'>Username Prefix</Form.Label>
				<Form.Control className='user-prefix-txt' type='text'
					onChange={(e)=>(setPrefix(e.target.value))}
				/>
			</Form.Group>

			<Form.Group className='user-postfix'>
				<Form.Label className='user-postfix-lbl'>Username Postfix</Form.Label>
				<Form.Control className='user-postfix-txt' type='text'
					onChange={(e)=>(setPostfix(e.target.value))}
				/>
			</Form.Group>

			<Form.Group className='user-cnt'>
				<Form.Label className='user-cnt-lbl'>How many users do you want to create?</Form.Label>
				<Form.Control className='user-cnt-txt' type='number'
					value={userCnt}
					onChange={formUserCntChange}
				/>
			</Form.Group>

			<Form.Group className='user-preview'>
				<Form.Label className='user-preview-lbl'>One of the Username will look something like this:</Form.Label>
				<span><pre className='user-preview-pre'>{prefix+getRandomInteger(0, userCnt-1)+postfix}</pre></span>
			</Form.Group>

			<Form.Group className='user-list-control'>
				<Button className='user-list-submit-btn' onClick={(e) => formSubmitHandler(getFormData(e))}>Submit <FiSend/></Button>
			</Form.Group>
		</Form>
	)
}

function getCreationLogFromLocalStorage() {
	var arr = [];
	try {
		arr = JSON.parse(localStorage.getItem(LS_ACC_CREATION_DATA))
		arr.reverse();
	} catch (err) {
		arr = [];
	}
	return arr;
}

function CreateUser({ match }) {
    const id = match.params.id;
	const useForceUpdate = () => {
		const [value, setValue] = useState(0); // integer state
		return () => setValue(value => value + 1); // update the state to force render
	}

	// Event Handler
	const [uselessValue, setUselessValue] = useState(0)
	const formSubmitHandler = async (data) => {
		try {
			const resp = await admin_usersAPI.createUser(data)
			if (resp) {
				console.log("OK", resp)
				if (localStorage.getItem(LS_ACC_CREATION_DATA) === null) {
					localStorage.setItem(LS_ACC_CREATION_DATA, JSON.stringify([]))
				}

				var arr = []
				try {
					arr = JSON.parse(localStorage.getItem(LS_ACC_CREATION_DATA))
				} catch (error) { // JSON parse error
					arr = []
				}

				const tmpid = arr.length;
				arr.push({
					id: tmpid,
					data: resp.data,
					when: (new Date()),
				})
				localStorage.setItem(LS_ACC_CREATION_DATA, JSON.stringify(arr))
				toast.success(
					"Success! Log #"+tmpid+" added.", {
						position: toast.POSITION.BOTTOM_CENTER,
						autoClose: 3000,
					}
				)
				setUselessValue(uselessValue+1)
			}
		} catch (error) {
			console.log("ERR", error)
		}
	}
	const eraseLocalStorageLogs = () => {
		if (window.confirm("ALL LOGS will be DELETED and the data CANNOT BE RECOVERED. Are you sure?")) {
			localStorage.removeItem(LS_ACC_CREATION_DATA)
			setUselessValue(uselessValue+1)
		}
	}

	// user_gen_type
	const [genType, setGenType] = useState('list')

	// Form 
	const getFormComponentFromType = {
		'list': <ListTypeCreationForm formSubmitHandler={formSubmitHandler}/>,
		'macro': <MacroTypeCreationForm formSubmitHandler={formSubmitHandler}/>,
	}


    return (
        <div>
            <AdminNavbar />
            <Sidebar />
            <div className="table-view">
                <Card>
                    <Card.Header as="h3" className="user-creation-card">
						Account Creation Tool
                        <div className="">
                            <Link to={`/admin/user`}  className="card-header-btn"> <BiLeftArrowAlt/> Back </Link>
                        </div>
                    </Card.Header>
                    <Card.Body>
						<Form.Group>
							<Form.Label className='user-creation-type-lbl'>Create method</Form.Label>
							<Form.Control className='user-creation-type-select' as='select' size='sm'
								onChange={(e)=>setGenType(e.target.value)}
							>
								<option value='list'>From a list of Username</option>
								<option value='macro'>Generate by Numbering</option>
							</Form.Control>
						</Form.Group>
						<hr/>
						<div className='form-container'>
						{
							getFormComponentFromType[genType]
						}
						</div>
                    </Card.Body>
                </Card>
                <Card>
                    <Card.Header as="h3" className="user-creation-card-log">
						Creation Log
                    </Card.Header>
                    <Card.Body>
						{
							<div className='log-container'>
								<div className='logs'>
									{
										getCreationLogFromLocalStorage().map((item) => (
											<p><Link to={`/admin/user/create/log/${item.id}`}  target="_blank">{item.id}# {new Date(item.when).toLocaleString()} <BiLinkExternal/></Link></p>
										))
									}
									<input type='hidden' className='useless-input' value={uselessValue}></input>
								</div>
								<div className='controls'>
									<Button onClick={eraseLocalStorageLogs}>DELETE ALL</Button>
								</div>
							</div>
						}
                    </Card.Body>
                </Card>
            </div>
        </div >
    );
}

export default CreateUser;