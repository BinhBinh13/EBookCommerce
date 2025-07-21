
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book List</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                display: flex;
            }
            .sidebar {
                width: 250px;
                background-color: #2c3e50;
                color: white;
                height: 100vh;
                padding: 20px;
            }
            .sidebar ul {
                list-style: none;
                padding: 0;
            }
            .sidebar ul li {
                margin: 15px 0;
            }
            .sidebar ul li a {
                text-decoration: none;
                color: white;
                display: block;
                padding: 10px;
                border-radius: 5px;
            }
            .sidebar ul li a:hover {
                background-color: #34495e;
            }
            .content {
                flex: 1;
                padding: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 10px;
                text-align: left;
            }
            .pagination {
                margin-top: 20px;
                text-align: center;
            }
            .pagination a {
                text-decoration: none;
                padding: 8px 12px;
                margin: 5px;
                border: 1px solid #007bff;
                color: #007bff;
                border-radius: 5px;
            }
            .pagination a:hover {
                background-color: #007bff;
                color: white;
            }
            .update-btn, .delete-btn {
                padding: 5px 10px;
                border: none;
                cursor: pointer;
                font-size: 14px;
                border-radius: 5px;
            }

            .update-btn {
                background-color: #4CAF50;
                color: white;
            }

            .delete-btn {
                background-color: #f44336;
                color: white;
            }

            .delete-btn:hover {
                background-color: #d32f2f;
            }

            .update-btn:hover {
                background-color: #45a049;
            }
            .add-book-container {
                margin-bottom: 10px;
            }

            .add-btn {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 8px 15px;
                cursor: pointer;
                font-size: 14px;
                border-radius: 5px;
            }

            .add-btn:hover {
                background-color: #218838;
            }

            .dropdown {
                position: relative;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                left: 0;
                top: 100%;
                background-color: #141414;
                min-width: 150px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
                z-index: 1;
            }

            .dropdown-content li {
                padding: 5px;
            }

            .dropdown-content li a {
                color: #333;
                padding: 8px 12px;
                display: block;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }

            .dropbtn {
                cursor: pointer;
            }
        </style>
    </head>
    <body>


        <div class="content">
            <h1>Book List</h1>

            <%-- Display Success or Error Message --%>
            <c:if test="${not empty message}">
                <div style="color: green; background-color: #d4edda; padding: 10px; border: 1px solid #c3e6cb; margin-bottom: 10px; border-radius: 5px;">
                    ${message}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div style="color: red; background-color: #f8d7da; padding: 10px; border: 1px solid #f5c6cb; margin-bottom: 10px; border-radius: 5px;">
                    ${error}
                </div>
            </c:if>

            <!-- Add Book Button -->
            <div class="add-book-container">
                <a href="${pageContext.request.contextPath}/adminaddbook">
                    <button class="add-btn">Add Book</button>
                </a>
            </div>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th style="width: 120px">CoverPic</th>
                    <th>Content</th>
                    <th style="width: 120px">Price</th>
                    <th>Status</th>
                    <th style="width: 200px">Tools</th> 
                </tr>
                <c:forEach var="book" items="${booklist}">
                    <tr>
                        <td>${book.bookId}</td>
                        <td>${book.bookName}</td>
                        <td>${book.author}</td>
                        <td><img width="100px" height="120px" src="${book.coverPics}" alt="alt"/></td>
                        <td><a href="${book.bookContent}" target="target">View content</a></td>
                        <td>${book.price} đ</td>
                        <td>${book.status}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/adminupdatebook?bookId=${book.bookId}">
                                <button class="update-btn">Update</button>
                            </a>
                            <a href="${pageContext.request.contextPath}/adminbookupdatestatus?bookId=${book.bookId}&status=${book.status == 1 ? 0 : 1}" onclick="return confirm('Are you sure you want to delete this book?');">
                                <button class="delete-btn">Status Change</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>


            <!-- Pagination Controls -->
            <div class="pagination">
                <c:if test="${pageNo > 1}">
                    <a href="${pageContext.request.contextPath}/adminbooklist?pageNo=${pageNo - 1}">Previous</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/adminbooklist?pageNo=${pageNo}">${pageNo}</a>
                <c:if test="${pageNo < totalPages}">
                    <a href="${pageContext.request.contextPath}/adminbooklist?pageNo=${pageNo + 1}">Next</a>
                </c:if>
            </div>
        </div>

    </body>
</html>
