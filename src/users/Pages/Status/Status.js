import React, {useState, useEffect} from 'react';
import { Card, Form } from 'react-bootstrap';
import { Link , useParams} from 'react-router-dom';
import oj_statusAPI from '../../../api/oj_statusAPI';
import Navbar from '../../Navbar';
import './status.scss';
import queryString from 'query-string';
function Status() {
    let href = window.location.href;
    const id = queryString.parse(href, { parseNumbers: true })
    console.log(id.author_id);
    const [status, setStatus] = useState([]);
    const [filters, setFilters] = useState({
        sort_by: '-submit_time',
        filter_by: ['author_id'],
        author_id: id.author_id,
    })
    const result = {
        "Accepted": "Accepted",
        "Wrong Answer": "Wrong_answer",
        "Runtime Error": "Runtime_error",
        "New": "New",
        "Compilation Error": "Compile_error",
        "System Error": "System_error",
        "Judged": "Judged",
        "Judging": "Judging"

    };

    //sort by id
    function handleSortChange(e){
        const condition = (e.target.value === 'newest' ? '-submit_time' : 'submit_time');
        setFilters({
            ...filters,
            sort_by: condition,

        })
    }
    function handleFilterVerdict(e){
        const value = e.target.value
        filters.filter_by.push('verdict');
        if(value === '') {
            filters.filter_by = filters.filter_by.filter((item) => item !== 'verdict');
            setFilters({
                ...filters,
                filter_by: filters.filter_by,
                verdict: '',
            })
        }
        else{
        setFilters({
            ...filters,
            verdict: value,
            
        })
    }
    };
    function handleFilterLanguege(e){
        const value = e.target.value;
        filters.filter_by.push('language');
        if (value === '') {
            filters.filter_by = filters.filter_by.filter((item) => item !== 'language');
            setFilters({
                ...filters,
                filter_by: filters.filter_by,
                language: '',
            })
        }
        else{
            setFilters({
                ...filters,
                language: value,

            })
        }
    }
    useEffect(() => {
        const fetchStatus = async () => {
            try {
                const response = await oj_statusAPI.getAll(filters);
                setStatus(response.data);
            } catch (error) {
               console.log('fail to fetch status: ', error); 
            }
        }
        fetchStatus();
    }, [filters])
    const hanldeTime = (time) => {
        return new Date(time).toDateString();  
    }
    return (
        <div>
            <Navbar/>
            <div className="status-container pages-container">
                  <Card>
                <Card.Header as="h3" className="status-header">
                    Status
                    <div className="status-feartures">
                        <div className="filter_by">
                            <Form className="filter_by" onChange={handleFilterVerdict}>
                                    <Form.Control as="select" className="filter_by">
                                        <option value="">All</option> 
                                        <option value="Accepted">Accepted</option>
                                        <option value="Wrong Answer">Wrong answer</option>
                                        <option value="Runtime Error">Runtime error</option>
                                        <option value="New">New</option>
                                        <option value="Compile Error">Compile error</option>
                                        <option value="System Error">System error</option>
                                        <option value="Judged">Judged</option>
                                        <option value="Judging">Judging</option>
                                </Form.Control>
                            </Form>
                                <Form className="filter_by" onChange={handleFilterLanguege}>
                                    <Form.Control as="select" className="filter_by">
                                        <option value="">All</option>
                                        <option value="Python3">Python3</option>
                                        <option value="Python2">Python2</option>
                                        <option value="C">C</option>
                                        <option value="Cpp">C++</option>
                                        <option value="Java">Java</option>
                                    </Form.Control>
                                </Form>
                        </div>
                        <div className="sort_by_day">
                                <Form.Control as="select" onChange={handleSortChange} >
                                    <option value="newest">Newest</option>
                                    <option value="lastest">Lastest</option>
                                </Form.Control>
                        </div>
                    </div>
                </Card.Header>
                <Card.Body>
                    
                        <table>
                            <thead>
                                <tr>
                                    <th>when</th>
                                    <th>ID</th>
                                    <th>Status</th>
                                    <th>Problem</th>
                                    <th>Time</th>
                                    <th>Memory</th>
                                    <th>Language</th>
                                    <th>Author</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    status.map(stat => {
                                        return (
                                            <tr key={stat.id}>
                                                <td>{hanldeTime(stat.submit_time)}</td>
                                                <td>{stat.id}</td>
                                                <td >
                                                    <div className="table-cell">
                                                        <div className={`result-container ${result[stat.verdict]}`}>
                                                            <div className="result-text">
                                                                {stat.verdict}
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div className="table-cell">
                                                        <Link to={`problem/${stat.problem}`} >{stat.problem}</Link>
                                                    </div>
                                                </td>
                                                <td>{stat.output["time"]}s</td>
                                                <td>{Math.floor(stat.output['memory']/1024)} byte</td>
                                                <td>{stat.language}</td>
                                                <td>{stat.author}</td>
                                                <td><Link to={`status/${stat.id}`}>detail</Link></td>
                                            </tr>
                                        )
                                    })
                                }
                            </tbody>
                        </table>
                </Card.Body>
            </Card>
            </div>
        </div>


    );
}

export default Status;