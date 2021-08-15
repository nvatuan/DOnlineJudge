import React, { useState } from 'react'
import { Form, FormControl } from 'react-bootstrap';

function TextFieldForm({onSubmit, placeHolder}) {
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
                <FormControl type="text" placeholder={placeHolder} className="mr-sm-2" onChange={handleSearchTerm}/>
            </Form>
        </div>
    )
}

export default TextFieldForm;
