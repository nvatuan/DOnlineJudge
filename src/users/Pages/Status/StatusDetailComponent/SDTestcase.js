import Collapsible from 'react-collapsible'
import { Card } from 'react-bootstrap';

function StatusDetailSample({ samples }) {
	try {
		return (
			<div className="submission_sample status_details-container__item">
				<Card>
					<Card.Header as="h3" >Sample Tests</Card.Header>
					<Card.Body>
						{
							samples.length === 0 
							? <p> This problem does not have any sample tests.</p>
							: samples.map((sample, idx) => {
								return (
									<Collapsible key={'sdsample-c'+idx} trigger={[`Sample Test #${idx+1}: ${sample.verdict} (CPU:${sample['cpu time']}ms, MEM:${sample['memory used']}KB)`]} easing='ease'>
										<table className='test-result'>
											<tbody>
												<tr>
													<td className='row-name'>Stderr</td>
													<td className='row-value'><pre>{sample['stderr']}</pre></td>
												</tr>
												<tr>
													<td className='row-name'>Stdout</td>
													<td className='row-value'><pre>{sample['stdout']}</pre></td>
												</tr>
											</tbody>
										</table>
									</Collapsible>
								)
							})
						}
					</Card.Body>
				</Card>
			</div>
		);
	} catch {
		return (
			<div className="submission_sample status_details-container__item">
				<Card>
					<Card.Header as="h3" >Sample Tests</Card.Header>
					<Card.Body>
						<div className='wait-text'> Please wait a moment... </div>
					</Card.Body>
				</Card>
			</div>
		)
	}
}

function StatusDetailHidden({ hiddens }) {
	try {
		return (
			<div className="submission_hidden status_details-container__item">
				<Card>
					<Card.Header as="h3" >Hidden Tests</Card.Header>
					<Card.Body>
						<ul>
							{
								hiddens.length === 0 
								? <p> This problem does not have any hidden tests.</p>
								: hiddens.map((hidden, idx) => {
									return (
										<Collapsible key={'sdhidden-c'+idx} trigger={[`Hidden Test #${idx+1}: ${hidden.verdict} (CPU:${hidden['cpu time']}ms, MEM:${hidden['memory used']}KB)`]} easing='ease'>
											<table className='test-result'>
											<tbody>
												<tr>
													<td className='row-name'>Stderr</td>
													<td className='row-value'><pre>{hidden['stderr']}</pre></td>
												</tr>
												<tr>
													<td className='row-name'>Stdout</td>
													<td className='row-value'><pre>{hidden['stdout']}</pre></td>
												</tr>
											</tbody>
											</table>
										</Collapsible>
									)
								})
							}
						</ul>
					</Card.Body>
				</Card>
			</div>
		);
	} catch {
		return (
			<div className="submission_hidden status_details-container__item">
				<Card>
					<Card.Header as="h3" >Hidden Tests</Card.Header>
					<Card.Body>
						<div className='wait-text'> Please wait a moment... </div>
					</Card.Body>
				</Card>
			</div>
		)
	}
}

export {
	StatusDetailSample,
	StatusDetailHidden,
}
