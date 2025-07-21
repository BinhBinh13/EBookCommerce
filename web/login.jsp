<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login - Book Haven</title>
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
            background-color: rgba(255, 255, 255, 0.9);
            padding: 2.5rem 3rem;
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
            margin-bottom: 2rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            font-weight: bold;
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
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        label {
            font-weight: bold;
            color: #34495e; /* Dark gray-blue */
            min-width: 120px; /* Ensure labels have consistent width */
            text-align: right;
        }

        input[type="text"],
        input[type="password"] {
            padding: 0.8rem;
            border: 2px solid #1e90ff;
            border-radius: 25px;
            font-size: 1rem;
            width: 100%;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #2ecc71; /* Emerald green */
            box-shadow: 0 0 10px rgba(46, 204, 113, 0.3);
        }

        input[type="submit"] {
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
            margin-top: 1rem;
        }

        input[type="submit"]:hover {
            background-color: #27ae60; /* Darker emerald green */
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(39, 174, 96, 0.5);
        }

        input[type="submit"]:active {
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
                font-size: 1.5rem;
            }
            
            .form-group {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            
            label {
                text-align: left;
                min-width: auto;
            }
            
            input[type="text"],
            input[type="password"],
            input[type="submit"] {
                padding: 0.7rem;
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Login</h1>
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Enter username:</label>
                <input type="text" name="username" id="username">
            </div>
            <div class="form-group">
                <label for="password">Enter password:</label>
                <input type="password" name="password" id="password">
            </div>
            <input type="submit" value="Login">
        </form>
        <div>
            <p class="error">${error != null ? error : ''}</p>
        </div>
    </div>
</body>
</html>