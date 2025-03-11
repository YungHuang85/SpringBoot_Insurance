<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.util.List,insurance.main.model.BonusProductBean" %>

<%! @SuppressWarnings("unchecked") %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
	<jsp:include page="sidebar.jsp" /> 
    <meta charset="UTF-8">
    <title>紅利商品管理</title>
    <link rel="stylesheet" href="//cdn.datatables.net/2.1.8/css/dataTables.dataTables.min.css">
    <!-- 引入 jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- 引入 Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- 引入 Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script> 
    <!-- 引入 SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <!-- 引入 SweetAlert2 JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- 引入 DataTables JS -->
    <script src="//cdn.datatables.net/2.1.8/js/dataTables.min.js"></script> 
    <!-- 引入 Font Awesome (用於按鈕圖示) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- 引入 Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
    <style>
    
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #ffffff;
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
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        
        th {
            background-color: Black;
            color: white;
        }
        
        .action-button {
            color: white; /* 字體顏色 */
            border: none; /* 無邊框 */
            padding: 5px 10px; /* 按鈕內邊距 */
            border-radius: 5px; /* 圓角 */
            cursor: pointer; /* 鼠標指針變為手形 */
        }
        
        .edit-button {
            background-color: #4CAF50; /* 修改按鈕藍色 */
        }
        
        .delete-button {
            background-color: #dc3545; /* 刪除按鈕紅色 */
        }
        
        .edit-button:hover {
            background-color: #45a049; /* 修改按鈕 hover 顏色 (深藍色) */
        }
        
        .delete-button:hover {
            background-color: #c82333; /* 刪除按鈕 hover 顏色 (深紅色) */
        }
        
        .product-image {
            width: 50px; /* 設定圖片寬度 */
            height: auto; /* 自動調整高度 */
        }

        /* 移除 SweetAlert2 標題區域的下邊框 */
        .swal2-title {
            border-bottom: none !important;
        }

        /* 可選：若要去掉彈框邊框的陰影或線條 */
        .swal2-popup {
            box-shadow: none !important;
            border: none !important;
        }
        
        .product-image {
            width: 100px;  /* 設定圖片寬度 */
            height: auto;  /* 高度自動調整 */
        }
        
        .nav-link {
    		color: black !important; /* 設定字體顏色為黑色 */
		}
		
		/* 圖表容器樣式 */
        #chartContainer {
            display: none;
            margin-top: 30px;
        }
        
        #sortByCountBtn {
    		background-color: #ADD8E6; /* 淡藍色 */
    		border: none; /* 去掉邊框 */
		}

		#sortByIdBtn {
    		background-color: #D0D0D0; /* 淡綠色 */
    		border: none; /* 去掉邊框 */
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
          <a class="nav-link category-link" href="${pageContext.request.contextPath}/bonusproduct/filter?category=便利生活">便利生活</a>
        </li>
        <li class="nav-item">
          <a class="nav-link category-link" href="${pageContext.request.contextPath}/bonusproduct/filter?category=星巴克">星巴克</a>
        </li>
        <li class="nav-item">
          <a class="nav-link category-link" href="${pageContext.request.contextPath}/bonusproduct/filter?category=旅遊交通">旅遊交通</a>
        </li>
      </ul>
      <!--  
      <form class="d-flex me-2" role="search" action="${pageContext.request.contextPath}/bonusproduct/search" method="get">
          <input class="form-control me-2" type="search" name="keyword" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
      -->

      <!-- 新增紅利商品按鈕 -->
      <div class="ms-auto"> <!-- 使用 Bootstrap 的 ms-auto 將按鈕推到右側 -->
          <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addProductModal">新增紅利商品</button>
      </div>

    </div>
  </div>
</nav>

<div class="container mt-3"> <!-- 添加 margin-top -->
    
    <table id="bonusProductTable">
        <thead>
            <tr>
                <th>商品編號</th>
                <th>商品名稱</th>
                <th>所需點數</th>
                <th>兌換次數</th>
                <th>商品圖片</th> <!-- 新增圖片欄位 -->
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<BonusProductBean> products = (List<BonusProductBean>) request.getAttribute("products");
                if (products != null && !products.isEmpty()) {
                    for (BonusProductBean product : products) {
                        String productNo = String.valueOf(product.getProductno());
                        String productName = product.getProductname();
                        int productCost = product.getCost();
                        int productCount = product.getCount();
                        String productImage = product.getProductimage(); // 假設這裡有獲取圖片 URL 的方法
            %>
                <tr>
                    <td><%= productNo %></td>
                    <td><%= productName %></td>
                    <td><%= productCost %></td>
                    <td><%= productCount %></td>
                    <td><img src="<%= productImage %>" alt="<%= productName %>" class="product-image"></td> <!-- 顯示圖片 -->
                    <td>
                        <!-- 修改按鈕 -->
                        <button type="button" class="action-button edit-button btn-sm" data-toggle="modal" data-target="#updateProductModal" 
                            data-productno="<%= productNo %>" data-productname="<%= productName %>" data-productcost="<%= productCost %>" 
                            data-productcount="<%= productCount %>" data-productimage="<%= productImage %>">
                            <i class="fas fa-edit"></i> 修改商品
                        </button>

                        <!-- 刪除按鈕 -->
                        <button type="button" class="action-button delete-button btn-sm"
                                onclick="confirmDelete('<%= product.getProductno() %>', '<%= product.getProductname() %>')">
                            <i class="fas fa-trash-alt"></i> 刪除商品
                        </button>

                        <!-- 隱藏的表單用於刪除請求 -->
                        <form id="deleteForm<%= productNo %>" method="post"
                              action="${pageContext.request.contextPath}/bonusproduct/delete">
                            <input type="hidden" name="productno" value="<%= productNo %>" />
                        </form>
                    </td>
                </tr>
            <% 
                    } 
                } else { 
            %> 
                <tr><td colspan="5">目前沒有任何紅利商品資料。</td></tr> 
            <% 
                } 
            %> 
        </tbody>
    </table>


<!-- 圖表容器 -->
    <div id="chartContainer">
        <canvas id="productChart"></canvas>
    </div>
    
</div>

<!-- 新增商品的模態框 -->
<div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addProductModalLabel">新增紅利商品資料</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 新增商品表單 -->
                <form method='post' action='${pageContext.request.contextPath}/bonusproduct/insert' enctype='multipart/form-data'>
                    <!-- 商品編號 -->
                    <div class="form-group">
                        <label for="productNo">紅利商品編號</label>
                        <input type="text" name="productno" id="productNo" class="form-control" required />
                    </div>

                    <!-- 商品名稱 -->
                    <div class="form-group">
                        <label for="productName">紅利商品名稱</label>
                        <input type="text" name="productname" id="productName" class="form-control" required />
                    </div>

                    <!-- 需要點數 -->
                    <div class="form-group">
                        <label for="cost">需要點數</label>
                        <input type="text" name="cost" id="cost" class="form-control" required />
                    </div>

                    <!-- 分類選擇 -->
                    <div class="form-group">
                        <label for="category">選擇分類</label>
                        <select name="category" id="category" class="form-control" required>
        				<option value="" disabled selected>請選擇分類</option>
        				<option value="便利生活">便利生活</option>
        				<option value="星巴克">星巴克</option>
        				<option value="旅遊交通">旅遊交通</option>
    				</select>
                    </div>

                    <!-- 商品圖片 -->
                    <div class="form-group">
                        <label for="productImage">商品圖片</label>
                        <input type="file" name="bonusproductimage" class="form-control-file" accept="image/*" required />
                    </div>

                    <!-- 提交按鈕 -->
                    <button type="submit" class="btn btn-primary">新增商品</button>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- 修改商品的模態框 -->
<div class="modal fade" id="updateProductModal" tabindex="-1" role="dialog" aria-labelledby="updateProductModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateProductModalLabel">修改紅利商品資料</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- 修改商品表單 -->
                <form method='post' action='${pageContext.request.contextPath}/bonusproduct/update' enctype='multipart/form-data'>
                    <!-- 商品編號 (只讀) -->
                    <div class="form-group">
                        <label for="updateProductNo">紅利商品編號</label>
                        <input type="text" name="productno" id="updateProductNo" class="form-control" readonly />
                    </div>

                    <!-- 商品名稱 -->
                    <div class="form-group">
                        <label for="updateProductName">紅利商品名稱</label>
                        <input type="text" name="productname" id="updateProductName" class="form-control" required />
                    </div>

                    <!-- 需要點數 -->
                    <div class="form-group">
                        <label for="updateCost">需要點數</label>
                        <input type="text" name="cost" id="updateCost" class="form-control" required />
                    </div>

                    <!-- 兌換次數 (只讀) -->
                    <div class="form-group">
                        <label for="updateCount">兌換次數</label>
                        <input type="text" name="count" id="updateCount" class="form-control" readonly />
                    </div>

                    <!-- 分類選擇 -->
                    <div class="form-group">
                        <label for="updateCategory">選擇分類</label>
                        <select name="category" id="category" class="form-control" required>
        				<option value="" disabled selected>請選擇分類</option>
        				<option value="便利生活">便利生活</option>
        				<option value="星巴克">星巴克</option>
        				<option value="旅遊交通">旅遊交通</option>
    				</select>
                    </div>

                    <!-- 商品圖片 -->
                    <div class="form-group">
                        <label for="updateProductImage">商品圖片</label>
                        <input type="file" name="bonusproductimage" class="form-control-file" accept="image/*" required/>
                    </div>

                    <!-- 提交按鈕 -->
                    <button type="submit" class="btn btn-primary">確定修改</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 圖表容器 -->
    <div id="chartContainer">
        <canvas id="productChart"></canvas>
    </div>
</div>

<!-- 排序按鈕 -->
<button id="sortByCountBtn" class="btn btn-primary">按兌換次數排序</button>
<button id="sortByIdBtn" class="btn btn-secondary">按商品ID排序</button>

<script>
    // 使用 jQuery 來處理填充修改資料
    $('#updateProductModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // 按鈕觸發的事件
        var productNo = button.data('productno');
        var productName = button.data('productname');
        var productCost = button.data('productcost');
        var productCount = button.data('productcount');
        var productImage = button.data('productimage');
        
        var modal = $(this);
        modal.find('#updateProductNo').val(productNo);
        modal.find('#updateProductName').val(productName);
        modal.find('#updateCost').val(productCost);
        modal.find('#updateCount').val(productCount); // 填充 count 欄位
        modal.find('#updateCategory').val(productImage);
    });

    function confirmDelete(productNo, productName) {
        Swal.fire({
            title: `確定刪除商品 ${productName}？`,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: '刪除',
            cancelButtonText: '取消'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById("deleteForm" + productNo).submit();
            }
        });
    }
    
 	// 初始化 DataTable
    $(document).ready(function() {
        $('#bonusProductTable').DataTable({
            "paging": true,  // 開啟分頁功能
            "pageLength": 10,  // 每頁顯示10筆資料
            "lengthMenu": [10, 25, 50, 100],  // 允許選擇每頁顯示筆數
            "language": {
                "search": "搜尋:",  // 修改搜尋框的文字
                "lengthMenu": "每頁顯示 _MENU_ 筆資料",  // 每頁顯示選項
                "info": "顯示第 _START_ 至 _END_ 筆資料，共 _TOTAL_ 筆",  // 顯示總數量的文字
                "infoEmpty": "顯示第 0 至 0 筆資料，共 0 筆",  // 當沒有資料時顯示的文字
                "infoFiltered": "(從 _MAX_ 筆資料中過濾)",  // 過濾顯示的資料文字
                "paginate": {
                    "next": "下一頁",  // 下一頁
                    "previous": "上一頁"  // 上一頁
                }
            }
        });
    });

    //chart.js 統計圖表
    document.addEventListener('DOMContentLoaded', function() {
        // 初始資料
        let originalData = [];
        let chartInstance;

        // 發送 GET 請求到 API
        fetch('http://localhost:8081/api/bonusproduct/products')
            .then(response => {
                if (!response.ok) {
                    throw new Error('網路錯誤，無法取得資料');
                }
                return response.json(); // 解析 JSON 資料
            })
            .then(data => {
                // 處理資料，準備圖表的資料
                const productNames = [];
                const exchangeCounts = [];

                // 存儲原始資料，以便後續使用
                originalData = data;

                // 解析原始資料
                data.forEach(function(product) {
                    productNames.push(product.productname);
                    exchangeCounts.push(product.count);
                });

                // 創建初始圖表
                chartInstance = createChart(productNames, exchangeCounts);

                // 顯示圖表容器
                document.getElementById('chartContainer').style.display = 'block';

                // 排序按鈕事件 - 按兌換次數排序
                document.getElementById('sortByCountBtn').addEventListener('click', function() {
                    // 按兌換次數對資料進行排序
                    const sortedData = originalData.sort((a, b) => b.count - a.count);
                    
                    // 更新圖表
                    const sortedNames = sortedData.map(item => item.productname);
                    const sortedCounts = sortedData.map(item => item.count);

                    chartInstance.data.labels = sortedNames;
                    chartInstance.data.datasets[0].data = sortedCounts;
                    chartInstance.update(); // 更新圖表
                });

                // 排序按鈕事件 - 按商品ID排序
                document.getElementById('sortByIdBtn').addEventListener('click', function() {
                    // 按商品ID對資料進行排序
                    const sortedDataById = originalData.sort((a, b) => a.productno - b.productno);
                    
                    // 更新圖表
                    const sortedNamesById = sortedDataById.map(item => item.productname);
                    const sortedCountsById = sortedDataById.map(item => item.count);

                    chartInstance.data.labels = sortedNamesById;
                    chartInstance.data.datasets[0].data = sortedCountsById;
                    chartInstance.update(); // 更新圖表
                });

            })
            .catch(error => {
                console.error('API 請求錯誤:', error);
                Swal.fire('錯誤', '無法載入資料，請稍後再試', 'error');
            });

        // 創建圖表的函數
        function createChart(productNames, exchangeCounts) {
            var ctx = document.getElementById('productChart').getContext('2d');
            return new Chart(ctx, {
                type: 'bar', // 設定圖表為條形圖
                data: {
                    labels: productNames, // X軸數據：商品名稱
                    datasets: [{
                        label: '兌換次數', // Y軸標籤
                        data: exchangeCounts, // Y軸數據：兌換次數
                        backgroundColor: 'rgba(75, 192, 192, 0.2)', // 設定條形圖的顏色
                        borderColor: 'rgba(75, 192, 192, 1)', // 設定條形圖邊界顏色
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true, // 自適應
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: '商品名稱' // X軸標題
                            },
                            ticks: {
                                autoSkip: true, // 自動跳過長的標籤
                                maxRotation: 45, // 旋轉 X 軸標籤
                                minRotation: 45
                            }
                        },
                        y: {
                            title: {
                                display: true,
                                text: '兌換次數' // Y軸標題
                            },
                            beginAtZero: true // Y軸從0開始
                        }
                    }
                }
            });
        }
    });

</script>

</body>
</html>
