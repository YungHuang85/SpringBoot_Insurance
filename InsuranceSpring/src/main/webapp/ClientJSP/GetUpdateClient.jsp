<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>旅平險投保人</title>
		<jsp:include page="sidebar.jsp" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/ClientCSS/GetClient.css">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	</head>

	<body>

		<div class="container">
			<jsp:useBean id="client" scope="request" class="insurance.main.model.ClientBean" />

			<div>
				<form action="${pageContext.request.contextPath}/clients/update" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="_method" value="PUT">
					<h2>修改旅平險投保人資料</h2>
					<table>
						<tr>
							<td>保單號碼
							<td><input type="text" name="insuranceNumber" readonly value="${param.insuranceNumber}">
						</tr>
						<tr>
							<td>帳號
							<td><input type="text" name="account" readonly value="${param.account}">
						</tr>
						<tr>
							<td>投保人
							<td><input type="text" name="username" required value="${param.username}">
						</tr>
						<tr>
							<td>投保人ID
							<td><input type="text" name="id_number" value="${param.id_number}" maxlength="10"
									pattern="^[A-Z]{1}[1289]{1}[0-9]{8}$" title="填寫格式錯誤" required>
						</tr>
						<tr>
							<td>投保商品
							<td><input type="text" name="insuranceProduct" readonly value="${param.insuranceProduct}">
						</tr>
						<tr>
							<td>旅遊地區</td>
							<td>
								<select name="country" required>
									<option value="台灣">台灣</option>
									<option value="日韓">日韓</option>
									<option value="東南亞">東南亞</option>
									<option value="歐洲">歐洲</option>
									<option value="美加">美加</option>
									<option value="紐澳">紐澳</option>
								</select>
							</td>
						</tr>


						<tr>
							<td>生效時間
							<td><input type="date" name="startTime" required value="${param.startTime}">
						</tr>
						<tr>
							<td>結束時間
							<td><input type="date" name="endTime" required value="${param.endTime}">
						</tr>
						<tr>
							<td>保額</td>
							<td>
								<select name="sumAssured" required>
									<option value="100W">100W</option>
									<option value="300W">300W</option>
									<option value="500W">500W</option>
									<option value="700W">700W</option>
									<option value="1000W">1000W</option>
								</select>
							</td>
						</tr>

						<tr>
							<td>意外身故
							<td><input type="text" name="premiums" required value="${param.premiums}">
						</tr>
						<tr>
							<td>圖片</td>
							<td><input type="file" class="form-control" id="profilePicture" name="profilePicture"
									accept="image/*" value="${param.profilePicture}"></td>
						</tr>
						<tr>
							<td>傷害醫療
							<td><input type="text" name="medicalTreatment" required value="${param.medicalTreatment}">
						</tr>
						<tr>
							<td>海外突發疾病
							<td><input type="text" name="overseasIllness" required value="${param.overseasIllness}">
						</tr>
						<tr>
							<td>海外醫療專機
							<td><input type="text" name="overseasFlights" required value="${param.overseasFlights}">
						</tr>
						<tr>
							<td>總保費
							<td><input type="text" name="totalCost" required value="${param.totalCost}">
						</tr>
					</table>


					<h2>修改旅平險受益人資料</h2>
					<table>
						<tr>
							<td>受益人
							<td><input type="text" name="beneficiaryName" required value="${param.beneficiaryName}">
						<tr>
							<td>與投保人關係</td>
							<td>
								<select name="relationship" required>
									<option value="本人">本人</option>
									<option value="配偶">配偶</option>
									<option value="父子">父子</option>
									<option value="父女">父女</option>
									<option value="母子">母子</option>
									<option value="(外)祖父母">(外)祖父母</option>
									<option value="(外)孫子女">(外)孫子女</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>受益人ID
							<td><input type="text" name="beneficiaryID" maxlength="10" value="${param.beneficiaryID}"
									pattern="^[A-Z]{1}[1289]{1}[0-9]{8}$" title="填寫格式錯誤" required>
						<tr>
							<td>受益人生日
							<td><input type="date" name="beneficiaryBirthday" value="${param.beneficiaryBirthday}">

						<tr>
							<td>受益人性別</td>
							<td>
								<select name="beneficiaryGender" id="beneficiaryGender" required>
									<option value="男" id="male">男</option>
									<option value="女" id="female">女</option>
								</select>
							</td>
						</tr>

						<tr>
							<td>受益人電話
							<td><input type="text" name="beneficiaryPhone" maxlength="10"
									value="${param.beneficiaryPhone}" pattern="^[0-9]{10}" title="限制數字10碼" required>
						<tr>
							<td>受益人地址
							<td><input type="text" name="beneficiaryAddress" required
									value="${param.beneficiaryAddress}">
					</table>
					<input type="submit" value="更新資料">
				</form>

				<form action="${pageContext.request.contextPath}/clients" method="get">
					<input type="submit" value="回到上一頁">
				</form>


			</div>

	</body>

	</html>