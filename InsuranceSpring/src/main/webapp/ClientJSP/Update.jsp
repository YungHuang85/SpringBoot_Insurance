<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>修改理賠狀態</title>
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
    <!-- sweet alert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
	<h2>修改理賠狀態</h2>

	
		<p>
			輸入保單號碼 : <input type="text"  disabled name="policyNumber"
				value="${requestScope.bean.policyNumber}" required class="searchInput"
				 />
				<input type="hidden"  name="policyNumber" id="policyNumber"
				value="${requestScope.bean.policyNumber}" 
				 />
		</p>
		<p>
			保單名稱 : <input type="text" disabled name="policyName"
				value="${bean.policyName}"  class="searchInput"/>
				<input type="hidden"  name="policyName"
				value="${bean.policyName}" />
		</p>
		<p>
			姓名 : <input type="text" disabled name="clientName" value="${bean.clientName}"  class="searchInput"/>
			<input type="hidden" name="clientName" value="${bean.clientName}"  />
		</p>
		<!-- <p>
			申請書表單: <input type="file" name="applicationForm" />
		</p>
		<p>
			身分證 : <input type="file" name="idCopy" />
		</p>
		<p>
			帳戶影本 : <input type="file" name="accountCopy" />-->
		
		
		<input type="hidden" id="applicationDate" name="applicationDate"
			value="${bean.applicationDate}" />
		<p>
			理賠金額 : <input type="text" id="claimAmount" name="claimAmount" 
			class="searchInput" value="${bean.claimAmount}"/>			
		</p>
		<p>
			備註欄 : 
				 
			<textarea name="comment" class="searchInput" id="comment">${bean.comment.trim()}</textarea>
				
		</p>
		<input type="hidden" id="email" name="email" 
			class="searchInput" value="${bean.email}"/>
		<input type="hidden" id="reviewer" name="reviewer" 
			class="searchInput" value="${AdminBean.name}"/>
		
		<p>
			<label for="claimStatus">審核狀態:</label> 
			<select  name="claimStatus" class="searchInput"
				id="claimStatus">
				
				<option value="審核中" ${bean.claimStatus == '待審核' ? 'selected' : ''}>待審核</option>
				<option value="審核完畢，待理賠"
					${bean.claimStatus == '審核完畢，待理賠' ? 'selected' : ''}>審核完畢，待理賠</option>
				<option value="已理賠成功"
					${bean.claimStatus == '已理賠成功' ? 'selected' : ''}>已理賠成功</option>
				<option value="資格不符，退件"
					${bean.claimStatus == '資格不符，退件' ? 'selected' : ''}>資格不符，退件</option>
			  </select>
		<p>
			<input  id="submitBtn" type="button" class="btn" value="送出" />
		</p>
	<input type="hidden"  id="reviewDate" name="reviewDate"/>
	</div>
	<script>
	$(document).ready(function() {
		
		
		function sendEmail(){
			
			let userEmail = $('#email').val(); // 使用者的 Email
	        let claimStatus = $('#claimStatus').val();
	        let claimAmount = $('#claimAmount').val();
	        let comment = $('#comment').val();
	        
	        console.log("claimStatus"+claimStatus);
	        console.log("claimAmount"+claimAmount);
	        console.log("comment"+comment);
	        console.log("userEmail"+userEmail);
	        
	        
	        $.ajax({
	            url: '/send-mail',
	            method: 'POST',
	            data: {
	            	claimStatus: $('#claimStatus').val(),
	            	claimAmount: $('#claimAmount').val(),
	            	comment: $('#comment').val(),
	            	email: $('#email').val(),
	            	policyNumber: $('#policyNumber').val(),
	            	
	            },
	            success: function (response) {
	                console.log("寄信成功");
	            },
	            error: function () {
	                alert('Failed to send email.');
	            }
	        });
	 
		}
		
		function setReviewDate() {
			let now = new Date();
			let year = now.getFullYear();
			let month = ('0' + (now.getMonth() + 1)).slice(-2); // 月份從0開始，所以要加1
			let day = ('0' + now.getDate()).slice(-2);
			let date = year + '-' + month + '-' + day;
			let hiddenInput = document.getElementById('reviewDate');
			hiddenInput.value = date;
			console.log(document.getElementById('reviewDate').value);
		}
		setReviewDate();
		
		$('#submitBtn').click(function() {
	    	
	        const formData = {
	            policyNumber: $('input[name="policyNumber"]').val(),
	            claimStatus:  $('select[name="claimStatus"]').val(),
	            claimAmount: $('input[name="claimAmount"]').val(),
	            comment: $('textarea[name="comment"]').val(),
	            reviewer: $('#reviewer').val()
	        };
	        const claimStatus =  $('select[name="claimStatus"]').val();
	        console.log('選中的狀態:', claimStatus);
	        console.log('formData:', formData);
	        console.log($('#reviewer').val());
	        $.ajax({
	            url: '/UpdateClaims',
	            type: 'put',
	            contentType: 'application/json', //前端送給後端的資料型態
	            data: JSON.stringify(formData),
	            success: function(response) {
	            	//修改成功就寄信
	            	sendEmail();
	            	
	            	 Swal.fire({
	 	                title: '成功!',
	 	                text: '資料已成功更新',
	 	                icon: 'success',
	 	            }).then((result) => {
	 	                if (result.isConfirmed) {
	 	                    // 用戶按下確認按鈕後跳轉到主頁
	 	                    window.location.href = '/insuranceClaims';
	 	                }
	 	            });
	               
	                
	            },
	            error: function(xhr, status, error) {
	                console.error('更新失敗:', error);
	                Swal.fire({
		                title: '失敗!',
		                text: '資料更新失敗',
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
