<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="java.util.*,insurance.main.products.model.*,insurance.main.products.dto.*" %>


	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<title>保險類別、商品</title>


		<style>
			h2 {
				font-size: 35px;
			}

			th {
				background-color: #000;
				color: #fff;
				border-collapse: collapse;
				border: 1px solid lightgray;
				padding: 15px;
			}

			.product-table {
				width: 100%;
				border-collapse: collapse;
				border: 1px solid lightgray;

				font-size: 15.5px;
			}

			.product-table tr {
				padding: 15px;
				border-collapse: collapse;
				border: 1px solid lightgray;
				text-align: left;
			}

			.product-table td {
				padding: 15px;
				border-collapse: collapse;
				border: 1px solid lightgray;
				text-align: left;

			}

			.category-table {
				width: 100%;
				border-collapse: collapse;
				border: 1px solid lightgray;

				font-size: 15px;
			}

			.tr {
				padding: 15px;
				border-collapse: collapse;
				border: 1px solid lightgray;
				text-align: left;
				font-size: 15.5px;
			}

			input[type="submit"] {
				padding: 10px 15px;
				color: white;
				border: none;
				border-radius: 5px;
				cursor: pointer;
				transition: background-color 0.3s ease;
			}

			input[type="text"] {
				height: 25px;
				border-radius: 5px;
				border: 1px solid black;
			}

			button {
				padding: 10px 15px;
				color: white;
				border: none;
				border-radius: 5px;
				cursor: pointer;
				transition: background-color 0.3s ease;
			}


			.edit {
				background-color: #4CAF50;
			}

			.edit:hover {
				background-color: #45a049;
			}

			.delete {
				background-color: #e74c3c;
			}

			.delete:hover {
				background-color: #c0392b;
			}

			.search {
				background-color: darkgray;
			}

			.search:hover {
				background-color: gray;
			}

			.green {
				background-color: #4caf50;
				margin-top: 20px;
			}

			.green:hover {
				background-color: #45a049;
			}

			#text {
				padding: 10px;
				color: black;
				cursor: pointer;
				font-size: 20px;
			}

			#text:hover {
				color: gray;
			}

			.box {
				display: flex;
				justify-content: space-between;
			}

			#fixedTable {
				width: 15vw;
				height: 30vh;
				position: absolute;
				left: 0;

			}

			.box2 {
				width: 70vw;
				position: absolute;
				left: 20%;
				right: 5%;

			}

			.light-table-filter {
				height: 30px;
				border-radius: 5px;
				border: 1px solid black;
			}

			#pictureModal {
				display: none;
				align-items: center;
				/* 垂直置中 */
				justify-content: center;
				/* 水平置中 */
				position: fixed;
				top: 0;
				left: 0;
				width: 100%;
				height: 100%;
				background-color: rgba(0, 0, 0, 0.8);
				/* 半透明黑色背景 */
			}

			#modalPicture {
				max-width: 90%;
				/* 限制最大寬度 */
				max-height: 90vh;
				/* 限制最大高度 */
				object-fit: contain;
				/* 保持原比例 */
			}
		</style>
	</head>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	<body>
		<jsp:include page="sidebar.jsp" />
		<div class="box">
			<div class="box1" id="fixedTable">

				<!-- 新增類別，觸發新增dialog -->
				<button class="green" onclick="openDialog('insert-c')">新增保險類別</button>
				<dialog id="insert-c">
					<form method="post" action="${pageContext.request.contextPath}/productlistBE/InsertCategory">
						<table>
							<tr>
								<th colspan="2">新增保險種類資料</th>
							<tr class="tr">
								<td class="tr">新的保險種類名稱 :
								<td class="tr"><input type="text" name="categoryname" required />
						</table>
						<button type="submit" class="green">保存</button>
						<button type="button" class="delete" onclick="closeDialog('insert-c')">取消</button>
					</form>
				</dialog>
				<!-- 類別表單 -->
				<table class="category-table">
					<thead>
						<th colspan="4" style="text-align:center; font-size:20px">保險種類
					</thead>
					<tbody>
						<% List<InsuranceCategoryDTO> ics = (ArrayList<InsuranceCategoryDTO>)
								request.getAttribute("ics");
								for (InsuranceCategoryDTO ic : ics) {
								%>
								<tr>
									<td style="text-align:right; font-size:17px">
										<%=ic.getCategoryid()%>.
									</td>
									<!--類別對應產品按鈕 -->
									<td>
										<button id="text" onclick="CategoryDetail('<%=ic.getCategoryid()%>')">
											<%=ic.getCategoryname()%>
										</button>
									</td>
									<td>
										<!-- 修改按鈕，觸發對應的 dialog -->
										<button type="button" class="edit"
											onclick="openDialog('dialog-<%=ic.getCategoryid()%>')">修改</button>

										<!-- 對應的 dialog -->
										<dialog id="dialog-<%=ic.getCategoryid()%>">
											<form method="post"
												action="${pageContext.request.contextPath}/productlistBE/UpdateCategoryById">
												<input type="hidden" name="categoryid"
													value="<%=ic.getCategoryid()%>" />
												<table>
													<tr>
														<th colspan="2">修改保險種類資料</th>
													<tr class="tr">
														<td class="tr">新的保險種類名稱 :
														<td class="tr"><input type="text" name="categoryname"
																value="<%=ic.getCategoryname()%>" required />
												</table>
												<button type="submit" class="green">保存</button>
												<button type="button" class="delete"
													onclick="closeDialog('dialog-<%=ic.getCategoryid()%>')">取消</button>
											</form>
										</dialog>
									</td>
									<td>
										<!-- 刪除按鈕，觸發對應-->
										<button type="button" class="delete" onclick="deleteAlert(this)">刪除</button>

										<!-- 表單 -->
										<form id="deleteForm-<%=ic.getCategoryid()%>" method="get"
											action="${pageContext.request.contextPath}/productlistBE/DeleteCategoryById">
											<input type="hidden" name="categoryid" value="<%=ic.getCategoryid()%>" />
										</form>
									</td>
								</tr>
								<% } %>

					</tbody>
				</table>
				<h3>
					共<%=ics.size()%>筆資料
				</h3>
			</div>

			<div class="box2">
				<h2>保險產品</h2>
				<br> <br>
				<!-- 模糊查詢產品名稱 -->
				<input type="search" class="light-table-filter" data-table="product-table" placeholder="請輸入關鍵字查詢"> <br>
				<!-- 顯示產品按鈕 -->
				<button class="search" onclick="displayAll()">顯示全部產品</button>
				<!-- 新增產品按鈕，觸發dialog -->
				<button class="green" onclick="openDialog('insert-p')">新增保險產品</button>
				<dialog id="insert-p">
					<form method="post" action="${pageContext.request.contextPath}/productlistBE/InsertProduct"
						enctype="multipart/form-data">
						<table>
							<tr>
								<th colspan="2">新增保險產品資料</th>
							<tr class="tr">
								<td class="tr">新的保險產品名稱 :
								<td class="tr"><input type="text" name="productname" required />
							<tr class="tr">
								<td class="tr">新的保險種類編號 :
								<td class="tr"><select name="categoryid">
										<option value="" disabled selected>請選擇保險種類編號</option>
										<% for (InsuranceCategoryDTO ic : ics) { %>
											<option value="<%=ic.getCategoryid()%>">
												<%=ic.getCategoryid()%>
											</option>
											<% } %>
									</select>
							<tr class="tr">
								<td class="tr">是否設為精選 :
								<td class="tr"><select name="isFeatured">
										<option value="" disabled selected>請選擇是或否</option>
										<option value="true">是</option>
										<option value="false">否</option>
							<tr class="tr">
								<td class="tr">新的保險產品圖片 :
								<td class="tr"> <input type="file" name="productPicture" accept="image/*">
							<tr class="tr">
								<td class="tr">新的保險產品描述 :
								<td class="tr"> <textarea name="productDescription"></textarea>
						</table>
						<button type="submit" class="green">保存</button>
						<button type="button" class="delete" onclick="closeDialog('insert-p')">取消</button>
					</form>
				</dialog>
				<!-- 產品清單 -->
				<table class="product-table" id="Mytable">
					<thead>
						<th>產品編號
						<th>產品名稱
						<th>類別編號
						<th>精選商品
						<th>產品圖片
						<th>產品描述
						<th>修改
						<th>刪除
					</thead>
					<tbody>
						<% List<InsuranceProductDTO> ips = (ArrayList<InsuranceProductDTO>) request.getAttribute("ips");
								for (InsuranceProductDTO ip : ips) {
								%>
								<tr>
									<td>
										<%=ip.getProductid()%>
									<td>
										<%=ip.getProductname()%>
									<td>
										<%=ip.getCategoryid()%>
									<td>
										<%=ip.isFeatured()? '是' : '否' %>
									<td>
										<% if (ip.getProductPicture() !=null) { %><img src=<%=ip.getProductPicture()%>
											alt="Product Picture" style="width: 50px; height: 50px; cursor: pointer;"
											onclick="showPictureModal(this)">
											<% } else { %> 無圖片 <% } %>
									</td>
									<td>
										<%=ip.getProductDescription()%>
									<td>
										<!-- 產品修改按鈕，觸發對應的 dialog -->
										<button type="button" class="edit"
											onclick="openDialog('editlog-<%=ip.getProductid()%>')">修改</button>
										<dialog id="editlog-<%=ip.getProductid()%>">
											<form method="post"
												action="${pageContext.request.contextPath}/productlistBE/UpdateProductById"
												enctype="multipart/form-data">
												<input type="hidden" name="productid" value="<%=ip.getProductid()%>" />
												<table>
													<tr>
														<th colspan="2">修改保險產品資料</th>
													<tr>
														<td>新的保險產品名稱 :
														<td><input type="text" name="productname"
																value="<%=ip.getProductname()%>" required />
													<tr>
														<td>新的保險種類編號 :
														<td><select name="categoryid">
																<option value="<%=ip.getCategoryid()%>" selected>
																	<%=ip.getCategoryid()%>
																</option>
																<% for (InsuranceCategoryDTO ic : ics) { %>
																	<option value="<%=ic.getCategoryid()%>">
																		<%=ic.getCategoryid()%>
																	</option>
																	<% } %>
															</select>
													<tr class="tr">
														<td class="tr">是否設為精選 :
														<td class="tr"><select name="isFeatured">
																<option value="<%=ip.isFeatured()%>" selected>
																	<%=ip.isFeatured()? '是' : '否' %>
																</option>
																<option value="true">是</option>
																<option value="false">否</option>
													<tr class="tr">
														<td class="tr">新的保險產品圖片 :
														<td class="tr"> <input type="file" name="productPicture"
																accept="image/*">
													<tr class="tr">
														<td class="tr">新的保險產品描述 :
														<td class="tr"> <textarea
																name="productDescription"><%=ip.getProductDescription()%></textarea>
												</table>
												<button type="submit" class="green">保存</button>
												<button type="button" class="delete"
													onclick="closeDialog('editlog-<%=ip.getProductid()%>')">取消</button>
											</form>
										</dialog>
									</td>

									<td>
										<!-- 修改刪除，觸發對應的 dialog -->
										<button type="button" class="delete" onclick="deleteAlert(this)">刪除</button>
										<form method="get"
											action="${pageContext.request.contextPath}/productlist/DeleteProductById"
											style="display: none;">
											<input type="hidden" name="productid" value="<%=ip.getProductid()%>" />
										</form>
										<% } %>

					</tbody>
				</table>
				<h3>
					共<%=ips.size()%>筆資料
				</h3>
			</div>
			<div id="pictureModal" class="modal close" onclick="closePictureModal()">
				<img class="modal-content" id="modalPicture">
			</div>
		</div>
		<script>

		
			window.addEventListener('DOMContentLoaded', function () {
				const header = document.querySelector('.navbar');
				const fixedTable = document.getElementById('fixedTable');
				console.log(header);
				function updateTablePosition() {
					const headerBottom = header.offsetTop + header.offsetHeight;
					if (window.scrollY > headerBottom) {
						fixedTable.style.position = 'fixed';
						fixedTable.style.top = '0px';
					} else {
						fixedTable.style.position = 'absolute';
						fixedTable.style.top = headerBottom + 'px';
					}
				}

				window.addEventListener('scroll', updateTablePosition);

	
				updateTablePosition();
			})

	
			function openDialog(dialogId) {
				const dialog = document.getElementById(dialogId);
				if (dialog) {
					dialog.showModal();
				}
			}

		
			function closeDialog(dialogId) {
				const dialog = document.getElementById(dialogId);
				if (dialog) {
					dialog.close();
				}
			}

			function showPictureModal(img) {
				const modal = document.getElementById('pictureModal');
				const modalPicture = document.getElementById('modalPicture');
				modal.style.display = 'flex';
				modalPicture.style.width = '500px';
				modalPicture.style.height = 'auto';
				modalPicture.src = img.src;
			}

			function closePictureModal() {
				const modal = document.getElementById('pictureModal');
				modal.style.display = 'none';
			}

			(function (document) {
				'use strict';

		
				var LightTableFilter = (function (Arr) {

					var _input;

				
					function _onInputEvent(e) {
						_input = e.target;
						var tables = document.getElementsByClassName(_input.getAttribute('data-table'));
						Arr.forEach.call(tables, function (table) {
							Arr.forEach.call(table.tBodies, function (tbody) {
								Arr.forEach.call(tbody.rows, _filter);
							});
						});
					}

				
					function _filter(row) {
						var text = row.textContent.toLowerCase(), val = _input.value.toLowerCase();
						row.style.display = text.indexOf(val) === -1 ? 'none' : 'table-row';
					}

					return {
						
						init: function () {
							var inputs = document.getElementsByClassName('light-table-filter');
							Arr.forEach.call(inputs, function (input) {
								input.oninput = _onInputEvent;
							});
						}
					};
				})(Array.prototype);

				
				document.addEventListener('readystatechange', function () {
					if (document.readyState === 'complete') {
						LightTableFilter.init();
					}
				});

			})(document);


			
			function CategoryDetail(categoryId) {
				var table = document.getElementsByClassName("product-table")[0];
				var tr = table.getElementsByTagName("tr");
				for (i = 0; i < tr.length; i++) {
					var td = tr[i].getElementsByTagName("td")[2];
					if (td) {
						var txtValue = td.textContent || td.innerText;
						if (txtValue.trim() === categoryId) {
							tr[i].style.display = "";
						} else {
							tr[i].style.display = "none";
						}
					}
				}
			}
		
			
			function displayAll() {
				var table = document.getElementsByClassName("product-table")[0];
				var tr = table.getElementsByTagName("tr");
				for (i = 0; i < tr.length; i++) {
					tr[i].style.display = "";
				}
			}

			function deleteAlert(button) {
				Swal.fire({
					title: "確定要刪除嗎?",
					text: "刪除成功後無法返回!",
					icon: "warning",
					showCancelButton: true,
					confirmButtonColor: "#3085d6",
					cancelButtonColor: "#d33",
					confirmButtonText: "是，刪除！",
					cancelButtonText: "取消"
				}).then((result) => {
					if (result.isConfirmed) {
				
						Swal.fire({
							title: "刪除成功",
							text: "資料已刪除",
							icon: "success",
							showConfirmButton: false, 
							timer: 1500  // 顯示成功提示 1.5 秒
						}).then(() => {
							
							const form = button.nextElementSibling;
							form.submit(); // 提交表單
						});
					}
				});
			}






		</script>
		<c:if test="${not empty messages}">
			<script>
				document.addEventListener('DOMContentLoaded', function () {
				
					var messages = "${messages}";

					if (messages == "資料重複") {
						Swal.fire({
							title: '錯誤',
							text: '請檢查資料是否重複！',
							icon: 'error',
							confirmButtonText: '好',
						});
					} else if (messages == "新增成功") {
						Swal.fire({
							title: '成功',
							text: '保存成功。',
							icon: 'success',
							confirmButtonText: '好',
						});
					}
				});
			</script>
		</c:if>


	</body>

	</html>