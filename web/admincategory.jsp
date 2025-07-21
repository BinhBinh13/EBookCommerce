<%-- 
    Document   : admincategory
    Created on : Mar 11, 2025, 7:45:21 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category List</title>
        <!-- Table Styles -->
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
        <!-- Modal Styles -->
        <style>
            /* Modal Overlay */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                backdrop-filter: blur(3px);
                animation: fadeIn 0.3s ease-in-out;
            }

            /* Modal Content */
            .modal-content {
                background-color: white;
                margin: 10% auto;
                padding: 25px;
                width: 50%;
                max-width: 500px;
                border-radius: 12px;
                text-align: left;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                position: relative;
                animation: slideIn 0.3s ease-in-out;
            }

            /* Close Button */
            .close {
                position: absolute;
                top: 12px;
                right: 16px;
                font-size: 24px;
                font-weight: bold;
                cursor: pointer;
                color: #555;
                transition: color 0.2s;
            }

            .close:hover {
                color: #e74c3c;
            }

            /* Form Styling */
            .modal-content label {
                display: block;
                font-weight: bold;
                margin-top: 12px;
                color: #333;
            }

            .modal-content input,
            .modal-content select,
            .modal-content textarea {
                width: 100%;
                padding: 10px;
                margin-top: 6px;
                border: 1px solid #ccc;
                border-radius: 6px;
                font-size: 16px;
                outline: none;
                transition: border-color 0.2s;
            }

            .modal-content input:focus,
            .modal-content select:focus,
            .modal-content textarea:focus {
                border-color: #3498db;
            }

            /* Buttons */
            .add-btn {
                display: block;
                width: 100%;
                padding: 12px;
                margin-top: 20px;
                background-color: #3498db;
                color: white;
                font-size: 16px;
                font-weight: bold;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s ease-in-out;
            }

            .add-btn:hover {
                background-color: #2980b9;
            }

            /* Animations */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            @keyframes slideIn {
                from {
                    transform: translateY(-20px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

        </style>
    </head>
    <body>

        <div class="content">
            <h1>Category List</h1>

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
            <!-- Add Book Button -->
            <div class="add-book-container">
                <button class="add-btn" onclick="openModal('addBookModal')">Add Category</button>
            </div>

            <!-- Search Bar -->
            <div class="search-container" style="margin-bottom: 15px;">
                <form action="${pageContext.request.contextPath}/admincategorylist" method="GET">
                    <input type="text" name="nameOrId" placeholder="Search by name or ID" 
                           value="${param.nameOrId}" style="padding: 8px; width: 250px; border: 1px solid #ccc; border-radius: 5px;">
                    <button type="submit" class="search-btn" style="padding: 8px 12px; background-color: #007bff; color: white; border: none; cursor: pointer; border-radius: 5px;">
                        Search
                    </button>
                </form>
            </div>

            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Status</th>
                    <th>Tools</th> <!-- New column for action buttons -->
                </tr>

                <c:choose>
                    <c:when test="${empty booklist}">
                        <tr>
                            <td colspan="4" style="text-align: center; color: red;">No category found</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="book" items="${booklist}">
                            <tr>
                                <td>${book.categoryId}</td>
                                <td>${book.categoryName}</td>
                                <td>${book.status}</td>
                                <td>
                                    <button class="update-btn" onclick="openEditModal('${book.categoryId}', '${book.categoryName}', '${book.status}')">Update</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

            </table>


            <!-- Pagination Controls -->
            <div class="pagination">
                <c:if test="${pageNo > 1}">
                    <a href="${pageContext.request.contextPath}/admincategorylist?pageNo=${pageNo - 1}&nameOrId=${param.nameOrId}">Previous</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/admincategorylist?pageNo=${pageNo}&nameOrId=${param.nameOrId}">${pageNo}</a>
                <c:if test="${pageNo < totalPages}">
                    <a href="${pageContext.request.contextPath}/admincategorylist?pageNo=${pageNo + 1}&nameOrId=${param.nameOrId}">Next</a>
                </c:if>
            </div>

            <!-- Add/Edit Book Modal -->
            <div id="addBookModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal('addBookModal')">&times;</span>
                    <h2>Add Category</h2>
                    <form action="${pageContext.request.contextPath}/adminaddcategory" method="get">
                        <label for="bookName">Category Name:</label>
                        <input type="text" id="bookName" name="bookName" required>
                        
                        <label for="bookStatus">Status:</label>
                        <select id="bookStatus" name="bookStatus">
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                        
                        <button type="submit" class="add-btn">Save</button>
                    </form>
                </div>
            </div>

            <!-- Edit Book Modal -->
            <div id="editBookModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeModal('editBookModal')">&times;</span>
                    <h2>Edit Category</h2>
                    <form action="${pageContext.request.contextPath}/adminupdatecategory" method="get">
                        <input type="hidden" id="editBookId" name="bookId">

                        <label for="editBookName">Category Name:</label>
                        <input type="text" id="editBookName" name="bookName" required>
                        
                        <label for="editBookStatus">Status:</label>
                        <select id="editBookStatus" name="bookStatus">
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>

                        <button type="submit" class="add-btn">Save Changes</button>
                    </form>
                </div>
            </div>           
        </div>
        <!-- JavaScript for Modal -->
        <script>
            function openModal(modalId) {
                document.getElementById(modalId).style.display = "block";
            }

            function closeModal(modalId) {
                document.getElementById(modalId).style.display = "none";
            }

            function openEditModal(id, name, status) {
                document.getElementById("editBookId").value = id;
                document.getElementById("editBookName").value = name;
                document.getElementById("editBookStatus").value = status;
                openModal("editBookModal");
            }

            window.onclick = function (event) {
                if (event.target.classList.contains("modal")) {
                    event.target.style.display = "none";
                }
            }
        </script>
    </body>
</html>
