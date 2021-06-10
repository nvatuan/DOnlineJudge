import React, {useRef } from 'react';
import JoditEditor from "jodit-react";

function Editor(props) {
    const {value} = props
    const editor = useRef(null)
    const config = {
        readonly: false
    }
    return (
        <JoditEditor
            ref={editor}
            value={value}
            config={config}
            tabIndex={1}
            // onChange={() => (setContent(content))}
        />
    );
}

export default Editor

