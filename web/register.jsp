<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register - EBOOK STORE</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url('anhnen4.jpg'); /* Replace with your library background image URL */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            backdrop-filter: blur(5px);
        }

        .container {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 2rem 3rem;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 400px;
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

        h1 {
            color: #1e90ff; /* Dodger blue */
            font-size: 2rem;
            margin-bottom: 1.5rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            animation: slideDown 1s ease-in-out;
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

        form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            text-align: left;
        }

        label {
            font-weight: bold;
            color: #34495e; /* Dark gray-blue */
            font-size: 1rem;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="file"] {
            padding: 0.8rem;
            border: 2px solid #1e90ff;
            border-radius: 25px;
            font-size: 1rem;
            width: 100%;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus,
        input[type="file"]:focus {
            outline: none;
            border-color: #2ecc71; /* Emerald green */
            box-shadow: 0 0 10px rgba(46, 204, 113, 0.3);
        }

        input[type="radio"] {
            margin-right: 0.5rem;
        }

        button[type="submit"] {
            padding: 12px 25px;
            border: none;
            border-radius: 25px;
            font-size: 1.1rem;
            cursor: pointer;
            background-color: #2ecc71; /* Emerald green */
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(46, 204, 113, 0.4);
            width: 100%;
            margin-top: 1.5rem;
        }

        button[type="submit"]:hover {
            background-color: #27ae60; /* Darker emerald green */
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(39, 174, 96, 0.5);
        }

        button[type="submit"]:active {
            transform: translateY(1px);
            box-shadow: 0 3px 10px rgba(39, 174, 96, 0.3);
        }

        .message {
            margin-top: 1rem;
        }

        .error {
            color: #e74c3c; /* Red for errors */
            font-size: 0.9rem;
            animation: shake 0.5s ease-in-out;
        }

        .success {
            color: #2ecc71; /* Green for success */
            font-size: 0.9rem;
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
                font-size: 1.5rem;
            }
            
            .form-group {
                gap: 0.8rem;
            }
            
            label {
                font-size: 0.9rem;
            }
            
            input[type="text"],
            input[type="email"],
            input[type="password"],
            input[type="file"],
            button[type="submit"] {
                padding: 0.7rem;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Register</h1>
        <form action="register" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="fullName">Enter your full name:</label>
                <input type="text" name="fullName" id="fullName" value="<%= request.getParameter("fullName") != null ? request.getParameter("fullName") : "" %>">
            </div>
            <div class="form-group">
                <label for="email">Enter your email:</label>
                <input type="email" name="email" id="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            </div>
            <div class="form-group">
                <label for="phoneNumber">Enter your phone number:</label>
                <input type="text" name="phoneNumber" id="phoneNumber" value="<%= request.getParameter("phoneNumber") != null ? request.getParameter("phoneNumber") : "" %>">
            </div>
            <div class="form-group">
                <label>Choose your gender:</label>
                <input type="radio" name="gender" value="Male" <%= "Male".equals(request.getParameter("gender")) ? "checked" : "" %>> Male
                <input type="radio" name="gender" value="Female" <%= "Female".equals(request.getParameter("gender")) ? "checked" : "" %>> Female
            </div>
            <div class="form-group">
                <label for="username">Enter your username:</label>
                <input type="text" name="username" id="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
            </div>
            <div class="form-group">
                <label for="password">Enter your password:</label>
                <input type="password" name="password" id="password">
            </div>
            <div class="form-group">
                <label for="passwordAgain">Confirm password again:</label>
                <input type="password" name="passwordAgain" id="passwordAgain">
            </div>
            <div class="form-group">
                <label for="avatar">Choose your avatar:</label>
                <input type="file" name="avatar" id="avatar" accept="image/*" >
            </div>
            <button type="submit">Register</button>
        </form>
        <div class="message">
            <% if (request.getAttribute("error") != null) { %>
                <p class="error"><%= request.getAttribute("error") %></p>
            <% } %>
            <% if (request.getAttribute("result") != null) { %>
                <p class="success"><%= request.getAttribute("result") %></p>
                <a href="login_test.jsp" style="color: #2ecc71; text-decoration: none;">Back to login page</a>
            <% } %>
        </div>
    </div>
</body>
</html>