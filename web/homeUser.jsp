
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Customer - User Information</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            backdrop-filter: blur(5px);
        }

        .container {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 2.5rem 3rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 600px;
            text-align: center;
            animation: fadeIn 1.5s ease-in;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        h1, h2 {
            color: #1e90ff; /* Dodger blue */
            margin-bottom: 1.5rem;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        h1 {
            font-size: 2.5rem;
            animation: slideDown 1s ease-in-out;
        }

        h2 {
            font-size: 1.8rem;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
        }

        .user-table th, .user-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 2px solid #e6f3ff; /* Light blue for borders */
            color: #34495e; /* Dark gray-blue */
        }

        .user-table th {
            background-color: #d0e8f2; /* Light blue for header */
            font-weight: bold;
        }

        .user-table tr:hover {
            background-color: #f5f9ff; /* Very light blue on hover */
            transition: background-color 0.3s ease;
        }

        .avatar-img {
            width: 100px;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .buttons {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            color: white;
            background-color: #2ecc71; /* Emerald green */
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(46, 204, 113, 0.4);
        }

        .btn:hover {
            background-color: #27ae60; /* Darker emerald green */
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(39, 174, 96, 0.5);
        }

        .btn:active {
            transform: translateY(1px);
            box-shadow: 0 3px 10px rgba(39, 174, 96, 0.3);
        }

        .error {
            color: #e74c3c; /* Red for errors */
            font-size: 1rem;
            margin-top: 1rem;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            50% { transform: translateX(5px); }
            75% { transform: translateX(-5px); }
            100% { transform: translateX(0); }
        }

        /* Responsive design */
        @media (max-width: 480px) {
            .container {
                padding: 1.5rem 2rem;
                margin: 1rem;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            h2 {
                font-size: 1.5rem;
            }
            
            .user-table th, .user-table td {
                padding: 0.8rem;
                font-size: 0.9rem;
            }
            
            .avatar-img {
                width: 80px;
            }
            
            .btn {
                padding: 8px 16px;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        
        <%
            // Lấy thông tin người dùng từ session
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser == null) {
        %>
            <p class="error">Error: User information not found. Please log in again.</p>
            <a href="login.jsp" class="btn">Back to Login</a>
        <%
            } else {
        %>
        <h1>Welcome <%= currentUser.getUsername() %></h1>
        <h2>Your Information:</h2>
        <table class="user-table">

            <tr>
                <th>Username:</th>
                <td><%= currentUser.getUsername() %></td>
            </tr>
            <tr>
                <th>Full Name:</th>
                <td><%= currentUser.getFullName() %></td>
            </tr>
            <tr>
                <th>Email:</th>
                <td><%= currentUser.getEmail() %></td>
            </tr>
            <tr>
                <th>Phone Number:</th>
                <td><%= currentUser.getPhoneNumber() %></td>
            </tr>
            <tr>
                <th>Gender:</th>
                <td><%= currentUser.getGender() %></td>
            </tr>
            <tr>
                <th>Avatar:</th>
                <td>
                    <img src="<%= currentUser.getAvatarPics() %>" alt="Avatar" class="avatar-img"/>
                </td>
            </tr>
        </table>
        <div class="buttons">
            <a href="editCustomer.jsp" class="btn">Edit Information</a>
            <a href="deleteCustomer.jsp" class="btn">Delete Account</a>
        </div>
        <%
            }
        %>
    </div>
</body>
</html>