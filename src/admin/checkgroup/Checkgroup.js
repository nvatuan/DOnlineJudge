import React, { useState } from 'react'
import CheckboxGroup from 'react-checkbox-group'

function Checkgroup(props) {
    // Initialize the checked values
    const [languge, setLanguage] = useState(['C', 'C++', 'Python', 'Java']);


    return (
        <div>
            <CheckboxGroup name="fruits" value={languge} onChange={setLanguage}>
                {(Checkbox) => (
                    <>
                        <label>
                            <Checkbox value="C" /> C
                        </label>
                        <label>
                            <Checkbox value="C++" /> C++
                        </label>
                        <label>
                            <Checkbox value="Python" /> Python
                        </label>
                        <label>
                            <Checkbox value="Java" /> Java
                        </label>
                    </>
                )}
            </CheckboxGroup>
        </div>

    )
}

export default Checkgroup;