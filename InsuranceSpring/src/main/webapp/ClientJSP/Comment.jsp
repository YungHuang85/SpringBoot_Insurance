<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
<jsp:include page="sidebar.jsp" />
    <title>評論管理</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
 <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Custom button colors */
        .btn-primary {
    background-color: #29293f !important;
    border-color: #29293f !important;
    color: white !important;
}

.btn-primary:hover {
    background-color: #47475f !important;
    border-color: #47475f !important;
}

/* Secondary button (search) */
.btn-search {
    background-color: #33393f !important;
    border-color: #33393f !important;
    color: white !important;
}

.btn-search:hover {
    background-color: #5a6268 !important;
    border-color: #5a6268 !important;
}

/* Delete button and modal close button */
.btn-danger, 
.btn-secondary[data-bs-dismiss="modal"] {
    background-color: darkred !important;
    border-color: darkred !important;
    color: white !important;
}

.btn-danger:hover, 
.btn-secondary[data-bs-dismiss="modal"]:hover {
    background-color: #a71d2a !important;
    border-color: #a71d2a !important;
}

/* Other secondary buttons */
.btn-secondary:not([data-bs-dismiss="modal"]) {
    background-color: #33393f !important;
    border-color: #33393f !important;
    color: white !important;
}

.btn-secondary:not([data-bs-dismiss="modal"]):hover {
    background-color: #5a6268 !important;
    border-color: #5a6268 !important;
}

/* Background colors */
body {
    background-color: rgba(246, 253, 248) !important;
}

.table {
    background-color: white !important;
}

/* Modal style updates */
.modal-content {
    background-color: white !important;
}

/* Success button (for save) */
.btn-success {
    background-color: #29293f !important;
    border-color: #29293f !important;
    color: white !important;
}

.btn-success:hover {
    background-color: #47475f !important;
    border-color: #47475f !important;
}
    </style>
</head>
<body>
    <!-- Rest of your JSP code remains the same -->
    <div class="container my-5">
        <!-- Update the search button class -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="d-flex align-items-center">
                <h1 class="me-3">評論管理</h1>
                <div class="input-group" style="width: 300px;">
                    <input type="text" id="searchKeyword" class="form-control" placeholder="搜尋主題、內容或分類...">
                    <button class="btn btn-search" type="button" onclick="searchComments()">搜尋</button>
                </div>
                <div id="searchError" class="text-danger mb-3" style="display: none;"></div>
            </div>
    
    <!-- 修改這裡：新增按鈕群組 -->
    <div class="d-flex gap-2"> <!-- gap-2 提供按鈕之間的間距 -->
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newCommentModal">
            新增評論
        </button>
       <button type="button" class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/comments/reply'">
            留言板
        </button>
    </div>
</div>

        
        <!-- Comments Table -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>主題</th>
                    <th>內容</th>
                    <th>分類</th>
                    <th>使用者</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody id="commentsTable">
                <c:forEach items="${comments}" var="comment">
   <tr>
                        <td>${comment.commentid}</td>
                        <td class="editable-cell">
                            <div class="view-mode">${comment.topic}</div>
                            <div class="edit-mode d-none">
                                <input type="text" class="form-control" value="${comment.topic}">
                            </div>
                        </td>
                        <td class="editable-cell">
                            <div class="view-mode">${comment.content}</div>
                            <div class="edit-mode d-none">
                                <textarea class="form-control">${comment.content}</textarea>
                            </div>
                        </td>
                        <td class="editable-cell">
                            <div class="view-mode">${comment.category}</div>
                            <div class="edit-mode d-none">
                                <select class="form-control">
                                    <option value="保單設計" ${comment.category == '保單設計' ? 'selected' : ''}>保單設計</option>
                                    <option value="理賠服務" ${comment.category == '理賠服務' ? 'selected' : ''}>理賠服務</option>
                                    <option value="客服服務" ${comment.category == '客服服務' ? 'selected' : ''}>客服服務</option>
                                    <option value="優惠活動" ${comment.category == '優惠活動' ? 'selected' : ''}>優惠活動</option>
                                    <option value="網站體驗" ${comment.category == '網站體驗' ? 'selected' : ''}>網站體驗</option>
                                    <option value="其他" ${comment.category == '其他' ? 'selected' : ''}>其他</option>
                                </select>
                            </div>
                        </td>
                        <td>${comment.username}</td>
                        <td>
                            <c:if test="${comment.username == 'e保通'}">
                                <div class="view-mode">
                                    <button type="button" class="btn btn-primary btn-sm" onclick="startEdit(this)">
                                        編輯
                                    </button>
                                </div>
                                <div class="edit-mode d-none">
                                    <button type="button" class="btn btn-success btn-sm" onclick="saveEdit(this)">
                                        保存
                                    </button>
                                    <button type="button" class="btn btn-secondary btn-sm" onclick="cancelEdit(this)">
                                        取消
                                    </button>
                                </div>
                            </c:if>   
                            <button type="button" class="btn btn-danger btn-sm" onclick="confirmDelete(${comment.commentid})">
                                刪除
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    


    <!-- Add Comment Modal -->
    <div class="modal fade" id="newCommentModal" tabindex="-1" aria-labelledby="newCommentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="newCommentModalLabel">新增評論</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="關閉"></button>
                </div>
                <form:form action="${pageContext.request.contextPath}/comments/add" method="post" modelAttribute="commentBean">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="topic" class="form-label">主題:</label>
                            <form:input path="topic" id="topic" class="form-control" required="required"/>
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">內容:</label>
                            <form:textarea path="content" id="content" class="form-control" required="required"></form:textarea>
                        </div>
                        <div class="mb-3">
                            <label for="category" class="form-label">分類:</label>
                            <form:select path="category" id="category" class="form-control" required="required">
                                <form:option value="">請選擇分類</form:option>
                                <c:forEach items="${commentCategories}" var="category">
                                    <form:option value="${category}">${category}</form:option>
                                </c:forEach>
                            </form:select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">關閉</button>
                        <button type="submit" class="btn btn-primary">新增</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>

<!-- Pie Chart Section -->
<div class="row">
    <div class="col-md-6 offset-md-3">
        <canvas id="categoryChart"></canvas>
    </div>
</div>


    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>


    
    
    
    <script>
 // 先定義 contextPath
    const contextPath = "${pageContext.request.contextPath}";
    
    
 // Enter 鍵搜尋事件監聽
    document.getElementById('searchKeyword').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            searchComments();
        }
    });

    // 搜尋功能
    function searchComments() {
        const keyword = document.getElementById('searchKeyword').value.trim();
        const searchError = document.getElementById('searchError');
        const commentsTable = document.getElementById('commentsTable');

        if (keyword.length < 1) {
            searchError.textContent = '請輸入搜尋關鍵字';
            searchError.style.display = 'block';
            return;
        }
        searchError.style.display = 'none';

        fetch(contextPath + '/comments/search?keyword=' + encodeURIComponent(keyword))
            .then(response => response.json())
            .then(comments => {
                commentsTable.innerHTML = '';
                
                if (comments.length === 0) {
                    commentsTable.innerHTML = '<tr><td colspan="6" class="text-center">找不到含有 "' + 
                        keyword + '" 的評論</td></tr>';
                    return;
                }

                comments.forEach(comment => {
                    let editButtons = '';
                    if (comment.username === 'e保通') {
                        editButtons = 
                            '<div class="view-mode">' +
                            '<button type="button" class="btn btn-primary btn-sm" onclick="startEdit(this)">' +
                            '編輯</button></div>' +
                            '<div class="edit-mode d-none">' +
                            '<button type="button" class="btn btn-success btn-sm" onclick="saveEdit(this)">' +
                            '保存</button>' +
                            '<button type="button" class="btn btn-secondary btn-sm" onclick="cancelEdit(this)">' +
                            '取消</button></div>';
                    }

                    const row = 
                        '<tr>' +
                        '<td>' + comment.commentid + '</td>' +
                        '<td class="editable-cell">' +
                        '<div class="view-mode">' + comment.topic + '</div>' +
                        '<div class="edit-mode d-none">' +
                        '<input type="text" class="form-control" value="' + comment.topic + '">' +
                        '</div></td>' +
                        '<td class="editable-cell">' +
                        '<div class="view-mode">' + comment.content + '</div>' +
                        '<div class="edit-mode d-none">' +
                        '<textarea class="form-control">' + comment.content + '</textarea>' +
                        '</div></td>' +
                        '<td class="editable-cell">' +
                        '<div class="view-mode">' + comment.category + '</div>' +
                        '<div class="edit-mode d-none">' +
                        '<select class="form-control">' +
                        '<option value="保單設計"' + (comment.category == '保單設計' ? ' selected' : '') + '>保單設計</option>' +
                        '<option value="理賠服務"' + (comment.category == '理賠服務' ? ' selected' : '') + '>理賠服務</option>' +
                        '<option value="客服服務"' + (comment.category == '客服服務' ? ' selected' : '') + '>客服服務</option>' +
                        '<option value="優惠活動"' + (comment.category == '優惠活動' ? ' selected' : '') + '>優惠活動</option>' +
                        '<option value="網站體驗"' + (comment.category == '網站體驗' ? ' selected' : '') + '>網站體驗</option>' +
                        '<option value="其他"' + (comment.category == '其他' ? ' selected' : '') + '>其他</option>' +
                        '</select></div></td>' +
                        '<td>' + comment.username + '</td>' +
                        '<td>' + editButtons +
                        '<button type="button" class="btn btn-danger btn-sm" onclick="confirmDelete(' + comment.commentid + ')">' +
                        '刪除</button></td></tr>';

                    commentsTable.innerHTML += row;
                });
            })
            .catch(error => {
                console.error('搜尋錯誤:', error);
                commentsTable.innerHTML = 
                    '<tr><td colspan="6" class="text-center text-danger">' +
                    '搜尋失敗，請稍後再試</td></tr>';
            });
    }
    
    
    // 進入編輯模式
// 進入編輯模式
// 進入編輯模式
function startEdit(button) {
        const row = button.closest('tr');
        
        // 切換按鈕和編輯區域的顯示
        row.querySelectorAll('.view-mode').forEach(el => el.classList.add('d-none'));
        row.querySelectorAll('.edit-mode').forEach(el => el.classList.remove('d-none'));
    }

    // 取消編輯
    function cancelEdit(button) {
        const row = button.closest('tr');
        
        // 切換回檢視模式
        row.querySelectorAll('.view-mode').forEach(el => el.classList.remove('d-none'));
        row.querySelectorAll('.edit-mode').forEach(el => el.classList.add('d-none'));
    }

    // 保存編輯（暫時只在前端更新）
     function saveEdit(button) {
        const row = button.closest('tr');
        const commentId = row.cells[0].textContent.trim();
        
        // 取得編輯值
        const topic = row.querySelector('.edit-mode input').value;
        const content = row.querySelector('.edit-mode textarea').value;
        const category = row.querySelector('.edit-mode select').value;

        // 測試輸出
      //  console.log('要更新的評論ID:', commentId);
      //  console.log('contextPath:', contextPath);
        
        // 構建完整的 URL（包含 commentId）
        const url = contextPath + '/comments/update/' + commentId;
      //  console.log('實際發送請求的URL:', url);

        // 構建表單數據
        const formData = new URLSearchParams();
        formData.append('topic', topic);
        formData.append('content', content);
        formData.append('category', category);

        // 發送請求
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData
        })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            // 更新視圖
            row.querySelector('td:nth-child(2) .view-mode').textContent = topic;
            row.querySelector('td:nth-child(3) .view-mode').textContent = content;
            row.querySelector('td:nth-child(4) .view-mode').textContent = category;
            
            // 切換回檢視模式
            cancelEdit(button);
            
            Swal.fire({
                title: '成功',
                text: '評論已更新',
                icon: 'success'
            });
        })
        .catch(error => {
            console.error('更新時發生錯誤:', error);
            Swal.fire({
                title: '錯誤',
                text: '無法更新評論',
                icon: 'error'
            });
        });
    }
    

    
       function confirmDelete(commentid) {
        Swal.fire({
            title: '確定要刪除這個評論嗎?',
            text: "此操作無法恢復!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '是的,刪除它!'
        }).then((result) => {
            if (result.isConfirmed) {
                fetch("${pageContext.request.contextPath}/comments/delete/" + commentid, {
                    method: 'DELETE'
                }).then(response => {
                    if (response.ok) {
                        Swal.fire('刪除成功!', '該評論已被刪除。', 'success').then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire('刪除失敗!', '無法刪除該評論。', 'error');
                    }
                }).catch(() => {
                    Swal.fire('錯誤!', '伺服器無回應，請稍後再試。', 'error');
                });
            }
        });
    }

    // Create pie chart
  // 移除原本的 fetch 請求，直接使用 JSP 的資料
document.addEventListener('DOMContentLoaded', function() {
    // 從已經渲染在頁面上的表格數據統計分類
    const categoryCount = {
        "保單設計": 0,
        "理賠服務": 0,
        "客服服務": 0,
        "優惠活動": 0,
        "網站體驗": 0,
        "其他": 0
    };

    // 獲取所有表格行
    const rows = document.querySelectorAll('#commentsTable tr');
    
    // 遍歷每一行，統計分類數量
    // 注意：category 在第 4 列 (index 3)
    rows.forEach(row => {
        const categoryCell = row.cells[3];
        if (categoryCell) {
            const category = categoryCell.querySelector('.view-mode').textContent;
            if (category in categoryCount) {
                categoryCount[category]++;
            }
        }
    });

    // 準備圖表數據
    const labels = Object.keys(categoryCount);
    const data = Object.values(categoryCount);

    // 建立圖表
    createCategoryChart(labels, data);
});

function createCategoryChart(labels, data) {
    // 計算總數以計算百分比
    const total = data.reduce((acc, curr) => acc + curr, 0);
    
    const ctx = document.getElementById('categoryChart').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: [
                    '#FF6384', '#36A2EB', '#FFCE56', 
                    '#8BC34A', '#E91E63', '#9575CD'
                ],
                hoverBackgroundColor: [
                    '#FF6384', '#36A2EB', '#FFCE56', 
                    '#8BC34A', '#E91E63', '#9575CD'
                ]
            }]
        },
        options: {
            responsive: true,
            plugins: {
                tooltip: {
                    titleFont: {
                        size: 16
                    },
                    bodyFont: {
                        size: 14
                    },
                    callbacks: {
                        label: function(context) {
                            // 計算百分比並四捨五入到整數
                            const percentage = Math.round((context.raw / total) * 100);
                            return context.label + ': ' + percentage + '%';
                        }
                    }
                },
                title: {
                    display: true,
                    text: '評論分類熱度統計',
                    font: {
                        size: 24,
                        weight: 'bold'
                    },
                    padding: {
                        top: 10,
                        bottom: 30
                    }
                },
                legend: {
                    position: 'bottom',
                    labels: {
                        font: {
                            size: 16
                        },
                        padding: 20
                    }
                }
            }
        }
    });
}
    </script>
</body>
</html>