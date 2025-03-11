<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="insurance.main.model.BonusProductBean" %>

<%! @SuppressWarnings("unchecked") %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>修改紅利商品資料</title>
    
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

        input[type="text"], select {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="file"] {
            margin-bottom: 10px;
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

        .readonly {
            background-color: #e9ecef; /* 灰色背景 */
            border: 1px solid #ced4da; /* 邊框 */
        }

        /* 圖片預覽樣式 */
        .image-preview {
            max-width: 100%;
            height: auto;
            margin-top: 10px;
        }
    </style>

    <script>
        function previewImage(event) {
            const imagePreview = document.getElementById('imagePreview');
            imagePreview.src = URL.createObjectURL(event.target.files[0]);
            imagePreview.style.display = 'block';
        }
    </script>
</head>
<body>
    <h2>修改紅利商品資料</h2>
    <form method="post" action="${pageContext.request.contextPath}/bonusproduct/update" enctype="multipart/form-data">
        <!-- 顯示產品編號 -->
        <label for="productno">紅利商品編號:</label>
        <input type="text" name="productno" value="${bonusProduct.productno}" class="readonly" readonly /><p>

        輸入紅利商品 : <input type="text" name="productname" value="${bonusProduct.productname}" required /><p>

        輸入需要點數 : <input type="text" name="cost" value="${bonusProduct.cost}" required pattern="\d+" title="請輸入有效的點數。" /><p>

        <!-- 新增分類下拉選單 -->
        <label for="category">選擇分類:</label>
        <select name="category" required>
            <option value="">-- 請選擇 --</option>
            <option value="便利生活">便利生活</option>
            <option value="星巴克">星巴克</option>
            <option value="旅遊交通">旅遊交通</option>
        </select><p>

        輸入產品圖片 : 
        <input type="file" name="bonusproductimage" accept="image/*" onchange="previewImage(event)" required /><p>

        <input type="submit" value="確定" />
    </form>
</body>
</html>
