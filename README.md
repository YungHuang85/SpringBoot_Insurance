# e-Insurance (e險無憂) 保險人壽網站 - 後端

# 專案簡介

本專案是一個使用Java & Spring Boot 開發的 Web 應用程式，主要功能包括：

    - 管理者登入, 登出
    - 會員列表
    - 保單管理
    - 商品管理
    - 理賠管理
    - 兌換專區
    - 常見問答
    - 討論區 

# 技術架構

    Spring Boot - 快速構建 Spring 應用，簡化配置與部署
    Spring MVC - 處理 HTTP 請求，支援 RESTful API
    Spring Data JPA - ORM 框架，簡化資料庫操作
    SQL Server - 資料庫，使用 Microsoft SQL Server JDBC 驅動
    MongoDB - NoSQL 資料庫，支援大規模數據儲存
    Spring Boot DevTools - 開發工具，支援熱部署
    Spring Boot Starter Web - 提供 Web 相關功能（REST API、MVC）
    Spring Boot Starter Test - 測試框架，支援 JUnit、Mockito
    Spring Boot Starter Mail - 郵件發送模組
    Spring Boot Starter Data MongoDB - 提供 MongoDB 整合支援
    Jakarta Servlet API - 提供 Servlet、JSP 相關功能
    Tomcat Embed Jasper - 支援 JSP 運行
    Apache Commons FileUpload - 處理檔案上傳
    Apache Commons IO - 處理 I/O 操作
    Jackson Databind - JSON 解析與轉換
    Google ZXing - 生成與解析 QR Code、條碼
    iText PDF - 生成與處理 PDF 文件
    AWS SDK SES - AWS 郵件服務（SES）
    Google API Client - 與 Google API 互動
    Spring Web - Spring 的 Web 框架，支援 MVC 和 REST
    Spring WebMVC - 提供 MVC 相關功能
    Spring Boot Maven Plugin - Spring Boot 應用的 Maven 插件，支援打包與執行

# 專案結構

    總結構:
    InsuranceSpring
    │── src/main/java/insurance/main
    │   ├── awsmodel      # AWS 相關模型
    │   ├── config       # 配置類
    │   ├── controller   # 通用控制器(網路投保, 會員, 討論區, 常見問題, 紅利商城)
    │   ├── dto          # 資料傳輸物件 (DTO)
    │   ├── model        # 通用數據模型(網路投保, 會員, 討論區, 常見問題, 紅利商城)
    │   ├── insuranceClaims
    │   │   ├── bean        # 保險理賠 Bean
    │   │   ├── controller  # 保險理賠控制器
    │   │   ├── dao         # 保險理賠數據存取
    │   │   ├── dto         # 保險理賠 DTO
    │   │   ├── service     # 保險理賠服務層
    │   ├── products
    │   │   ├── controller  # 保險產品控制器
    │   │   ├── dto         # 保險產品 DTO
    │   │   ├── model       # 保險產品數據模型
    │   ├── premiums
    │   │   ├── controller  # 投保保費控制器
    │   │   ├── model       # 投保保費數據模型
    │── src/main/resources
    │   ├── fonts          # 字型資源
    │   ├── static         # 靜態資源
    │   │   ├── picture    # 圖片存放
    │   ├── templates      # Thymeleaf/HTML 模板
    │   ├── application.properties  # 設定檔
    │   ├── logback-spring.xml  # 日誌設定
    │── src/test/java
    │   ├── 測試類別
    │── target  # 編譯後輸出目錄
    │── pom.xml  # Maven 依賴管理
    │── HELP.md  # Spring Boot 預設文件
    │── mvnw  # Maven Wrapper (Linux/Mac)
    │── mvnw.cmd  # Maven Wrapper (Windows)



    後端本人負責程式範圍:
    InsuranceSpring
    │── src/
    │   ├── main/java/
    │   │   ├── insurance.main/
    │   │   │   ├── DemoSpringWebProjectApplication.java
    │   │   │   ├── ServletInitializer.java
    │   │   │   ├── awsmode/                      # AWS 相關功能
    │   │   │   │   ├── EmailController.java
    │   │   │   │   ├── EmailRequest.java
    │   │   │   │   ├── EmailService.java
    │   │   │   │   ├── PdfGenerator.java
    │   │   │   ├── config/                          # 配置層
    │   │   │   │   ├── RootAppConfig.java
    │   │   │   │   ├── WebAppInitializer.java
    │   │   │   ├── controller/                    # 控制層
    │   │   │   │   ├── ClientController.java
    │   │   │   ├── model/                         # Model 層
    │   │   │   │   ├── BeneBean1.java
    │   │   │   │   ├── BeneRepository.java
    │   │   │   │   ├── ClientBean.java
    │   │   │   │   ├── ClientRepository.java
    │   │   │   │   ├── ClientService.java
    │   │   │   ├── premiums/                      # 保費計算功能
    │   │   │   │   ├── controller/
    │   │   │   │   │   ├── TravelPremiumsController.java
    │   │   │   │   ├── model/
    │   │   │   │   │   ├── TravelPremiumsBean.java
    │   │   │   │   │   ├── TravelPremiumsRepository.java
    │   │   │   │   │   ├── TravelPremiumsService.java
    │   ├── main/resources/
    │   │   ├── application.properties
    │   ├── test/java/
    │── Deployed Resources/
    │   ├── webapp/
    │   │   ├── ClientCSS/                         # CSS
    │   │   │   ├── GetAll.css
    │   │   │   ├── GetClient.css
    │   │   │   ├── InsertTravel.css
    │   │   │   ├── InsertTravelResult.css
    │   │   ├── ClientHTML/                        # HTML 頁面
    │   │   │   ├── InsertTravel.html
    │   │   ├── ClientJSP/                         # JSP 頁面
    │   │   │   ├── GetAllClient.jsp
    │   │   │   ├── GetClient.jsp
    │   │   │   ├── GetUpdateClient.jsp
    │   │   │   ├── InsertClientResult.jsp
    │   │   │   ├── sidebar.jsp
    │── pom.xml


# 環境設置

1. 前置需求

請確保你的開發環境已安裝以下工具：

    JDK 17 或更新版本
    Microsoft SQL Server 2022 
    SQL Server Management Studio (SSMS)
    MongoDB Community Server v7.0.6或更新版本
    Eclipse / IntelliJ IDEA / VS Code - 任何一款 Java IDE

2. 設定環境變數

請修改 application.properties 來搭配你的資料庫環境。(預設資料庫名稱 = insurance)

    #SQL Server DataSource Setting
    spring.datasource.driver-class-name=com.microsoft.sqlserver.jdbc.SQLServerDriver
    spring.datasource.url=jdbc:sqlserver://localhost:1433;databaseName="你的MSSQL資料庫名稱";encrypt=true;TrustServerCertificate=true
    spring.datasource.username="你的MSSQL帳號"
    spring.datasource.password="你的MSSQL密碼"
    spring.jpa.hibernate.ddl-auto=none
    spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.SQLServerDialect

    #MongoDB
    spring.data.mongodb.uri=mongodb://localhost:27017/"你的mongoDB資料庫名稱"

3. 啟動專案

    1. 確保SQL資料表皆執行(MSSQL執行e_insurance.sql; mongoDB執行travelpremiums.csv)

    2. 執行src/main/java的insurance.main的 DemoSpringWebProjectApplication

    3. 網頁輸入網址: http://localhost:8081/adminLogin

    4. 進入登入頁面(輸入帳號: EEIT902024017; 密碼: EEIT017)
