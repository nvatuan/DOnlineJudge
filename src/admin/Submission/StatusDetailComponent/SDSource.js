import { Card } from 'react-bootstrap';
import { UnControlled  as CodeMirror } from 'react-codemirror2';

require('codemirror/lib/codemirror.css');
require('codemirror/theme/material.css');
require('codemirror/theme/neat.css');

function StatusDetailSource({content, language}) {
    const getCodeMirrorModeFromLanguage = (lang) => {
        return {
            'PyPy3': 'python',
            'PyPy': 'python',
            'Python3': 'python',
            'Python2': 'python',
            'Java': 'text/x-java',
            'C': 'text/x-csrc',
            'Cpp': 'text/x-c++src',
        }[lang]
    };

	try {
		return (
			<div className="source-code status_details-container__item">
				<Card>
					<Card.Header as="h3">Source Code</Card.Header>
					<Card.Body>
						<div className="editor-container">
							<CodeMirror
								value={content}
								options={{
									matchBrackets: true,
									styleActiveLine: true,
									theme: "material",
									mode: getCodeMirrorModeFromLanguage(language),
									lineNumbers: true,
									readOnly: 'nocursor'
								}}
							/>
						</div>
					</Card.Body>
				</Card>
			</div>
		)
	} catch {
		return (
			<div className="source-code status_details-container__item">
				<Card>
					<Card.Header as="h3">Source code</Card.Header>
					<Card.Body>
						<div className='wait-text'> Please wait a moment... </div>
					</Card.Body>
				</Card>
			</div>
		)
	}
}

export default StatusDetailSource;
