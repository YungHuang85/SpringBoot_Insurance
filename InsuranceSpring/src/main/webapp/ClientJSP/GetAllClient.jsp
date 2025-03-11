<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="insurance.main.model.ClientBean, insurance.main.model.BeneBean1, java.util.*" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>旅平險投保人資料</title>
       <jsp:include page="sidebar.jsp" />

        <!-- DataTables CSS、JS（這裡使用 CDN） -->
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.5/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.5/js/jquery.dataTables.min.js"></script>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/ClientCSS/GetAll.css">

        <style>
            /* 你原本的樣式... */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.8);
            }

            .modal-content {
                margin: auto;
                display: block;
                width: 80%;
                max-width: 700px;
            }

            .close {
                position: absolute;
                top: 10px;
                right: 25px;
                color: white;
                font-size: 35px;
                font-weight: bold;
                cursor: pointer;
            }

            .close:hover,
            .close:focus {
                color: #bbb;
                text-decoration: none;
                cursor: pointer;
            }
        </style>
    </head>

    <body>
    <button class="htmlbutton" onclick="location.href='ClientHTML/InsertTravel.html';">新增資料</button>



    <div align="center">
        <h2 style="display: inline; text-align: center;">旅平險投保資料</h2>

        <%
            @SuppressWarnings("unchecked")
            List<ClientBean> clients = (List<ClientBean>) request.getAttribute("clients");
            @SuppressWarnings("unchecked")
            List<BeneBean1> beneficiaries = (List<BeneBean1>) request.getAttribute("beneficiaries");
        %>

       
        <table border="1" class="order-table" id="ProductTable">
            <thead>
                <tr>
              <th colspan="14" class="th0" style="text-align: center;">投保人欄位</th>
    		  <th colspan="6" class="th1" style="text-align: center;">受益人欄位</th>
    		  <th colspan="2" class="th2" style="text-align: center;">設定</th>
                </tr>
                <tr>
                    <th class="th0" style="text-align: center;">保單</th>
                    <th class="th0" style="text-align: center;">會員帳號</th>                  
                    <th class="th0" style="text-align: center;">投保人</th>
                    <th class="th0" style="text-align: center;">頭像</th>
                    <th class="th0" style="text-align: center;">商品</th>
                    <th class="th0" style="text-align: center;">地點</th>
                    <th class="th0" style="text-align: center;">生效時間</th>
                    <th class="th0" style="text-align: center;">結束時間</th>
                    <th class="th0" style="text-align: center;">意外身故</th>
                    <th class="th0" style="text-align: center;">意外身故$</th>
                    <th class="th0" style="text-align: center;">傷害醫療</th>
                    <th class="th0" style="text-align: center;">突發疾病</th>
                    <th class="th0" style="text-align: center;">醫療專機</th>
                    <th class="th0" style="text-align: center;">總保費</th>

                    <th class="th1" style="text-align: center;">受益人</th>
                    <th class="th1" style="text-align: center;">投保人關係</th>
                    <th class="th1" style="text-align: center;">身分證ID</th>
                    <th class="th1" style="text-align: center;">生日</th>
                    <th class="th1" style="text-align: center;">性別</th>              
                    <th class="th1" style="text-align: center;">地址</th>

                    <th class="th2" style="text-align: center;">修改</th>
                    <th class="th2" style="text-align: center;">刪除</th>
                </tr>
            </thead>
            <tbody>
            <%
                // 原本迭代全部資料
                if (clients != null && beneficiaries != null) {
                    for (int i = 0; i < clients.size(); i++) {
                        ClientBean client = clients.get(i);
                        BeneBean1 bene = beneficiaries.get(i);
            %>
                <tr>
                    <form action="${pageContext.request.contextPath}/ClientJSP/GetUpdateClient.jsp" method="post">
                        <td><%= client.getInsuranceNumber() %></td>
                        <td><%= client.getAccount() %></td>
                      
                        <td>
                              <a
								href="${pageContext.request.contextPath}/ClientJSP/GetClient.jsp?insuranceNumber=<%= client.getInsuranceNumber() %>&username=<%= client.getUsername() %>&id_number=<%= client.getId_number() %>&birthday=<%= client.getBirthday() %>&gender=<%= client.getGender() %>&phone=<%= client.getPhone() %>&email=<%= client.getEmail() %>&address=<%= client.getAddress() %>&insuranceProduct=<%= client.getProduct() %>&country=<%= client.getLocation() %>&startTime=<%= client.getStartTime() %>&endTime=<%= client.getEndTime() %>&sumAssured=<%= client.getSumAssured() %>&premiums=<%= client.getPremiums() %>&updateTime=<%= client.getUpdateTime() %>">
								<%= client.getUsername() %>
							  </a>
                        </td>
                        <td>
                            <%
                                String base64Image = client.getProfilePictureBase64();
                                if (base64Image != null) {
                            %>
                                <img src="data:image/jpeg;base64,<%= base64Image %>" 
                                     alt="Profile Picture" 
                                     style="width: 50px; height: 50px; cursor: pointer;" 
                                     onclick="showModal(this)">
                            <% } else { %>
                                無圖片
                            <% } %>
                        </td>
                        <td><%= client.getProduct() %></td>
                        <td><%= client.getLocation() %></td>
                        <td><%= client.getStartTime() %></td>
                        <td><%= client.getEndTime() %></td>
                        <td><%= client.getSumAssured() %></td>
                        <td><%= client.getPremiums() %></td>
                        <td><%= client.getMedicalTreatment() %></td>
                        <td><%= client.getOverseasIllness() %></td>
                        <td><%= client.getOverseasFlights() %></td>
                        <td><%= client.getTotalCost() %></td>
                        <td><%= bene.getBeneficiaryName() %></td>
                        <td><%= bene.getRelationship() %></td>
                        <td><%= bene.getBeneficiaryID() %></td>
                        <td><%= bene.getBeneficiaryBirthday() %></td>
                        <td><%= bene.getBeneficiaryGender() %></td>                
                        <td><%= bene.getBeneficiaryAddress() %></td>

                        <!-- 隱藏欄位 -->
                        <input type="hidden" name="profilePicture" value="<%= client.getProfilePicture() %>">
                        <input type="hidden" name="account" value="<%= client.getAccount() %>">
                        <input type="hidden" name="insuranceNumber" value="<%= client.getInsuranceNumber() %>">
                        <input type="hidden" name="username" value="<%= client.getUsername() %>">
                        <input type="hidden" name="id_number" value="<%= client.getId_number() %>">
                        <input type="hidden" name="insuranceProduct" value="<%= client.getProduct() %>">
                        <input type="hidden" name="country" value="<%= client.getLocation() %>">
                        <input type="hidden" name="startTime" value="<%= client.getStartTime() %>">
                        <input type="hidden" name="endTime" value="<%= client.getEndTime() %>">
                        <input type="hidden" name="sumAssured" value="<%= client.getSumAssured() %>">
                        <input type="hidden" name="premiums" value="<%= client.getPremiums() %>">
                        <input type="hidden" name="updateTime" value="<%= client.getUpdateTime() %>">
                        <input type="hidden" name="medicalTreatment" value="<%= client.getMedicalTreatment() %>">
                        <input type="hidden" name="overseasIllness" value="<%= client.getOverseasIllness() %>">
                        <input type="hidden" name="overseasFlights" value="<%= client.getOverseasFlights() %>">
                        <input type="hidden" name="totalCost" value="<%= client.getTotalCost() %>">

                        <input type="hidden" name="relationship" value="<%= bene.getRelationship() %>">
                        <input type="hidden" name="beneficiaryName" value="<%= bene.getBeneficiaryName() %>">
                        <input type="hidden" name="beneficiaryID" value="<%= bene.getBeneficiaryID() %>">
                        <input type="hidden" name="beneficiaryBirthday" value="<%= bene.getBeneficiaryBirthday() %>">
                        <input type="hidden" name="beneficiaryGender" value="<%= bene.getBeneficiaryGender() %>">
                        <input type="hidden" name="beneficiaryPhone" value="<%= bene.getBeneficiaryPhone() %>">
                        <input type="hidden" name="beneficiaryAddress" value="<%= bene.getBeneficiaryAddress() %>">

                        <td><button class="btn1" type="submit">修改</button></td>
                    </form>

                    <form action="${pageContext.request.contextPath}/clients/delete" method="post"
                          enctype="multipart/form-data" onsubmit="return handleDelete(event)">
                        <td>
                            <input type="hidden" name="_method" value="DELETE">
                            <input type="hidden" name="insuranceNumber" value="<%= client.getInsuranceNumber() %>">
                            <button type="submit">刪除</button>
                        </td>
                    </form>
                </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>

        <!-- 直接顯示總筆數（若需要） -->
        <h3>總共 <%= (clients != null) ? clients.size() : 0 %> 筆投保資料</h3>
    </div>

    <!-- Modal (放大圖片) -->
    <div id="imageModal" class="modal">
        <span class="close" onclick="closeModal()">&times;</span>
        <img class="modal-content" id="modalImage">
    </div>
    <script>
        function showModal(img) {
            const modal = document.getElementById('imageModal');
            const modalImage = document.getElementById('modalImage');
            modal.style.display = 'block';
            modalImage.src = img.src;
        }
        function closeModal() {
            const modal = document.getElementById('imageModal');
            modal.style.display = 'none';
        }
    </script>

    <!-- sweetalert2 刪除前警告 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        async function handleDelete(event) {
            event.preventDefault();
            const result = await Swal.fire({
                title: '確定要刪除此筆資料嗎？',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: '確定',
                cancelButtonText: '取消'
            });
            if (result.isConfirmed) {
                event.target.submit();
            } else {
                console.log('取消刪除');
            }
        }
    </script>

    <!-- DataTables 初始化設定 -->
    <script>
      $(document).ready(function() {
          $('#ProductTable').DataTable({
              "paging": true,      // 開啟分頁
              "pageLength": 10,    // 每頁顯示 10 筆
              "lengthMenu": [10, 25, 50, 100],  // 可選筆數          
              "ordering": true,    // 若要讓使用者可點欄位排序
              "info": true,        // 預設會顯示「顯示第 X 筆到...」
              "searching": true,   // 預設會顯示搜尋框       
              "language": {
                  "search": "搜尋:",  
                  "lengthMenu": "　　　顯示 _MENU_ 筆資料", 
                  "info": "　　　顯示第 _START_ 至 _END_ 筆資料，共 _TOTAL_ 筆",
                  "infoEmpty": "顯示第 0 至 0 筆資料，共 0 筆",
                  "infoFiltered": "(從 _MAX_ 筆資料中過濾)",
                  "paginate": {
                      "next": "下一頁",
                      "previous": "上一頁"
                  }
              }
          });
      });
    </script>
</body>
</html>
