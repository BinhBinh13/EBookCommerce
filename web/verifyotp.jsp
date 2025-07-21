<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verify OTP</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <form action="reset-password" method="post">
        <h2>Verify OTP</h2>
        <p>Enter the OTP sent to your email.</p>
        
        <c:if test="${not empty errorMessage}">
            <span class="error">${errorMessage}</span>
        </c:if>

        <input type="hidden" name="action" value="verifyOTP">
        <input type="text" placeholder="Enter OTP" name="otp" required>
        <button type="submit">Verify OTP</button>
    </form>
</body>
</html>
