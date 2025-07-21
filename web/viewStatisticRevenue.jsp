<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Revenue Statistics</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        select {
            padding: 5px;
            font-size: 16px;
            margin-bottom: 20px;
        }
        table {
            width: 80%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .total-row {
            font-weight: bold;
            background-color: #e6f3ff;
        }
    </style>
</head>
<body>
    <h1>Revenue Statistics by Month (${selectedYear})</h1>
    
    <!-- Form chọn năm -->
    <form method="get" action="revenue">
        <label for="year">Select Year: </label>
        <select name="year" id="year" onchange="this.form.submit()">
            <c:forEach var="year" items="${years}">
                <option value="${year}" ${year == selectedYear ? 'selected' : ''}>${year}</option>
            </c:forEach>
        </select>
    </form>

    <!-- Biểu đồ -->
    <canvas id="revenueChart" width="600" height="400"></canvas>

    <!-- Bảng chi tiết doanh thu -->
    <h2>Revenue Details (${selectedYear})</h2>
    <table>
        <tr>
            <th>Date</th>
            <th>Month</th>
            <th>Revenue (VND)</th>
        </tr>
        <c:forEach var="detail" items="${revenueDetails}">
            <tr>
                <td><fmt:formatDate value="${detail[0]}" pattern="dd-MM-yyyy"/></td>
                <td>${detail[1]}</td>
                <td><fmt:formatNumber value="${detail[2]}" type="number" groupingUsed="true"/> VND</td>
            </tr>
        </c:forEach>
    </table>

    <!-- Tổng doanh thu theo tháng -->
    <h2>Monthly Totals (${selectedYear})</h2>
    <table>
        <tr>
            <th>Month</th>
            <th>Total Revenue (VND)</th>
        </tr>
        <c:forEach var="entry" items="${monthlyTotals}">
            <tr>
                <td>${entry.key}</td>
                <td><fmt:formatNumber value="${entry.value}" type="number" groupingUsed="true"/> VND</td>
            </tr>
        </c:forEach>
        <tr class="total-row">
            <td>Total for ${selectedYear}</td>
            <td><fmt:formatNumber value="${yearlyTotal}" type="number" groupingUsed="true"/> VND</td>
        </tr>
    </table>

    <script>
        // Lấy dữ liệu từ session cho biểu đồ
        var revenueData = [
            <c:forEach var="data" items="${revenueData}">
                { month: ${data[0]}, total: ${data[1]} },
            </c:forEach>
        ];

        // Tạo nhãn và dữ liệu cho biểu đồ
        var labels = revenueData.map(data => "Month " + data.month);
        var totals = revenueData.map(data => data.total);

        // Vẽ biểu đồ cột
        var ctx = document.getElementById('revenueChart').getContext('2d');
        var chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Revenue (VND) in ' + ${selectedYear},
                    data: totals,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: 'Revenue (VND)'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Month'
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>