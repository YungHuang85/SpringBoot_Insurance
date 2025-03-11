<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>管理者列表</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.datatables.net/2.1.8/css/jquery.dataTables.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	color: #333;
}

.admin-container {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 20px;
	padding: 30px;
}

.admin-card {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
	display: flex;
	align-items: center;
	flex-direction: column;
	transition: transform 0.3s;
}

.admin-card:hover {
	transform: scale(1.05);
}

.admin-avatar {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	object-fit: cover;
	margin-bottom: 20px;
}

.admin-name {
	font-size: 20px;
	font-weight: bold;
	color: #003366;
	margin-bottom: 10px;
}

.admin-responsibility {
	font-size: 16px;
	color: #666;
	margin-bottom: 10px;
}

.admin-link {
	color: #4285f4;
	text-decoration: none;
	font-weight: bold;
	transition: color 0.3s;
}

.admin-link:hover {
	color: #356ac3;
}

.action-button {
	margin-top: 10px;
	font-size: 14px;
	font-weight: bold;
	color: white; /* 文字顏色統一為白色 */
	border: none;
	padding: 6px 12px; /* 適當縮小內邊距 */
	border-radius: 6px; /* 圓角 */
	cursor: pointer;
	transition: background 0.3s ease-in-out, transform 0.2s;
	margin: 5px; /* 增加按鈕間距，避免太貼近 */
}

/* 編輯按鈕：預設藍底白字 */
.edit-button {
	background-color: #28a745 !important; /* 預設藍色 */
	color: white !important; /* 文字白色 */
	border: none;
	padding: 6px 12px;
	border-radius: 6px;
	cursor: pointer !important;
	transition: background 0.3s ease-in-out, transform 0.2s;
	opacity: 1 !important; /* 確保不透明 */
}

/* 滑鼠懸停時變深藍色 */
.edit-button:hover {
	background-color: #006400 !important; /* 深藍色 */
	transform: scale(1.05);
}

/* 解除 disabled 影響，讓 disabled 也顯示藍色 */
.edit-button:disabled {
	background-color: #007bff !important;
	color: white !important;
	opacity: 1 !important;
	cursor: not-allowed !important;
}

/* 刪除按鈕：紅底白字 */
.delete-button {
	background-color: #dc3545; /* Bootstrap 標準紅色 */
}

.delete-button:hover {
	background-color: #c82333; /* 滑鼠懸停時變深紅 */
	transform: scale(1.05);
}

.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content1 {
	background-color: #fefefe;
	margin: 15% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 50%;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}
/* 📌 標題樣式 */
.modal-content1 h2 {
	font-size: 24px;
	font-weight: bold;
	color: #333;
	text-align: center;
	margin-bottom: 15px;
	border-bottom: 2px solid #007bff;
	padding-bottom: 10px;
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.preset-button {
	margin-left: 10px;
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 5px 10px;
	border-radius: 5px;
	cursor: pointer;
}

.preset-button:hover {
	background-color: #0056b3;
}

.error {
	color: red;
	font-size: 14px;
}
/* 管理者列表與會員列表統一樣式 */
.page-title {
    font-size: 32px;
    font-weight: bold;
    color: black;
    text-align: center; /* 讓標題文字置中 */
    margin: 20px auto;
    letter-spacing: 1px;
    flex: 1; /* 讓標題填滿中間區域 */
    position: relative; /* 讓底線可以相對於標題定位 */
}

/* 讓標題底線有動畫 */
.page-title::after {
   content: "";
    display: block;
    width: 50px;
    height: 3px;
    background-color: black;
    margin: 8px auto 0; /* 這裡改為 auto 讓底線居中 */
    border-radius: 2px;
    transition: width 0.3s ease-in-out;
}


/* 滑鼠懸停時，讓底線變長 */
.page-title:hover::after {
	width: 120px;
}

/* 統一按鈕樣式 */
.add-button {
	font-size: 16px; /* 字體稍微縮小 */
	font-weight: bold;
	color: white;
	background-color: #007bff; /* 藍色背景 */
	border: none;
	padding: 8px 16px; /* 減少內邊距，讓按鈕變小 */
	border-radius: 6px; /* 減少圓角 */
	cursor: pointer;
	transition: background 0.3s ease-in-out, transform 0.2s;
}

/* 滑鼠懸停時變深藍色 */
.add-button:hover {
	background-color: #0056b3;
	transform: scale(1.05); /* 滑鼠懸停時微放大 */
}

/* 增加進場動畫 */
@
keyframes fadeIn {from { opacity:0;
	transform: scale(0.8);
}

to {
	opacity: 1;
	transform: scale(1);
}

}

/* 讓按鈕在顯示時有淡入動畫 */
.add-button {
	animation: fadeIn 0.3s ease-in-out;
}

/* 讓按鈕靠右 */
.button-container {
	display: flex;
	justify-content: flex-end; /* 讓內容靠右對齊 */
	padding-right: 30px; /* 右邊留 20px 的間距 */
	margin-bottom: 5px; /* 與下方內容保留間距 */
}

/* 讓按鈕與其他按鈕樣式一致 */
.add-button {
	font-size: 18px;
	font-weight: bold;
	color: white;
	background-color: #007bff;
	border: none;
	padding: 8px 16px;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.3s ease-in-out, transform 0.2s;
}

.add-button:hover {
	background-color: #0056b3;
	transform: scale(1.05);
}
/* 讓按鈕並排 */
.button-group {
	display: flex;
	justify-content: center; /* 讓按鈕置中 */
	gap: 10px; /* 設定按鈕之間的間距 */
}

.edit-button, .delete-button {
	width: 60px; /* 設定按鈕的固定寬度 */
	text-align: center;
}

.modal-content1 input[type="text"], .modal-content1 input[type="password"],
	.modal-content1 input[type="file"] {
	width: 100%;
	padding: 8px;
	margin: 5px 0 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
}

.submit-button {
	background-color: #28a745; /* 綠色 */
	color: white;
	font-size: 16px;
	font-weight: bold;
	border: none;
	padding: 10px 20px;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.3s ease-in-out;
}

.submit-button:hover {
	background-color: #218838;
}

@
keyframes fadeIn {from { opacity:0;
	transform: scale(0.9);
}

to {
	opacity: 1;
	transform: scale(1);
}

}
.save-container {
	display: flex;
	justify-content: center; /* 讓按鈕水平置中 */
	margin-top: 20px;
}

.save-button {
	background-color: #28a745; /* 綠色 */
	color: white;
	font-size: 16px;
	font-weight: bold;
	border: none;
	padding: 10px 20px;
	border-radius: 6px;
	cursor: pointer;
	transition: background 0.3s ease-in-out;
}

.download-button {
    font-size: 16px;
    font-weight: bold;
    color: white;
    background-color: #7ebcff;
    border: none;
    padding: 8px 16px;
    border-radius: 6px;
    cursor: pointer;
    transition: background 0.3s ease-in-out, transform 0.2s;
    position: absolute;
    right: 30px; /* 讓按鈕靠右 */
}

.download-button:hover {
    background-color: #0056b3;
    transform: scale(1.05);
}
.title-container {
   display: flex;
    align-items: center; /* 讓標題和按鈕垂直置中 */
    justify-content: center; /* 讓標題置中 */
    width: 100%;
    padding: 0 20px;
    position: relative;
}


</style>
</head>
<body>
	<jsp:include page="../ClientJSP/sidebar.jsp" />
	<div class="title-container">
		<h2 class="page-title">管理者列表</h2>
		<button id="downloadLogBtn" class="download-button">下載 Log</button>
	</div>
	<div class="button-container">
		<button id="addAdminBtn" class="add-button"
			onclick="openModal('addAdminModal')">新增管理員</button>
	</div>

	<div class="admin-container" id="adminContainer">
		<c:forEach var="admin" items="${adminList}">
			<div class="admin-card" id="adminCard-${admin.id}">
				<img src="/getImage/${admin.id}" alt="Admin Avatar"
					class="admin-avatar">
				<div class="admin-name">${admin.name}</div>
				<div class="admin-name">${admin.username}</div>

				<div class="admin-responsibility">${admin.modules}</div>

				<div class="button-group">
					<button class="edit-button action-button"
						onclick="editAdmin(${admin.id})">編輯</button>
					<button class="delete-button action-button"
						onclick="deleteAdmin(${admin.id})">刪除</button>
				</div>
			</div>
		</c:forEach>
	</div>

	<!-- 新增管理員 Modal -->
	<div id="addAdminModal" class="modal">
		<div class="modal-content1">
			<span class="close" onclick="closeModal('addAdminModal')">&times;</span>
			<h2>新增管理員</h2>
			<form id="addAdminForm">
				<input type="hidden" name="action" value="add"> <label>帳號:</label>
				<input type="text" id="username" name="username" required><br>
				<label>密碼:</label> <input type="password" id="password"
					name="password" required><br> <label>姓名:</label> <input
					type="text" id="name" name="name" required><br> <label>信箱:</label>
				<input type="text" id="admin_email" name="admin_email" required>
				<span id="emailError" class="error"></span><br> <label>照片:</label>
				<input type="file" id="profile_picture" name="profile_picture"><br>

				<div class="button-group">
					<button type="button" class="submit-button" onclick="submitForm()">新增</button>
					<button type="button" class="preset-button"
						onclick="fillPresetData()">一鍵帶入資料</button>
				</div>
			</form>
		</div>
	</div>
	<div id="editAdminModal" class="modal">
		<div class="modal-content1">
			<span class="close" onclick="closeModal('editAdminModal')">&times;</span>
			<h2>編輯管理員資料</h2>
			<form id="editAdminForm">
				<input type="hidden" id="hiddenAdminId" name="id"> <label>帳號:</label>
				<input type="text" id="editUsername" name="username" required><br>
				<label>密碼:</label> <input type="password" id="editPassword"
					name="password" required><br> <label>姓名:</label> <input
					type="text" id="editName" name="name" required><br> <label>信箱:</label>
				<input type="text" id="editAdminEmail" name="adminEmail" required><br>
				<label>照片:</label> <input type="file" id="editProfilePicture"
					name="profilePicture"><br>
				<div class="save-container">
					<button type="button" class="save-button" onclick="updateAdmin()">儲存修改</button>
				</div>
			</form>
		</div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
        function openModal(modalId) {
            $('#' + modalId).show();
        }

        function closeModal(modalId) {
            $('#' + modalId).hide();
        }

        function fillPresetData() {
            $('#username').val('EEIT202502140158');
            $('#password').val('ASD123asd@@');
            $('#name').val('李凱莉');
            $('#admin_email').val('kayyyy@insurance2024@gmail.com');
        }

        function submitForm() {
            const adminData = {
                username: document.getElementById('username').value,
                password: document.getElementById('password').value,
                name: document.getElementById('name').value,
                adminEmail: document.getElementById('admin_email').value
            };

            $.ajax({
                url: '/add',  // 確保這是後端處理新增管理員的正確路徑
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(adminData),
                success: function(response) {
                    if (response.status === 'success') {
                        // 顯示成功的提示
                       Swal.fire({
            	    title: '成功',
            	    text: '管理員已新增',
            	    icon: 'success',
            	    timer: 500, // 2秒後自動關閉
            	    showConfirmButton: false
            	}).then(() => {
            	    location.reload();
            	});
                    } else {
                        Swal.fire('新增失敗', response.message, 'error');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    Swal.fire('新增失敗', '請稍後再試', 'error');
                }
            });
        }
        
        function editAdmin(adminId) {
            console.log("editAdmin 被觸發，adminId:", adminId);
            editAdminById(adminId); 
        }

        function editAdminById(adminId) {
            console.log("editAdminById 被觸發，adminId:", adminId);
            $.ajax({
                url: '/get', // 假設此 API 提供管理員詳細資料
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ id: parseInt(adminId, 10) }), // 傳遞管理員 ID
                success: function(response) {
                    console.log("成功獲取管理員資料:", response);
                    if (response.status === 'success') {
                        // 填入資料到表單
                        $('#hiddenAdminId').val(response.data.id);
                        $('#editUsername').val(response.data.username);
                        $('#editPassword').val(response.data.password);
                        $('#editName').val(response.data.name);
                        $('#editAdminEmail').val(response.data.adminEmail);
                        $('#editProfilePicture').val(''); // 清空檔案輸入
                        openModal('editAdminModal'); // 開啟編輯 Modal
                    } else {
                        Swal.fire('錯誤', response.message || '無法取得管理員資料', 'error');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 失敗，error:", error);
                    Swal.fire('錯誤', '伺服器發生問題，請稍後再試', 'error');
                }
            });
        }



        // 更新管理員資料
 function updateAdmin(adminId) {
    let formData = new FormData();
    formData.append('id', document.getElementById('hiddenAdminId').value);
    formData.append('username', document.getElementById('editUsername').value);
    formData.append('password', document.getElementById('editPassword').value);
    formData.append('name', document.getElementById('editName').value);
    formData.append('adminEmail', document.getElementById('editAdminEmail').value);

    let profilePicture = document.getElementById('editProfilePicture').files[0];
    if (profilePicture) {
        formData.append('profilePicture', profilePicture);
    }

    $.ajax({
        url: '/edit',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function(response) {
            if (response.status === 'success') {
            	Swal.fire({
            	    title: '成功',
            	    text: '管理員資料已更新',
            	    icon: 'success',
            	    timer: 1500, 
            	    showConfirmButton: false
            	}).then(() => {
            	    location.reload();
            	});
            } else {
                Swal.fire('失敗', response.message || '無法更新資料', 'error');
            }
        },
        error: function(xhr, status, error) {
            Swal.fire('錯誤', '伺服器發生問題，請稍後再試', 'error');
            console.error('AJAX 錯誤:', xhr.responseText);
        }
    });
}
        
        //刪除
         function deleteAdmin(adminId) {
    Swal.fire({
        title: '確定要刪除嗎？',
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
                url: 'delete',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ id: adminId }), 
                success: function(response) {
                    if (response.status === "success") {
                        Swal.fire({
                            icon: 'success',
                            title: '刪除成功！',
                            text: '',
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
                error: function(jqXHR) {
                    Swal.fire({
                        icon: 'error',
                        title: '刪除失敗',
                        text: jqXHR.responseJSON ? jqXHR.responseJSON.message : '無法刪除，請稍後再試'
                    });
                }
            });
        }
    });
}
        
         function viewAdminDetails(adminId) {
        	    $.ajax({
        	        url: '/getDetail',
        	        type: 'POST',
        	        contentType: 'application/json',
        	        data: JSON.stringify({ id: adminId }),
        	        success: function(response) {
        	            if (response.status === 'success') {
        	                // 填充詳細資料到彈窗
        	                $('#detailAdminId').text(response.id);
        	                $('#detailUsername').text(response.username);
        	                $('#detailName').text(response.name);
        	                $('#detailEmail').text(response.adminEmail);
        	                if (response.profilePictureUrl) {
        	                    $('#detailProfilePicture').attr('src', response.profilePictureUrl);
        	                } else {
        	                    $('#detailProfilePicture').attr('src', '/default-avatar.png'); // 默認圖片
        	                }
        	                openModal('adminDetailModal'); // 開啟彈窗
        	            } else {
        	                Swal.fire('錯誤', response.message || '無法取得管理員資料', 'error');
        	            }
        	        },
        	        error: function(xhr, status, error) {
        	            Swal.fire('錯誤', '伺服器發生問題，請稍後再試', 'error');
        	        }
        	    });
        	}
         document.getElementById("downloadLogBtn").addEventListener("click", function() {
        	    Swal.fire({
        	        title: "請輸入要下載的 Log 日期",
        	        input: "text",
        	        inputPlaceholder: "格式: YYYY-MM-DD，若下載最新請留空",
        	        showCancelButton: true,
        	        confirmButtonText: "下載",
        	        cancelButtonText: "取消",
        	        inputValidator: (value) => {
        	            if (value && !/^\d{4}-\d{2}-\d{2}$/.test(value)) {
        	                return "請輸入正確的日期格式 (YYYY-MM-DD)";
        	            }
        	        }
        	    }).then((result) => {
        	        if (result.isConfirmed) {
        	            let logDate = result.value;
        	            let downloadUrl = "/download";
        	            if (logDate) {
        	                downloadUrl += "?date=" + logDate;
        	            }

        	            // 觸發下載
        	            window.location.href = downloadUrl;
        	        }
        	    });
        	});



    </script>
</body>
</html>
