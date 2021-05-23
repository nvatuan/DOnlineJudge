import React, { useRef, useState } from 'react'
import { Form, Button, FormControl } from 'react-bootstrap';
function Search(props) {
    const { onSubmit } = props;
    const [searchTerm, setSearchTerm] = useState('');

    function handleSearchTerm(e) {
        const value = e.target.value
        setSearchTerm(value);
    }
    function handleSearch(e){
        if(!onSubmit) return;
        onSubmit(searchTerm);
        e.preventDefault();
    }
    return (
        <div>
            <Form inline onSubmit={handleSearch}>
                <FormControl type="text" placeholder="Search" className="mr-sm-2" onChange={handleSearchTerm}/>
                <Button type="submit" variant="outline-success">Search</Button>
            </Form>
        </div>
    )
}

export default Search
