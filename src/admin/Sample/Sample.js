import React, { useState } from "react";
import Button from 'react-bootstrap/Button'
import "./Sample.scss"

function Sample() {
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
        <div className="Sample">

            {fields.map((field, idx) => {
                return (
                    <div key={`${field}-${idx}`}>
                        <textarea
                            className="textArea"
                            placeholder="Enter sample..."
                            value={field.value || ""}
                            onChange={e => handleChange(idx, e)}
                        />
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
    );
}
export default Sample
