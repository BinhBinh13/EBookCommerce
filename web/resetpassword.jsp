<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <style>
        /* Reset một số thuộc tính mặc định */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Thiết lập nền cho toàn bộ trang */
        body {
            font-family: Arial, sans-serif;
            background-image: url('anh44.jpg'); /* Đặt đường dẫn tới ảnh nền */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
            color: #fff; /* Đặt màu chữ là trắng cho dễ nhìn trên nền tối */
        }

        /* Bố cục chính của form */
        form {
            background-color: rgba(255, 255, 255, 0.9); /* Nền trắng với độ trong suốt */
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        /* Tiêu đề của form */
        form h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
        }

        /* Mô tả ngắn gọn về form */
        form p {
            font-size: 16px;
            margin-bottom: 20px;
            color: #555;
        }

        /* Định dạng cho thông báo lỗi */
        .error {
            color: red;
            margin-bottom: 10px;
            font-size: 14px;
            display: block;
        }

        /* Định dạng cho các input */
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        /* Định dạng cho nút submit */
        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        /* Hiệu ứng hover cho nút submit */
        button[type="submit"]:hover {
            background-color: #45a049;
        }

        /* Đảm bảo form có chiều rộng linh hoạt */
        form input, form button {
            display: block;
            margin: 10px auto;
        }
    </style>
</head>
<body>
    <form action="reset-password" method="post">
        <h2>Reset Password</h2>
        <p>Enter your new password.</p>

        <c:if test="${not empty errorMessage}">
            <span class="error">${errorMessage}</span>
        </c:if>

        <input type="hidden" name="action" value="resetPassword">
        <input type="password" placeholder="Enter new password" name="newPassword" required>
        <input type="password" placeholder="Confirm new password" name="confirmPassword" required>
        <button type="submit">Reset Password</button>
    </form>
</body>
</html>
