<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
    <title>QA資料</title>
   <style>
        body {
            background-color: #FFFFFF; /* 白色背景 */
            color: #000000; /* 黑色字體 */
            font-family: Arial, sans-serif;
            text-align: center;
        }

        h2, h3 {
            color: #333333; /* 深灰色字體 */
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
            background-color: #F8F9FA; /* 淺灰色背景 */
        }

        table, th, td {
            border: 1px solid #DDDDDD; /* 淺灰色邊框 */
        }

        th {
            background-color: #28A745; /* 綠色背景 */
            color: #FFFFFF; /* 白色字體 */
            padding: 10px;
        }

        td {
            padding: 10px;
            text-align: left;
            background-color: #FFFFFF; /* 白色背景 */
        }

        tr:nth-child(even) td {
            background-color: #F2F2F2; /* 更淺灰色背景 */
        }

        tr:hover td {
            background-color: #D4EDDA; /* 淡綠色背景 */
        }
    </style>
</head>
<body>
<div align="center">
    <h2>QA資料</h2>
    <table>
        <tr>
            <th>QA 編號</th>
            <th>問題</th>
            <th>答案</th>
        </tr>
        <c:forEach var="qa" items="${qaList}">
            <tr>
                <td>${qa.qaid}</td>
                <td>${qa.question}</td>
                <td>${qa.answer}</td>
            </tr>
        </c:forEach>
    </table>
    <h3>共 ${fn:length(qaList)} 筆評論資料</h3>
</div>
</body>
</html>

