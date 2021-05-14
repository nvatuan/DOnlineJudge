import React from 'react';
import PropTypes from 'prop-types';
import {Button} from '../Button';
import './Pagination.css'
function Pagination(props) {
    const {pagination, onPageChange, paginate, coinPerPage, totalCoins} = props;
    const {page} = pagination
    const pageNumbers = [];
    function handlePageChange(newPage){
        if(onPageChange){
            onPageChange(newPage);
        }
    }
    for(let i = 1 ; i <= Math.ceil(totalCoins/coinPerPage); i++){
        pageNumbers.push(i);
    }
    return (
        <div className="page-container">
            <nav aria-label="Page navigation example">
                <ul className="pagination justify-content-center">
                    <li className="page-item">
                        <Button buttonStyle='btn--primary' buttonSize='btn--medium' buttonColor='blue'
                            onClick={() => handlePageChange(page - 1)}>Prev
                        </Button>
                    </li>
                    {pageNumbers.map(number => (
                        <li key={number} className="page-item">
                            <a onClick={() => paginate(number)}   className="page-link">
                                {number}
                            </a>
                        </li>
                    ))}
                    <li className="page-item">
                        <Button buttonStyle='btn--primary' buttonSize='btn--medium' buttonColor='blue'
                            onClick={() => handlePageChange(page + 1)}>Next
                        </Button>
                    </li>
                </ul>
            </nav>
        </div>
    )
}

Pagination.propTypes = {
    pagination: PropTypes.object.isRequired,
    onPageChange: PropTypes.func,
    coinPerPage: PropTypes.number,
    totalCoins: PropTypes.number,
}
Pagination.defaultProps = {
    onPageChange: null,
}
export default Pagination

