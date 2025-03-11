<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="insurance.main.model.BonusProductBean" %>

<%! @SuppressWarnings("unchecked") %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>新增紅利商品資料</title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            margin: 0 auto;
        }

        input[type="text"], input[type="file"], select {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        #productMsg {
            display: block;
            margin: 10px 0;
            font-size: 14px;
            color: #d9534f; /* 初始顏色為紅色 */
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #0056b3; /* 提交按鈕懸停顏色 */
        }

        /* 提示文字樣式變化 */
        #productMsg.ok {
            color: #5cb85c; /* 成功提示顏色 */
        }
    </style>

    <!-- 引入jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
    
</head>
<body>
    <h2>新增紅利商品資料</h2>
    <form method="post" action="${pageContext.request.contextPath}/bonusproduct/insert" enctype="multipart/form-data">
        輸入紅利商品編號 : <input type="text" name="productno" required /><span id="productMsg"></span><p>
        
        輸入紅利商品 : <input type="text" name="productname" required /><p>

        輸入需要點數 : <input type="text" name="cost" required /><p>

        <!-- 新增分類下拉選單 -->
        <label for="category">選擇分類:</label>
        <select name="category" required>
            <option value="">-- 請選擇 --</option>
            <option value="便利生活">便利生活</option>
            <option value="星巴克">星巴克</option>
            <option value="旅遊交通">旅遊交通</option>
        </select><p>

        <!-- 新增圖片上傳字段 -->
        輸入產品圖片 : <input type="file" name="bonusproductimage" accept="image/*" required /><p>

        <input type="submit" value="確定" />
    </form>
</body>
</html>
