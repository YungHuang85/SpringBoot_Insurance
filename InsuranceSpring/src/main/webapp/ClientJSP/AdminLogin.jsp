<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- http://127.0.0.1:8080/insuranceSpring/adminLogin -->
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>後台系統管理登入</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap"
	rel="stylesheet">
<style>
body {
	margin: 0;
	font-family: 'Poppins', sans-serif;
	height: 100vh;
	background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
	display: flex;
	justify-content: center;
	align-items: center;
	overflow: hidden;
	position: relative;
}

body::before {
	content: '';
	position: absolute;
	top: -50%;
	left: -50%;
	width: 200%;
	height: 200%;
	background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 10%,
		transparent 40%);
	animation: moveBackground 10s infinite linear;
	z-index: 0;
}

@
keyframes moveBackground { 0% {
	transform: rotate(0deg);
}

100

%
{
transform

rotate


(


360deg














)












;
}
}
.container {
	position: relative;
	z-index: 1;
	width: 90%;
	max-width: 400px;
	background: rgba(255, 255, 255, 0.15);
	padding: 40px;
	border-radius: 15px;
	backdrop-filter: blur(15px);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
	text-align: center;
	color: #fff;
}

h1 {
	text-align: center;
	font-size: 28px;
	font-weight: 600;
	margin-bottom: 20px;
	color: #e0e0e0;
}

.input-group {
	margin-bottom: 20px;
}

label {
	display: block;
	margin-bottom: 5px;
	font-size: 18px;
}

.input-field {
	width: 100%;
	padding: 12px;
	border: none;
	border-radius: 10px;
	background: rgba(255, 255, 255, 0.1);
	color: black;
	font-size: 18px;
	transition: border 0.3s, box-shadow 0.3s;
	outline: none;
	margin-top: 10px;
}

.input-field:focus {
	border: 1px solid #29b6f6;
	box-shadow: 0 0 10px #29b6f6;
}

.button-container {
	display: flex;
	gap: 10px;
	justify-content: center;
}

button {
	padding: 10px 20px;
	border: none;
	border-radius: 25px;
	font-size: 16px;
	cursor: pointer;
	transition: all 0.3s ease;
	font-weight: 600;
}

.login-btn {
	background: #00bcd4;
	color: #fff;
	box-shadow: 0 4px 8px rgba(41, 182, 246, 0.4);
}

.login-btn:hover {
	background: #0288d1;
	transform: translateY(-2px);
}

.reset-btn {
	background: #b0bec5;
	color: #fff;
	box-shadow: 0 4px 8px rgba(176, 190, 197, 0.4);
}

.reset-btn:hover {
	background: #78909c;
	transform: translateY(-2px);
}

.remember-me {
	display: flex;
	align-items: center;
	margin-bottom: 20px;
}

.remember-me input {
	margin-right: 8px;
}

.error-message {
	color: #ff5252;
	font-size: 14px;
}

.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	justify-content: center;
	align-items: center;
	z-index: 999;
}

.modal.show {
	display: flex;
	animation: fadeIn 0.3s ease-in-out;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
.modal-content {
	background: #fff;
	padding: 20px;
	border-radius: 10px;
	width: 90%;
	max-width: 450px;
	text-align: center;
	position: relative;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
	color: #333;
}

.close-btn {
	position: absolute;
	top: 10px;
	right: 10px;
	font-size: 18px;
	cursor: pointer;
	color: #aaa;
}

.close-btn:hover {
	color: #000;
}
</style>

</head>


<body>

	<div class="container">
		<h1>線上投保後台系統</h1>
		<form action="${pageContext.request.contextPath}/Login" method="post"
			id="loginForm">
			<div class="input-group">
				<label for="account1">帳號</label> <input type="text" id="account1"
					name="username" class="input-field" placeholder="請輸入帳號"
					maxlength="15" required>
				<c:if test="${not empty usernameError}">
					<div class="error-message">${usernameError}</div>
				</c:if>
			</div>
			<div class="input-group">
				<label for="password1">密碼</label> <input type="password"
					id="password1" name="password" class="input-field"
					placeholder="請輸入密碼" maxlength="15" required>
				<c:if test="${not empty passwordError}">
					<div class="error-message">${passwordError}</div>
				</c:if>
				<c:if test="${not empty accountLocked}">
					<p style="color: red;">${accountLocked}</p>
				</c:if>
			</div>
			<div class="remember-me">
				<input type="checkbox" id="rememberMe"> <label
					for="rememberMe">記住我</label>
			</div>
			<div class="button-container">
				<button type="submit" class="login-btn">登入</button>
				<button type="reset" class="reset-btn" id="forgotBtn">忘記密碼</button>
			</div>
		</form>
		<form action="${pageContext.request.contextPath}/forgotPwd"
			method="post" id="forgotPwdForm">
			<div id="forgotPwdModal" class="modal">
				<div class="modal-content">
					<span class="close-btn">&times;</span>
					<h2>重設密碼</h2>
					<div class="form-group">
						<label for="modal-username">帳號：</label> <input type="text"
							id="modal-username" name="username" class="input-field"
							placeholder="請輸入帳號" required />
						<c:if test="${not empty usernameError}">
							<div class="error-message">${usernameError}</div>
						</c:if>
					</div>
					<div class="form-group">
						<label for="modal-email">Email：</label> <input type="email"
							id="modal-email" name="adminEmail" class="input-field"
							placeholder="請輸入信箱" required />
						<c:if test="${not empty emailError}">
							<div class="error-message">${emailError}</div>
						</c:if>
					</div>
					<div class="button-container">
						<button type="submit" class="login-btn" id="sendReset">發送重設密碼函</button>
					</div>
				</div>
			</div>
		</form>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
	
		//有動到LogoutServlet
		document.addEventListener("DOMContentLoaded", function() {
			const accountInput = document.getElementById("account1");
			const passwordInput = document.getElementById("password1");
			const rememberMeCheckbox = document.getElementById("rememberMe");

			// 加載時讀取 localStorage
			if (localStorage.getItem("rememberMe") === "true") {
				accountInput.value = localStorage.getItem("username") || "";
				passwordInput.value = localStorage.getItem("password") || "";
				rememberMeCheckbox.checked = true; // 勾選記住我
			} else {
				// 如果沒有勾選記住我，清除 localStorage
				localStorage.removeItem("username");
				localStorage.removeItem("password");
				localStorage.removeItem("rememberMe");
			}

			// 存到 localStorage
			document.getElementById("loginForm").addEventListener(
					"submit",
					function() {
						if (rememberMeCheckbox.checked) {
							localStorage
									.setItem("username", accountInput.value);
							localStorage.setItem("password",
									passwordInput.value);
							localStorage.setItem("rememberMe", "true");
						} else {
							localStorage.removeItem("username");
							localStorage.removeItem("password");
							localStorage.removeItem("rememberMe");
						}
					});
		});
		//以下是忘記密碼

	document.addEventListener("DOMContentLoaded", function() {
    const forgotBtn = document.getElementById("forgotBtn"); // 忘記密碼按鈕
    const modal = document.getElementById("forgotPwdModal"); // Modal 視窗
    const closeBtn = document.querySelector(".close-btn"); // 關閉按鈕 (×)
    const closeModalBtn = document.getElementById("closeModal"); // 返回按鈕

    // 顯示 Modal
    forgotBtn.addEventListener("click", function(event) {
        event.preventDefault(); 
        modal.style.display = "flex"; // 顯示 Modal
    });

    // 點擊關閉按鈕隱藏 Modal
    closeBtn.addEventListener("click", function() {
        modal.style.display = "none";
    });

    // 點擊返回按鈕隱藏 Modal
    closeModalBtn.addEventListener("click", function() {
        modal.style.display = "none";
    });

    // 點擊 Modal 外部隱藏 Modal
    window.addEventListener("click", function(event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });
});
		
	    document.getElementById("forgotPwdForm").addEventListener("submit", function(event) {
	        event.preventDefault();

	        const username = document.getElementById("modal-username").value;
	        const adminEmail = document.getElementById("modal-email").value;

	        fetch(this.action, {
	            method: "POST",
	            headers: { "Content-Type": "application/x-www-form-urlencoded" },
	            body: new URLSearchParams({ username, adminEmail })
	        })
	        .then(response => response.json())
	        .then(data => {
	            if (data.successMessage) {
	                Swal.fire({
	                    icon: 'success',
	                    title: '重設密碼函已寄至您的信箱',
	                    text: data.successMessage,
	                    confirmButtonText: '確定'
	                });
	            } else if (data.errorMessage) {
	                Swal.fire({
	                    icon: 'error',
	                    title: '錯誤',
	                    text: data.errorMessage,
	                    confirmButtonText: '確定'
	                });
	            }
	        })
	        .catch(error => console.error("Error:", error));
	    });
	    document.addEventListener("DOMContentLoaded", function () {
	        <c:if test="${not empty successMessage}">
	            Swal.fire({
	                icon: 'success',
	                title: '修改成功',
	                text: '${successMessage}',
	                confirmButtonText: '確定'
	            });
	        </c:if>
	    });
	</script>
</body>
</html>