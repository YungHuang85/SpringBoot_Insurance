--管理員資料表
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[admin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NULL,
	[username] [nvarchar](255) NULL,
	[password] [nvarchar](255) NULL,
	[createDate] [date] NULL,
	[admin_email] [nvarchar](255) NULL,
	[password_last_updated] [nvarchar](255) NULL,
	[login_fail_count] [int] NULL,
	[profile_picture_image_type] [varchar](255) NULL,
	[modules] [nvarchar](255) NULL,
	[profile_picture] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[admin] ADD  DEFAULT ((0)) FOR [login_fail_count]
GO

SET IDENTITY_INSERT [dbo].[admin] ON;
INSERT INTO [insurance].[dbo].[admin] 
([id], [name], [username], [password], [createDate], [admin_email], [password_last_updated], [login_fail_count], [profile_picture_image_type], [modules], [profile_picture]) 
VALUES
(1,'楊子毅', 'EEIT902024001', 'EEIT001', '2024-09-11', 'admin_email', NULL, 0, NULL, '商品管理', NULL),
(2, '許侑宸', 'EEIT902024010', 'EEIT010', '2024-09-11', 'admin_email', NULL, 0, NULL, '常見問答、討論區', NULL),
(3, '羅方翎', 'EEIT902024011', 'EEIT011', '2024-09-11', 'fanglingluoo@gmail.com', NULL, 0, 'image/jpeg', '管理者、會員列表', NULL),
(4, '黃翊永', 'EEIT902024017', 'EEIT017', '2024-09-11', 'admin_email', NULL, 0, NULL, '保單管理', NULL),
(5, '侯薇榕', 'EEIT902024024', 'EEIT024', '2024-09-11', 'admin_email', NULL, 0, NULL, '理賠管理', NULL),
(6, '許傳政', 'EEIT902024028', 'EEIT028', '2024-09-11', 'admin_email', NULL, 0, NULL, '兌換專區', NULL);
SET IDENTITY_INSERT [dbo].[admin] OFF;


--會員等級
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MembershipLevel](
	[level] [int] NOT NULL,
	[level_name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO [insurance].[dbo].[MembershipLevel] ([level], [level_name]) VALUES (1, '金級會員');
INSERT INTO [insurance].[dbo].[MembershipLevel] ([level], [level_name]) VALUES (2, '銀級會員');
INSERT INTO [insurance].[dbo].[MembershipLevel] ([level], [level_name]) VALUES (3, '銅級會員');
INSERT INTO [insurance].[dbo].[MembershipLevel] ([level], [level_name]) VALUES (4, '一般會員');


--會員資料表
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[members](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[account] [varchar](255) NULL,
	[address] [varchar](255) NULL,
	[birthday] [date] NULL,
	[CreatedAt] [datetime2](6) NULL,
	[email] [varchar](255) NULL,
	[gender] [varchar](255) NULL,
	[IdNumber] [varchar](255) NOT NULL,
	[membership] [int] NOT NULL,
	[password] [varchar](255) NULL,
	[phone] [varchar](255) NULL,
	[username] [varchar](255) NULL,
	[points] [int] NOT NULL,
	[created_at] [datetime2](6) NULL,
	[id_number] [varchar](255) NULL,
	[firstLogin] [int] NULL,
	[first_login] [bit] NULL,
 CONSTRAINT [PK_members] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_members_email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_members_IdNumber] UNIQUE NONCLUSTERED 
(
	[IdNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UQ_members_phone] UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[members] ADD  CONSTRAINT [DF_Members_Points]  DEFAULT ((0)) FOR [points]
GO

ALTER TABLE [dbo].[members]  WITH CHECK ADD  CONSTRAINT [FK_members_membership] FOREIGN KEY([membership])
REFERENCES [dbo].[MembershipLevel] ([level])
GO

ALTER TABLE [dbo].[members] CHECK CONSTRAINT [FK_members_membership]
GO
SET IDENTITY_INSERT [dbo].[members] ON;
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (1, 'user001', '台北市中山區中山北路一段1號', '1988-03-15', '2024-09-11 00:00:00', 'user001@email.com', '男', 'A123556789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912344478', '王大明', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (2, 'user002', '台北市大安區復興南路二段2號', '1975-07-22', '2024-09-25 00:00:00', 'user002@email.com', '女', 'B223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0923456789', '林美玲', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (3, 'user003', '新北市板橋區文化路三段3號', '1992-11-30', '2024-10-09 00:00:00', 'user003@email.com', '男', 'C123456789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0934567890', '張志明', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (4, 'user004', '台中市西區民生路四段4號', '1983-05-18', '2024-10-23 00:00:00', 'user004@email.com', '女', 'D223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0945678901', '陳婷婷', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (5, 'user005', '高雄市前金區中正路五段5號', '1995-09-25', '2024-11-06 00:00:00', 'user005@email.com', '男', 'E123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956789012', '李明宏', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (6, 'binchen01222', '基隆市仁愛區松江南路19號', '1993-11-04', '2025-01-18 16:42:29', 'binchen012@gmail.com', '女', 'A246569003', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0921430159', '陳丙醇', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (7, 'froggychiu01111', '基隆市中正區義二路89巷29號', '1980-02-19', '2025-01-18 16:44:08', 'froggychiu@gmail.com', '男', 'C120274018', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0955777451', '邱傑威', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (8, 'jason8884', '臺北市萬華區台北市萬華區東園街119巷', '1966-05-23', '2025-01-18 16:45:28', 'jason@gmail.com', '男', 'A192881681', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0931538471', '林凱翔', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (9, 'chin0923', '臺北市信義區林口街111號1樓', '2025-01-14', '2025-01-18 16:47:30', 'wei0923@hotmail.com', '女', 'F200397293', 4, 'ASD123asd@@', '0920159430', '杜言欣', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (10, 'user010', '基隆市中正區中正路十段10號', '1993-04-05', '2025-01-15 00:00:00', 'user010@email.com', '女', 'J223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901234567', '謝佳君', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (11, 'user011', '台北市信義區信義路一段11號', '1985-08-20', '2024-09-18 00:00:00', 'user011@email.com', '男', 'K124446789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912345679', '郭建宏', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (12, 'user012', '新北市永和區永和路二段12號', '1977-01-15', '2024-10-02 00:00:00', 'user012@email.com', '女', 'L223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0923456780', '許雅芬', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (13, 'user013', '台中市北區三民路三段13號', '1990-05-30', '2024-10-16 00:00:00', 'user013@email.com', '男', 'M123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0934567891', '鄭明德', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (14, 'user014', '高雄市苓雅區成功路四段14號', '1982-09-12', '2024-10-30 00:00:00', 'user014@email.com', '女', 'N223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0945678902', '周淑華', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (15, 'ebaotong', '臺北市中正區北平西路3號100', '2025-01-01', '2025-01-18 16:47:30', 'ebaotong@gmail.com', '男', 'K123456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912345678', 'e保通', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (16, 'user016', '桃園市楊梅區大成路六段16號', '1973-03-08', '2024-11-27 00:00:00', 'user016@email.com', '女', 'P223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967890124', '曾雅玲', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (17, 'user017', '新竹市北區經國路七段17號', '1988-07-19', '2024-12-11 00:00:00', 'user017@email.com', '男', 'Q123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0978901235', '薛志強', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (19, 'user019', '基隆市仁愛區仁愛路九段19號', '1979-02-28', '2025-01-08 00:00:00', 'user019@email.com', '男', 'S123456789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0990123457', '藍建銘', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (20, 'dila777666', '臺北市信義區林口街111號1樓', '1984-10-20', '2025-01-24 18:53:00', 'dila777666@example.com', '男', 'A119261996', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0977100000', '迪拉胖', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (21, 'user021', '新北市中和區中和路一段21號', '1986-10-07', '2024-09-30 00:00:00', 'user021@email.com', '男', 'U123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912345670', '龍志文', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (22, 'user022', '台中市南區建國路二段22號', '1976-01-31', '2024-10-14 00:00:00', 'user022@email.com', '女', 'V223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0923456781', '沈雅文', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (23, 'user023', '高雄市三民區三民路三段23號', '1991-05-16', '2024-10-28 00:00:00', 'user023@email.com', '男', 'W123456789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0934567892', '江志賢', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (24, 'user024', '台南市永康區永康路四段24號', '1984-09-28', '2024-11-11 00:00:00', 'user024@email.com', '女', 'X223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0945678903', '金美珠', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (25, 'user025', '桃園市龜山區文化路五段25號', '1997-12-10', '2024-11-25 00:00:00', 'user025@email.com', '男', 'Y123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956789014', '宋建業', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (26, 'user026', '新竹市香山區中華路六段26號', '1972-04-23', '2024-12-09 00:00:00', 'user026@email.com', '女', 'Z223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967890125', '巫雅婷', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (27, 'user027', '嘉義市西區民權路七段27號', '1989-08-05', '2024-12-23 00:00:00', 'user027@email.com', '男', 'A123456780', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0978901236', '范志平', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (28, 'user028', '基隆市信義區信二路八段28號', '1967-11-18', '2025-01-06 00:00:00', 'user028@email.com', '女', 'B223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0989012347', '侯雅芳', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (29, 'user029', '台北市松山區松山路九段29號', '1980-03-01', '2025-01-20 00:00:00', 'user029@email.com', '男', 'C123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0990123458', '柯建成', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (30, 'user030', '新北市三重區三和路十段30號', '1995-06-24', '2025-02-13 00:00:00', 'user030@email.com', '女', 'D223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901234569', '卓雅惠', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (31, 'user031', '台北市萬華區西寧路一段31號', '1965-04-15', '2024-09-13 00:00:00', 'user031@email.com', '男', 'E123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912567834', '石建國', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (32, 'user032', '新北市新莊區新莊路二段32號', '1993-05-10', '2024-09-27 00:00:00', 'user032@email.com', '女', 'F223456780', 3, 'ASD123asd@@', '0923567845', '林雅茹', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (33, 'user033', '台中市豐原區中正路三段33號', '1991-12-30', '2024-10-11 00:00:00', 'user033@email.com', '男', 'G123456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0921430856', '唐志成', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (34, 'user034', '高雄市鳳山區鳳山路四段34號', '1984-06-18', '2024-10-25 00:00:00', 'user034@email.com', '女', 'H223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0933555888', '孫美麗', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (35, 'user035', '台南市新營區民生路五段35號', '1996-10-25', '2024-11-08 00:00:00', 'user035@email.com', '男', 'I123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956669078', '徐明勳', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (36, 'user036', '桃園市八德區介壽路六段36號', '1969-01-03', '2024-11-22 00:00:00', 'user036@email.com', '女', 'J223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967891119', '高雅萱', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (37, 'user037', '新竹市東區民權路七段37號', '1988-03-14', '2024-12-06 00:00:00', 'user037@email.com', '男', 'K123456780', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0911101290', '張志遠', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (38, 'user038', '嘉義市西區民族路八段38號', '1999-07-29', '2024-12-20 00:00:00', 'user038@email.com', '女', 'L223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0989088801', '莊雅琳', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (39, 'user039', '基隆市安樂區安樂路九段39號', '1977-11-11', '2025-01-03 00:00:00', 'user039@email.com', '男', 'M123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0999993412', '郭志明', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (40, 'user040', '台北市大同區重慶北路40號', '1994-05-05', '2025-01-17 00:00:00', 'user040@email.com', '女', 'N223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901232013', '陳美玉', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (41, 'user041', '新北市土城區學府路一段41號', '1986-09-20', '2024-09-20 00:00:00', 'user041@email.com', '男', 'O123456780', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912999634', '彭建志', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (42, 'user042', '台中市大里區大里路二段42號', '1973-02-15', '2024-10-04 00:00:00', 'user042@email.com', '女', 'P223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0923485245', '曾雅芝', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (43, 'user043', '高雄市岡山區岡山路三段43號', '1992-06-30', '2024-10-18 00:00:00', 'user043@email.com', '男', 'Q123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0934567666', '程志豪', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (44, 'user044', '台南市麻豆區中山路四段44號', '1981-10-12', '2024-11-01 00:00:00', 'user044@email.com', '女', 'R223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0945678751', '黃雅玲', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (45, 'user045', '桃園市平鎮區環南路五段45號', '1997-01-25', '2024-11-15 00:00:00', 'user045@email.com', '男', 'S123456780', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956789541', '楊志偉', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (46, 'user046', '新竹市香山區中華路六段46號', '1974-04-08', '2024-11-29 00:00:00', 'user046@email.com', '女', 'T223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967890159', '葉雅惠', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (47, 'user047', '嘉義市東區民生路七段47號', '1987-08-19', '2024-12-13 00:00:00', 'user047@email.com', '男', 'U123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0978901966', '廖建華', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (48, 'user048', '基隆市中山區中山路八段48號', '1968-12-02', '2024-12-27 00:00:00', 'user048@email.com', '女', 'V223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0989012881', '趙雅婷', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (49, 'user049', '台北市士林區文林路九段49號', '1979-03-28', '2025-01-10 00:00:00', 'user049@email.com', '男', 'W123456780', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0990123442', '劉志強', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (50, 'user050', '新北市淡水區中正路50號', '1993-07-14', '2025-01-24 00:00:00', 'user050@email.com', '女', 'X223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901234423', '蕭雅文', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (51, 'user051', '台中市潭子區中山路一段51號', '1985-11-07', '2024-10-02 00:00:00', 'user051@email.com', '男', 'Y123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912375634', '謝建銘', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (52, 'user052', '高雄市小港區小港路二段52號', '1975-02-28', '2024-10-16 00:00:00', 'user052@email.com', '女', 'Z223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0923476745', '鄭雅君', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (53, 'user053', '台南市白河區中正路三段53號', '1990-06-16', '2024-10-30 00:00:00', 'user053@email.com', '男', 'A123456781', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0934467856', '賴志豪', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (54, 'user054', '桃園市大溪區介壽路四段54號', '1983-10-28', '2024-11-13 00:00:00', 'user054@email.com', '女', 'B223456781', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0949678967', '龍雅芳', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (55, 'user055', '新竹市北區光復路五段55號', '1998-01-10', '2024-11-27 00:00:00', 'user055@email.com', '男', 'C123456781', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956799078', '韓建志', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (56, 'user056', '嘉義市西區民族路六段56號', '1971-05-23', '2024-12-11 00:00:00', 'user056@email.com', '女', 'D223456781', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967877189', '魏雅玲', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (57, 'user057', '基隆市七堵區明德一路七段57號', '1988-09-05', '2024-12-25 00:00:00', 'user057@email.com', '男', 'E123456781', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0978801290', '羅志遠', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (58, 'user058', '台北市北投區中央北路八段58號', '1966-12-18', '2025-01-08 00:00:00', 'user058@email.com', '女', 'F223456781', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0988812301', '蘇雅琪', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (59, 'user059', '新北市林口區文化路九段59號', '1981-04-01', '2025-01-22 00:00:00', 'user059@email.com', '男', 'G123456781', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0990553412', '馮建成', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (60, 'user060', '台中市太平區中山路十段60號', '1994-07-24', '2025-02-13 00:00:00', 'user060@email.com', '女', 'H223456781', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901277523', '盧雅萍', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (87, 'user006', '台南市東區長榮路六段6號', '1970-12-03', '2024-11-20 00:00:00', 'user006@email.com', '女', 'F223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967890123', '吳美芳', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (88, 'user007', '桃園市中壢區環中東路七段7號', '1987-02-14', '2024-12-04 00:00:00', 'user007@email.com', '男', 'G123456789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0978901234', '周建志', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (89, 'user008', '新竹市東區光復路八段8號', '1998-06-29', '2024-12-18 00:00:00', 'user008@email.com', '女', 'H223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0989012345', '楊雅婷', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (90, 'user009', '嘉義市西區民生路九段9號', '1978-10-11', '2025-01-01 00:00:00', 'user009@email.com', '男', 'I123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0990123456', '黃志偉', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (91, 'user015', '台南市安平區建平路五段15號', '1996-12-25', '2024-11-13 00:00:00', 'user015@email.com', '男', 'O123456789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956789013', '洪志豪', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (92, 'user018', '嘉義市東區忠孝路八段18號', '1999-11-02', '2024-12-25 00:00:00', 'user018@email.com', '女', 'R223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0989012346', '趙雅琪', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (93, 'user020', '台北市內湖區內湖路十段20號', '1994-06-14', '2025-01-22 00:00:00', 'user020@email.com', '女', 'T223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901234568', '方淑娟', 0, NULL, '', 0, 0);
SET IDENTITY_INSERT [dbo].[members] OFF;


--驗證碼
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VerificationCode](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[member_id] [int] NOT NULL,
	[code] [nvarchar](50) NOT NULL,
	[expiry_date] [datetime] NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[VerificationCode] ADD  DEFAULT (getdate()) FOR [created_at]
GO

ALTER TABLE [dbo].[VerificationCode]  WITH CHECK ADD FOREIGN KEY([member_id])
REFERENCES [dbo].[members] ([id])
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VerificationCodeBean](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[code] [varchar](255) NOT NULL,
	[expiryDate] [datetime2](6) NOT NULL,
	[member_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[VerificationCodeBean]  WITH CHECK ADD  CONSTRAINT [FK1xmth886u8v4qb4h2wt3r22lg] FOREIGN KEY([member_id])
REFERENCES [dbo].[members] ([id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[VerificationCodeBean] CHECK CONSTRAINT [FK1xmth886u8v4qb4h2wt3r22lg]
GO


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--商品購買
--投保人資料 (有圖片)--
CREATE TABLE dbo.travelClient2 (
    insuranceNumber NVARCHAR(50) PRIMARY KEY,
    account VARCHAR(255),
	bonusPoints INT,
    username NVARCHAR(50),
    id_number NVARCHAR(10),
    birthday DATE,
    gender NVARCHAR(10),
    phone NVARCHAR(50),
    email NVARCHAR(50),
    address NVARCHAR(255),
    product NVARCHAR(50),
    location NVARCHAR(50),
    startTime DATE,
    endTime DATE,
    sumAssured NVARCHAR(50),
    medicalTreatment INT,
    overseasIllness INT,
    overseasFlights INT,
    premiums INT,
	totalCost INT,
	profilePicture VARBINARY(MAX),
    updateTime DATETIME2(0) DEFAULT GETDATE()
);

INSERT INTO dbo.travelClient2 (
    insuranceNumber, account, bonusPoints, username, id_number, birthday, gender, phone, email, address, 
    product, location, startTime, endTime, sumAssured, medicalTreatment, overseasIllness, overseasFlights, premiums, totalCost, profilePicture, updateTime
) 
VALUES
('T0001', 'jason8884',9 ,'王大明', 'A178594789', '1994-10-10', '男', '0900000001', 'test1@gmail.com', '台北市南港區', '旅平險', '台灣', '2024-08-01', '2024-08-06', '300W', 80, 180, 150, 72, 482, NULL, '2024-11-11T11:08:00'),
('T0002', 'jason8884',11 ,'陳大偉', 'H105239385', '1992-05-15', '男', '0900000002', 'test2@gmail.com', '桃園市桃園區', '旅平險', '日韓', '2024-08-01', '2024-08-04', '700W', 80, 180, 150, 155, 565, NULL, '2024-07-05T11:08:00'),
('T0003', 'chin0923',14 ,'李大美', 'F294976699', '1960-02-02', '女', '0900000003', 'test3@gmail.com', '新北市板橋區', '旅平險', '日韓', '2024-08-20', '2024-08-20', '1000W', 80, 180, 150, 290, 700, NULL, '2025-04-15T11:08:00'),
('T0004', 'insuranceco2024', 10,'張慧君', 'A223456789', '1985-08-22', '女', '0900000004', 'test4@gmail.com', '高雄市前鎮區', '旅平險', '歐洲', '2024-07-05', '2024-07-12', '500W', 80, 180, 150, 120, 530, NULL, '2024-11-20T11:08:00'),
('T0005', 'jason8884',12 ,'陳志強', 'H198765432', '1968-03-15', '男', '0900000005', 'test5@gmail.com', '台中市南區', '旅平險', '東南亞', '2024-02-10', '2024-02-17', '1000W', 80, 180, 150, 200, 610, NULL, '2024-01-30T11:08:00'),
('T0006', 'froggychiu01111',9 ,'李美華', 'F212233445', '1995-12-30', '女', '0900000006', 'test6@gmail.com', '新竹市東區', '旅平險', '東南亞', '2024-02-15', '2024-02-22', '300W', 80, 180, 150, 70, 480, NULL, '2024-10-05T11:08:00'),
('T0007', 'jason8884',10 ,'王金平', 'A198877665', '1990-06-18', '男', '0900000007', 'test7@gmail.com', '台北市大安區', '旅平險', '歐洲', '2024-07-25', '2024-07-01', '300W', 80, 180, 150, 130, 540, NULL, '2024-01-01T11:08:00'),
('T0008', 'jason8884',12 ,'劉美玲', 'F267788990', '1980-11-05', '女', '0900000008', 'test8@gmail.com', '基隆市仁愛區', '旅平險', '美加', '2024-12-20', '2024-12-27', '1000W', 80, 180, 150, 220, 630, NULL, '2024-11-25T11:08:00'),
('T0009', 'froggychiu01111',10 ,'蔡英文', 'F223344556', '1983-01-30', '女', '0900000009', 'test9@gmail.com', '台中市西屯區', '旅平險', '紐澳', '2024-07-05', '2024-07-12', '500W', 80, 180, 150, 110, 520, NULL, '2024-11-10T11:08:00'),
('T0010', 'chin0923',11 ,'黃淑芬', 'F298877665', '1998-04-12', '女', '0900000010', 'test10@gmail.com', '桃園市龜山區', '旅平險', '東南亞', '2024-07-30', '2024-07-07', '700W', 80, 180, 150, 180, 590, NULL, '2024-10-15T11:08:00'),


('T0031', 'chin0923',3 , '張明偉', 'A456789013', '1985-09-12', '男', '0900000031', 'test31@gmail.com', '台北市萬華區', '登山險', '雪山', '2024-07-01', '2024-07-03', '200W', 0, 0, 0, 150, 150,NULL, '2024-06-20T11:08:00'),
('T0032', 'insuranceco2024',3,'鍾小華', 'A567890124', '1995-11-23', '女', '0900000032', 'test32@gmail.com', '新北市中和區', '登山險', '雪山', '2024-07-15', '2024-07-18', '200W', 0, 0, 0, 180, 180,NULL, '2024-07-12T11:08:00'),
('T0033', 'froggychiu01111',4,'王大志', 'A678901235', '1990-02-15', '男', '0900000033', 'test33@gmail.com', '高雄市鼓山區', '登山險', '玉山', '2024-08-20', '2024-08-24', '200W', 0, 0, 0, 200, 200,NULL, '2024-08-20T11:08:00'),
('T0034', 'chin0923',3,'林小麗', 'A789012346', '1982-07-18', '女', '0900000034', 'test34@gmail.com', '台南市中西區', '登山險', '陽明山', '2024-04-28', '2024-04-28', '100W', 0, 0, 0, 170, 170,NULL, '2024-04-10T11:08:00'),
('T0035', 'chin0923',3,'呂大偉', 'A890123457', '1978-04-25', '男', '0900000035', 'test35@gmail.com', '台中市北屯區', '登山險', '陽明山', '2024-09-05', '2024-09-05', '100W', 0, 0, 0, 190, 190,NULL, '2024-09-01T11:08:00'),
('T0036', 'binchen01222',2,'劉麗華', 'A901234578', '1999-05-20', '女', '0900000036', 'test36@gmail.com', '桃園市龜山區', '登山險', '中央尖山', '2024-06-22', '2024-06-25', '200W', 0, 0, 0, 130, 130,NULL, '2024-06-01T11:08:00'),
('T0037', 'binchen01222',3,'林育炫', 'A012345689', '1980-11-29', '女', '0900000037', 'test37@gmail.com', '台南市安平區', '登山險', '大霸尖山', '2024-08-10', '2024-08-11', '200W', 0, 0, 0, 150, 150,NULL, '2024-07-20T11:08:00'),
('T0038', 'froggychiu01111',4,'陳大壯', 'A123456791', '1971-07-10', '男', '0900000038', 'test38@gmail.com', '高雄市鳳山區', '登山險', '奇萊山', '2024-10-01', '2024-10-02', '200W', 0, 0, 0, 220, 220,NULL, '2024-12-25T11:08:00'),
('T0039', 'binchen01222',4,'王青俊', 'A234567892', '1995-03-15', '男', '0900000039', 'test39@gmail.com', '台北市大安區', '登山險', '雪山', '2024-06-03', '2024-06-03', '200W', 0, 0, 0, 200, 200,NULL, '2024-05-05T11:08:00'),
('T0040', 'jason8884',5,'胡中壢', 'A345678903', '1988-05-25', '女', '0900000040', 'test40@gmail.com', '新竹市東區', '登山險', '七星山', '2024-09-18', '2024-09-18', '100W', 0, 0, 0, 250, 250,NULL, '2024-09-01T11:08:00');


--更新table中圖片--
UPDATE dbo.travelClient2
SET profilePicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java專題2_總資料_Spring_front_1_31\profile圖檔\profile1.jpg', SINGLE_BLOB) AS Image
)
WHERE insuranceNumber IN ('T0001', 'T0002', 'T0003', 'T0004', 'T0005', 'T0006', 'T0007', 'T0008', 'T0009',
'T0010', 'T0031', 'T0032', 'T0033', 'T0034', 'T0035', 'T0036', 'T0037', 'T0038', 'T0039', 'T0040');

--更改日期資料型態--
ALTER TABLE travelClient2 ALTER COLUMN startTime DATE;
ALTER TABLE travelClient2 ALTER COLUMN endTime DATE;


--受益人資料
CREATE TABLE dbo.beneficiary (
    insuranceNumber NVARCHAR(50) PRIMARY KEY,
    relationship NVARCHAR(50),
    beneficiaryName NVARCHAR(50),
    beneficiaryID NVARCHAR(10),
    beneficiaryBirthday DATE,
    beneficiaryGender NVARCHAR(10),
    beneficiaryPhone NVARCHAR(50),
    beneficiaryAddress NVARCHAR(255)
);

INSERT INTO dbo.beneficiary (
    insuranceNumber, relationship, beneficiaryName, beneficiaryID, 
    beneficiaryBirthday, beneficiaryGender, beneficiaryPhone, beneficiaryAddress
)
VALUES
('T0001', '本人', '王大明', 'A178594789', '1994-10-10', '男', '0900000001', '台北市南港區'),
('T0002', '配偶', '黃小虎', 'H240779262', '1995-08-15', '女', '0900000002', '桃園市桃園區'),
('T0003', '母子', '李大頭', 'A123341925', '1990-08-15', '男', '0900000003', '新北市板橋區'),
('T0004', '母子', '張志強', 'Z123456789', '1980-01-20', '男', '0900000004', '高雄市苓雅區'),
('T0005', '父女', '劉淑華', 'L287654321', '1978-04-15', '女', '0900000005', '台北市大安區'),
('T0006', '配偶', '張大明', 'Z134567890', '1992-03-10', '男', '0900000006', '台中市南區'),
('T0007', '配偶', '張小芳', 'Z245678901', '1995-07-25', '女', '0900000007', '新北市永和區'),
('T0008', '配偶', '李志強', 'L156789012', '1985-09-30', '男', '0900000008', '高雄市前鎮區'),
('T0009', '母女', '林月娥', 'L267890123', '1987-12-05', '女', '0900000009', '台南市東區'),
('T0010', '(外)孫子女', '王小華', 'W178901234', '1970-05-18', '男', '0900000010', '台中市北區'),

('T0031', '本人', '張明偉', 'A198745692', '1985-09-12', '男', '0900000031', '台北市松山區'),
('T0032', '配偶', '林美麗', 'H256789104', '1990-03-20', '女', '0900000032', '新北市三重區'),
('T0033', '母子', '黃大明', 'A143567892', '1988-07-15', '男', '0900000033', '高雄市前鎮區'),
('T0034', '母子', '李小強', 'Z145678902', '1992-11-25', '男', '0900000034', '台中市北區'),
('T0035', '父女', '劉小華', 'L287456123', '1983-05-15', '女', '0900000035', '台北市士林區'),
('T0036', '配偶', '王大偉', 'Z134789025', '1994-02-22', '男', '0900000036', '台南市東區'),
('T0037', '配偶', '張慧玲', 'Z245789103', '1989-08-15', '女', '0900000037', '新竹市香山區'),
('T0038', '配偶', '李志偉', 'L156780923', '1987-12-30', '男', '0900000038', '高雄市小港區'),
('T0039', '母女', '林秀華', 'L267801234', '1984-10-05', '女', '0900000039', '台南市南區'),
('T0040', '(外)孫子女', '王大華', 'W178902345', '1975-06-18', '男', '0900000040', '台中市西屯區');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

drop table InsuranceProduct;
drop table InsuranceCategory;


--商品種類
CREATE TABLE InsuranceCategory (
	CategoryID  int IDENTITY(1,1) PRIMARY KEY,
	CategoryName nvarchar(10) NOT NULL,
);

CREATE TABLE InsuranceProduct (
	ProductID  int IDENTITY(1,1) PRIMARY KEY,
	ProductName nvarchar(20) NOT NULL,
	ProductPicture VARBINARY(MAX),
	ProductDescription NVARCHAR(MAX),
	CategoryID  int NOT NULL,
	IsFeatured  BIT NOT NULL DEFAULT 0,
FOREIGN KEY (CategoryID) REFERENCES InsuranceCategory (CategoryID)
);


INSERT INTO InsuranceCategory
	VALUES ('旅平險'),('登山險'),('醫療險'),('意外險'),('壽險');

INSERT INTO InsuranceProduct 
	VALUES 
    ('國內外旅平險', NULL, '保障國內外旅遊期間的意外事故與醫療需求', 1, 1),
    ('登山險', NULL, '登山活動專屬保障，涵蓋意外及醫療費用', 2, 1),
    ('住院醫療保險', NULL, '住院期間的醫療費用全面保障', 3, 1),
('重大疾病險', NULL, '涵蓋七項重度重大疾病特製保障', 3, 1),
    ('傷害保險', NULL, '意外受傷的醫療與賠償保障', 4, 0),
    ('執行業務 傷害保險', NULL, '工作風險無憂，專業保障隨行', 4, 1),
   ('長短年期 定期壽險', NULL,  '彈性年期，保障安心，滿足不同人生階段需求', 5, 0),
('小額終身壽險', NULL, '低門檻終身保障，輕鬆守護摯愛未來',5,1),
('大額終身壽險', NULL, '高額保障，財富傳承，給家人穩固的未來',5,0)

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java專題2_總資料_Spring_front_1_31\保險產品圖片\國內外旅平險.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 1;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java專題2_總資料_Spring_front_1_31\保險產品圖片\登山險.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 2;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java專題2_總資料_Spring_front_1_31\保險產品圖片\住院醫療險.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 3;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java專題2_總資料_Spring_front_1_31\保險產品圖片\重大疾病險.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 4;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java專題2_總資料_Spring_front_1_31\保險產品圖片\傷害保險.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 5;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java專題2_總資料_Spring_front_1_31\保險產品圖片\業務意外險.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 6;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java專題2_總資料_Spring_front_1_31\保險產品圖片\定期壽險.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 7;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java專題2_總資料_Spring_front_1_31\保險產品圖片\小額終身壽險.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 8;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java專題2_總資料_Spring_front_1_31\保險產品圖片\大額終身壽險.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 9;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  drop table InsuranceClaim;

CREATE TABLE InsuranceClaim (
    policyNumber VARCHAR(50) PRIMARY KEY,           -- 保單號碼 (文字，主鍵)
	id_number VARCHAR(50),                          --身分證字號
    policyName NVARCHAR(100) NOT NULL,               -- 保單名稱 (文字)
    clientName NVARCHAR(100) NOT NULL,            -- 名字 (文字)

    proveFile NVARCHAR(100),                        -- 證明文件
	idCopy NVARCHAR (100),                             --身分證
    accountCopy NVARCHAR(100),                       -- 帳戶影本檔案 (PDF 檔案路徑)
    claimStatus NVARCHAR(100),					-- 理賠進度 (文字)
    
    applicationDate DATE NOT NULL,                  -- 申請日期 (日期)
	comment NVARCHAR(300),                         --備註欄
    claimAmount VARCHAR(50),                        --理賠金額

 
   
    address NVARCHAR(500),                   -- 居住地址
    phone VARCHAR(20),                      -- 行動電話
    email VARCHAR(100),            -- 電子郵件（必填，用於通知）
    accidentReason NVARCHAR(300),                    -- 事故原因
    
    claimCategories NVARCHAR(255),           -- 理賠類別（多選，用逗號分隔存儲）
    beneficiaryName NVARCHAR(100),            -- 受益人姓名
	beneficiaryID VARCHAR(20),              --受益人身分證字號
    bankCode VARCHAR(10),                   -- 銀行代號
    accountCode VARCHAR(100),                -- 行庫帳號
	signature VARCHAR(max),                     -- 簽名檔案 base64
    reviewer NVARCHAR(20),                     --審核人員
   	
)				 

INSERT INTO InsuranceClaim (
    policyNumber, policyName, clientName, applicationDate, claimStatus,email
) VALUES
('T0005', '旅平險', '陳志強', '2025-01-31', '待審核','30439lucy@gmail.ocm'),
('T0006', '旅平險', '李美華', '2025-01-30', '待審核','30439lucy@gmail.ocm');



    update travelClient2
set id_number = 'A123456789'
where insuranceNumber IN('T0002','T0003','T0004','T0001','T0005')



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--紅利商城 商品--
CREATE TABLE bonusproduct (

productno	decimal(4)	PRIMARY KEY,			--商品編號
productname 	varchar(100)	NOT NULL,		--商品名稱
category varchar(30)	NOT NULL,				--商品分類
cost	int	NOT NULL,							--需要點數
productimage	varchar(MAX),					--圖片
count int	NOT NULL,							--兌換次數
);

INSERT INTO bonusproduct (productno, productname, category, cost, productimage, count)
VALUES 
(1001, '超商折價券25元', '便利生活', 25, '/BonusMallPic/超商折價券25元.jpg', 100),
(1002, '超商折價券50元', '便利生活', 50, '/BonusMallPic/超商折價券50元.jpg', 101),
(1003, '超商折價券100元', '便利生活', 100, '/BonusMallPic/超商折價券100元.jpg', 130),
(1004, 'City Cafe 中杯熱美式咖啡', '便利生活', 35, '/BonusMallPic/City Cafe 中杯熱美式咖啡.jpg', 150),
(1005, 'City Cafe 大杯熱美式咖啡', '便利生活', 45, '/BonusMallPic/City Cafe 大杯熱美式咖啡.jpg', 200),
(1006, 'City Cafe 特大杯熱美式咖啡', '便利生活', 60, '/BonusMallPic/City Cafe 特大杯熱美式咖啡.jpg', 10),
(1007, 'City Cafe 中杯熱拿鐵咖啡', '便利生活', 35, '/BonusMallPic/City Cafe 中杯熱拿鐵咖啡.jpg', 20),
(1008, 'City Cafe 大杯熱拿鐵咖啡', '便利生活', 45, '/BonusMallPic/City Cafe 大杯熱拿鐵咖啡.jpg', 30),
(1009, 'City Cafe 特大杯熱拿鐵咖啡', '便利生活', 60, '/BonusMallPic/City Cafe 特大杯熱拿鐵咖啡.jpg', 40),
(1010, 'CITY PRIMA 精品美式', '便利生活', 80, '/BonusMallPic/CITY PRIMA 精品美式.jpg', 50),
(1011, 'CITY PRIMA 精品冰美式', '便利生活', 80, '/BonusMallPic/CITY PRIMA 精品冰美式.jpg', 60),
(1012, 'CITY PRIMA 精品拿鐵', '便利生活', 80, '/BonusMallPic/CITY PRIMA 精品拿鐵.jpg', 70),
(1013, 'CITY PRIMA 精品冰拿鐵', '便利生活', 80, '/BonusMallPic/CITY PRIMA 精品冰拿鐵.jpg', 80),
(1014, '統一超商 茶葉蛋', '便利生活', 10, '/BonusMallPic/統一超商 茶葉蛋.jpg', 0),
(1015, '統一超商 熱狗', '便利生活', 30, '/BonusMallPic/統一超商 熱狗.jpg', 20),
(1016, '星巴克 大杯那堤', '星巴克', 180, '/BonusMallPic/星巴克 大杯那堤.jpg', 20),
(1017, '星巴克 大杯美式咖啡', '星巴克', 100, '/BonusMallPic/星巴克 大杯美式咖啡.jpg', 50),
(1018, '星巴克 美式蛋糕組合', '星巴克', 260, '/BonusMallPic/星巴克 美式蛋糕組合.jpg', 50),
(1019, '星巴克 那堤蛋糕組合', '星巴克', 260, '/BonusMallPic/星巴克 那堤蛋糕組合.jpg', 20),
(1020, '星巴克 美式輕食組合', '星巴克', 260, '/BonusMallPic/星巴克 美式輕食組合.jpg', 30),
(1021, 'iRent 汽車60分鐘時數券', '旅遊交通', 120, '/BonusMallPic/iRent 汽車60分鐘時數券.jpg', 10),
(1022, '格上租車 300元租車現金抵用券', '旅遊交通', 300, '/BonusMallPic/格上租車 300元租車現金抵用券.jpg', 10),
(1023, 'yoxi 50元搭車金', '旅遊交通', 50, '/BonusMallPic/yoxi 50元搭車金.jpg', 50),
(1024, 'yoxi 100元搭車金', '旅遊交通', 100, '/BonusMallPic/yoxi 100元搭車金.jpg', 50);

--點數--
CREATE TABLE points(
    username NVARCHAR(150) NOT NULL,	-- 使用者姓名
    email NVARCHAR(150) NOT NULL,		-- 電子郵件
    points int NOT NULL,				--點數
);

INSERT INTO points (
    username, email, points) 
VALUES
('陳丙醇', 'binchen012@gmail.com', 200),
('邱傑威', 'froggychiu@gmail.com', 200),
('林凱翔', 'jason@gmail.com', 200),
('杜言欣', 'wei0923@hotmail.com', 200);

--兌換紀錄--
CREATE TABLE bonushistory(
    id INT IDENTITY(1,1) PRIMARY KEY,   -- 自增主鍵，會自動生成唯一的 id
    username NVARCHAR(150) NOT NULL,    -- 使用者姓名
    email NVARCHAR(150) NOT NULL,       -- 電子郵件
    productname VARCHAR(100) NOT NULL,  -- 商品名稱
    cost INT NOT NULL,                  -- 需要點數
    date DATE                           -- 兌換時間
);


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--QA--
CREATE TABLE QA (
    QA_id decimal(4) primary key ,        
    question NVARCHAR(MAX) NOT NULL,    
    answer NVARCHAR(MAX) NOT NULL,        
  );

INSERT INTO QA (QA_id, question, answer) VALUES 
(1001, '什麼是保險責任？', '保險責任是保險公司在保險合同中承擔的賠付義務。'), 
(1002, '保險理賠需要哪些材料？', '需要醫療費用單據、病歷證明等資料。'), 
(1003, '理賠審核需要多久？', '通常需要 7-14 個工作日完成審核。'), 
(1004, '什麼是保險金？', '保險金是保險公司在符合條件下支付給被保險人的金額。'),
(1005, '什麼是投保人？', '投保人是指與保險公司訂立保險合同並支付保險費的人。'),
(1006, '什麼是被保險人？', '被保險人是指在保險合同中享有保障的人。'),
(1007, '保單失效後怎麼處理？', '您可以申請保單復效，通常需要補交保險費和健康聲明。'),
(1008, '保險費是如何計算的？', '保險費是根據被保險人的年齡、性別、健康狀況等因素計算的。'),
(1009, '可以提前解約保險嗎？', '可以提前解約，但可能會損失一部分退保金。'),
(1010, '什麼是保險的免責條款？', '免責條款是指保險公司不承擔賠償責任的情況。'),
(1011, '哪些情況下保險不賠償？', '如自殺、酒後駕駛、犯罪行為等情況，保險公司通常不賠償。'),
(1012, '什麼是保單貸款？', '保單貸款是指持有具有現金價值的保單可以向保險公司申請貸款。'),
(1013, '如何查詢保單信息？', '您可以通過保險公司官網或客服熱線查詢保單信息。'),
(1014, '保險的等待期是什麼？', '等待期是指保單生效後一定時間內，保險公司不承擔責任的期間。'),
(1015, '什麼是續保？', '續保是指在保單到期時繼續延長保險保障的一種方式。'),
(1016, '如何更改保險的受益人？', '您可以通過填寫更改申請書並提交保險公司辦理。'),
(1017, '保險公司如何處理理賠申請？', '保險公司會對申請進行審核，確認事故是否在保險責任範圍內。'),
(1018, '什麼是壽險？', '壽險是一種以被保險人生命為保險標的的保險。');

select * from  QA;
DROP TABLE QA;


--Comment--
CREATE TABLE Comment (
   commentid INT PRIMARY KEY,
   topic VARCHAR(255) NOT NULL,
   content VARCHAR(MAX) NOT NULL,
   category VARCHAR(50) NOT NULL,
   userid INT NOT NULL,
   username VARCHAR(255),
   CONSTRAINT FK_Comment_User FOREIGN KEY (userid) REFERENCES members(id)
);

-- 插入資料
INSERT INTO Comment (commentid, topic, content, category, userid) VALUES
(1001, '網站使用體驗', '網站設計簡潔易用，操作方便。', '網站體驗', 3), 
(1002, '理賠服務評價', '理賠過程透明，但時間稍長。', '理賠服務', 6),
(1003, '客服回應速度', '客服回應很快，非常滿意！', '客服服務', 7),
(1004, '保單設計', '保單條款清晰，滿足需求。', '保單設計', 8),
(1005, '優惠活動', '優惠活動吸引力大，但條件較為複雜。', '優惠活動', 9),
(1006, '理賠速度', '理賠速度尚可，但希望能更快。', '理賠服務', 3),
(1007, '網站錯誤修正', '網站存在小錯誤，但修復迅速。', '網站體驗', 6),
(1008, '客服專業度', '客服非常專業，回答問題詳盡。', '客服服務', 7),
(1009, '理賠文件要求', '需要提供的理賠文件過多，稍嫌麻煩。', '理賠服務', 8),
(1010, '客戶回饋機制', '希望能增加更多回饋機制。', '其他', 9),
(1011, '支付方式', '支付方式靈活，選擇多樣。', '其他', 3),
(1012, '手機應用程式', '手機應用設計良好，但偶爾會卡頓。', '網站體驗', 6),
(1013, '理賠金額核算', '理賠金額透明，核算準確。', '理賠服務', 7),
(1014, '客服態度', '客服態度熱情，令人滿意。', '客服服務', 8),
(1015, '網頁速度', '網頁加載速度快，體驗很好。', '網站體驗', 9),
(1016, '保險條款解釋', '條款解釋清楚，無疑問。', '保單設計', 3),
(1017, '保險費用', '費用相較市場略高，但值得信賴。', '保單設計', 6),
(1018, '服務體驗', '整體服務體驗良好，會推薦給朋友。', '其他', 7);

-- 更新用戶名
UPDATE c
SET c.username = m.username
FROM Comment c
INNER JOIN members m ON c.userid = m.id;

-- 查詢資料
SELECT 
   c.commentid,
   c.topic, 
   c.content,
   c.category,
   c.userid,
   m.username
FROM Comment c
INNER JOIN members m ON c.userid = m.id;

--留言區--
DROP TABLE Reply;
CREATE TABLE Reply (
   replyid INT PRIMARY KEY,
   content VARCHAR(MAX) NOT NULL,
   commentid INT NOT NULL,
   userid INT NOT NULL,
  
   CONSTRAINT FK_Reply_User FOREIGN KEY (userid) REFERENCES members(id)
);

INSERT INTO Reply (replyid, content, commentid, userid) VALUES
-- 1001 疑似罹患重大疾病
(1, '建議你可以先去醫院做個詳細檢查，拿到確診報告後再來投保會比較保險，因為如果投保時已經有症狀，之後理賠可能會有爭議。', 1001, 5),
(2, '我之前也是類似情況，後來等到確診完全康復後才投保的，這樣比較不會有理賠糾紛。', 1001, 8),

-- 1002 理賠申請文件
(3, '要特別注意的是診斷證明上要寫明詳細的傷勢和治療過程，我之前申請時就是因為這個被要求補件。', 1002, 3),
(4, '勞保跟保險公司是分開申請的，建議先把醫院的相關文件都準備齊全。', 1002, 7),

-- 1003 手術前保險諮詢
(5, '建議你可以直接寫email給客服，反應比較快，我上次就是用email詢問的。', 1003, 11),

-- 1004 長期照顧險投保建議
(6, '我之前幫父母投保時選擇了年期較短的方案，保費負擔比較不會那麼重。', 1004, 2),
(7, '可以考慮選擇有生前提前給付的方案，這樣理賠會比較有保障。', 1004, 9),
(8, '建議選擇有豁免保費條款的，萬一之後沒收入也比較不用擔心。', 1004, 13),

-- 1005 網路投保優惠方案
(9, '記得看清楚繳費方式，有些優惠只適用於年繳。', 1005, 4),

-- 1006 理賠審核進度查詢
(10, '正常處理時間大概是3-4週，如果超過可以打電話詢問。', 1006, 6),
(11, '建議你準備一下收據正本，通常都會需要補件。', 1006, 12),

-- 1007 網站保單查詢功能異常
(12, '系統維修應該是最近在更新，預計這週就會恢復了。', 1007, 8),

-- 1008 保費調整諮詢
(13, '你可以考慮調整保額，這樣可以降低一點保費。', 1008, 1),
(14, '建議找你的業務員討論，看看有沒有其他合適的組合。', 1008, 10),

-- 1009 實支實付理賠金額疑問
(15, '你可以要求理賠部門提供詳細的理賠計算明細，這樣比較好理解金額的來源。', 1009, 5),

-- 1010 保單解約諮詢
(16, '解約前建議先算一下解約金，有時候損失蠻大的。', 1010, 7),
(17, '可以考慮辦理保單貸款，這樣保障還在。', 1010, 11),

-- 1011 新增保障方案諮詢
(18, '這預算其實蠻夠的，建議考慮重大疾病的附約。', 1011, 3),

-- 1012 APP無法更新保單資料
(19, '試試看清除APP快取，我之前這樣就解決了。', 1012, 9),
(20, '最近系統在更新，等幾天再試試看。', 1012, 13),

-- 1013 癌症理賠申請流程
(21, '等待期一般是30天，建議你先把相關檢查報告準備好。', 1013, 2),
(22, '記得要附上病理報告，這個最重要。', 1013, 6),
(23, '可以先跟業務員確認一下理賠項目，有些檢查費用也可以申請。', 1013, 12),

-- 1014 保單內容變更服務
(24, '你可以試試看官網的線上變更功能，某些項目已經可以線上處理了。', 1014, 4),

-- 1015 網路投保系統操作問題
(25, '建議你先截圖存檔，之後重新填寫比較保險。', 1015, 8),
(26, '我遇過一樣的情況，換個瀏覽器就可以了。', 1015, 11),

-- 1016 醫療險投保年齡限制
(27, '現在有些公司有推出針對老年人的專案，保費會比較高但還是可以投保。', 1016, 1),
(28, '建議選擇實支實付型的，理賠比較沒爭議。', 1016, 7),

-- 1017 理賠金額分期付款
(29, '分期付款通常要主動提出申請，建議先詢問理賠部門。', 1017, 5),

-- 1018 保單借款諮詢
(30, '保單借款的利率一般都比銀行低，但要注意借款金額不要超過保單價值準備金。', 1018, 10),
(31, '記得要評估還款能力，以免影響保障。', 1018, 13),

-- 1019 網路投保優惠活動
(32, '變更內容通常不會影響已享有的優惠，但還是建議先確認一下。', 1019, 3),
(33, '我之前有享受過這個優惠，蠻划算的。', 1019, 9),

-- 1020 保單健檢服務體驗
(34, '建議你直接找業務員做保單健檢，會比較詳細。', 1020, 2),
(35, '線上系統還在優化中，可能要再等等。', 1020, 6);



ALTER TABLE Reply ADD username VARCHAR(255);

ALTER TABLE Reply ADD gender VARCHAR(20);

UPDATE r
SET r.username = m.username
FROM Reply r
INNER JOIN members m ON r.userid = m.id;

UPDATE r
SET r.gender = m.gender
FROM Reply r
INNER JOIN members m ON r.userid = m.id

select * from  Reply;

