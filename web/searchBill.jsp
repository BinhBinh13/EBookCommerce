<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>List of Bills</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: Arial, sans-serif;
            }
            .container {
                margin-top: 30px;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            .status-paid {
                color: green;
                font-weight: bold;
            }
            .status-unpaid {
                color: red;
                font-weight: bold;
            }
            .btn-custom {
                width: 80px;
            }
        </style>
        <script>
            function doViewDetail(bill_id, total_money) {
                if (confirm("Are you sure you want to view bill details for Bill ID: " + bill_id + "?")) {
                    window.location.href = "viewbilldetail2?bill_id=" + bill_id + "&total_money=" + total_money;
                }
            }
            function doUpdate(bill_id, status) {
                if (confirm("Are you sure you want to update the status of Bill ID: " + bill_id + "?")) {
                    window.location.href = "updatebill?bill_id=" + bill_id + "&status=" + status;
                }
            }
            function goBack() {
                window.top.location.href = "admin";
            }
        </script>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">LIST OF BILL</h2>
            
            <form action="checkbill" method="post" class="mb-3">
                <div class="row">
                    <div class="col-md-6">
                        <input type="text" name="account_id" class="form-control" placeholder="Enter Account ID">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary">Search</button>
                    </div>
                </div>
            </form>
            
            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty requestScope.error}">
                <p style="color: red; font-weight: bold;">${requestScope.error}</p>
            </c:if>
            
            <!-- Hiển thị danh sách hóa đơn nếu có -->
            <c:if test="${not empty sessionScope.data3}">
                <table class="table table-bordered table-striped">
                    <thead class="table-primary">
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
                        <c:forEach items="${sessionScope.data3}" var="bill">
                            <tr>
                                <td>${bill.getBillId()}</td>
                                <td>${bill.getAccountId()}</td>
                                <td>${bill.getTotal_money()}</td>
                                <td>${bill.getPayment()}</td>
                                <td>${bill.getCreate_date()}</td>
                                <td>
                                    <span class="${bill.status == 1 ? 'status-paid' : 'status-unpaid'}">
                                        ${bill.status == 1 ? 'PAID' : 'UNPAID'}
                                    </span>
                                </td>
                                <td>
                                    <button class="btn btn-info btn-sm btn-custom" onclick="doViewDetail('${bill.getBillId()}', '${bill.total_money}')">View</button>
                                    <button class="btn btn-warning btn-sm btn-custom" onclick="doUpdate('${bill.getBillId()}', '${bill.status}')">Update</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            
            <button class="btn btn-danger" onclick="goBack()">Back</button>
        </div>
    </body>
</html>