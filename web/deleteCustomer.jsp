<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Customer Account</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background: white;
            padding: 2rem 3rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            color: #2c3e50;
            margin-bottom: 1.5rem;
            font-size: 1.8rem;
            font-weight: 600;
        }

        p {
            color: #666;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .confirm {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .button {
            padding: 12px 24px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }

        .button[type="submit"] {
            background: #e74c3c;
            color: white;
        }

        .button[type="submit"]:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
        }

        .button[href] {
            background: #ecf0f1;
            color: #2c3e50;
        }

        .button[href]:hover {
            background: #dfe6e9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(44, 62, 80, 0.2);
        }

        .message {
            color: #27ae60;
            font-weight: 500;
            margin-top: 2rem;
            padding: 1rem;
            background: #e8f4f8;
            border-radius: 10px;
            animation: slideIn 0.3s ease-in;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .countdown {
            font-size: 1.2rem;
            color: #e74c3c;
            font-weight: 600;
            display: inline-block;
            min-width: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Delete Your Account</h1>
        <%
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser == null) {
                response.sendRedirect("login_test.jsp");
                return;
            }
        %>
        <p>Are you sure you want to delete your account? This action cannot be undone.</p>
        <form id="deleteForm" action="delete" method="get"> 
            <input type="hidden" name="accountId" value="<%= currentUser.getAccountId() %>">
            <div class="confirm">
                <input class="button" type="submit" value="Confirm Delete" onclick="showConfirmationMessage(event)">
                <a class="button" href="userprofile">Cancel</a>
            </div>
        </form>
        
        <div id="confirmationMessage" class="message" style="display:none;">
            Account deleted successfully! Redirecting in <span id="countdown">5</span> seconds...
        </div>
    </div>

    <script>
        function showConfirmationMessage(event) {
            event.preventDefault();
            document.getElementById("confirmationMessage").style.display = "block";

            var countdownElement = document.getElementById("countdown");
            var countdownValue = 5;

            var countdownInterval = setInterval(function() {
                countdownValue--;
                countdownElement.textContent = countdownValue;

                if (countdownValue === 0) {
                    clearInterval(countdownInterval);
                    document.getElementById("deleteForm").submit();
                }
            }, 100);
        }
    </script>
</body>
</html>