<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bill Detail List</title>
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
            background-color: #f4f6f9;
            padding: 20px;
            color: #333;
        }

        /* Container chính */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        /* Tiêu đề */
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 28px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }

        /* Style cho bảng */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #3498db;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        td {
            color: #555;
        }

        /* Hiệu ứng hover cho hàng */
        tr:hover {
            background-color: #f9f9f9;
            transition: background-color 0.3s ease;
        }

        /* Style cho button */
        .back-button {
            display: inline-block;
            padding: 12px 25px;
            background-color: #e74c3c;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: #c0392b;
        }

        /* Style cho thông báo khi không có dữ liệu */
        .no-data {
            text-align: center;
            color: #e74c3c;
            font-size: 18px;
            margin-top: 20px;
        }

        /* Style cho Total Money */
        .total-money {
            font-size: 20px;
            font-weight: bold;
            color: #2c3e50;
            text-align: right; /* Căn lề phải */
            margin-top: 20px;
        }
    </style>
    <script type="text/javascript">
        function goBack() {
            // Sử dụng window.top.location.href để thoát khỏi iframe và chuyển hướng toàn bộ trang
            window.top.location.href = "viewbill";
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>LIST OF BILL DETAIL</h1>

        <!-- Kiểm tra nếu danh sách rỗng -->
        <c:if test="${empty sessionScope.data_detail}">
            <p class="no-data">No bill details found.</p>
        </c:if>

        <!-- Hiển thị bảng nếu danh sách không rỗng -->
        <c:if test="${not empty sessionScope.data_detail}">
            <table>
                <thead>
                    <tr>
                        <th>Bill Detail ID</th>
                        <th>Bill ID</th>
                        <th>Book Name</th>
                        <th>Book ID</th>
                        <th>Price (VNĐ)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${sessionScope.data_detail}" var="c">
                        <tr>
                            <td>${c.bdId}</td>
                            <td>${c.billId}</td>
                            <td>${c.bookName}</td>
                            <td>${c.bookId}</td>
                            <td>${c.price}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <h4 class="total-money">🚀 TOTAL MONEY: ${sessionScope.total_money}đ</h4> <!-- Căn lề phải cho tổng tiền -->
        </c:if>
        
        <!-- Button quay lại -->
        <a href="#" class="back-button" onclick="goBack()">BACK</a>
    </div>
</body>
</html>
