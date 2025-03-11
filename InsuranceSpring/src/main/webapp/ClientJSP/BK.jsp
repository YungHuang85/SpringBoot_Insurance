<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.util.List,insurance.main.model.BonusProductBean" %>

<%! @SuppressWarnings("unchecked") %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
    <meta charset="UTF-8">
    <title>紅利商品管理</title>
    <link rel="stylesheet" href="//cdn.datatables.net/2.1.8/css/dataTables.dataTables.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- 引入 Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css"> <!-- 引入 SweetAlert2 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//cdn.datatables.net/2.1.8/js/dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- 引入 SweetAlert2 JS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1200px;
            margin: auto;
        }
        h2 {
            color: #333;
            border-bottom: 2px solid #007BFF;
            padding-bottom: 10px;
            text-align: center;
        }
        .card {
            margin-bottom: 20px; /* 卡片之間的間距 */
            height: auto; /* 自動調整卡片高度 */
        }
        .card-title {
            font-size: 1rem; /* 縮小商品名稱字體 */
        }
        .card-text {
            font-size: 0.9rem; /* 縮小所需點數字體 */
        }
        .point-img {
            width: 30px; /* 設定圖片寬度 */
            height: auto; /* 自動調整高度 */
            margin-right: 5px; /* 圖片與數字之間的間距 */
        }
        .point-text {
            font-size: 1.2rem; /* 放大數字字體 */
            margin-right: 10px; /* 點數與按鈕之間的間距 */
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/bonusproduct/BonusMall">紅利商城管理</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath}/bonusproduct/filter?category=全部">全部</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/bonusproduct/filter?category=便利生活">便利生活</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/bonusproduct/filter?category=星巴克">星巴克</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/bonusproduct/filter?category=旅遊交通">旅遊交通</a>
        </li>
      </ul>
      <form class="d-flex me-2" role="search" action="${pageContext.request.contextPath}/bonusproduct/search" method="get">
          <input class="form-control me-2" type="search" name="keyword" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success" type="submit">Search</button>
      </form>

      <!-- 新增紅利商品按鈕 -->
      <div class="ms-auto"> <!-- 使用 Bootstrap 的 ms-auto 將按鈕推到右側 -->
          <a href="${pageContext.request.contextPath}/bonusproduct/add" class="btn btn-success">新增紅利商品</a>
      </div>

    </div>
  </div>
</nav>

<div class="container mt-3"> <!-- 添加 margin-top -->
    <!-- 商品顯示區域 -->
    <div class="row">
        <% 
            List<BonusProductBean> products = (List<BonusProductBean>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
                for (BonusProductBean product : products) {
        %>
                <div class="col-md-3"> <!-- 每行顯示四個卡片 -->
                    <div class="card">
                        <img src="<%= product.getProductimage() %>" class="card-img-top" alt="<%= product.getProductname() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= product.getProductname() %></h5>

                            <!-- 替換需要點數文字為圖片和數字 -->
                            <div style="display: flex; align-items: center;">
                                <img src="${pageContext.request.contextPath}/BonusMallPic/point.jpg" alt="" class="point-img"> 
                                <span class="point-text"><%= product.getCost() %> 點</span> <!-- 顯示點數 -->
                            </div>

                            <!-- 修改和刪除按鈕並排顯示 -->
                            <div style="display: flex; justify-content: space-between; margin-top: 10px;"> <!-- 增加上方間距 -->
                                <!-- 修改按鈕 -->
                                <a href="${pageContext.request.contextPath}/bonusproduct/update?productno=<%= product.getProductno() %>" class="btn btn-warning">修改商品</a>

                                <!-- 刪除按鈕 -->
                                <button type ="button"
                                        class ="btn btn-danger"
                                        onclick ="confirmDelete('<%= product.getProductno() %>', '<%= product.getProductname() %>')">刪除商品
                                </button>

                                <!-- 隱藏的表單用於刪除請求 -->
                                <form id ="deleteForm<%= product.getProductno() %>" method ="post"
                                      action ="${pageContext.request.contextPath}/bonusproduct/delete">
                                    <input type ="hidden"
                                           name ="productno"
                                           value ="<%= product.getProductno() %>" />
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
                <% 
                } 
            } else { 
                %> 
                <div class ="col-12"> 
                    <div class ="alert alert-warning"
                         role ="alert">目前沒有任何紅利商品資料。</div> 
                </div> 
                <% 
            } 
        %> 
    </div>

</div>

<script>
// 確認刪除商品
function confirmDelete(productNo, productName) {
    Swal.fire({
        title: "你要刪除商品「" + productName + "」嗎？",
        icon: "question",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "是的",
        cancelButtonText: "取消"
    }).then((result) => {
        if (result.isConfirmed) {
            document.getElementById("deleteForm" + productNo).submit(); // 提交表單以執行刪除
        } else {
            Swal.fire("已取消");
        }
    });
}
</script>

<!-- 引入 Bootstrap 和 jQuery 的 JS -->
<script src="//cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="//stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>

</body>
</html>
