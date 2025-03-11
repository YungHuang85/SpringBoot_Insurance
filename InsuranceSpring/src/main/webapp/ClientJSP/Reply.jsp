<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>留言板</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        /* Background color */
        body {
            background-color: rgba(246, 253, 248) !important;
        }

        .table {
            background-color: white !important;
        }

        /* Delete button */
        .btn-danger {
            background-color: darkred !important;
            border-color: darkred !important;
            color: white !important;
        }

        .btn-danger:hover {
            background-color: #a71d2a !important;
            border-color: #a71d2a !important;
        }

        /* Ensure all button text is white */
        .btn {
            color: white !important;
        }
    </style>
    
</head>
<body>
    <div class="container my-5">
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>留言板</h1>
            <button type="button" class="btn btn-secondary" onclick="window.location.href='${pageContext.request.contextPath}/comments'">
                返回評論管理
            </button>
        </div>

        <!-- Replies Table -->
       <table class="table table-striped">
    <thead>
        <tr>
            <th>留言ID</th>
            <th>留言內容</th>
            <th>評論ID</th>
            <th>性別</th>
            <th>使用者名稱</th>
            <th>操作</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${replies}" var="reply">
            <tr>
                <td>${reply.replyid}</td>
                <td>${reply.content}</td>
                <td>${reply.commentid}</td>
                <td>${reply.gender}</td>
                <td>${reply.username}</td>
                <td>
                   <button type="button" class="btn btn-danger btn-sm" onclick="confirmDelete(${reply.replyid})">
    刪除
</button>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
    </div>

    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    const contextPath = "${pageContext.request.contextPath}";

    function confirmDelete(replyId) {
        console.log("Deleting reply with ID:", replyId);
        Swal.fire({
            title: '確定要刪除這個留言嗎?',
            text: "此操作無法恢復!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '是的,刪除它!'
        }).then((result) => {
            if (result.isConfirmed) {
                // 修改這裡，改用加號連接確保 ID 被正確加入
                const deleteUrl = contextPath + '/comments/reply/delete/' + replyId;
                console.log("Delete URL:", deleteUrl);
                
                fetch(deleteUrl, {
                    method: 'DELETE'
                }).then(response => {
                    if (response.ok) {
                        Swal.fire('刪除成功!', '該留言已被刪除。', 'success').then(() => {
                            window.location.reload();
                        });
                    } else {
                        Swal.fire('刪除失敗!', '無法刪除該留言。', 'error');
                    }
                }).catch(() => {
                    Swal.fire('錯誤!', '伺服器無回應，請稍後再試。', 'error');
                });
            }
        });
    }
    </script>
</body>
</html>