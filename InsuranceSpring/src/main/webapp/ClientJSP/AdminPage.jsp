<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }

        .admin-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
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
            margin-right: 20px;
        }

        .admin-info {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .admin-name {
            font-size: 22px;
            font-weight: bold;
            color: #003366;
            margin-bottom: 4px;
            display: flex;
            align-items: center;
        }

        .admin-responsibility-inline {
            font-size: 18px;
            margin-left: 10px;
            color: #666;
        }

        .admin-responsibility {
            font-size: 16px;
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
    </style>
</head>

<body>
<!-- 左側功能列表 -->
	<jsp:include page="../ClientJSP/sidebar.jsp" />
 <h2 style="text-align: left; color: #black; margin:30px;">管理者列表 & 負責模組</h2>

	<div class="admin-container">
        <!-- 管理員卡片 -->
        <div class="admin-card">
            <img src="${pageContext.request.contextPath}/picture/admin017.jpg" alt="Admin Avatar" class="admin-avatar">
            <div class="admin-info">
                <div class="admin-name">黃翊永<span class="admin-responsibility-inline">組長</span></div>
                <a href="http://localhost:8081/clients" class="admin-link">保單管理</a>
              
            </div>
        </div>

        <div class="admin-card">
            <img src="${pageContext.request.contextPath}/picture/admin01.jpg" alt="Admin Avatar" class="admin-avatar">
            <div class="admin-info">
                <div class="admin-name">楊子毅<span class="admin-responsibility-inline">副組長</span></div>
                <a href="http://localhost:8081/productlistBE/GetAllProductlist" class="admin-link">投保種類</a>
                 
            </div>
        </div>
        
        <div class="admin-card">
            <img src="${pageContext.request.contextPath}/picture/admin011.jpg" alt="Admin Avatar" class="admin-avatar">
            <div class="admin-info">
                <div class="admin-name">羅方翎</div>
                <div class="admin-responsibility"></div>
                <div class="admin-responsibility"></div>
                <a href="${pageContext.request.contextPath}/CrudMembers?action=selectAll" class="admin-link">會員列表</a>
            </div>
        </div>
        
        <div class="admin-card">
            <img src="${pageContext.request.contextPath}/picture/admin024.jpg" alt="Admin Avatar" class="admin-avatar">
            <div class="admin-info">
                <div class="admin-name">侯薇榕</div>
                <div class="admin-responsibility"></div>
                <a href="http://localhost:8081/insuranceClaims" class="admin-link">理賠管理</a>
            </div>
        </div>
        
        <div class="admin-card">
            <img src="${pageContext.request.contextPath}/picture/admin028.jpg" alt="Admin Avatar" class="admin-avatar">
            <div class="admin-info">
                <div class="admin-name">許傳政</div>
                <div class="admin-responsibility"></div>
                <a href="http://localhost:8081/bonusproduct/BonusMall" class="admin-link">紅利兌換管理</a>
            </div>
        </div>
        
        <div class="admin-card">
            <img src="${pageContext.request.contextPath}/picture/admin10.jpg" alt="Admin Avatar" class="admin-avatar">
            <div class="admin-info">
                <div class="admin-name">許侑宸</div>
                <div class="admin-responsibility"></div>
                <a href="http://localhost:8081/QA/page" class="admin-link">常見問答</a>
                <a href="http://localhost:8081/comments/page" class="admin-link">討論區</a>
            </div>
        </div>
        
    </div>
</body>

</html>
