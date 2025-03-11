<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html>

  <head>
    <meta charset="UTF-8">
    <title>旅平險投保人</title>
   <jsp:include page="sidebar.jsp" />
    <link rel="stylesheet" href="../ClientCSS/GetClient.css">
  </head>

  <body>

    <div class="container">
      <jsp:useBean id="client" scope="request" class="insurance.main.model.ClientBean" />
      <h2>個人資料</h2>
      <form>
        <table>
          <tr>
            <td>保單號碼
            <td><input type="text" name="insuranceNumber" readonly value="${param.insuranceNumber}">
          <tr>
            <td>姓名
            <td><input type="text" name="username" readonly value="${param.username}">
          <tr>
            <td>身分證字號
            <td><input type="text" name="id_number" readonly value="${param.id_number}">
          <tr>
            <td>生日
            <td><input type="text" name="birthday" readonly value="${param.birthday}">
          <tr>
            <td>性別
            <td><input type="text" name="gender" readonly value="${param.gender}">
          <tr>
            <td>電話
            <td><input type="text" name="phone" readonly value="${param.phone}">
          <tr>
            <td>E-mail
            <td><input type="text" name="email" readonly value="${param.email}">
          <tr>
            <td>地址
            <td><input type="text" name="address" readonly value="${param.address}">
        </table>
      </form>
      <form action="${pageContext.request.contextPath}/clients" method="get">
        <button class="button1" type="submit">回到上一頁</button>
      </form>
    </div>
  </body>

  </html>