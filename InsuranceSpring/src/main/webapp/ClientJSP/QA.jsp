<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="sidebar.jsp" />
<title>QA資料</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
body {
    background-color: rgba(246, 253, 248);
    color: #000000;
    font-family: Arial, sans-serif;
    text-align: center;
}

h2, h3 {
    color: #333333;
}

.search-container {
    margin: 20px auto;
    width: 80%;
}

.search-input {
    padding: 8px;
    width: 300px;
    border: 1px solid #ddd;
    border-radius: 4px;
    margin-right: 10px;
}

table {
    border-collapse: collapse;
    width: 80%;
    margin: 20px auto;
    background-color: white;
}

table, th, td {
    border: 1px solid #DDDDDD;
}

th {
    background-color: #29293f;
    color: white;
    padding: 10px;
}

td {
    padding: 10px;
    text-align: left;
    background-color: white;
}

tr:nth-child(even) td {
    background-color: rgba(246, 253, 248);
}

tr:hover td {
    background-color: #f8f9fa;
}

.action-btn {
    padding: 5px 10px;
    margin: 0 3px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    color: white;
}

.edit-btn {
    background-color: #29293f;
}

.edit-btn:hover {
    background-color: #47475f;
}

.delete-btn {
    background-color: darkred;
}

.delete-btn:hover {
    background-color: #a71d2a;
}

.search-btn {
    background-color: #33393f;
}

.search-btn:hover {
    background-color: #5a6268;
}

.add-btn {
    background-color: #29293f;
    margin-left: 10px !important;
}

.add-btn:hover {
    background-color: #47475f;
}

.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,0.4);
}

.modal-content {
    background-color: white;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 50%;
    border-radius: 5px;
}

.form-group {
    margin-bottom: 15px;
    text-align: left;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
}

.form-group input, .form-group textarea {
    width: 100%;
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
}

.action-btn-container {
    display: flex;
    justify-content: center;
    gap: 5px;
}

td:last-child {
    text-align: center;
}
</style>
</head>
<body>
<div align="center">
    <h2>QA資料</h2>
    
    <!-- 搜尋框 -->
    <div class="search-container">
        <form action="${pageContext.request.contextPath}/QA/search" method="GET" style="display: inline-block;">
            <input type="text" name="keyword" class="search-input" placeholder="請輸入關鍵字..." value="${param.keyword}">
            <button type="submit" class="action-btn search-btn">搜尋</button>
        </form>
        <button class="action-btn add-btn" onclick="openAddModal()">新增</button>

</div>

    <table>
        <tr>
            <th>QA 編號</th>
            <th>問題</th>
            <th>答案</th>
            <th>操作</th>
        </tr>
        <c:forEach var="qa" items="${qaList}">
            <tr>
                <td>${qa.qaid}</td>
                <td>${qa.question}</td>
                <td>${qa.answer}</td>
                <td>
                    <div class="action-btn-container">
                        <button class="action-btn edit-btn" onclick="openEditModal(${qa.qaid}, '${qa.question}', '${qa.answer}')">
                            編輯
                        </button>
                        <button class="action-btn delete-btn" onclick="confirmDelete(${qa.qaid})">
                            刪除
                        </button>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </table>
    <h3>共 ${fn:length(qaList)} 筆QA資料</h3>
</div>

<!-- 新增 Modal 視窗 -->
<div id="addModal" class="modal">
    <div class="modal-content">
        <h3>新增QA資料</h3>
        <form id="addForm" action="${pageContext.request.contextPath}/QA/add" method="POST">
            <div class="form-group">
                <label>問題:</label>
                <textarea id="addQuestion" name="question" required></textarea>
            </div>
            <div class="form-group">
                <label>答案:</label>
                <textarea id="addAnswer" name="answer" required></textarea>
            </div>
            <button type="submit" class="action-btn edit-btn">新增</button>
            <button type="button" class="action-btn delete-btn" onclick="closeAddModal()">取消</button>
        </form>
    </div>
</div>

<!-- 編輯彈窗 -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <h3>編輯QA資料</h3>
        <form id="editForm" action="${pageContext.request.contextPath}/QA/update" method="POST">
            <input type="hidden" id="editId" name="qaid">
            <div class="form-group">
                <label>問題:</label>
                <textarea id="editQuestion" name="question" required></textarea>
            </div>
            <div class="form-group">
                <label>答案:</label>
                <textarea id="editAnswer" name="answer" required></textarea>
            </div>
            <button type="submit" class="action-btn edit-btn">更新</button>
            <button type="button" class="action-btn delete-btn" onclick="closeEditModal()">取消</button>
        </form>
    </div>
</div>

<script>
// 打開編輯彈窗
function openEditModal(id, question, answer) {
    document.getElementById('editModal').style.display = 'block';
    document.getElementById('editId').value = id;
    document.getElementById('editQuestion').value = question;
    document.getElementById('editAnswer').value = answer;
}

// 關閉編輯彈窗
function closeEditModal() {
    document.getElementById('editModal').style.display = 'none';
}

// 確認刪除
function confirmDelete(id) {
    Swal.fire({
        title: '確定要刪除嗎？',
        text: "此操作無法恢復！",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#28A745',
        cancelButtonColor: '#dc3545',
        confirmButtonText: '是的，刪除！',
        cancelButtonText: '取消'
    }).then((result) => {
        if (result.isConfirmed) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/QA/delete';
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'qaid';
            input.value = id;
            form.appendChild(input);
            document.body.appendChild(form);
            form.submit();
        }
    });
}

// 打開新增彈窗
function openAddModal() {
    document.getElementById('addModal').style.display = 'block';
    // 清空表單
    document.getElementById('addQuestion').value = '';
    document.getElementById('addAnswer').value = '';
}

// 關閉新增彈窗
function closeAddModal() {
    document.getElementById('addModal').style.display = 'none';
}

// 點擊外部關閉彈窗
window.onclick = function(event) {
    if (event.target == document.getElementById('editModal')) {
        closeEditModal();
    }
    if (event.target == document.getElementById('addModal')) {
        closeAddModal();
    }
}
</script>
</body>
</html>