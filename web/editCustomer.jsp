<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Edit Customer Information</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background: linear-gradient(135deg, #74ebd5, #acb6e5); /* Gradient background */
                overflow-y: auto;
            }

            .container {
                background-color: rgba(255, 255, 255, 0.95);
                padding: 2rem 3rem;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                width: 100%;
                max-width: 450px;
                text-align: center;
                animation: fadeIn 1s ease-in-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            h1 {
                color: #2c3e50; /* Dark blue-gray */
                font-size: 2rem;
                margin-bottom: 1.5rem;
                text-transform: uppercase;
                letter-spacing: 1.5px;
            }

            form {
                display: flex;
                flex-direction: column;
                gap: 1.2rem;
            }

            .form-group {
                text-align: left;
            }

            label {
                font-weight: bold;
                color: #34495e; /* Darker gray-blue */
                margin-bottom: 0.5rem;
                display: block;
                font-size: 1rem;
            }

            input[type="text"],
            input[type="email"],
            select {
                width: 100%;
                padding: 0.8rem;
                border: 2px solid #3498db; /* Light blue */
                border-radius: 25px;
                font-size: 1rem;
                box-sizing: border-box;
                transition: all 0.3s ease;
            }

            input[type="text"]:focus,
            input[type="email"]:focus,
            select:focus {
                outline: none;
                border-color: #2ecc71; /* Emerald green */
                box-shadow: 0 0 8px rgba(46, 204, 113, 0.3);
            }

            select {
                appearance: none;
                background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="6"><polyline points="0,0 6,6 12,0" fill="none" stroke="%2334495e" stroke-width="2"/></svg>') no-repeat right 15px center;
                background-size: 12px;
                padding-right: 2rem;
            }

            .button input[type="submit"] {
                width: 100%;
                padding: 0.9rem;
                border: none;
                border-radius: 25px;
                background-color: #2ecc71; /* Emerald green */
                color: white;
                font-size: 1.1rem;
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 5px 15px rgba(46, 204, 113, 0.4);
            }

            .button input[type="submit"]:hover {
                background-color: #27ae60; /* Darker green */
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(39, 174, 96, 0.5);
            }

            .button input[type="submit"]:active {
                transform: translateY(1px);
                box-shadow: 0 3px 10px rgba(39, 174, 96, 0.3);
            }

            .cancel-link {
                margin-top: 1rem;
                display: block;
                color: #3498db; /* Light blue */
                text-decoration: none;
                font-size: 0.95rem;
                transition: color 0.3s ease;
            }

            .cancel-link:hover {
                color: #2c3e50; /* Darker shade */
                text-decoration: underline;
            }

            /* Responsive design */
            @media (max-width: 480px) {
                .container {
                    padding: 1.5rem 2rem;
                    margin: 1rem;
                }

                h1 {
                    font-size: 1.6rem;
                }

                input[type="text"],
                input[type="email"],
                select,
                .button input[type="submit"] {
                    padding: 0.7rem;
                    font-size: 0.95rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Update Information</h1>
            <%
                // Lấy thông tin người dùng từ session
                User currentUser = (User) session.getAttribute("currentUser") == null ? (User) session.getAttribute("currentAdmin") : (User) session.getAttribute("currentUser");
                if (currentUser == null ) {
                    response.sendRedirect("login_test.jsp");
                    return;
                }
            %>
            <form action="update" method="post" enctype="multipart/form-data">
                <input type="hidden" name="accountId" value="<%= currentUser.getAccountId() %>">

                <div class="form-group">
                    <label>Full Name:</label>
                    <input type="text" name="fullName" value="<%= currentUser.getFullName() %>" required>
                </div>

                <div class="form-group">
                    <label>Email:</label>
                    <input type="email" name="email" value="<%= currentUser.getEmail() %>" required>
                </div>

                <div class="form-group">
                    <label>Phone Number:</label>
                    <input type="text" name="phoneNumber" value="<%= currentUser.getPhoneNumber() %>" required>
                </div>

                <div class="form-group">
                    <label>Gender:</label>
                    <select name="gender" required>
                        <option value="Male" <%= currentUser.getGender().equalsIgnoreCase("Male") ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= currentUser.getGender().equalsIgnoreCase("Female") ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= currentUser.getGender().equalsIgnoreCase("Other") ? "selected" : "" %>>Other</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Avatar:</label>
                    <input type="file" id="avatarFile" name="avatarPics" accept="image/*" >
                    <input type="hidden" id="avatarBase64" name="avatarPicsBase64">
                </div>

                <input type="hidden" name="currentImage" value="<%= currentUser.getAvatarPics() %>" />
                <div class="button">
                    <input type="submit" value="Update Information">
                </div
            </form>
            <c:if test ="${message != null}">
                <p>${message}</p>
            </c:if>

            <p><a href="${sessionScope.currentAdmin != null ? "view_adminInfo.jsp" : "userprofile"}" class="cancel-link">Go Back</a></p>

        </div>
    </body>
</html>