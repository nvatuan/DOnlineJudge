import React, { useState, useEffect } from 'react';
import axios from 'axios';
import Navbar from '../../Navbar';
import Coin from './Coin.js';
import Pagination from '../../Pagination/Pagination';
import {Card} from 'react-bootstrap';
import coin from './Coin.js';
import './Problem.scss';
function Problem() {
    const [coins, setCoins] = useState([]);
    const [search, setSearch] = useState('');
    const [pagination, setPagination] = useState({
        page: 1
    })
    const [loading, setLoading] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const [coinsPerPage, setcoinsPerPage] = useState(9);

    //
    const [filters, setFilters] = useState({
        page: 1
    })
    useEffect(() => {
        const fectchCoins = async () =>{
            setLoading(true);
            const res = await axios.get(`https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=150&page=1&sparkline=false`);
            setCoins(res.data);
            setLoading(false);
            setPagination(filters);
        }
        fectchCoins();
    }, [filters])
    const handleChange = (e) => {
        setSearch(e.target.value);
    }
    const handlePageChange = (newPage) =>{
        console.log('New page: ', newPage);
        setFilters({
            ...filters,
            page: newPage
        })
    }
    //serach feature
    const filteredCoins = coins.filter(coin => (
        coin.name.toLowerCase().includes(search.toLowerCase())
    ))
    //get current page 
    const indexOfLastCoin = currentPage * coinsPerPage;
    const indexOfFirstCoin = indexOfLastCoin - coinsPerPage;
    const currentCoin = coins.slice(indexOfFirstCoin, indexOfLastCoin);
    //page change
    const paginate = pageNumber => setCurrentPage(pageNumber);
    return (
        <div>
            <Navbar />
            <div className="pages-container">
                <div className="problems-container">
                    <div className="card-container">
                        <Card>
                            <Card.Header as="h3">Problem</Card.Header>
                            <Card.Body>
                                <div className="coin-app">
                                    <div className="coin-search">
                                        <div className="coin-text">Search</div>
                                        <form action="">
                                            <input type="text" className="coin-input" placeholder="Search"
                                                onChange={handleChange} />

                                        </form>
                                    </div>
                                    {currentCoin.map(coin => {
                                        return (
                                            <Coin
                                                key={coin.id}
                                                name={coin.name}
                                                image={coin.image}
                                                symbol={coin.symbol}
                                                price={coin.current_price}
                                                volume={coin.market_cap} />
                                        )
                                    })}
                                    <Pagination
                                        pagination={pagination}
                                        onPageChange={handlePageChange}
                                        paginate={paginate}
                                        coinPerPage={coinsPerPage}
                                        totalCoins={coins.length}
                                    />
                                </div>
                            </Card.Body>
                        </Card>
                    </div>
                </div>
            </div>
        </div>
            );
}

export default Problem
