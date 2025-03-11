<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>重設密碼</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.container {
	background: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 400px;
}

.container h1 {
	font-size: 24px;
	margin-bottom: 20px;
}

.input-group {
	margin-bottom: 15px;
}

.input-group label {
	display: block;
	font-size: 14px;
	margin-bottom: 5px;
}

.input-group input {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.button-container {
	text-align: center;
}

.button-container button {
	padding: 10px 20px;
	border: none;
	background-color: #007bff;
	color: #fff;
	border-radius: 5px;
	cursor: pointer;
}

.button-container button:hover {
	background-color: #0056b3;
}

.error-message {
	color: #ff5252;
	font-size: 14px;
	margin-bottom: 15px;
}

.success-message {
	color: #4caf50;
	font-size: 14px;
	margin-bottom: 15px;
}
</style>
</head>
<body>
	<div class="container">
		<h1>重設密碼</h1>
		<form action="${pageContext.request.contextPath}/resetPassword"
			method="post">
			<div class="input-group">
				<label for="newPassword">新密碼：</label> <input type="password"
					id="newPassword" name="newPassword" required>
			</div>
			<div class="input-group">
				<label for="confirmPassword">確認密碼：</label> <input type="password"
					id="confirmPassword" name="confirmPassword" required>
			</div>
			<c:if test="${not empty errorMessage}">
				<div class="error-message">${errorMessage}</div>
			</c:if>
			<c:if test="${not empty successMessage}">
				<div class="success-message">${successMessage}</div>
			</c:if>
			<input type="hidden" name="token" value="${param.token}">
			<div class="button-container">
				<button type="submit">確認修改</button>
			</div>
		</form>
	</div>
</body>
</html>
