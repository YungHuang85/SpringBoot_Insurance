<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增理賠資料</title>
 <style>
        /* 基本全局設置 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #202124;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 100%;
        }

        h2 {
            text-align: center;
            color: #202124;
            margin-bottom: 20px;
        }

        form {
            margin-bottom: 15px;
        }

        p {
            margin: 10px 0;
        }

        .searchInput {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #dadce0;
            border-radius: 4px;
            font-size: 14px;
        }

        .custom-file-input {
            width: 100%;
            padding: 5px;
            margin-bottom: 15px;
            border: 1px solid #dadce0;
            border-radius: 4px;
            font-size: 14px;
        }

        .btn {
            background-color: #1a73e8;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #1558b0;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<div class="container">
	<h2>新增理賠資料</h2>
	  <!-- 如果查無此保單紀錄，顯示alert -->


	<!--  <form method="get" action="GetClientTravel">
		請先輸入保單號碼: <input type="text" name="policyNumber"
			value="${bean.insuranceNumber}" class="searchInput" required />
		<button type="submit" class="btn" >搜尋</button>
	</form>-->
	<form id="searchForm">
    請先輸入保單號碼: 
    <input type="text" id="policyNumber" name="policyNumber" value="${bean.insuranceNumber}" class="searchInput" required />
    <button type="button" id="searchButton" class="btn">搜尋</button>
 	</form>
	<br />
	<c:if test="${not empty insuranceClaim}">

	<form:form method="post" modelAttribute="insuranceClaim" action="../InsertClaims" enctype="multipart/form-data">
	<form:input path="policyNumber" type="hidden" name="policyNumber" 
			value="${bean.insuranceNumber}" />
		<p>
			保單名稱 : <input type="text" name="policyName" disabled class="searchInput"
				value="${bean.insuranceProduct}" /> <form:input  path="policyName" type="hidden"
				name="policyName" value="${bean.insuranceProduct}" />
		<p>
			姓名 : <input type="text" name="clientName" disabled class="searchInput"
				value="${bean.username}" /> <form:input path="clientName" type="hidden" name="clientName"
				 value="${bean.username}" />
		<p>
			申請書表單: <form:input type="file" path="applicationForm" name="applicationForm"  class="custom-file-input" />
		<p>
			身分證 : <form:input type="file" path="idCopy" name="idCopy"  class="custom-file-input"/>
		<p>
			帳戶影本 : <form:input type="file" path="accountCopy" name="accountCopy" class="custom-file-input"/>
		<p>
		<div style="display: none;">
			簽名先不做: <input type="text" name="signatureFile" />
		</div>

		<form:input type="hidden" path="applicationDate" id="applicationDate" name="applicationDate"/>
		 <form:input type="hidden" path="claimStatus" name="claimStatus" value="審核中" />
		<p>
			<input type="submit" value="送出" onclick="check()" class="btn" />
			  
	</form:form>
	</c:if>
	<c:if test="${empty insuranceClaim}">
	<form method="post" action="../InsertClaims" enctype="multipart/form-data">
	<input type="hidden" name="policyNumber" 
			value="${bean.insuranceNumber}" />
		<p>
			保單名稱 : <input type="text" name="policyName" disabled class="searchInput"
				value="${bean.insuranceProduct}" /> <input type="hidden"
				name="policyName" value="${bean.insuranceProduct}" />
		<p>
			姓名 : <input type="text" name="clientName" disabled class="searchInput"
				value="${bean.username}" /> <input type="hidden" name="clientName"
				 value="${bean.username}" />
		<p>
			申請書表單: <input type="file"  name="applicationForm"  class="custom-file-input" />
		<p>
			身分證 : <input type="file"  name="idCopy"  class="custom-file-input"/>
		<p>
			帳戶影本 : <input type="file"  name="accountCopy" class="custom-file-input"/>
		<p>
		<div style="display: none;">
			簽名先不做: <input type="text" name="signatureFile" />
		</div>

		<input type="hidden"  id="applicationDate" name="applicationDate"/>
		 <input type="hidden" name="claimStatus" value="審核中" />
		<p>
			<input type="submit" value="送出" class="btn" />
			  
	<form>
	</c:if>
	</div>
	<script>
		function setApplicationDate() {
			let now = new Date();
			let year = now.getFullYear();
			let month = ('0' + (now.getMonth() + 1)).slice(-2); // 月份從0開始，所以要加1
			let day = ('0' + now.getDate()).slice(-2);
			let date = year + '-' + month + '-' + day;
			let hiddenInput = document.getElementById('applicationDate');
			hiddenInput.value = date;
			console.log(document.getElementById('applicationDate').value);
		}
		setApplicationDate();
		
		$(document).ready(function() {
	        $('#searchButton').click(function() {
	            let policyNumber = $('#policyNumber').val();
	            console.log(policyNumber);

	            if (!policyNumber) {
	                alert('請輸入保單號碼');
	                return;
	            }
				let url="/GetClientTravel/"+policyNumber;
			
	            $.ajax({
	                url: url,
	                type: 'get',
	                success: function(response) {
	                	//response 是伺服器返回的資料，通常是 JSON 格式
	                	//檢查伺服器返回的資料是否存在。
	                    if (response && response != null) {
	  
	                        // 將回傳的資料填入對應的欄位
	                        $('input[name="policyName"]').val(response.insuranceProduct);
	                        $('input[name="clientName"]').val(response.username);
	                        $('input[name="policyNumber"]').val(response.insuranceNumber);
	                    }else {
	                        // 無資料，提示
	                        alert('查無此筆保單紀錄');
	                      
	                    }
	                },
	                error: function(xhr, status, error) {
	                 
	                	 if (xhr.status === 204) {
	                         // HTTP 204 無內容
	                         alert('查無此筆保單紀錄');
	                     } else {
	                         // 其他錯誤
	                        
	                         alert('查詢失敗，請稍後再試');
	                     }
	                }
	            });
	        });
	    });
	</script>
</body>
</html>
