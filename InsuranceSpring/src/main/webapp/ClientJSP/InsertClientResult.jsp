<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>新增投保人資料結果</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/ClientCSS/InsertTravelResult.css">
    </head>

    <body>

        <div>
            <h2>新增投保人資料結果</h2>
            <form action="${pageContext.request.contextPath}/clients" method="get">
                <button type="submit">返回旅平險投保人資料</button>
            </form>
            <table>
                <tr>
                    <th>保單號碼</th>
                    <th>姓名</th>
                    <th>身分證字號</th>
                    <th>生日</th>
                    <th>性別</th>
                    <th>電話</th>
                    <th>E-mail</th>
                    <th>地址</th>
                    <th>投保商品</th>
                    <th>旅遊地區</th>
                    <th>生效時間</th>
                    <th>結束時間</th>
                    <th>意外身故</th>
                    <th>意外身故$</th>
                    <th>傷害醫療</th>
                    <th>突發疾病</th>
                    <th>醫療專機</th>
                    <th>總保費</th>

                    <th>與投保人關係</th>
                    <th>受益人姓名</th>
                    <th>受益人ID</th>
                    <th>受益人生日</th>
                    <th>受益人性別</th>
                    <th>受益人電話</th>
                    <th>受益人地址</th>


                </tr>
                <%
                // 從 request 中獲取多筆資料
                String[] insuranceNumbers = request.getParameterValues("insuranceNumber[]");
                String[] usernames = request.getParameterValues("username[]");
                String[] idNumbers = request.getParameterValues("id_number[]");
                String[] birthdays = request.getParameterValues("birthday[]");
                String[] genders = request.getParameterValues("gender[]");
                String[] phones = request.getParameterValues("phone[]");
                String[] emails = request.getParameterValues("email[]");
                String[] addresses = request.getParameterValues("address[]");
                String[] insuranceProducts = request.getParameterValues("insuranceProduct[]");
                String[] countries = request.getParameterValues("country[]");
                String[] startTimes = request.getParameterValues("startTime[]");
                String[] endTimes = request.getParameterValues("endTime[]");
                String[] sumAssureds = request.getParameterValues("sumAssured[]");
                String[] premiums = request.getParameterValues("premiums[]");
                String[] medicalTreatment = request.getParameterValues("medicalTreatment[]");
                String[] overseasIllness = request.getParameterValues("overseasIllness[]");
                String[] overseasFlights = request.getParameterValues("overseasFlights[]");
                String[] totalCost = request.getParameterValues("totalCost[]");

                String[] relationship = request.getParameterValues("relationship[]");
                String[] beneficiaryName = request.getParameterValues("beneficiaryName[]");
                String[] beneficiaryID = request.getParameterValues("beneficiaryID[]");
                String[] beneficiaryBirthday = request.getParameterValues("beneficiaryBirthday[]");
                String[] beneficiaryGender = request.getParameterValues("beneficiaryGender[]");
                String[] beneficiaryPhone = request.getParameterValues("beneficiaryPhone[]");
                String[] beneficiaryAddress = request.getParameterValues("beneficiaryAddress[]");
                
                // 確保資料的長度一致
                int numEntries = insuranceNumbers != null ? insuranceNumbers.length : 0;

                // 循環處理所有的投保人資料
                for (int i = 0; i < numEntries; i++) {
            %>
                    <tr>
                        <td>
                            <%= insuranceNumbers[i] %>
                        </td>
                        <td>
                            <%= usernames[i] %>
                        </td>
                        <td>
                            <%= idNumbers[i] %>
                        </td>
                        <td>
                            <%= birthdays[i] %>
                        </td>
                        <td>
                            <%= genders[i] %>
                        </td>
                        <td>
                            <%= phones[i] %>
                        </td>
                        <td>
                            <%= emails[i] %>
                        </td>
                        <td>
                            <%= addresses[i] %>
                        </td>
                        <td>
                            <%= insuranceProducts[i] %>
                        </td>
                        <td>
                            <%= countries[i] %>
                        </td>
                        <td>
                            <%= startTimes[i] %>
                        </td>
                        <td>
                            <%= endTimes[i] %>
                        </td>
                        <td>
                            <%= sumAssureds[i] %>
                        </td>
                        <td>
                            <%= premiums[i] %>
                        </td>

                        <td>
                            <%= medicalTreatment[i] %>
                        </td>
                        <td>
                            <%= overseasIllness[i] %>
                        </td>
                        <td>
                            <%= overseasFlights[i] %>
                        </td>
                        <td>
                            <%= totalCost[i] %>
                        </td>

                        <td>
                            <%= relationship[i] %>
                        </td>
                        <td>
                            <%= beneficiaryName[i] %>
                        </td>
                        <td>
                            <%= beneficiaryID[i] %>
                        </td>
                        <td>
                            <%= beneficiaryBirthday[i] %>
                        </td>
                        <td>
                            <%= beneficiaryGender[i] %>
                        </td>
                        <td>
                            <%= beneficiaryPhone[i] %>
                        </td>
                        <td>
                            <%= beneficiaryAddress[i] %>
                        </td>
                    </tr>
                    <% } %>
            </table>
        </div>
    </body>

    </html>