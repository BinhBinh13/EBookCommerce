<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard - Ebook Store</title>
        <style>
            /* Reset mặc định */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Arial', sans-serif;
            }

            /* Style cho toàn trang */
            body {
                background: linear-gradient(135deg, #e0e7ff 0%, #f4f6f9 100%);
                color: #333;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                padding: 20px 0;
            }

            /* Container chính */
            .container {
                max-width: 1200px; /* Kích thước lớn hơn */
                width: 100%;
                margin: 0 auto;
                background-color: #fff;
                border-radius: 20px; /* Bo góc lớn hơn */
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                overflow: hidden;
                padding: 40px; /* Tăng padding */
            }

            /* Header */
            .header {
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 40px; /* Tăng khoảng cách */
                background-color: #2c3e50;
                color: white;
                padding: 25px; /* Tăng padding */
                border-radius: 15px; /* Bo góc lớn hơn */
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
            }

            .header-icon {
                font-size: 35px; /* Tăng kích thước icon */
                margin-right: 20px;
            }

            h1 {
                font-size: 36px; /* Tăng font-size */
                font-weight: bold;
            }

            /* Tiêu đề phụ */
            h2 {
                text-align: center;
                color: #2c3e50;
                font-size: 28px; /* Tăng font-size */
                margin-bottom: 40px; /* Tăng khoảng cách */
                border-bottom: 3px solid #3498db;
                padding-bottom: 15px; /* Tăng padding */
            }

            /* Style cho avatar */
            .avatar-container {
                text-align: center;
                margin-bottom: 40px; /* Tăng khoảng cách */
            }

            .avatar-img {
                width: 180px; /* Tăng kích thước avatar */
                height: 180px;
                border-radius: 50%;
                object-fit: cover;
                border: 6px solid #3498db;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            /* Style cho bảng */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 30px; /* Tăng khoảng cách */
                background-color: #fff;
                border-radius: 15px; /* Bo góc lớn hơn */
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 25px; /* Tăng padding */
                text-align: left;
                border-bottom: 2px solid #ddd; /* Tăng độ dày viền */
            }

            th {
                background-color: #3498db;
                color: white;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                width: 35%; /* Tăng chiều rộng cột tiêu đề */
                font-size: 20px; /* Tăng font-size */
            }

            td {
                color: #555;
                font-size: 20px; /* Tăng font-size */
                position: relative;
                padding-left: 60px; /* Tăng padding để chứa icon */
            }

            /* Icon trước mỗi thông tin */
            td::before {
                content: '';
                font-family: 'Font Awesome 5 Free';
                font-weight: 900;
                position: absolute;
                left: 25px; /* Tăng khoảng cách icon */
                color: #3498db;
                font-size: 22px; /* Tăng kích thước icon */
            }

            tr:nth-child(1) td::before {
                content: '\f2c2';
            } /* Account ID */
            tr:nth-child(2) td::before {
                content: '\f0a3';
            } /* Full Name */
            tr:nth-child(3) td::before {
                content: '\f0e0';
            } /* Email */
            tr:nth-child(4) td::before {
                content: '\f095';
            } /* Phone Number */
            tr:nth-child(5) td::before {
                content: '\f228';
            } /* Gender */
            
            tr:nth-child(6) td::before {
                content: '\f03e';
            } /* Avatar */

            /* Hiệu ứng hover cho hàng */
            tr:hover {
                background-color: #f0f8ff;
                transition: background-color 0.3s ease;
            }

            /* Style cho thông báo */
            .no-data {
                text-align: center;
                color: #e74c3c;
                font-size: 22px; /* Tăng font-size */
                margin-top: 40px; /* Tăng khoảng cách */
            }

            /* Style cho button */
            .button {
                display: inline-block;
                padding: 18px 35px; /* Tăng padding */
                background-color: #3498db;
                color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 12px; /* Bo góc lớn hơn */
                font-size: 20px; /* Tăng font-size */
                margin-top: 50px; /* Tăng khoảng cách */
                transition: background-color 0.3s ease;
                display: block;
                width: 250px; /* Tăng kích thước nút */
                margin-left: auto;
                margin-right: auto;
            }

            .button:hover {
                background-color: #2980b9;
            }

            .back-button {
                display: inline-block;
                padding: 18px 35px; /* Tăng padding */
                background-color: #e74c3c;
                color: white;
                text-align: center;
                text-decoration: none;
                border-radius: 12px; /* Bo góc lớn hơn */
                font-size: 20px; /* Tăng font-size */
                margin-top: 40px; /* Tăng khoảng cách */
                transition: background-color 0.3s ease;
                display: block;
                width: 250px; /* Tăng kích thước nút */
                margin-left: auto;
                margin-right: auto;
            }

            .back-button:hover {
                background-color: #c0392b;
            }
        </style>
        <!-- Font Awesome để sử dụng icon -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    </head>
    <body>
        <div class="container">
            <!-- Header -->
            <div class="header">
                <span class="header-icon"><i class="fas fa-user-shield"></i></span>
                <h1>Admin Dashboard</h1>
            </div>

            <%
                User currentAdmin = (User) session.getAttribute("currentAdmin");
                if (currentAdmin == null) {
            %>
            <p class="no-data">Error: Admin information is not available. Please log in again.</p>
            <div>
                <a href="login.jsp" class="back-button">Back to Login</a>
            </div>
            <%
                } else {
            %>


            <h2>Admin Information</h2>
            <table>
                <tr>
                    <th>Account ID</th>
                    <td><%= currentAdmin.getAccountId() %></td>
                </tr>

                <tr>
                    <th>Full Name</th>
                    <td><%= currentAdmin.getFullName() %></td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td><%= currentAdmin.getEmail() %></td>
                </tr>
                <tr>
                    <th>Phone Number</th>
                    <td><%= currentAdmin.getPhoneNumber() %></td>
                </tr>
                <tr>
                    <th>Gender</th>
                    <td><%= currentAdmin.getGender() %></td>
                </tr>

                <tr>
                    <th>Avatar</th>
                    <td><img src="<%= currentAdmin.getAvatarPics() %>" onerror="this.src='assets/img/people.png';" alt="alt"/></td>
                </tr>
            </table>

            <!-- Nút Update Information -->
            <div>
                <a href="editCustomer.jsp" class="button">Update Information</a>
            </div>
            <%
                }
            %>
        </div>
    </body>
</html>