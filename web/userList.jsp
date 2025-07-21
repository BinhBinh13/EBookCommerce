<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>User List</title>
    <style>
        body { background-color: #f4f6f9; padding: 20px; color: #333; font-family: 'Arial', sans-serif; }
        .container { max-width: 800px; margin: auto; background: #fff; padding: 30px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); }
        h2 { text-align: center; color: #2c3e50; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #2c3e50; color: white; }
        a { text-decoration: none; color: #3498db; }
        a:hover { color: #2980b9; }
        .btn { padding: 8px 12px; background: #2ecc71; color: white; border: none; border-radius: 5px; cursor: pointer; text-align: center; display: inline-block; }
        .btn:hover { background: #27ae60; }
    </style>
</head>
<body>
    <div class="container">
        <h2>User List</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
            </tr>
            <c:forEach var="user" items="${list}">
                <tr>
                    <td>${user.accountId}</td>
                    <td>${user.username}</td>
                    <td>${user.fullName}</td>
                    <td>${user.email}</td>
                    <td>${user.phoneNumber}</td>
                    <td>${user.roles}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>
