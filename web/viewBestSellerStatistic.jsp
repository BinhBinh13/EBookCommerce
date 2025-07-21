<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Best Seller Statistics</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1, h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .filter-container {
            text-align: center;
            margin-bottom: 20px;
        }
        select, button {
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: #fff;
            cursor: pointer;
            transition: border-color 0.3s;
        }
        select:hover, button:hover {
            border-color: #888;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            margin-left: 10px;
        }
        button:hover {
            background-color: #45a049;
        }
        .chart-container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto 40px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }
        .table-container, .ranking-container {
            width: 100%;
            overflow-x: auto;
            margin-top: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
            border-right: 1px solid #ddd; /* Thêm đường kẻ dọc giữa các cột */
        }
        th:last-child, td:last-child {
            border-right: none; /* Bỏ đường kẻ dọc ở cột cuối cùng */
        }
        th {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .error-message {
            text-align: center;
            color: red;
            margin: 10px 0;
        }
        .legend-container {
            width: 100%;
            max-width: 800px;
            margin: 0 auto 20px;
            padding: 10px;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }
        .legend-container h3 {
            text-align: center;
            color: #333;
            margin-bottom: 10px;
        }
        .legend-container ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .legend-container li {
            margin: 5px 15px;
            font-size: 14px;
            color: #333;
        }
        .ranking-container .book-names {
            line-height: 1.5; /* Khoảng cách giữa các dòng */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Best Seller Statistics</h1>

        <!-- Form chọn năm -->
        <div class="filter-container">
            <form action="${pageContext.request.contextPath}/bestseller" method="GET">
                <label for="yearSelect">Select Year: </label>
                <select id="yearSelect" name="year">
                    <option value="">All Years</option>
                    <c:forEach var="year" items="${sessionScope.availableYears}">
                        <option value="${year}" ${param.year == year ? 'selected' : ''}>${year}</option>
                    </c:forEach>
                </select>
                <button type="submit">View</button>
            </form>
        </div>

        <!-- Biểu đồ -->
        <div class="chart-container">
            <canvas id="bestSellerChart"></canvas>
        </div>

        <!-- Bảng chú thích -->
        <div class="legend-container">
            <h3>Legend</h3>
            <ul>
                <c:forEach var="record" items="${sessionScope.bestSellerList}" varStatus="loop">
                    <li>${loop.count}: ${fn:escapeXml(record[1])}</li>
                </c:forEach>
            </ul>
        </div>

        <!-- Bảng chi tiết -->
        <div class="table-container">
            <h2>Book Sales Details</h2>
            <table>
                <thead>
                    <tr>
                        <th>Book ID</th>
                        <th>Book Name</th>
                        <th>Quantity Sold</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <c:if test="${empty sessionScope.bestSellerList}">
                        <tr>
                            <td colspan="3" style="text-align: center;">No data available.</td>
                        </tr>
                    </c:if>
                    <c:forEach var="record" items="${sessionScope.bestSellerList}">
                        <tr>
                            <td>${record[0]}</td>
                            <td>${fn:escapeXml(record[1])}</td>
                            <td>${record[2]}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Bảng xếp hạng -->
        <div class="ranking-container">
            <h2>Top Best Selling Books</h2>
            <table>
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Book Name</th>
                        <th>Quantity Sold</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty sessionScope.bestSellerList}">
                        <tr>
                            <td colspan="3" style="text-align: center;">No data available.</td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty sessionScope.bestSellerList}">
                        <c:set var="currentRank" value="1" />
                        <c:set var="currentQuantity" value="${sessionScope.bestSellerList[0][2]}" />
                        <c:set var="bookNames" value="${fn:escapeXml(sessionScope.bestSellerList[0][1])}" />
                        <c:forEach var="record" items="${sessionScope.bestSellerList}" varStatus="loop">
                            <c:if test="${loop.index > 0}">
                                <c:choose>
                                    <c:when test="${record[2] == currentQuantity}">
                                        <!-- Nếu số lượng giống với nhóm trước, gộp tên sách -->
                                        <c:set var="bookNames" value="${bookNames}<br>${fn:escapeXml(record[1])}" />
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Kết thúc nhóm trước, hiển thị hàng -->
                                        <tr>
                                            <td>Top ${currentRank}</td>
                                            <td class="book-names">${bookNames}</td>
                                            <td>${currentQuantity}</td>
                                        </tr>
                                        <!-- Bắt đầu nhóm mới -->
                                        <c:set var="currentRank" value="${currentRank + 1}" />
                                        <c:set var="currentQuantity" value="${record[2]}" />
                                        <c:set var="bookNames" value="${fn:escapeXml(record[1])}" />
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <c:if test="${loop.last}">
                                <!-- Hiển thị nhóm cuối cùng -->
                                <tr>
                                    <td>Top ${currentRank}</td>
                                    <td class="book-names">${bookNames}</td>
                                    <td>${currentQuantity}</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Dữ liệu ban đầu
        const initialData = [
            <c:forEach var="record" items="${sessionScope.bestSellerList}" varStatus="loop">
                ['${loop.count}', '${fn:replace(record[1], "'", "\\'")}', ${record[2]}]${loop.last ? '' : ','}
            </c:forEach>
        ];

        // Hàm vẽ biểu đồ cột
        function drawChart(data) {
            if (!data || data.length === 0) {
                document.getElementById('bestSellerChart').style.display = 'none';
                const container = document.querySelector('.chart-container');
                container.innerHTML += '<p class="error-message">No data available for this year.</p>';
                return;
            }

            const ctx = document.getElementById('bestSellerChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar', // Biểu đồ cột
                data: {
                    labels: data.map(item => item[0]), // Số thứ tự (1, 2, 3,...)
                    datasets: [{
                        label: 'Quantity Sold',
                        data: data.map(item => item[2]), // Số lượng
                        backgroundColor: 'rgba(75, 192, 192, 0.6)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { 
                            beginAtZero: true, 
                            title: { display: true, text: 'Quantity Sold' } 
                        },
                        x: { 
                            title: { display: true, text: 'Book Number' },
                            ticks: {
                                autoSkip: false,
                                maxRotation: 0,
                                minRotation: 0
                            }
                        }
                    },
                    plugins: {
                        legend: { display: true, position: 'top' },
                        title: { 
                            display: true, 
                            text: 'Best Selling Books' + (document.getElementById('yearSelect').value ? ' in ' + document.getElementById('yearSelect').value : ' (All Years)')
                        }
                    }
                }
            });
        }

        // Vẽ biểu đồ ban đầu
        window.onload = function() {
            console.log('Initial data:', initialData); // Debug dữ liệu ban đầu
            drawChart(initialData);
        };
    </script>
</body>
</html>