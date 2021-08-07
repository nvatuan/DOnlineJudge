import './UserCreationLog.scss'
const LS_ACC_CREATION_DATA = 'admin-usercreation-data'

function UserCreateionLog ({match}) {
	const id = match.params.id
	var arr = [];
	try {
		arr = JSON.parse(localStorage.getItem(LS_ACC_CREATION_DATA));
	} catch (err) {
		arr = [];
	}
	console.log('Array', arr)

	return (
		arr.length > id 
		?   <div className='log-page'>
				<h1>Log #{id}</h1>
				<em>At {new Date(arr[id].when).toLocaleString()}</em>
				<hr/>
				<p>
					Each row is seperated by a comma character (',')
				</p>
				<p className='log-content'>
					<p>username,password,email,firstname,lastname</p>
					{
						arr[id].data.map((obj) => (
							<p key={'user-creationlog-log-'+id}>{obj.username},{obj.password},{obj.email},{obj.first_name},{obj.last_name}</p>
						))
					}
				</p>
			</div>
		: 	<div className='log-page'>
				<h1> Log could not be found. </h1>
			</div>
	);
}

export default UserCreateionLog;