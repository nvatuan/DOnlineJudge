import React from 'react'
import Navbar from '../../Navbar';
import { Card } from 'react-bootstrap';
import Collapsible from 'react-collapsible'
import './About.scss';
import { BsChevronDown } from "react-icons/bs"; //react-icon
import { GoPrimitiveDot } from "react-icons/go";

function RenderAnswer({ ans }) {
    if (ans.length == 0) return <p></p>;
    if (ans.charAt(0) === '{') {
        let tmp = ans.substring(1).split(',');
        return (
            <ul>
                {tmp.map((op) => (<li>{op}</li>))}
            </ul>
        );
    } else {
        return (
            <p>
                {ans}
            </p>
        );
    }
}

function FaqCollapsible({ question, answer }) {
    var lines = answer.split('\n');
    console.log(lines);
    return (
        <>
            <Collapsible trigger={[question, <BsChevronDown />]} easing='ease'>
                {
                    lines.map((line) => (<RenderAnswer ans={line} />))
                }
            </Collapsible>
            <div className="faq-collapsible-footer"></div>
        </>
    );
}

function About() {
    return (
        <div>
            <Navbar />
            <div className="pages-container">
                <div className="aboutus-container">
                    <Card className="aboutus-card">
                        <Card.Header as="h3" className="aboutus-header">
                            About us
                        </Card.Header>
                        <Card.Body>
                            <h5>Về nhóm và sản phẩm</h5>
                            <hr></hr>
                            {/* Question 1: Chúng tôi là ai?*/}
                            <Collapsible trigger={["Chúng tôi là ai?", <BsChevronDown />]} easing='ease'>
                                <p>Chúng tôi là sinh viên K18 của trường Đại học Bách Khoa Đà Nẵng bao gồm 4 người.</p>
                                <ul>
                                    <li>Ngô Văn Anh Tuấn (lead project)</li>
                                    <li>Nguyễn Đăng Thông (back-end dev)</li>
                                    <li>Trần Đình Quang Huy (lead front-end)</li>
                                    <li>Trần Xuân Phúc (front-end dev)</li>
                                </ul>
                            </Collapsible>

                            {/* Question 2: DOnlineJudge là gì?*/}
                            <Collapsible trigger={["DOnlineJudge là gì?", <BsChevronDown />]} easing='ease'>
                                <p>DOnlineJudge là một trình chấm code trực tuyến (online judge) được thiết kế để biên dịch (compile) và chấm kết quả (grading) một bài code của người dùng một cách tự động, thông qua các kiểm thử được thiết kế từ trước bởi người ra đề.</p>
                            </Collapsible>

                            {/* Question 3: Mục đích của DOnlineJudge?*/}
                            <Collapsible trigger={["Mục đích của DOnlineJudge?", <BsChevronDown />]} easing='ease'>
                                <p>Tự động hóa quá trình chấm code (tính đúng đắn của thuật toán) thông qua kiểm tra output. Hỗ trợ người dùng luyện tập khả năng tư duy thuật toán của họ.</p>
                            </Collapsible>

                            <br />
                            <h5>Chi tiết triển khai (Implementation details)</h5>
                            <hr></hr>
                            {/* Question*/}
                            <Collapsible trigger={["Front-end", <BsChevronDown />]} easing='ease'>
                                <p>Front-end được sử dụng framework ReactJS để phát triển.</p>
                            </Collapsible>

                            {/* Question*/}
                            <Collapsible trigger={["Back-end", <BsChevronDown />]} easing='ease'>
                                <p>Back-end cho web server là một API server, sử dụng Django REST framework.</p>
                            </Collapsible>

                            {/* Question*/}
                            <Collapsible trigger={["Back-end giao tiếp với Server chấm như thế nào?", <BsChevronDown />]} easing='ease'>
                                <p>
                                    Khi nhận code của người dùng nộp lên sẽ được đưa vào một hàng chờ, và backend sẽ tìm
                                    một server chấm thích hợp. Nếu chưa tìm được, backend sẽ chờ một khoảng thời gian trước khi tìm tiếp.
                                </p>
                                <p>
                                    Sau khi tìm được, nó sẽ khởi tạo một tiến trình background để chuẩn bị gửi thông tin biên dịch/chấm bài
                                    qua judge server. Sau khi gửi, tiến trình đó sẽ chờ đợi phản hồi từ server chấm để cập nhập thông tin
                                    của bài chấm lên /status.
                                </p>
                                <p>
                                    Back-end có một danh sách các server chấm cùng địa chỉ websocket của chúng. Back-end chọn server chấm
                                    theo tiêu chí tham lam là số lượng task còn tồn động ít nhất trên số nhân CPU.
                                </p>
                            </Collapsible>

                            {/* Question*/}
                            <Collapsible trigger={["Server chấm code như thế nào?", <BsChevronDown />]} easing='ease'>
                                <p>
                                    Server chấm sử dụng công nghệ Docker để biên dịch và thực thi code trong cô lập.
                                    Trong container Docker, có một script dùng để bắt đầu và kết thúc quá trình này.
                                    Sau khi hoàn tất (thành công hoặc thất bại), script sẽ báo cáo thông tin về từ
                                    bên trong Docker ra bên ngoài server chấm. Server chấm sẽ lọc những thông tin quan trọng,
                                    phản hồi về lại với Back-end thông qua địa chỉ đã gửi request.
                                </p>
                                <p>
                                    Nếu server chấm không có tác vụ, nó sẽ thỉnh thoảng ping đến back-end để xác nhận còn sống (heartbeat).
                                </p>
                            </Collapsible>
                            
                        </Card.Body>
                        <Card.Footer>
                            <p><em>
                                Mọi thông tin hay yêu cầu khác, xin hãy liên lạc đến admin@doj.com
                            </em></p>
                        </Card.Footer>
                    </Card>
                </div>
            </div>
        </div>
    )
}

export default About
