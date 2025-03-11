<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>保險申請詳情</title>
<style>
/* 基本設定 */
body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f7f9;
	text-align: center;
	margin: 0;
	padding: 0;
}

/* 容器 */
.container {
	width: 60%;
	margin: 40px auto;
	background: #ffffff;
	padding: 25px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	text-align: left;
}

/* 標題 */
h2 {
	font-size: 22px;
	color: #333;
	border-bottom: 3px solid #4caf50;
	padding-bottom: 10px;
	margin-bottom: 25px;
}

h3 {
	font-size: 18px;
	color: #4caf50;
	margin-top: 20px;
	border-left: 5px solid #4caf50;
	padding-left: 10px;
}

/* 表格樣式 */
table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	background-color: #fff;
}

th, td {
	border: 1px solid #ddd;
	padding: 12px;
	text-align: left;
	font-size: 16px;
}

/* 讓所有表頭大小統一 */
th {
	background: #4caf50;
	color: white;
	font-weight: bold;
	width: 200px; /* 統一表頭寬度 */
	text-align: center;
}

/* 讓內容自動適應 */
td {
	background: #f9f9f9;
	width: auto;
}

/* 超連結樣式 */
a {
	color: #007bff;
	text-decoration: none;
	font-weight: bold;
}

a:hover {
	text-decoration: underline;
}

/* 灰色區塊 */
.gray-box {
	border: 1px solid #ccc;
	padding: 20px;
	border-radius: 8px;
	background-color: #f8f9fa;
	margin-top: 20px;
}

/* 簽名區塊 */
.signature-box {
	text-align: center;
	margin-top: 20px;
	padding: 15px;
	border: 2px dashed #4caf50;
	border-radius: 8px;
	background-color: #f1fff1;
}

.signature-box img {
	max-width: 500px;
	height: auto;
	border: 2px solid #ddd;
	border-radius: 5px;
	margin-top: 10px;
}
</style>
</head>
<body>

	<div class="container">
		<h2>理賠申請表單</h2>

		<!-- 基本資料 -->
		<h3>基本資料</h3>
		<table>
			<tr>
				<th>保單號碼</th>
				<td>${bean.policyNumber}</td>
			</tr>
			<tr>
				<th>身分證字號</th>
				<td>${bean.idNumber}</td>
			</tr>
			<tr>
				<th>投保人姓名</th>
				<td>${bean.clientName}</td>
			</tr>
			<tr>
				<th>地址</th>
				<td>${bean.address}</td>
			</tr>
			<tr>
				<th>聯絡電話</th>
				<td>${bean.phone}</td>
			</tr>
			<tr>
				<th>電子郵件</th>
				<td>${bean.email}</td>
			</tr>
		</table>

		<!-- 申請內容 -->
		<h3>申請內容</h3>
		<table>
			<tr>
				<th>事故原因</th>
				<td>${bean.accidentReason}</td>
			</tr>
			<tr>
				<th>申請種類</th>
				<td>${bean.policyName}</td>
			</tr>
			<tr>
				<th>理賠類別</th>
				<td>${bean.claimCategories}</td>
			</tr>
		</table>

		<!-- 檔案上傳 -->
		<h3>檔案上傳</h3>
		<table>
			<tr>
				<th>身分證檔案</th>
				<td><a
					href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}/${bean.idCopy}"
					target="_blank">查看檔案</a></td>
			</tr>
			<tr>
				<th>帳戶影本</th>
				<td><a
					href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}/${bean.accountCopy}"
					target="_blank">查看檔案</a></td>
			</tr>
			<tr>
				<th>證明文件</th>
				<td><a
					href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}/${bean.proveFile}"
					target="_blank">查看檔案</a></td>
			</tr>
		</table>

		<!-- 保險金給付方式 -->
		<h3>保險金給付方式</h3>
		<div class="gray-box">
			<table>
				<tr>
					<th>受益人姓名</th>
					<td>${bean.beneficiaryName}</td>
				</tr>
				<tr>
					<th>受益人身分證字號</th>
					<td>${bean.beneficiaryID}</td>
				</tr>
				<tr>
					<th>銀行代號</th>
					<td>${bean.bankCode}</td>
				</tr>
				<tr>
					<th>行庫帳號</th>
					<td>${bean.accountCode}</td>
				</tr>
			</table>
		</div>

		<!-- 簽名區塊 -->
		<h3>簽名</h3>
		<div class="signature-box">
			<img src="${bean.signature}" alt="簽名圖片">
		</div>

	</div>

</body>
</html>
