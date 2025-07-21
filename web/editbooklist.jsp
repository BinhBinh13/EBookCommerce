<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Book</title>
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
            form {
                width: 50%;
                background: #f4f4f4;
                padding: 20px;
                border-radius: 5px;
            }
            label {
                font-weight: bold;
                display: block;
                margin-top: 10px;
            }
            input, textarea {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            button {
                margin-top: 15px;
                padding: 10px 15px;
                background: #007bff;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }
            button:hover {
                background: #0056b3;
            }
        </style>
    </head>
    <body>


        <div class="content">
            <h1>Update Book</h1>

            <form action="${pageContext.request.contextPath}/admineditbook" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">

                <input type="hidden" name="bookId" value="${book.bookId}" readonly=""/>

                <label>Book Name:</label>
                <input type="text" name="bookName" value="${book.bookName}" required />

                <label>Supplier:</label>
                <select name="supplierId" required>
                    <c:forEach var="s" items="${supplier}">
                        <option value="${s.supplierId}" ${s.supplierId eq book.supplierId ? 'selected' : ''}>
                            ${s.supplierName}
                        </option>
                    </c:forEach>
                </select>

                <label>Category:</label>
                <select name="categoryId" required>
                    <c:forEach var="c" items="${category}">
                        <option value="${c.categoryId}" ${c.categoryId eq book.categoryId ? 'selected' : ''}>
                            ${c.categoryName}
                        </option>
                    </c:forEach>
                </select>


                <label>Cover Pics URL:</label>
                <img  name="currentImage" src="${book.coverPics}" alt="alt" />
                <input type="file" name="coverPics" value="${book.coverPics}" />

                <label>Author:</label>
                <input type="text" name="author" value="${book.author}" required />

                <label>Description:</label>
                <textarea name="description" required>${book.description}</textarea>

                <label>Book Content URL:</label>
                <a name="currentContent" href="${book.bookContent}">View Content</a>
                <input type="file" name="bookContent" value="${book.bookContent}"  />

                <label>Price:</label>
                <input type="number" step="0.01" name="price" value="${book.price}" required />
                
                <input type="hidden" name="currentImage" value="${book.coverPics}" />
                
                <input type="hidden" name="currentContent" value="${book.bookContent}" />
                
                <button type="submit" value="update" name="submit">Update Book</button>
            </form>
        </div>

        <script>
            function validateForm() {
                let bookName = document.forms[0]["bookName"].value;
                let price = document.forms[0]["price"].value;

                if (bookName.trim() === "" || price <= 0) {
                    alert("Please enter valid details.");
                    return false;
                }
                return true;
            }
        </script>

    </body>
</html>
