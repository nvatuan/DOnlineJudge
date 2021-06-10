import React, { useState } from "react";
import Switch from "react-switch";

function Swit(props) {
    const [checked, setChecked] = useState(true);
    return (
        <div>
            <Switch onChange={setChecked} checked={checked} />
        </div>
    );
}

export default Swit;
