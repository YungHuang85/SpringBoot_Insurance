<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="sidebar.jsp" /> 
<meta charset="UTF-8">
<title>Chart.js 統計圖表</title>
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
    width: 50vw;
    margin: auto;
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

.chart-title {
    text-align: center;
    margin-bottom: 30px; /* 調整標題與圖表的間距 */
}

</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"> <!-- 引入 Bootstrap -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script> <!-- 引入 Bootstrap JS -->
</head>
<body>
<ul class="nav nav-tabs custom-tabs">
  <li class="nav-item">
    <a class="nav-link" aria-current="page" href="/insuranceClaims">理賠進度查詢</a>
  </li>
  <li class="nav-item">
    <a class="nav-link active"  href="/ClientJSP/Chart.jsp">統計圖表</a>
  </li>

</ul>

 <br>

<h2 class="chart-title">理賠人員處理案件數統計</h2>
<div class="wrapper">
<canvas id="reviewerChart"></canvas>
</div>

<script>

$(document).ready(function () {
	
	$.ajax({
        url: '/GetInsuranceClaimAll',
        type: "GET",
        dataType: "json",
        success: function (data) {
            let reviewers = ["楊子毅", "許侑宸", "羅方翎", "黃翊永", "侯薇榕", "許傳政"];
            let claimCounts = {};

            reviewers.forEach(name => {
                claimCounts[name] = 0;
            });

            data.forEach(item => {
                if (item.claimStatus !== "待審核" && claimCounts.hasOwnProperty(item.reviewer)) {
                    claimCounts[item.reviewer]++;
                }
            });

            let chartLabels = reviewers;
            let chartData = reviewers.map(name => claimCounts[name]);

            let ctx = document.getElementById("reviewerChart").getContext("2d");
            $("#reviewerChart").attr("width", 250).attr("height", 350);

            new Chart(ctx, {
                type: "bar",
                data: {
                    labels: chartLabels,
                    datasets: [{
                        label: "已審核案件數",
                        data: chartData,
                        backgroundColor: "rgba(54, 162, 235, 0.6)",
                        borderColor: "black",
                        borderWidth: 2,
                        barThickness: 50
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            labels: {
                                font: {
                                    size: 16,  // 增加圖例文字大小
                                    weight: 'bold'  // 加粗文字
                                },
                                padding: 20  // 增加圖例的間距
                            }
                        }
                    },
                    layout: {
                        padding: {
                            right: 10,
                            bottom: 30,
                            left: 10,
                           // 為較大的標籤留出空間
                        }
                    },
                    scales: {
                        x: {
                            ticks: {
                                font: {
                                    size: 20,// 將 X 軸文字大小從 12 改為 16
                                    weight: 'bold' // 加粗文字
                                },
                                maxRotation: 0,
                                minRotation: 0,
                                autoSkip: false,
                                padding: 10 // 增加文字與軸的間距
                            }
                        },
                        y: {
                            beginAtZero: true,
                            ticks: {
                                padding: 5
                            }
                        }
                    }
                }
            });
        },
        error: function (xhr, status, error) {
            console.error("API 請求失敗: ", error);
        }
    });
});

</script>

</body>
</html>
