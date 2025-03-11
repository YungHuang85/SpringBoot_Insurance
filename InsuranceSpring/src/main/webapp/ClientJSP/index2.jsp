<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="sidebar.jsp" />  
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- 引入 Bootstrap -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script> <!-- 引入 Bootstrap JS -->
<title>理賠進度查詢</title>
<style>
table {
	
	border-collapse: collapse;
	margin-top: 10px;
}

table, th, td {
	border: 1px solid black;
}

th, td {
	padding: 10px;
	text-align: left;
}

.btn {
	padding: 5px 10px;
	text-decoration: none;
	color: white;
	background-color: blue;
	border-radius: 5px;
	margin: 5px
}

.btn.delete {
	background-color: red;
}

.buttonTop {
	display: flex;
}

.searchInput {
	padding: 5px; /* 增加內部的間距 */
	width: 150px; /* 設定寬度 */
	font-size: 16px; /* 增加字體大小 */
	border: 1px solid #ccc; /* 增加邊框樣式 */
	border-radius: 5px; /* 邊角圓滑 */
}

th {
	background-color: black; /* 设置背景颜色为黑色 */
	
	color: white; /* 设置字体颜色为白色 */
}


body {
    margin: 0;
    padding: 0;
    font-family: Arial, sans-serif;
}

.wrapper {
    width: 80vw; /* 限制寬度為螢幕的 80% */
    margin: auto; /* 讓內容區塊置中 */
    padding: 10px;
}

.table-container {
    max-width: 100%; /* 讓表格佔滿可用空間 */
    margin: auto; /* 水平置中 */
}

table {
    width: 100%; /* 讓表格最大化 */
    border-collapse: collapse;
    margin-top: 10px;
}

th, td {
    padding: 10px;
    border: 1px solid black;
    text-align: left;
}

th {
    background-color: black;
    color: white;
}

 .styled-dropdown {
        padding: 8px 12px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: white;
        cursor: pointer;
        transition: all 0.3s ease;
        box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
        margin-left: 10px;
    }

    .styled-dropdown:hover {
        background-color: #f5f5f5;
    }

    .styled-dropdown:focus {
        border-color: #007bff;
        outline: none;
        box-shadow: 0px 0px 5px rgba(0, 123, 255, 0.5);
    }
    
    /* 讓選單更明顯 */
.custom-tabs {
    background-color: #f8f9fa; /* 淺灰背景 */
    border-radius: 8px; /* 圓角 */
    padding: 8px; /* 上下間距 */
}

/* 標籤樣式 */
.custom-tabs .nav-link {
    font-weight: bold; /* 加粗字體 */
    font-size: 18px; /* 增加字體大小 */
    color: #333; /* 深灰色 */
    padding: 12px 20px; /* 增加間距 */
    transition: all 0.3s ease-in-out; /* 添加動態效果 */
}


</style>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<!-- sweet alert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" rel="stylesheet">
</head>
<body>


<ul class="nav nav-tabs custom-tabs">
  <li class="nav-item">
    <a class="nav-link active" aria-current="page" href="/insuranceClaims">理賠進度查詢</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="/ClientJSP/Chart.jsp">統計圖表</a>
  </li>

</ul>

 <br>
	<div class="wrapper">
		<!-- 新增 Bootstrap 容器，確保與兩側有距離 -->
		<div class="table-container">

			<div class='buttonTop'>

				<input type="text" class="searchInput" name="policyNumber"
					placeholder="搜尋保單號碼">

				<!--  <button type="button" id="searchButton" class="btn">搜尋</button>-->

				<!-- 美觀的 Dropdown 選單 -->
				<select id="claimStatusFilter" class="styled-dropdown">
    <option value="">全部顯示</option>
    <c:set var="statusSet" value="" />
    <c:forEach var="claim" items="${requestScope.claims}">
        <c:if test="${not fn:contains(statusSet, claim.claimStatus)}">
            <option value="${claim.claimStatus}">${claim.claimStatus}</option>
            <c:set var="statusSet" value="${statusSet},${claim.claimStatus}" />
        </c:if>
    </c:forEach>
</select>



			</div>

			<table>
				<thead>
					<tr>
						<th>保單號碼</th>
						<th>保單名稱</th>
						<th>客戶名稱</th>
						<th>申請書表單</th>
						<th>理賠進度</th>
						<th>備註欄</th>
						<th>理賠金額</th>
						<th>審核人員</th>
						<th>申請日期</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="claim" items="${requestScope.claims}">
						<tr>
							<td>${claim.policyNumber}</td>
							<td>${claim.policyName}</td>
							<td>${claim.clientName}</td>
							<td>

									<a href="${pageContext.request.contextPath}/GetFormClaim/${claim.policyNumber}"
										target="_blank">表單連結</a>

								</td>
							<!-- <td><c:choose>
							<c:when test="${not empty claim.idCopy}">
								<a href="${claim.idCopy}" target="_blank">檔案連結</a>
							</c:when>
							<c:otherwise>無檔案</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${not empty claim.accountCopy}">
								<a href="${claim.accountCopy}" target="_blank">檔案連結</a>
							</c:when>
							<c:otherwise>無檔案</c:otherwise>
						</c:choose></td>
						<td><c:choose>
							<c:when test="${not empty claim.proveFile}">
								<a href="${claim.proveFile}" target="_blank">檔案連結</a>
							</c:when>
							<c:otherwise>無檔案</c:otherwise>
						</c:choose></td>-->
							<td>${claim.claimStatus}</td>


							<td>${claim.comment}</td>
							<td>${claim.claimAmount}</td>
							<td>${claim.reviewer}</td>
							<td>${claim.applicationDate}</td>
							<td>
								<form action="GetOneClaim/${claim.policyNumber}" method="get"
									style="display: inline;">
									<button type="submit" id="UpdateButton" class="btn"">更新資料</button>
								</form>
								 <!--<form action="DeleteClaims/${claim.policyNumber}" method="delete" style="display: inline;">
							<input type="hidden" name="policyNumber" value="${claim.policyNumber}">-->
								<button type="button" id="DeleteButton" class="btn delete"
									value="${claim.policyNumber}">刪除資料</button> <!--</form>-->
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- SweetAlert2 彈窗邏輯 -->
			<c:if test="${not empty alertMessage}">
				<script>
            Swal.fire({
                icon: '${alertType}', // success, error, warning, info, question
                title: '${alertType == "success" ? "成功" : "失敗"}',
                text: '${alertMessage}'
                
            });
        </script>
			</c:if>
		</div>
	</div>
	<script>


$(document).ready(function () {
	
	 // 監聽 Dropdown 變化，根據選擇的理賠進度篩選表格
    $('#claimStatusFilter').change(function () {
        let selectedStatus = $(this).val();
        
        // 遍歷表格，隱藏不符合的行
        $('table tbody tr').each(function () {
            let rowStatus = $(this).find('td:nth-child(5)').text().trim(); // 第 5 欄是理賠進度
            if (selectedStatus === "" || rowStatus === selectedStatus) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
	 
 // 監聽搜尋框輸入事件，進行模糊篩選
    $('.searchInput').on('keyup', function () {
        let searchValue = $(this).val().trim().toLowerCase(); // 轉小寫避免大小寫影響搜尋

        $('table tbody tr').each(function () {
            let policyNumber = $(this).find('td:eq(0)').text().trim().toLowerCase(); // 第1欄是保單號碼

            if (policyNumber.includes(searchValue) || searchValue === "") {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    });
	//模糊查詢
 /** $('#searchButton').click(function () {
	  console.log('執行程式');
        const policyNumber = $('.searchInput').val().trim();

        if (!policyNumber) {
            alert('請輸入保單號碼');
            return;
        }

        const url = '/GetSomeClaims/'+policyNumber;
        console.log(url);
        // 發送 AJAX 請求
        $.ajax({
            url: url,
            type: 'get',
            dataType: 'json',
            success: function (response) {
                if (response && response.length > 0) {
                    // 清空表格內容
                    $('table tbody').empty();

                    // 動態插入新數據
                    response.forEach(function(data) {
                        var row = '<tr>' +
                                  '<td>' + data.policyNumber + '</td>' +
                                  '<td>' + data.policyName + '</td>' +
                                  '<td>' + data.clientName + '</td>' +
                                  
                                  '<td>' + (data.idCopy ? '<a href="' + data.idCopy + '" target="_blank">檔案連結</a>' : '無檔案') + '</td>' +
                                  '<td>' + (data.accountCopy ? '<a href="' + data.accountCopy + '" target="_blank">檔案連結</a>' : '無檔案') + '</td>' +
                                  '<td>' + data.claimStatus + '</td>' +
                                  '<td>' + data.applicationDate + '</td>' +
                                  '<td>' +
                                  '<form action="GetOneClaim/' + data.policyNumber + '" method="put" style="display: inline;">' +
                                  '<button type="submit" class="btn">修改狀態</button>' +
                                  '</form>' +
                                   
                                  '<button type="button" id="DeleteButton" class="btn delete"  value="' + data.policyNumber + '">刪除資料</button>' +
                                 
                                  '</td>' +
                                  '</tr>';
                        $('table tbody').append(row);
                    });
                } else {
                    // 如果沒有返回數據，顯示提示信息
                    $('table tbody').html('<tr><td colspan="9">查無此筆保單紀錄</td></tr>');
                }
            },
            error: function (xhr, status, error) {
                console.error('AJAX Error: ', error);
                alert('查詢失敗，請稍後再試');
            }
        });
      
    });*/
	
	
	//刪除
  $('table').on('click', '.btn.delete', function () {
	  	console.log('執行被觸發');
	    // 获取按钮的值（policyNumber）
	    const policyNumber = $(this).val();
  
	    const url = '/DeleteClaims/'+policyNumber;
        console.log(url);

	    // 发起 AJAX 请求
	    $.ajax({
	        url: url, // 替换为你的后端接口
	        type: 'delete', 
	        success: function (response) {
	            console.log('成功:', response);
	            // 根据返回的响应更新页面或显示提示
	          	           
	            Swal.fire({
	                title: '成功!',
	                text: '資料已成功刪除',
	                icon: 'success',
	            }).then((result) => {
	                if (result.isConfirmed) {
	                    // 用戶按下確認按鈕後跳轉到主頁
	                    window.location.href = '/insuranceClaims';
	                }
	            });
	        },
	        error: function (xhr, status, error) {
	            console.error('错误:', error);
	            Swal.fire({
	                title: '失敗!',
	                text: '資料刪除失敗',
	                icon: 'error',
	                confirmButtonText: '確認'
	            }).then((result) => {
	                if (result.isConfirmed) {
	                    // 用戶按下確認按鈕後跳轉到主頁
	                    window.location.href = '/insuranceClaims';
	                }
	            });
	        }
	    });
	});
}); 


</script>

</body>
</html>
