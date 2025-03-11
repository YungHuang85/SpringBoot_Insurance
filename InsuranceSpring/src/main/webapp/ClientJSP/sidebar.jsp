<%@ page contentType="text/html;charset=UTF-8" language="java"%> 
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title></title>
	<style>
        /* 全域樣式 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }

        /* 頂部區塊樣式 */
        .header-container {
		    background-image: url('${pageContext.request.contextPath}/picture/grass.jpg');
		    background-size: cover;  /* 確保圖片覆蓋整個區域 */
		    background-position: center;
		    padding: 70px;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		}

        /* 左側的歡迎文字樣式 */
        .c1 {
            color: black;
            font-weight: bold;

            margin: 0;
        }

        /* 右側的登入管理者區塊樣式 */
        .header-container .username {
            font-size: 20px;
            color: black;
            margin-right: 15px;
            font-weight: bold;
        }

        /* 登出按鈕樣式 */
        .logout-link {
            color: #ffffff;
            background-color: black;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 20px;
            transition: background-color 0.3s, color 0.3s;
        }

        .header-container .logout-link:hover {
            background-color: #ffffff;
            color: #4285f4;
            border: 1px solid #4285f4;
            font-size: 22px;

        }

        /* 導覽列樣式 */
        .navbar {
            padding: 5px 20px !important;
            display: flex;
            justify-content: center;
            background-color: #8eaa9b;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
        }

        .navbar ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 20px;
        }

        .navbar ul li {
            display: inline;
        }

        .navbar ul li a {
            color: white;
            text-decoration: none;
            font-size: 22px;
            padding: 5px 1px;
            border-radius: 3px;
            transition: background-color 0.3s;
        }

        .navbar ul li a:hover {
            background-color: #35c34d;
        }

        /* 主內容樣式 */
        .content {
            /*margin-top: 10px;*/
            /*padding: 5px;*/
            background-color: white;
            color: black;
            box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
            font-weight: bold;
        }

        .sp1 {
            font-size: 40px;
        }

        .sp2 {
            font-size: 20px;
        }
    </style>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<script src="script.js"></script>
		
	<link rel="stylesheet"
		href=" https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
	
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
		rel="stylesheet">
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-p34f1UUtsS3wqzfto5wAAmdvj+osOnFyQFpp4Ua3gs/ZVWx6oOypYoCJhGGScy+8"
		crossorigin="anonymous"></script>
	</head>
	
	<body>
		<div class="header-container">
			<div class="c1">
				<span class="sp1">線上投保管理系統</span>
	            <br>
	            <span class="sp2">歡迎登入!請選擇功能進行操作。<span>
			</div>
			<div class="username">
				<span>登入管理者：${AdminBean.name}</span> <span style="margin: 0 10px;">|</span>
				<a
					href="${pageContext.request.contextPath}/Logout"
					class="logout-link">登出</a>
			</div>
		</div>
	
		<!-- 導覽列 -->
		
		<div class="navbar">
			<ul>
				<li><a
					href="${pageContext.request.contextPath}/list">
						<i class="fa-solid fa-user-tie"></i> 管理者
				</a></li>
			<li><a
				href="${pageContext.request.contextPath}/CrudMembers?action=selectAll">
					<i class="fa-solid fa-users-line"></i> 會員列表
			</a></li>
			<li><a
				href="http://localhost:8081/clients"> <i
					class="fa-solid fa-people-roof"></i> 保單管理
			</a></li>
			<li><a href="http://localhost:8081/productlistBE/GetAllProductlist">
					<i class="fa-solid fa-list-check"></i> 商品管理
			</a></li>
			<li><a href="http://localhost:8081/insuranceClaims">
					<i class="fa-solid fa-person-burst"></i> 理賠管理
			</a></li>
			<li><a href="http://localhost:8081/bonusproduct/BonusMall">
					<i class="fa-solid fa-gift"></i> 兌換專區
			</a></li>
			<li><a href="http://localhost:8081/QA/page">
					<i class="fa-solid fa-comments"></i> 常見問答
				</a></li>
				</a></li>
				<li><a
					href="http://localhost:8081/comments">
						<i class="fa-solid fa-comments"></i> 討論區
				</a></li>
			</ul>
		</div>
		
	</body>
</html>
