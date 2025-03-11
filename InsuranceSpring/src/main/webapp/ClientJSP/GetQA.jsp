<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>單筆QA資料</title>
    <style>
        body {
            background-color: #FFFFFF; /* 白色背景 */
            color: #000000; /* 黑色字體 */
            font-family: Arial, sans-serif;
            text-align: center;
        }

        h2 {
            color: #333333; /* 深灰色字體 */
        }

        .navbar {
            padding: 5px 20px !important;
            display: flex;
            justify-content: center;
            background-color: #8eaa9b; /* 替換為指定的背景色 */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            margin-bottom: 10px;
        }

        .navbar a {
            color: white; /* 白色字體 */
            text-decoration: none;
            font-size: 22px;
            padding: 5px 10px; /* 增加左右內距 */
            border-radius: 3px;
            transition: background-color 0.3s;
        }

        .navbar a:hover {
            background-color: #6f8c7d; /* 更深的綠色 */
        }

        table {
            border-collapse: collapse;
            width: 50%;
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
            text-align: center;
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
    <h2>單筆QA資料</h2>
    <table>
        <tr>
            <th>QA 編號</th>
            <td>${qa.qaid}</td>
        </tr>
        <tr>
            <th>問題</th>
            <td>${qa.question}</td>
        </tr>
        <tr>
            <th>答案</th>
            <td>${qa.answer}</td>
        </tr>
    </table>
</div>
</body>
</html>


