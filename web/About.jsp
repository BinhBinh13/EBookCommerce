<%-- 
    Document   : About
    Created on : Mar 20, 2025, 2:37:16 PM
    Author     : Phong vu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới Thiệu - Booka Ebook Store</title>
    <style>
        /* Reset default margin/padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body */
        body {
            font-family: 'Arial', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: url('anhnenwweb.jpg'); /* Thay YOUR_IMAGE_URL bằng link hình nền của bạn */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            backdrop-filter: blur(5px);
        }

        .content-container {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 2rem;
            width: 80%;
            max-width: 900px;
            overflow-y: auto;
            max-height: 80%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            font-size: 2.5rem;
            color: #1e90ff;
            text-transform: uppercase;
            margin-bottom: 1rem;
        }

        h2 {
            font-size: 2rem;
            color: #34495e;
            margin-bottom: 0.5rem;
            text-align: left;
        }

        p {
            font-size: 1.2rem;
            color: #2c3e50;
            line-height: 1.6;
            margin-bottom: 1rem;
            text-align: justify;
        }

        .team-members {
            list-style: none;
            margin-top: 1rem;
            padding-left: 0;
            font-size: 1.1rem;
            color: #16a085;
        }

        .team-members li {
            margin-bottom: 0.5rem;
            text-indent: 20px;
        }

        .intro-text {
            margin-bottom: 2rem;
            text-align: justify;
        }

        .member-intro {
            background-color: #f4f4f4;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .member-intro h3 {
            font-size: 1.8rem;
            color: #76d7c4;
            margin-bottom: 1rem;
        }

        .member-intro p {
            font-size: 1rem;
            color: #34495e;
            text-align: justify;
        }

        footer {
            text-align: center;
            color: #34495e;
            margin-top: 2rem;
        }

        footer p {
            font-size: 1rem;
            color: #76d7c4;
        }

        /* Add indentation for smaller content sections */
        .intro-text p, .member-intro p {
            text-indent: 30px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .content-container {
                width: 90%;
            }

            h1 {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>

    <div class="content-container">
        <h1>Giới Thiệu Dự Án Booka</h1>

        <div class="intro-text">
            <p><strong>Booka</strong> là một dự án web bán sách điện tử được phát triển bởi nhóm 4, với mục đích cung cấp nền tảng cho người dùng tìm kiếm và mua sách trực tuyến. Dự án giúp người dùng trải nghiệm mua sách thuận tiện, dễ dàng qua giao diện người dùng thân thiện. Hệ thống sử dụng các công nghệ tiên tiến như JSP, Servlet và HTML/CSS cho phần front-end.</p>
            <p>Sau đây là các thành viên trong nhóm và vai trò của họ trong dự án:</p>
        </div>

        <div class="team-members">
            <ul>
                <li>Lê Hùng Cường - Quản lý dự án, phát triển back-end</li>
                <li>Bùi Ngọc Anh - Phát triển front-end, thiết kế giao diện</li>
                <li>Đặng Tấn Bình - Phát triển chức năng người dùng</li>
                <li>Vũ Sỹ Khải - Phát triển chức năng giỏ hàng, thanh toán</li>
                <li>Nguyễn Ngọc Quang - Phát triển hệ thống bảo mật và bảo vệ dữ liệu</li>
                <li>Phan Anh Tú - Kiểm thử và tối ưu hiệu suất trang web</li>
            </ul>
        </div>

        <div class="member-intro">
            <h3>Lê Hùng Cường</h3>
            <p>Lê Hùng Cường là quản lý dự án và phát triển back-end của hệ thống. Người chịu trách nhiệm triển khai các chức năng cơ bản của hệ thống và đảm bảo các yêu cầu về hiệu suất và bảo mật của trang web.</p>
        </div>

        <div class="member-intro">
            <h3>Bùi Ngọc Anh</h3>
            <p>Bùi Ngọc Anh là người phát triển giao diện front-end của trang web, thiết kế các trang để người dùng dễ dàng tìm kiếm và mua sách. Người đảm bảo trải nghiệm người dùng thân thiện và dễ sử dụng.</p>
        </div>

        <div class="member-intro">
            <h3>Đặng Tấn Bình</h3>
            <p>Đặng Tấn Bình phát triển các chức năng người dùng, từ đăng nhập, đăng ký, đến việc quản lý thông tin người dùng trên hệ thống.</p>
        </div>

        <div class="member-intro">
            <h3>Vũ Sỹ Khải</h3>
            <p>Vũ Sỹ Khải phát triển chức năng giỏ hàng và thanh toán của trang web, giúp người dùng có thể dễ dàng thêm sản phẩm vào giỏ và hoàn tất thanh toán một cách tiện lợi.</p>
        </div>

        <div class="member-intro">
            <h3>Nguyễn Ngọc Quang</h3>
            <p>Nguyễn Ngọc Quang đảm nhận vai trò bảo mật hệ thống, bảo vệ dữ liệu của người dùng và các giao dịch trên website.</p>
        </div>

        <div class="member-intro">
            <h3>Phan Anh Tú</h3>
            <p>Phan Anh Tú là người kiểm thử và tối ưu hiệu suất trang web, đảm bảo rằng hệ thống hoạt động mượt mà và hiệu quả trong mọi điều kiện.</p>
        </div>
        
        <div>
            <a href="home">BACK</a>
        </div>

        <footer>
            <p>&copy; 2025 Booka. Tất cả quyền được bảo lưu.</p>
        </footer>
    </div>

</body>
</html>
