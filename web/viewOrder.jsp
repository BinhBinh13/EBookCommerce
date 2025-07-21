<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Order List</title>
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

        /* Style cho thông báo status */
        .status-info {
            text-align: center;
            color: #e74c3c; /* Màu đỏ */
            font-size: 14px; /* Kích thước chữ nhỏ */
            font-weight: 500;
            margin-top: 20px; /* Khoảng cách trên */
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

        /* Style cho trạng thái trong cột Status */
        .status-label {
            display: inline-block;
            padding: 5px 10px;
            font-weight: 600;
            text-transform: uppercase;
            border-radius: 3px; /* Giảm bo góc */
            text-decoration: none;
            cursor: default;
            text-align: center; /* Căn giữa chữ */
        }

        .paid {
            color: #27ae60; /* Màu chữ xanh lá */
            background-color: transparent; /* Không có màu nền */
        }

        .unpaid {
            color: #e74c3c; /* Màu chữ đỏ */
            background-color: transparent; /* Không có màu nền */
        }

        /* Hiệu ứng hover cho hàng */
        tr:hover {
            background-color: #f9f9f9;
            transition: background-color 0.3s ease;
        }

        /* Style cho button */
        .action-button {
            display: inline-block;
            padding: 8px 15px;
            margin-right: 10px;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background-color 0.3s ease;
        }

        .action-button:hover {
            background-color: #2980b9;
        }

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
    </style>
    <script type="text/javascript">
        function doViewDetail(bill_id, total_money) {
            if (confirm("Are you want to view bill detail with " + bill_id + " ?")) {
                window.location.href = "viewbilldetail?bill_id=" + bill_id+"&total_money="+total_money;
            }
        }

        function doUpdate(bill_id, status) {
            if (confirm("Are you sure to update status of the bill with id " + bill_id + " ?")) {
                window.location.href = "updatebill?bill_id=" + bill_id + "&status="+ status;
            }
        }

        function goBack() {
            // Sử dụng window.top.location.href để thoát khỏi iframe và chuyển hướng toàn bộ trang
            window.top.location.href = "homepageAdmin.jsp";
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>LIST OF BILL</h1>

        <!-- Kiểm tra nếu danh sách rỗng -->
        <c:if test="${empty sessionScope.data}">
            <p class="no-data">No bills found.</p>
        </c:if>

        <!-- Hiển thị bảng nếu danh sách không rỗng -->
        <c:if test="${not empty sessionScope.data}">
            <table>
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Account ID</th>
                        <th>Total Money</th>
                        <th>Payment Method</th>
                        <th>Create Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${sessionScope.data}" var="c">
                        <c:set var="bill_id" value="${c.billId}"/>
                        <c:set var="status" value="${c.status}"/>
                        <c:set var="total_money" value="${c.total_money}"/>
                        <tr>
                            <td>${bill_id}</td>
                            <td>${c.accountId}</td>
                            <td>${c.total_money}</td>
                            <td>${c.payment}</td>
                            <td>${c.create_date}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${status == 1}">
                                        <span class="status-label paid">Paid</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-label unpaid">Unpaid</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="#" class="action-button" onclick="doViewDetail('${bill_id}', '${total_money}')">View</a>
                                <a href="#" class="action-button" onclick="doUpdate('${bill_id}','${status}')">Update</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <!-- Button quay lại -->
        <a href="#" class="back-button" onclick="goBack()">BACK</a>     
    </div>
</body>
</html>
