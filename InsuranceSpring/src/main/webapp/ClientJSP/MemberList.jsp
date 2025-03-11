<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>會員列表</title>
<link rel="stylesheet"
	href="https://cdn.datatables.net/2.1.8/css/jquery.dataTables.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<style>
@charset "UTF-8";

h1 {
	margin-bottom: 10px;
	color: #333;
}

table {
	width: 100%;
	margin: 20px auto;
	border-collapse: collapse;
	table-layout: auto;
}

table, th, td {
	border: 1px solid #ddd;
	padding: 5px;
	text-align: center;
	word-wrap: break-word;
	white-space: normal;
}

th {
	background-color: #333;
	color: #fff;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

.search-input {
	padding: 10px;
	width: 250px;
	border: 1px solid #ddd;
	border-radius: 5px;
	margin-right: 10px;
}

.search-button {
	padding: 10px 20px;
	background-color: #393936;
	color: #fff;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.search-add-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.add-button {
	padding: 10px 20px;
	background-color: #4CAF50;
	color: #fff;
	font-size: 16px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: all 0.3s ease;
	float: right;
}

.add-button:hover {
	background-color: #45a049;
}

/* Modal 對話框樣式 */
.modal {
	display: none; /* 默認隱藏 */
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5);
	border: 1px solid #ddd;
}

.modal-content1 {
	background-color: #fff;
	margin: 5% auto; /* 讓 modal 垂直置中 */
	padding: 20px;
	border-radius: 10px; /* 圓角 */
	width: 80%; /* 設定寬度 */
	max-width: 900px; /* 限制最大寬度 */
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	animation: fadeIn 0.3s ease-in-out;
}

label {
	display: block;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.edit-button, .delete-button {
	border: none;
	padding: 10px;
	cursor: pointer;
	font-size: 16px;
	color: white;
	border-radius: 5px;
	margin: 2px;
}

.edit-button {
	background-color: #4CAF50; /* 綠色 */
	transition: all 0.3s ease;
}

.edit-button:hover {
	background-color: #45a049;
}

.delete-button {
	background-color: #f44336;
	transition: all 0.3s ease;
}

.delete-button:hover {
	background-color: #e53935;
}

.fas {
	pointer-events: none;
}

.long-input {
	width: 300px;
}

/* 調整顯示筆數和搜尋區域的佈局，讓它們在同一行 */
.dataTables_length, .dataTables_filter {
	display: inline-block;
	margin-right: 20px;
	vertical-align: middle;
}

/* 讓搜尋框有圓角邊框並且修改字體 */
.dataTables_filter input {
	border-radius: 10px;
	padding: 5px 10px;
	font-size: 14px;
	border: 1px solid #ccc;
}

/* 調整顯示筆數下拉框的樣式 */
.dataTables_length select {
	border-radius: 10px;
	padding: 5px;
	font-size: 14px;
	border: 1px solid #ccc;
}

/* 搜尋區域的標籤樣式 */
.dataTables_filter label {
	font-weight: bold;
	font-size: 14px;
}

/* 顯示筆數標籤的樣式 */
.dataTables_length label {
	font-weight: bold;
	font-size: 14px;
}
/* 置中 DataTable 分頁按鈕 */
div.dataTables_paginate {
	text-align: center;
	margin-top: 20px;
}

/* 修改 DataTable 分頁按鈕的樣式 */
div.dataTables_paginate a {
	display: inline-block;
	padding: 5px 10px;
	margin: 2px;
	border: 1px solid #ddd;
	border-radius: 4px;
	color: #333;
	text-decoration: none;
	transition: background-color 0.3s ease, color 0.3s ease;
}

/* 滑鼠放上去時變成手指形狀 */
div.dataTables_paginate a:hover {
	cursor: pointer;
	background-color: #f1f1f1;
	color: #000;
}

/* 當前頁面的按鈕樣式 */
div.dataTables_paginate a.current {
	background-color: #4CAF50;
	color: white;
	border: 1px solid #4CAF50;
}

/* 置中 DataTable */
div.dataTables_info {
	text-align: center;
	margin-top: 10px;
}

/* 通用輸入框樣式 */
.modal-input {
	width: 60%;
	padding: 8px;
	margin-top: 10px;
	margin-bottom: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
	box-sizing: border-box; /* 確保內距和邊框計入元素總寬度 */
}

/* 下拉選單樣式 */
.modal-select {
	width: 100%;
	padding: 10px;
	margin-top: 5px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
	box-sizing: border-box;
}

.submit-button {
	background-color: #4CAF50;
	color: #ffffff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s;
	float: right;
	margin-left: 10px;
}

.cancel-button {
	background-color: #f44336;
	color: #ffffff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s;
	float: right;
}
/* 預設情況下未排序的箭頭樣式 */
th.sorting::after {
	content: " ⬍"; /* 表示可以上下排序的箭頭 */
	color: #cccccc;
	font-size: 12px;
	margin-left: 5px;
}

/* 升冪排序的箭頭 */
th.sorting_asc::after {
	content: " ▲";
	color: #000000;
}

/* 降冪排序的箭頭 */
th.sorting_desc::after {
	content: " ▼";
	color: #000000;
}

.submit-button:hover {
	background-color: #357ae8;
}

.analyzemodal {
	display: none; /* 預設隱藏 */
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5);
}

#analysis h3 {
	font-size: 22px; /* 調整字體大小 */
	font-weight: bold;
	color: #002147; /* 深藍色 */
	text-align: center; /* 讓標題置中 */
	margin-bottom: 15px;
	text-transform: uppercase; /* 轉為大寫 */
	letter-spacing: 1px; /* 增加字距 */
	position: relative;
	padding-bottom: 10px;
}

#analysis canvas {
	display: block;
	margin: 0 auto;
	max-width: 100%;
	height: auto;
}

#ageChart {
	width: 100% !important;
	max-width: 300px !important;
	height: 300px !important;
	max-height: 300px !important;
	display: block;
	margin: 0 auto; /* 讓圖表置中 */
}

#trendChart {
	width: 600px !important;
	max-width: 600px !important;
	height: 300px !important;
	max-height: 300px !important;
	display: block;
	margin: 0 auto;
}

#ageChart {
	width: 100% !important;
	max-width: 300px !important;
	height: 300px !important;
	max-height: 300px !important;
	display: block;
	margin: 0 auto;
}

.main-container {
	max-width: 85%;
	margin: 0 auto;
	padding: 20px;
}

.member-title {
	font-size: 32px;
	font-weight: bold;
	color: #002147;
	text-align: center;
	margin-bottom: 20px;

	padding-bottom: 5px;
	font-family: 'Playfair Display', 'Georgia', serif;
	letter-spacing: 1.5px;
	text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); /* 輕微陰影 */
}

/* 讓標題底線有動畫 */
.member-title::after {
	content: "";
	display: block;
	width: 50px;
	height: 3px;
	background-color: black; /* 黑色底線 */
	margin: 8px auto 0;
	border-radius: 2px;
	transition: width 0.3s ease-in-out;
}

/* 滑鼠懸停時，讓底線變長 */
.member-title:hover::after {
	width: 120px;
}

#analyzeBtn {
	font-size: 16px; /* 字體稍微縮小 */
	font-weight: bold;
	color: white;
	background-color: #007bff; /* 藍色背景 */
	border: none;
	padding: 8px 16px; /* 減少內邊距，讓按鈕變小 */
	border-radius: 6px; /* 減少圓角 */
	margin-bottom: 10px;
	cursor: pointer;
	transition: background 0.3s ease-in-out, transform 0.2s;
	cursor: pointer;
}

#analyzeBtn:hover {
	background-color: #0056b3; /* 滑鼠移過去變深藍色 */
}

.modal-content1 h2 {
	font-size: 28px; /* 加大字體 */
	font-weight: bold;
	color: black; /* 字體顏色為黑色 */
	text-align: center;
	margin-bottom: 20px;
	border-bottom: 2px solid black; /* 將底線改為黑色 */
	padding-bottom: 10px;
}

@
keyframes fadeIn {from { opacity:0;
	transform: scale(0.8);
}

to {
	opacity: 1;
	transform: scale(1);
}

}
/* 容器設定 Flexbox 來讓內部元素並排 */
#analysis {
	display: flex;
	justify-content: center; /* 讓區塊在容器內置中 */
	gap: 40px; /* 設定區塊之間的間距 */
	flex-wrap: wrap; /* 避免太窄時壓縮，可以自動換行 */
	padding: 20px;
}

/* 美化數據顯示區塊 */
.data-box {
	background: #f8f9fa;
	padding: 15px 30px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	text-align: center;
	width: 220px; /* 固定每個區塊的寬度 */
	transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
}

/* 標題樣式 */
.data-box h3 {
	font-size: 18px;
	font-weight: bold;
	color: #333;
	margin-bottom: 10px;
}

/* 數據樣式 */
.data-box p {
	font-size: 36px;
	font-weight: bold;
	color: #007bff;
	margin: 5px 0;
	animation: bounce 1.5s infinite alternate;
}

/* 簡單的數字跳動動畫 */
@
keyframes bounce {from { transform:translateY(0);
	
}

to {
	transform: translateY(-5px);
}

}

/* 滑鼠懸停效果 */
.data-box:hover {
	transform: scale(1.05);
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
}

/* 讓 "註冊趨勢" 標題更有層次 */
#trendChartContainer h3 {
	font-size: 22px;
	font-weight: bold;
	color: #002147; /* 深藍色 */
	text-align: center;
	margin-bottom: 15px;
	text-transform: uppercase;
	letter-spacing: 1px;
	padding: 10px 0;
	border-bottom: 2px solid #007bff; /* 加上底線 */
	display: inline-block;
}

/* 讓 canvas 有漂亮的邊框和陰影 */
#trendChartContainer {
	text-align: center;
	background: #f8f9fa; /* 背景色淡灰 */
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	width: 90%;
	max-width: 800px;
	margin: 0 auto;
}

/* 確保 canvas 佔滿容器 */
#trendChart {
	max-width: 100%;
	height: 400px; /* 固定高度 */
}

.chart-container {
	background: #f8f9fa;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	text-align: center;
	margin: 0 auto;
	max-width: 600px;
}

/* 設定 Canvas 圖表的最大寬度 */
#trendChart {
	width: 100% !important;
	max-width: 600px;
	height: 300px !important;
}

.chart-container h3 {
	font-size: 22px; /* 字體大小 */
	font-weight: bold;
	color: #002147; /* 深藍色 */
	text-align: center;
	margin-bottom: 15px;
	text-transform: uppercase; /* 轉為大寫 */
	letter-spacing: 1px; /* 增加字距 */
	position: relative;
	padding-bottom: 10px;
}

/* 加上底線動畫 */
.chart-container h3::after {
	content: "";
	display: block;
	width: 50px;
	height: 3px;
	background-color: #007bff;
	margin: 8px auto 0;
	border-radius: 2px;
	transition: width 0.3s ease-in-out;
}

/* 滑鼠懸停時底線變長 */
.chart-container h3:hover::after {
	width: 80px;
}

/* 美化圖表容器 */
.chart-container {
	background: #f8f9fa;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	text-align: center;
	margin: 20px auto;
	max-width: 600px; /* 設定最大寬度，避免過度拉伸 */
}

/* 設定 Canvas 圖表最大寬度 */
#trendChart, #ageChart {
	width: 100% !important;
	max-width: 600px;
	height: 300px !important;
}

</style>
</head>
<body>
	<!-- 左側功能列表 -->
	<jsp:include page="../ClientJSP/sidebar.jsp" />
	<!-- 主內容-->
	<div class="main-container">
		<div class="content">
			<h2 class="member-title">會員列表</h2>
			<!-- 搜尋區域 -->
			<div class="search-group">
				<button id="analyzeBtn" class="">會員數據分析</button>
				<button id="addMemberBtn" class="add-button">新增會員</button>
			</div>
			<!-- 顯示會員資料表格 -->
			<div class="st1">
				<div>
					<table id="admin-table" class="admin-table">
						<thead>
							<tr>
								<th>會員姓名</th>
								<th>性別</th>
								<th>生日</th>
								<th>帳號</th>
								<!--<th>密碼</th>-->
								<!--<th>手機號碼</th>-->
								<!--<th>地址</th>-->
								<th>電子郵件</th>
								<!--<th>身分證號碼</th>-->
								<!--<th>會員等級</th>-->
								<th>註冊時間</th>
								<th>修改/刪除</th>
							</tr>
						</thead>
						<tbody>
							<!-- 顯示查詢到的會員列表 -->
							<c:forEach var="member" items="${memberList}">
								<tr>
									<td>${member.username}</td>
									<td>${member.gender}</td>
									<td>${member.birthday}</td>
									<td>${member.account}</td>
									<!--<td>${member.password}</td>-->
									<!--<td>${member.phone}</td>-->
									<!--<td>${member.address}</td>-->
									<td>${member.email}</td>
									<!--<td>${member.idNumber}</td>-->
									<!--<td>${member.membership}</td>-->
									<td>${member.formattedCreatedAt}</td>
									<td>
										<!-- 修改按鈕 -->
										<button class="edit-button"
											onclick="editMemberByAdmin(${member.id})">
											<i class="fas fa-pen"></i>
										</button> <!-- 刪除按鈕 -->
										<button class="delete-button"
											onclick="deleteMember(${member.id})">
											<i class="fas fa-trash"></i>
										</button> <!-- 編輯會員的模態框 -->
									</td>
								</tr>
							</c:forEach>
							<!-- 如果沒有查詢到資料，提示訊息 -->
							<c:if test="${empty memberList}">
								<tr>
									<td colspan="11">目前沒有會員資料。</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal 對話框內容 -->
	<div id="addMemberModal" class="modal">
		<div class="modal-content1">
			<span class="close">&times;</span>
			<h2>新增會員</h2>

			<form id="addMemberForm" method="post"
				action="${pageContext.request.contextPath}/CrudMembers">

				<input type="hidden" name="action" value="add"> 帳號: <input
					type="text" name="account" id="account" data-target="account"
					minlength="8" maxlength="16" required class="modal-input" /><br>
				<span class="error" data-target="account"
					style="color: red; font-size: 14px;"></span><br> <label
					for="password">密碼：</label>
				<div
					style="position: relative; display: inline-block; width: 100%; max-width: 300px;">
					<input type="password" name="password" id="password"
						data-target="password" minlength="8" maxlength="16" required
						class="modal-input" style="padding-right: 30px; width: 100%;" />
					<i class="fa fa-eye" id="togglePassword"
						style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); cursor: pointer;"></i>
				</div>
				<span class="error" data-target="password"
					style="color: red; font-size: 14px;"></span><br> 確認密碼: <input
					type="password" name="confirm_password" id="confirm_password"
					data-target="confirm_password" minlength="8" maxlength="16"
					required class="modal-input" /><br> <span class="error"
					data-target="confirm_password" style="color: red; font-size: 14px;"></span><br>
				會員姓名:<input type="text" name="username" id="username" required
					class="modal-input" /><br> 性別: <select name="gender" required
					class="modal-input">
					<option value="男">男</option>
					<option value="女">女</option>
				</select><br> 生日: <input type="date" id="birthday"
					data-target="birthday" name="birthday" required class="modal-input" /><br>
				<span class="error" data-target="birthday"
					style="color: red; font-size: 14px;"></span><br> 身分證字號: <input
					type="text" name="idNumber" id="idNumber" data-target="idNumber"
					minlength="10" maxlength="10" required class="modal-input" /> <span
					class="error" data-target="idNumber"
					style="color: red; font-size: 14px;"></span><br> 手機號碼: <input
					type="text" name="phone" id="phone" maxlength="10"
					class="modal-input" /><br> <span id="phoneError"
					style="color: red; font-size: 14px;"></span><br> <label>縣市：</label>
				<select id="city" name="city">
					<option value="">請選擇</option>
				</select> <label>鄉鎮區：</label> <select id="area" name="area"
					style="display: none;">
					<option value="">請選擇</option>
				</select> <label></label> <input type="text" name="addressDetail"
					id="addressDetail" placeholder="請輸入詳細地址" required /><br> <input
					type="hidden" name="address" id="address" /> 電子郵件: <input
					type="text" name="email" id="email" class="modal-input" /><br>
				<span id="emailError" style="color: red; font-size: 14px;"></span><br>

				<button type="button" id="autoFillButton">自動填入資料</button>

				<input type="submit" class="add-button" value="確認新增">
			</form>
		</div>
	</div>

	<div id="editMemberModal" class="modal">
		<div class="modal-content1">
			<span class="close" onclick="closeEditModal()">&times;</span>
			<h2>修改會員資料</h2>
			<form id="editMemberForm">

				<label for="editAccount">帳號：</label> <input type="text"
					id="editAccount" name="account" disabled class="modal-input"><br>

				<input type="hidden" id="hidden" name="id" disabled
					class="modal-input"> <label for="editPassword"> 密碼：</label>
				<input type="password" id="editPassword" name="password"
					class="modal-input" minlength="8" maxlength="16"> <span
					id="passwordEditError" style="color: red; font-size: 14px;"></span><br>

				<label for="editConfirm_password"> 確認密碼：</label> <input
					type="password" id="editConfirm_password"
					name="editConfirm_password" class="modal-input" minlength="8"
					maxlength="16"> <span id="editConfirmPasswordError"
					style="color: red; font-size: 14px;"></span><br> <label
					for="editUsername">會員姓名：</label> <input type="text"
					id="editUsername" name="username" class="modal-input"><br>

				<label for="editGender">性別：</label> <select id="editGender"
					name="editGender" class="modal-input">
					<option value="男">男</option>
					<option value="女">女</option>
				</select><br> <label for="editBirthday">生日：</label> <input type="date"
					id="editBirthday" name="birthday" class="modal-input"><br>

				<label for="editIdNumber">身分證號：</label> <input type="text"
					id="editIdNumber" name="idNumber" minlength="10" maxlength="10"
					disabled class="modal-input"><br> <span
					id="editNumberError" style="color: red; font-size: 14px;"></span><br>


				<label for="editPhone">手機號碼：</label> <input type="text"
					id="editPhone" name="phone" maxlength="10" class="modal-input"><br>
				<span id="editphoneError" style="color: red; font-size: 14px;"></span><br>

				<label for="editAddress">地址：</label> <input type="text"
					id="editAddress" name="address" class="modal-input"><br>

				<label for="editEmail">電子郵件：</label> <input type="email"
					id="editEmail" name="email" class="modal-input"><br>

				<button type="button" onclick="updateMember()" class="submit-button">儲存修改</button>
				<button type="button" onclick="closeEditModal()"
					class="cancel-button">取消</button>
			</form>
		</div>
	</div>

	<div id="analyzeModal" class="analyzemodal">
		<div class="modal-content1">
			<span class="close" onclick="closeAnalyzeModal()">&times;</span>
			<h2>會員數據分析</h2>
<a href="${pageContext.request.contextPath}/api/stats/download" download="member_stats.csv">
    下載會員統計資料 (CSV)
</a>
			<div id="analysis">
				<div class="data-box">
					<h3>本月註冊人數</h3>
					<p id="monthlyRegistrations">0</p>
				</div>
				<div class="data-box">
					<h3>總會員人數</h3>
					<p id="totalMembers">0</p>
				</div>
			</div>
			<div class="chart-container">
				<h3>註冊人數趨勢</h3>
				<canvas id="trendChart" width="800" height="400"></canvas>
			</div>
			<div class="chart-container">
				<h3>年齡分布</h3>
				<canvas id="ageChart"></canvas>
			</div>
		</div>
	</div>
	<div id="loading" style="display: none; text-align: center;">
		<p>數據加載中，請稍後...</p>
	</div>
	</div>

	<!-- JavaScript 用於控制 Modal 的顯示和隱藏 -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.21/js/jquery.dataTables.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
    $(document).ready(function() {
    	     
    	     var cityData = [
    	    	    {
    	    	        "CityName": "臺北市",
    	    	        "CityEngName": "Taipei City",
    	    	        "AreaList": [
    	    	            { "ZipCode": "100", "AreaName": "中正區", "AreaEngName": "Zhongzheng Dist." },
    	    	            { "ZipCode": "103", "AreaName": "大同區", "AreaEngName": "Datong Dist." },
    	    	            { "ZipCode": "104", "AreaName": "中山區", "AreaEngName": "Zhongshan Dist." },
    	    	            { "ZipCode": "105", "AreaName": "松山區", "AreaEngName": "Songshan Dist." },
    	    	            { "ZipCode": "106", "AreaName": "大安區", "AreaEngName": "Da’an Dist." },
    	    	            { "ZipCode": "108", "AreaName": "萬華區", "AreaEngName": "Wanhua Dist." },
    	    	            { "ZipCode": "110", "AreaName": "信義區", "AreaEngName": "Xinyi Dist." },
    	    	            { "ZipCode": "111", "AreaName": "士林區", "AreaEngName": "Shilin Dist." },
    	    	            { "ZipCode": "112", "AreaName": "北投區", "AreaEngName": "Beitou Dist." },
    	    	            { "ZipCode": "114", "AreaName": "內湖區", "AreaEngName": "Neihu Dist." },
    	    	            { "ZipCode": "115", "AreaName": "南港區", "AreaEngName": "Nangang Dist." },
    	    	            { "ZipCode": "116", "AreaName": "文山區", "AreaEngName": "Wenshan Dist." }
    	    	        ]
    	    	    },
    	    	    {
    	    	        "CityName": "基隆市",
    	    	        "CityEngName": "Keelung City",
    	    	        "AreaList": [
    	    	            { "ZipCode": "200", "AreaName": "仁愛區", "AreaEngName": "Ren’ai Dist." },
    	    	            { "ZipCode": "201", "AreaName": "信義區", "AreaEngName": "Xinyi Dist." },
    	    	            { "ZipCode": "202", "AreaName": "中正區", "AreaEngName": "Zhongzheng Dist." },
    	    	            { "ZipCode": "203", "AreaName": "中山區", "AreaEngName": "Zhongshan Dist." },
    	    	            { "ZipCode": "204", "AreaName": "安樂區", "AreaEngName": "Anle Dist." },
    	    	            { "ZipCode": "205", "AreaName": "暖暖區", "AreaEngName": "Nuannuan Dist." },
    	    	            { "ZipCode": "206", "AreaName": "七堵區", "AreaEngName": "Qidu Dist." }
    	    	        ]
    	    	    },
    	    	    {
    	    	        "CityName": "新北市",
    	    	        "CityEngName": "New Taipei City",
    	    	        "AreaList": [
    	    	            { "ZipCode": "207", "AreaName": "萬里區", "AreaEngName": "Wanli Dist." },
    	    	            { "ZipCode": "208", "AreaName": "金山區", "AreaEngName": "Jinshan Dist." },
    	    	            { "ZipCode": "220", "AreaName": "板橋區", "AreaEngName": "Banqiao Dist." },
    	    	            { "ZipCode": "221", "AreaName": "汐止區", "AreaEngName": "Xizhi Dist." },
    	    	            { "ZipCode": "222", "AreaName": "深坑區", "AreaEngName": "Shenkeng Dist." },
    	    	            { "ZipCode": "223", "AreaName": "石碇區", "AreaEngName": "Shiding Dist." },
    	    	            { "ZipCode": "224", "AreaName": "瑞芳區", "AreaEngName": "Ruifang Dist." },
    	    	            { "ZipCode": "226", "AreaName": "平溪區", "AreaEngName": "Pingxi Dist." },
    	    	            { "ZipCode": "227", "AreaName": "雙溪區", "AreaEngName": "Shuangxi Dist." },
    	    	            { "ZipCode": "228", "AreaName": "貢寮區", "AreaEngName": "Gongliao Dist." },
    	    	            { "ZipCode": "231", "AreaName": "新店區", "AreaEngName": "Xindian Dist." },
    	    	            { "ZipCode": "232", "AreaName": "坪林區", "AreaEngName": "Pinglin Dist." },
    	    	            { "ZipCode": "233", "AreaName": "烏來區", "AreaEngName": "Wulai Dist." },
    	    	            { "ZipCode": "234", "AreaName": "永和區", "AreaEngName": "Yonghe Dist." },
    	    	            { "ZipCode": "235", "AreaName": "中和區", "AreaEngName": "Zhonghe Dist." },
    	    	            { "ZipCode": "236", "AreaName": "土城區", "AreaEngName": "Tucheng Dist." },
    	    	            { "ZipCode": "237", "AreaName": "三峽區", "AreaEngName": "Sanxia Dist." },
    	    	            { "ZipCode": "238", "AreaName": "樹林區", "AreaEngName": "Shulin Dist." },
    	    	            { "ZipCode": "239", "AreaName": "鶯歌區", "AreaEngName": "Yingge Dist." },
    	    	            { "ZipCode": "241", "AreaName": "三重區", "AreaEngName": "Sanchong Dist." },
    	    	            { "ZipCode": "242", "AreaName": "新莊區", "AreaEngName": "Xinzhuang Dist." },
    	    	            { "ZipCode": "243", "AreaName": "泰山區", "AreaEngName": "Taishan Dist." },
    	    	            { "ZipCode": "244", "AreaName": "林口區", "AreaEngName": "Linkou Dist." },
    	    	            { "ZipCode": "247", "AreaName": "蘆洲區", "AreaEngName": "Luzhou Dist." },
    	    	            { "ZipCode": "248", "AreaName": "五股區", "AreaEngName": "Wugu Dist." },
    	    	            { "ZipCode": "249", "AreaName": "八里區", "AreaEngName": "Bali Dist." },
    	    	            { "ZipCode": "251", "AreaName": "淡水區", "AreaEngName": "Tamsui Dist." },
    	    	            { "ZipCode": "252", "AreaName": "三芝區", "AreaEngName": "Sanzhi Dist." },
    	    	            { "ZipCode": "253", "AreaName": "石門區", "AreaEngName": "Shimen Dist." }
    	    	        ]
    	    	    }
    	    	]; 

    	    	// 初始化縣市選單
    	    	$.each(cityData, function (index, city) {
    	    	    $('#city').append('<option value="' + index + '">' + city.CityName + '</option>');
    	    	});

    	    	// 第二層選單 (鄉鎮區)
    	    	$("#city").change(function () {
    	    	    var cityValue = $(this).val();
    	    	    $("#area").empty().hide(); // 清空鄉鎮區選項並隱藏
    	    	    if (cityData[cityValue]) {
    	    	        var areaList = cityData[cityValue].AreaList; // 取得對應的鄉鎮區
    	    	        $.each(areaList, function (key, value) {
    	    	            $('#area').append('<option value="' + key + '">' + value.AreaName + '</option>');
    	    	        });
    	    	        $("#area").show(); // 顯示鄉鎮區選單
    	    	    }
    	    	});
    	     
        	 $('#autoFillButton').on('click', function () {
        		 const autoData = {
        		    account: 'TestUser777',
                    password: 'ASD123asd@@',
        		    username: '測試用',
        		    gender: '男',
        		    birthday: '1990-01-01',
        		    idNumber: 'A123456789',
        		    phone: '0933066111',
        		    city: '臺北市',
        		    area: '信義區',
        		    addressDetail: '林口街111號1樓',
        		    email: 'user777@example.com'
        		};
        		 
        		 //填入autoData
        		  $('#account').val(autoData.account);
        	        $('#password').val(autoData.password);
        	        $('#confirm_password').val(autoData.password);
        	        $('#username').val(autoData.username);
        	        $('#gender').val(autoData.gender);
        	        $('#birthday').val(autoData.birthday);
        	        $('#idNumber').val(autoData.idNumber);
        	        $('#phone').val(autoData.phone);
        	        $('#email').val(autoData.email);
        	        $('#addressDetail').val(autoData.addressDetail);
        	        
        	    //必須要觸發change事件
        	        const cityKey = getCityKeyByName(autoData.city);
    if (cityKey !== null) {
        $('#city').val(cityKey).trigger('change'); // 觸發縣市改變事件
            
        setTimeout(function () {
            const areaKey = getAreaKeyByName(cityKey, autoData.area);
            if (areaKey !== null) {
                $('#area').val(areaKey).trigger('change'); // 觸發鄉鎮區的 `change` 事件
            }
        }, 300);
    }
    updateFullAddress();
        	 });

        	 function getCityKeyByName(cityName) {
        		    let cityKey = null;
        		    $.each(cityData, function (key, city) {
        		        if (city.CityName === cityName) {
        		            cityKey = key;
        		            return false; // 結束迴圈
        		        }
        		    });
        		    return cityKey;
        		}
        	 
        	 function getAreaKeyByName(cityKey, areaName) {
        		    let areaKey = null;
        		    if (cityData[cityKey] && cityData[cityKey].AreaList) {
        		        $.each(cityData[cityKey].AreaList, function (key, area) {
        		            if (area.AreaName === areaName) {
        		                areaKey = key;
        		                return false; // 結束迴圈
        		            }
        		        });
        		    }
        		    return areaKey;
        		}
        	 
    	    // 更新完整地址函數
    	    function updateFullAddress() {
    	        const cityName = $('#city option:selected').text();
    	        const areaName = $('#area option:selected').text();
    	        const addressDetail = $('#addressDetail').val();

    	        if (cityName && cityName !== "請選擇" && areaName && areaName !== "請選擇") {
    	        	 var fullAddress = cityName + areaName + addressDetail;
    	             $('#address').val(fullAddress);
    	        } else {
    	            $('#address').val('');
    	        }
    	    }

    	    // 當地址欄位變化時更新完整地址
    	    $('#city, #area, #addressDetail').on('change blur', function () {
    	        updateFullAddress();
    	    });
    	    
    	    $('#addMemberForm').on('submit', function(event) {
    	        updateFullAddress(); 
    	    });
    
    	
    	var table = $('#admin-table').DataTable({
        	
            "language": {
                "lengthMenu": "顯示 _MENU_ 筆資料",
                "zeroRecords": "找不到符合的資料",
                "info": "顯示第 _START_ 至 _END_ 筆，共 _TOTAL_ 筆",
                "infoEmpty": "顯示第 0 至 0 筆，共 0 筆",
                "infoFiltered": "(從 _MAX_ 筆資料過濾)",
                "search": "搜尋：",
                "paginate": {
                    "first": "第一頁",
                    "last": "最後一頁",
                    "next": "下一頁",
                    "previous": "上一頁"
                },
                "loadingRecords": "載入中...",
                "processing": "處理中...",
                "emptyTable": "目前沒有資料"
            },
            // 這裡修正了 lengthMenu 的位置和語法
            "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "全部"]]
        });
        
        // 清除篩選條件的邏輯
        $('#clear-search-button').on('click', function() {
            $.fn.dataTable.ext.search = []; // 清空所有的篩選條件
            table.search('').columns().search('').draw(); 
        });
       
        // 取 Modal 和按鈕元素
        var modal = $('#addMemberModal');
        var btn = $('#addMemberBtn');
        var span = $('.close');

        // 當點擊新增會員按鈕時，顯示對話框
        btn.on('click', function() {
            modal.show(); // 顯示 Modal
        });

        // 隱藏對話框
        span.on('click', function() {
            modal.hide();
        });
        //新增的欄位資料檢查錯誤訊息方法
        function validator(target, errorMsg, valid) {
        	var $errorSpan = $('.error[data-target="' + target + '"]');
        	var success = valid;
        	if (typeof valid === "function") {
        		success = valid();
        	}
        	if (success) {
        		$errorSpan.text('');
        		return true;
        	}
        	$errorSpan.text(errorMsg);
        	return false;
        }
        
        $('form').on('input blur', 'input[data-target], #birthday',function () {
            const target = $(this).data('target');
            const value = $(this).val();
            let errorMsg = '';
            let valid = true;

            switch (target) {
                case 'account':
                    valid = value !== '' && /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/.test(value);
                    errorMsg = '帳號必須為 8 至 16 位英文字母和數字的組合，且至少包含一個英文字母和一個數字';
                    break;
                case 'password':
                    valid = value !== '' && /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%&])[A-Za-z\d!@#$%&]{8,16}$/.test(value);
                    errorMsg = '密碼必須包含至少一個大寫字母、小寫字母、數字和特殊符號，且長度為 8 至 16 位';
                    break;
                    
                case 'confirm_password':
                const passwordValue = $('#password').val();
                valid = value === passwordValue; 
                errorMsg = '輸入的密碼不一致';
                break;
                
                case 'birthday':
                    const selectedDate = new Date(value);
                    const currentDate = new Date();
                    currentDate.setHours(0, 0, 0, 0); // 清除時間部分

                    if (isNaN(selectedDate.getTime())) { // 確認是否為有效日期
                        valid = false;
                        errorMsg = '請輸入有效的日期格式';
                    } else {
                        valid = selectedDate <= currentDate;
                        errorMsg = '生日不可大於當前日期';
                    }
                    break;
                    
                case 'idNumber':
                	 const gender =$('select[name="gender"]').val();
                	 const genderCode = gender === '男' ? '1' : '2';
                	 if (!/^[A-Z][12]\d{8}$/.test(value)) {
                         valid = false;
                         errorMsg = '身分證字號格式不正確';
                     } else if (value[1] !== genderCode) {
                         valid = false;
                         errorMsg = '身分證字號需符合所選性別規則';
                     } else {
                         valid = checkID(value);
                         errorMsg = valid ? '' : '身分證字號檢核碼錯誤';
                     }
                     break;
            
            }
            if (!validator(target, errorMsg, valid)) {
                isValid = false;
            }
        });

        // 性別欄位變更時，觸發身分證欄位驗證
        $('select[name="gender"]').on('change', function () {
            $('#idNumber').trigger('blur'); // 主動觸發身分證驗證
        });
        
        //身分證字號驗證改寫
        // checkID 函數檢查身份證字號的檢核碼
     function checkID(idNumber) {
         // 依照字母的編號排列，存入陣列。
         var letters = ['A', 'B', 'C', 'D', 
             'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 
             'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 
             'X', 'Y', 'W', 'Z', 'I', 'O'];
         // 儲存各個乘數
         var multiply = [1, 9, 8, 7, 6, 5, 4, 3, 2, 1];
         var firstChar = idNumber.charAt(0).toUpperCase();
         var lastNum = parseInt(idNumber.charAt(9),10);
         var firstNum = letters.indexOf(firstChar) + 10;
         
         if(firstNum<10) return false;
         var nums = [ Math.floor(firstNum / 10) , firstNum % 10];
         var total = 0;
         
         //nums[0]=Math.floor(firstNum/10);
         //nums[1]=firstNum % 10;
         
         // 加總計算
         for (var i = 0; i < multiply.length; i++) {
         	  total += ( i < 2 ? nums[i] : parseInt(idNumber.charAt( i - 1 ))) * multiply[i];
         }
         // 和最後一個數字比對
         return (10 - (total % 10)) % 10 === lastNum;
     }
       
     // 密碼輸入框眼睛圖示控制
     $('#togglePassword').removeClass('fa-eye').addClass('fa-eye-slash');
     
        $('#togglePassword').on('click', function() {
            const passwordField = $('#password');
            const isPassword = passwordField.attr('type') === 'password';
            passwordField.attr('type', isPassword ? 'text' : 'password');
            $(this).toggleClass('fa-eye fa-eye-slash');
        });
    
     // 編輯用的生日錯誤判斷!
        $('#editBirthday').on('change', function() {
            var selectedDate = new Date($(this).val());
            var currentDate = new Date();
            currentDate.setHours(0, 0, 0, 0);
            if (selectedDate > currentDate) {
                alert('請確認日期，生日不可大於當前日期。');
                $(this).val('');
            }
        });
     
       
     // 檢查編輯會員的身分證字號格式
        $('#editIdNumber').on('blur', function() {
            var editIdNumber = $(this).val();
            var gender = $('select[name="editGender"]').val();
            var genderCode = (gender === '男') ? '1' : '2';

            // 第一步：基本格式檢查
            if (!/^[A-Z][12]\d{8}$/.test(editIdNumber)) {
                $('#editNumberError').text('身分證字號格式不正確');
            } else if (editIdNumber[1] !== genderCode) {
                $('#editNumberError').text('身分證字號需符合所選性別規則');
            } else if (!checkID(editIdNumber)) {
                // 第二步：使用 checkID 檢查檢核碼
                $('#editNumberError').text('身分證字號檢核碼錯誤');
            } else {
                $('#editNumberError').text(''); 
            }
        });
     
     // 密碼格式驗證
        $('#editPassword').on('blur', function() {
            var password = $(this).val();

            // 密碼的正則表達式
            if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%&])[A-Za-z\d!@#$%&]{8,16}$/.test(password)) {
                $('#passwordEditError').text('密碼必須包含至少一個大寫字母、小寫字母、數字和特殊符號，且長度為 8 至 16 位');
            } else {
                $('#passwordEditError').text(''); 
            }
        });

        // 檢查兩次輸入的密碼是否一致
        $('#editPassword, #editConfirm_password').on('blur', function() {
            var password = $('#editPassword').val().trim();
            var confirmPassword = $('#editConfirm_password').val().trim();

            if (password !== "" && confirmPassword !== "") {
                $('#editConfirmPasswordError').text('輸入的密碼不一致'); // 如果兩個都是空的，不顯示錯誤訊息
                if (password !== confirmPassword) {
                    $('#editConfirmPasswordError').text('輸入的密碼不一致');
                } else {
                    $('#editConfirmPasswordError').text(''); // 清除錯誤訊息
                }
            }
        });

        $('#phone').on('blur', function() {
            var phone = $(this).val();

            // 檢查手機號碼格式
            if (!/^09\d{8}$/.test(phone)) {
                $('#phoneError').text('手機號碼格式不正確，必須為 09 開頭的 10 位數字');
            } else {
                $('#phoneError').text(''); 
            }
        });
        
        $('#editPhone').on('blur', function() {
            var editPhone = $(this).val();

            // 檢查手機號碼格式
            if (!/^09\d{8}$/.test(editPhone)) {
                $('#editphoneError').text('手機號碼格式不正確，必須為 09 開頭的 10 位數字');
            } else {
                $('#editphoneError').text(''); // 清除錯誤訊息
            }
        });
        
        $('#email').on('blur', function() {
            var email = $(this).val();

            // 檢查電子郵件格式
            if (!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email)) {
                $('#emailError').text('電子郵件格式不正確');
            } else {
                $('#emailError').text(''); // 清除錯誤訊息
            }
        });

        // 提交表單的 AJAX 請求
        $('#addMemberForm').on('submit', function(event) {
        	console.log($(this).serialize());
            event.preventDefault(); // 防止表單提交刷新頁面
            console.log("表單提交被攔截，開始驗證帳號");
            
            // 進行 AJAX 提交
              console.log("進行 AJAX 提交");
               $.ajax({
                   url: '${pageContext.request.contextPath}/addMember',
                   type: 'POST',
                   data: $('#addMemberForm').serialize(),
                   success: function(response) {
                	   
                   	   console.log("AJAX 請求成功，回應：", response);
                   	   
                   	 if (response.status == "success") {
                         Swal.fire({
                             icon: 'success',
                             title: '新增成功',
                             showConfirmButton: true
                         }).then(() => {
                             $('#addMemberModal').hide();
                             location.reload();
                         });
                     } else {
                         Swal.fire({
                             icon: 'error',
                             title: '錯誤',
                             text: response.message,
                         });
                         console.log("伺服器返回錯誤：", response.message);
                     }
                 },
                 error: function(jqXHR, textStatus, errorThrown) {
                     console.error("AJAX 請求失敗：", textStatus, errorThrown);
                     Swal.fire({
                         icon: 'error',
                         title: '無法新增會員',
                         text: '請稍後再試。',
                     });
                 }
               });
               
            // 如果帳號格式有誤，阻止提交
            var account = $('#account').val();
            if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$/.test(account)) {
                $('#accountError').text('帳號必須為 8 至 16 位英文字母和數字的組合，且至少包含一個英文字母和一個數字');
                return; // 阻止提交
            }

            // 如果密碼格式有誤，阻止提交
           	var password = $('#password').val().trim();
	        var confirmPassword = $('#confirm_password').val().trim();
	
	        if (password !== confirmPassword) {
	            $('#confirmPasswordError').text('兩次輸入的密碼不一致');
	            event.preventDefault(); // 阻止提交
	            return false; 
	        }
           
            //如果手機格式有誤，阻止提交
            var phone = $('#phone').val();
            if (!/^09\d{8}$/.test(phone)){
            	 $('#editphoneError').text('手機號碼格式不正確，必須為 09 開頭的 10 位數字');
            	 return; // 阻止提交
            }
           
            // 如果電子郵件格式有誤，阻止提交
            var email = $('#email').val();
            if (!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email)) {
                $('#emailError').text('電子郵件格式不正確');
                return; // 阻止提交
            }
            
            if(!isIdValid){
            	return; // 阻止提交
            }
            
        });
        
        
     // 點擊分析按鈕
        $('#analyzeBtn').on('click', function () {
            $('#analyzeModal').show(); // 顯示模態框
            loadAnalysisData(); // 加載數據
        });

        // 關閉模態框
        $('.close').on('click', function () {
            $('#analyzeModal').hide(); // 確保正確隱藏模態框
            console.log('Close button clicked'); // 測試是否觸發事件
        });

        
        let trendChartInstance = null;
        let ageChartInstance = null;
        // 加載數據並顯示
        function loadAnalysisData() {
            $('#loading').show(); // 顯示加載提示

            // AJAX 請求 1: 加載總結數據
            const summaryRequest = $.ajax({
                url: '/api/stats/summary',
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    $('#monthlyRegistrations').text(data.monthlyRegistrations);
                    $('#totalMembers').text(data.totalMembers);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.error('無法加載總結數據:', textStatus, errorThrown);
                    alert('無法加載總結數據，請稍後再試');
                }
            });

            // AJAX 請求 2: 加載註冊趨勢數據
            const trendRequest = $.ajax({
                url: '/api/stats/trend',
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                	console.log('原始數據:', data);
                	const labels = ["2024-03", "2024-04", "2024-05", "2024-06", "2024-07", "2024-08", "2024-09", "2024-10", "2024-11", "2024-12","2025-01", "2025-02"]; // X軸標籤
                    const values = data.map(item => item.registrations); // 註冊數據
                    console.log('處理後的標籤:', labels);
                    console.log('X軸標籤:', labels);
                    console.log('Y軸數據:', values);

                    // 繪製折線圖
                     if (trendChartInstance) {
                trendChartInstance.destroy();
            }

            // 繪製折線圖
            const ctx = $('#trendChart')[0].getContext('2d');
            trendChartInstance = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '註冊人數',
                        data: values,
                        borderColor: 'blue',
                        borderWidth: 2,
                        tension: 0.3
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false, // 防止無限延展
                    scales: {
                        x: { title: { display: true, text: '年-月份' } },
                        y: { title: { display: true, text: '註冊人數' }, beginAtZero: true }
                    }
                }
            });
        },
                error: function () {
                    alert('無法加載註冊趨勢數據，請稍後再試');
                }
            });
            // AJAX 請求 3: 年齡分布數據
          const ageDistributionRequest = $.ajax({
    url: '/api/stats/age-distribution',
    type: 'GET',
    dataType: 'json',
    success: function (data) {
        console.log("年齡分布 API 回應:", data); // 確保 API 回應正常

        // 改這一行，使用 ageRange 而不是 age_group
        const labels = data.map(item => item.ageRange);  
        const values = data.map(item => item.count);

        // 檢查 labels 是否正確
        console.log("處理後的標籤:", labels);
        console.log("Y 軸數據:", values);

        // 清除舊的 Chart，避免重複繪製
        if (ageChartInstance) {
            ageChartInstance.destroy();
        }

        // 限制 Doughnut 圖表大小
        $('#ageChart').css({
            'width': '100%',
            'max-width': '300px',
            'height': '300px',
            'max-height': '300px'
        });

        // 繪製 Doughnut 圖表
        const ctx = $('#ageChart')[0].getContext('2d');
        ageChartInstance = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    label: '人數',
                    data: values,
                    backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0', '#9966FF']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '50%',
                plugins: {
                    legend: { display: true },
                    tooltip: { enabled: true }
                }
            }
        });
    },
    error: function (jqXHR, textStatus, errorThrown) {
        console.error('無法加載年齡分布數據:', textStatus, errorThrown);
        alert('無法加載年齡分布數據');
    }
});

            // 當所有請求完成時隱藏加載提示
            $.when(summaryRequest, trendRequest, ageDistributionRequest).done(function () {
                $('#loading').hide(); // 隱藏加載提示
            });
        }
        
        
    });
    
//上面結束是$(document).ready(function()  的結束}

//取得會員詳細資料
   function editMemberByAdmin(memberId) {
    $('.error-message').text('');
    // 發送 AJAX 請求取會員資料
    $.ajax({
        url: '${pageContext.request.contextPath}/selectMemberByAdmin',
        type: 'POST',
        data: {
            id: memberId
        },
        success: function(response) {
            if (response.status === "success" && response.data) {
                const data = response.data;
                $('#hidden').val(data.id || '');
                $('#editAccount').val(data.account || '');
                $('#editPassword').val(data.password || '');
                $('#editUsername').val(data.username || '');
                $('#editGender').val(data.gender || '');
                $('#editBirthday').val(data.birthday || '');
                $('#editIdNumber').val(data.idNumber || '');
                $('#editPhone').val(data.phone || '');
                $('#editAddress').val(data.address || '');
                $('#editEmail').val(data.email || '');
                $('#editMemberModal').show(); // 顯示修改對話框
            } else {
                alert('錯誤：' + (response.message || '無法取得會員資料'));
            }
        },
        error: function() {
            alert('無法取得會員資料，請稍後再試。');
        }
    });
}
    function closeEditModal() {
        $('#editMemberModal').hide(); 
    }

    function deleteMember(memberId) {
    	 Swal.fire({
    	        title: '確定要刪除此會員嗎？',
    	        text: '刪除成功後無法返回！',
    	        icon: 'warning',
    	        showCancelButton: true,
    	        confirmButtonColor: '#3085d6',
    	        cancelButtonColor: '#d33',
    	        confirmButtonText: '是，刪除！',
    	        cancelButtonText: '取消'
    	    }).then((result) => {
    	        if (result.isConfirmed) {
    	          
    	            $.ajax({
    	                url: '${pageContext.request.contextPath}/deleteMember',
    	                type: 'POST',
    	                data: { id: memberId }, 
    	                success: function(response) {
    	                    if (response.status === "success") {
    	                        Swal.fire({
    	                            icon: 'success',
    	                            title: '刪除成功！',
    	                            text: '會員已刪除!',
    	                            showConfirmButton: true
    	                        }).then(() => {
    	                            location.reload(); 
    	                        });
    	                    } else {
    	                        Swal.fire({
    	                            icon: 'error',
    	                            title: '刪除失敗',
    	                            text: response.message
    	                        });
    	                    }
    	                },
    	                error: function() {
    	                    Swal.fire({
    	                        icon: 'error',
    	                        title: '刪除失敗',
    	                        text: '無法刪除會員，請稍後再試'
    	                    });
    	                }
    	            });
    	        }
    	    });
    }
    
    // 更新會員
    function updateMember() {
        event.preventDefault();
        $('.error-message').text('');
        var memberId = $('#hidden').val().trim();// 隱藏儲存會員 ID
        var account = $('#editAccount').val();
        var password = $('#editPassword').val();
        var confirmPassword = $('#editConfirm_password').val();
        var username = $('#editUsername').val();
        var gender = $('#editGender').val();
        var birthday = $('#editBirthday').val();
        var idNumber = $('#editIdNumber').val();
        var phone = $('#editPhone').val();
        var address = $('#editAddress').val();
        var email = $('#editEmail').val();
        
        // 如果密碼格式有誤，阻止儲存
        if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%&])[A-Za-z\d!@#$%&]{8,16}$/.test(password)) {
            $('#passwordError').text('密碼必須包含至少一個大寫字母、小寫字母、數字和特殊符號，且長度為 8 至 16 位');
            return; // 阻止儲存
        }

        if(confirmPassword !== ''){
        	if (password !== confirmPassword) {
                $('#confirmPasswordError').text('兩次輸入的密碼不一致');
                return; 
         	}
        }else{
        	alert('請輸入確認密碼');
        	return;
        }
        
       //如果手機格式有誤，阻儲存
        if (!/^09\d{8}$/.test(phone)){
        	 $('#phoneError').text('手機號碼格式不正確，必須為 09 開頭的 10 位數字');
        	 return; 
        }
       
        // 如果電子郵件格式有誤，阻止儲存
        if (!/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/.test(email)) {
            $('#emailError').text('電子郵件格式不正確');
            return; 
        }
        
        $.ajax({
            url: '${pageContext.request.contextPath}/editMemberByAdmin',
            type: 'POST',
            data: {
               
                id: memberId,
                account: account,
                password: password,
                username: username,
                gender: gender,
                birthday: birthday,
                idNumber: idNumber,
                phone: phone,
                address: address,
                email: email
            },
            success: function(response) {
                if (response.status === "success") {
                    Swal.fire({
                        icon: 'success',
                        title: '修改成功',
                        text: '會員資料已更新！',
                        showConfirmButton: true
                    }).then(() => {
                        $('#editMemberModal').hide(); // 關閉 modal
                        location.reload(); // 刷新頁面以顯示更新後的資料
                    });
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: '更新失敗',
                        text: response.message || '發生未知錯誤，請稍後再試。'
                    });
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("Error: " + textStatus, errorThrown);
                Swal.fire({
                    icon: 'error',
                    title: '更新失敗',
                    text: '無法更新會員資料，請稍後再試。'
                });
            }
        });
    }
    
</script>
</body>
</html>