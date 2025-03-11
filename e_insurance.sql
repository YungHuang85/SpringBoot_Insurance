--�޲z����ƪ�
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
(1,'���l��', 'EEIT902024001', 'EEIT001', '2024-09-11', 'admin_email', NULL, 0, NULL, '�ӫ~�޲z', NULL),
(2, '�\�ݮf', 'EEIT902024010', 'EEIT010', '2024-09-11', 'admin_email', NULL, 0, NULL, '�`���ݵ��B�Q�װ�', NULL),
(3, 'ù���', 'EEIT902024011', 'EEIT011', '2024-09-11', 'fanglingluoo@gmail.com', NULL, 0, 'image/jpeg', '�޲z�̡B�|���C��', NULL),
(4, '������', 'EEIT902024017', 'EEIT017', '2024-09-11', 'admin_email', NULL, 0, NULL, '�O��޲z', NULL),
(5, '�J���_', 'EEIT902024024', 'EEIT024', '2024-09-11', 'admin_email', NULL, 0, NULL, '�z�ߺ޲z', NULL),
(6, '�\�ǬF', 'EEIT902024028', 'EEIT028', '2024-09-11', 'admin_email', NULL, 0, NULL, '�I���M��', NULL);
SET IDENTITY_INSERT [dbo].[admin] OFF;


--�|������
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

INSERT INTO [insurance].[dbo].[MembershipLevel] ([level], [level_name]) VALUES (1, '���ŷ|��');
INSERT INTO [insurance].[dbo].[MembershipLevel] ([level], [level_name]) VALUES (2, '�ȯŷ|��');
INSERT INTO [insurance].[dbo].[MembershipLevel] ([level], [level_name]) VALUES (3, '�ɯŷ|��');
INSERT INTO [insurance].[dbo].[MembershipLevel] ([level], [level_name]) VALUES (4, '�@��|��');


--�|����ƪ�
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
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (1, 'user001', '�x�_�����s�Ϥ��s�_���@�q1��', '1988-03-15', '2024-09-11 00:00:00', 'user001@email.com', '�k', 'A123556789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912344478', '���j��', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (2, 'user002', '�x�_���j�w�ϴ_���n���G�q2��', '1975-07-22', '2024-09-25 00:00:00', 'user002@email.com', '�k', 'B223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0923456789', '�L����', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (3, 'user003', '�s�_���O���Ϥ�Ƹ��T�q3��', '1992-11-30', '2024-10-09 00:00:00', 'user003@email.com', '�k', 'C123456789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0934567890', '�i�ө�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (4, 'user004', '�x������ϥ��͸��|�q4��', '1983-05-18', '2024-10-23 00:00:00', 'user004@email.com', '�k', 'D223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0945678901', '���@�@', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (5, 'user005', '�������e���Ϥ��������q5��', '1995-09-25', '2024-11-06 00:00:00', 'user005@email.com', '�k', 'E123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956789012', '������', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (6, 'binchen01222', '�򶩥����R�ϪQ���n��19��', '1993-11-04', '2025-01-18 16:42:29', 'binchen012@gmail.com', '�k', 'A246569003', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0921430159', '�����J', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (7, 'froggychiu01111', '�򶩥������ϸq�G��89��29��', '1980-02-19', '2025-01-18 16:44:08', 'froggychiu@gmail.com', '�k', 'C120274018', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0955777451', '���ǫ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (8, 'jason8884', '�O�_���U�ذϥx�_���U�ذϪF���119��', '1966-05-23', '2025-01-18 16:45:28', 'jason@gmail.com', '�k', 'A192881681', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0931538471', '�L�͵�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (9, 'chin0923', '�O�_���H�q�ϪL�f��111��1��', '2025-01-14', '2025-01-18 16:47:30', 'wei0923@hotmail.com', '�k', 'F200397293', 4, 'ASD123asd@@', '0920159430', '�����Y', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (10, 'user010', '�򶩥������Ϥ������Q�q10��', '1993-04-05', '2025-01-15 00:00:00', 'user010@email.com', '�k', 'J223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901234567', '�¨Χg', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (11, 'user011', '�x�_���H�q�ϫH�q���@�q11��', '1985-08-20', '2024-09-18 00:00:00', 'user011@email.com', '�k', 'K124446789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912345679', '���ا�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (12, 'user012', '�s�_���éM�ϥéM���G�q12��', '1977-01-15', '2024-10-02 00:00:00', 'user012@email.com', '�k', 'L223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0923456780', '�\����', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (13, 'user013', '�x�����_�ϤT�����T�q13��', '1990-05-30', '2024-10-16 00:00:00', 'user013@email.com', '�k', 'M123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0934567891', '�G���w', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (14, 'user014', '�������d���Ϧ��\���|�q14��', '1982-09-12', '2024-10-30 00:00:00', 'user014@email.com', '�k', 'N223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0945678902', '�P�Q��', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (15, 'ebaotong', '�O�_�������ϥ_�����3��100', '2025-01-01', '2025-01-18 16:47:30', 'ebaotong@gmail.com', '�k', 'K123456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912345678', 'e�O�q', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (16, 'user016', '��饫�����Ϥj�������q16��', '1973-03-08', '2024-11-27 00:00:00', 'user016@email.com', '�k', 'P223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967890124', '������', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (17, 'user017', '�s�˥��_�ϸg����C�q17��', '1988-07-19', '2024-12-11 00:00:00', 'user017@email.com', '�k', 'Q123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0978901235', '���ӱj', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (19, 'user019', '�򶩥����R�Ϥ��R���E�q19��', '1979-02-28', '2025-01-08 00:00:00', 'user019@email.com', '�k', 'S123456789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0990123457', '�ūػ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (20, 'dila777666', '�O�_���H�q�ϪL�f��111��1��', '1984-10-20', '2025-01-24 18:53:00', 'dila777666@example.com', '�k', 'A119261996', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0977100000', '�}�ԭD', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (21, 'user021', '�s�_�����M�Ϥ��M���@�q21��', '1986-10-07', '2024-09-30 00:00:00', 'user021@email.com', '�k', 'U123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912345670', '�s�Ӥ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (22, 'user022', '�x�����n�ϫذ���G�q22��', '1976-01-31', '2024-10-14 00:00:00', 'user022@email.com', '�k', 'V223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0923456781', '�H����', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (23, 'user023', '�������T���ϤT�����T�q23��', '1991-05-16', '2024-10-28 00:00:00', 'user023@email.com', '�k', 'W123456789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0934567892', '���ӽ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (24, 'user024', '�x�n���ñd�ϥñd���|�q24��', '1984-09-28', '2024-11-11 00:00:00', 'user024@email.com', '�k', 'X223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0945678903', '�����]', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (25, 'user025', '��饫�t�s�Ϥ�Ƹ����q25��', '1997-12-10', '2024-11-25 00:00:00', 'user025@email.com', '�k', 'Y123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956789014', '���ط~', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (26, 'user026', '�s�˥����s�Ϥ��ظ����q26��', '1972-04-23', '2024-12-09 00:00:00', 'user026@email.com', '�k', 'Z223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967890125', '�Ŷ��@', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (27, 'user027', '�Ÿq����ϥ��v���C�q27��', '1989-08-05', '2024-12-23 00:00:00', 'user027@email.com', '�k', 'A123456780', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0978901236', '�S�ӥ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (28, 'user028', '�򶩥��H�q�ϫH�G���K�q28��', '1967-11-18', '2025-01-06 00:00:00', 'user028@email.com', '�k', 'B223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0989012347', '�J����', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (29, 'user029', '�x�_���Q�s�ϪQ�s���E�q29��', '1980-03-01', '2025-01-20 00:00:00', 'user029@email.com', '�k', 'C123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0990123458', '�_�ئ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (30, 'user030', '�s�_���T���ϤT�M���Q�q30��', '1995-06-24', '2025-02-13 00:00:00', 'user030@email.com', '�k', 'D223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901234569', '�����f', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (31, 'user031', '�x�_���U�ذϦ����@�q31��', '1965-04-15', '2024-09-13 00:00:00', 'user031@email.com', '�k', 'E123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912567834', '�۫ذ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (32, 'user032', '�s�_���s���Ϸs�����G�q32��', '1993-05-10', '2024-09-27 00:00:00', 'user032@email.com', '�k', 'F223456780', 3, 'ASD123asd@@', '0923567845', '�L����', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (33, 'user033', '�x�����׭�Ϥ������T�q33��', '1991-12-30', '2024-10-11 00:00:00', 'user033@email.com', '�k', 'G123456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0921430856', '��Ӧ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (34, 'user034', '��������s�ϻ�s���|�q34��', '1984-06-18', '2024-10-25 00:00:00', 'user034@email.com', '�k', 'H223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0933555888', '�]���R', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (35, 'user035', '�x�n���s��ϥ��͸����q35��', '1996-10-25', '2024-11-08 00:00:00', 'user035@email.com', '�k', 'I123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956669078', '�}����', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (36, 'user036', '��饫�K�w�Ϥ��ظ����q36��', '1969-01-03', '2024-11-22 00:00:00', 'user036@email.com', '�k', 'J223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967891119', '������', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (37, 'user037', '�s�˥��F�ϥ��v���C�q37��', '1988-03-14', '2024-12-06 00:00:00', 'user037@email.com', '�k', 'K123456780', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0911101290', '�i�ӻ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (38, 'user038', '�Ÿq����ϥ��ڸ��K�q38��', '1999-07-29', '2024-12-20 00:00:00', 'user038@email.com', '�k', 'L223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0989088801', '�����Y', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (39, 'user039', '�򶩥��w�ְϦw�ָ��E�q39��', '1977-11-11', '2025-01-03 00:00:00', 'user039@email.com', '�k', 'M123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0999993412', '���ө�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (40, 'user040', '�x�_���j�P�ϭ��y�_��40��', '1994-05-05', '2025-01-17 00:00:00', 'user040@email.com', '�k', 'N223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901232013', '������', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (41, 'user041', '�s�_���g���Ͼǩ����@�q41��', '1986-09-20', '2024-09-20 00:00:00', 'user041@email.com', '�k', 'O123456780', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912999634', '�^�ا�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (42, 'user042', '�x�����j���Ϥj�����G�q42��', '1973-02-15', '2024-10-04 00:00:00', 'user042@email.com', '�k', 'P223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0923485245', '������', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (43, 'user043', '���������s�ϩ��s���T�q43��', '1992-06-30', '2024-10-18 00:00:00', 'user043@email.com', '�k', 'Q123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0934567666', '�{�ӻ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (44, 'user044', '�x�n���¨��Ϥ��s���|�q44��', '1981-10-12', '2024-11-01 00:00:00', 'user044@email.com', '�k', 'R223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0945678751', '������', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (45, 'user045', '��饫��������n�����q45��', '1997-01-25', '2024-11-15 00:00:00', 'user045@email.com', '�k', 'S123456780', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956789541', '���Ӱ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (46, 'user046', '�s�˥����s�Ϥ��ظ����q46��', '1974-04-08', '2024-11-29 00:00:00', 'user046@email.com', '�k', 'T223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967890159', '�����f', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (47, 'user047', '�Ÿq���F�ϥ��͸��C�q47��', '1987-08-19', '2024-12-13 00:00:00', 'user047@email.com', '�k', 'U123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0978901966', '���ص�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (48, 'user048', '�򶩥����s�Ϥ��s���K�q48��', '1968-12-02', '2024-12-27 00:00:00', 'user048@email.com', '�k', 'V223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0989012881', '�����@', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (49, 'user049', '�x�_���h�L�Ϥ�L���E�q49��', '1979-03-28', '2025-01-10 00:00:00', 'user049@email.com', '�k', 'W123456780', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0990123442', '�B�ӱj', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (50, 'user050', '�s�_���H���Ϥ�����50��', '1993-07-14', '2025-01-24 00:00:00', 'user050@email.com', '�k', 'X223456780', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901234423', '������', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (51, 'user051', '�x������l�Ϥ��s���@�q51��', '1985-11-07', '2024-10-02 00:00:00', 'user051@email.com', '�k', 'Y123456780', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0912375634', '�«ػ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (52, 'user052', '�������p��Ϥp����G�q52��', '1975-02-28', '2024-10-16 00:00:00', 'user052@email.com', '�k', 'Z223456780', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0923476745', '�G���g', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (53, 'user053', '�x�n���ժe�Ϥ������T�q53��', '1990-06-16', '2024-10-30 00:00:00', 'user053@email.com', '�k', 'A123456781', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0934467856', '��ӻ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (54, 'user054', '��饫�j�˰Ϥ��ظ��|�q54��', '1983-10-28', '2024-11-13 00:00:00', 'user054@email.com', '�k', 'B223456781', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0949678967', '�s����', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (55, 'user055', '�s�˥��_�ϥ��_�����q55��', '1998-01-10', '2024-11-27 00:00:00', 'user055@email.com', '�k', 'C123456781', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956799078', '���ا�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (56, 'user056', '�Ÿq����ϥ��ڸ����q56��', '1971-05-23', '2024-12-11 00:00:00', 'user056@email.com', '�k', 'D223456781', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967877189', '�Q����', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (57, 'user057', '�򶩥��C���ϩ��w�@���C�q57��', '1988-09-05', '2024-12-25 00:00:00', 'user057@email.com', '�k', 'E123456781', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0978801290', 'ù�ӻ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (58, 'user058', '�x�_���_��Ϥ����_���K�q58��', '1966-12-18', '2025-01-08 00:00:00', 'user058@email.com', '�k', 'F223456781', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0988812301', 'Ĭ���X', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (59, 'user059', '�s�_���L�f�Ϥ�Ƹ��E�q59��', '1981-04-01', '2025-01-22 00:00:00', 'user059@email.com', '�k', 'G123456781', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0990553412', '���ئ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (60, 'user060', '�x�����ӥ��Ϥ��s���Q�q60��', '1994-07-24', '2025-02-13 00:00:00', 'user060@email.com', '�k', 'H223456781', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901277523', '�c����', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (87, 'user006', '�x�n���F�Ϫ��a�����q6��', '1970-12-03', '2024-11-20 00:00:00', 'user006@email.com', '�k', 'F223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0967890123', '�d����', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (88, 'user007', '��饫���c�������F���C�q7��', '1987-02-14', '2024-12-04 00:00:00', 'user007@email.com', '�k', 'G123456789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0978901234', '�P�ا�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (89, 'user008', '�s�˥��F�ϥ��_���K�q8��', '1998-06-29', '2024-12-18 00:00:00', 'user008@email.com', '�k', 'H223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0989012345', '�����@', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (90, 'user009', '�Ÿq����ϥ��͸��E�q9��', '1978-10-11', '2025-01-01 00:00:00', 'user009@email.com', '�k', 'I123456789', 2, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0990123456', '���Ӱ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (91, 'user015', '�x�n���w���ϫإ������q15��', '1996-12-25', '2024-11-13 00:00:00', 'user015@email.com', '�k', 'O123456789', 3, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0956789013', '�x�ӻ�', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (92, 'user018', '�Ÿq���F�ϩ������K�q18��', '1999-11-02', '2024-12-25 00:00:00', 'user018@email.com', '�k', 'R223456789', 1, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0989012346', '�����X', 0, NULL, '', 0, 0);
INSERT INTO [insurance].[dbo].[members]       ([id], [account], [address], [birthday], [CreatedAt], [email], [gender], [IdNumber], [membership],        [password], [phone], [username], [points], [created_at], [id_number], [firstLogin], [first_login])       VALUES (93, 'user020', '�x�_������Ϥ�����Q�q20��', '1994-06-14', '2025-01-22 00:00:00', 'user020@email.com', '�k', 'T223456789', 4, '4f10e61e8a8b31744f74981fe2742953057aac17831449ef9bcd5f13cafd4e38', '0901234568', '��Q�S', 0, NULL, '', 0, 0);
SET IDENTITY_INSERT [dbo].[members] OFF;


--���ҽX
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

--�ӫ~�ʶR
--��O�H��� (���Ϥ�)--
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
('T0001', 'jason8884',9 ,'���j��', 'A178594789', '1994-10-10', '�k', '0900000001', 'test1@gmail.com', '�x�_���n���', '�ȥ��I', '�x�W', '2024-08-01', '2024-08-06', '300W', 80, 180, 150, 72, 482, NULL, '2024-11-11T11:08:00'),
('T0002', 'jason8884',11 ,'���j��', 'H105239385', '1992-05-15', '�k', '0900000002', 'test2@gmail.com', '��饫����', '�ȥ��I', '����', '2024-08-01', '2024-08-04', '700W', 80, 180, 150, 155, 565, NULL, '2024-07-05T11:08:00'),
('T0003', 'chin0923',14 ,'���j��', 'F294976699', '1960-02-02', '�k', '0900000003', 'test3@gmail.com', '�s�_���O����', '�ȥ��I', '����', '2024-08-20', '2024-08-20', '1000W', 80, 180, 150, 290, 700, NULL, '2025-04-15T11:08:00'),
('T0004', 'insuranceco2024', 10,'�i�z�g', 'A223456789', '1985-08-22', '�k', '0900000004', 'test4@gmail.com', '�������e���', '�ȥ��I', '�ڬw', '2024-07-05', '2024-07-12', '500W', 80, 180, 150, 120, 530, NULL, '2024-11-20T11:08:00'),
('T0005', 'jason8884',12 ,'���ӱj', 'H198765432', '1968-03-15', '�k', '0900000005', 'test5@gmail.com', '�x�����n��', '�ȥ��I', '�F�n��', '2024-02-10', '2024-02-17', '1000W', 80, 180, 150, 200, 610, NULL, '2024-01-30T11:08:00'),
('T0006', 'froggychiu01111',9 ,'������', 'F212233445', '1995-12-30', '�k', '0900000006', 'test6@gmail.com', '�s�˥��F��', '�ȥ��I', '�F�n��', '2024-02-15', '2024-02-22', '300W', 80, 180, 150, 70, 480, NULL, '2024-10-05T11:08:00'),
('T0007', 'jason8884',10 ,'������', 'A198877665', '1990-06-18', '�k', '0900000007', 'test7@gmail.com', '�x�_���j�w��', '�ȥ��I', '�ڬw', '2024-07-25', '2024-07-01', '300W', 80, 180, 150, 130, 540, NULL, '2024-01-01T11:08:00'),
('T0008', 'jason8884',12 ,'�B����', 'F267788990', '1980-11-05', '�k', '0900000008', 'test8@gmail.com', '�򶩥����R��', '�ȥ��I', '���[', '2024-12-20', '2024-12-27', '1000W', 80, 180, 150, 220, 630, NULL, '2024-11-25T11:08:00'),
('T0009', 'froggychiu01111',10 ,'���^��', 'F223344556', '1983-01-30', '�k', '0900000009', 'test9@gmail.com', '�x������ٰ�', '�ȥ��I', '�ÿD', '2024-07-05', '2024-07-12', '500W', 80, 180, 150, 110, 520, NULL, '2024-11-10T11:08:00'),
('T0010', 'chin0923',11 ,'���Q��', 'F298877665', '1998-04-12', '�k', '0900000010', 'test10@gmail.com', '��饫�t�s��', '�ȥ��I', '�F�n��', '2024-07-30', '2024-07-07', '700W', 80, 180, 150, 180, 590, NULL, '2024-10-15T11:08:00'),


('T0031', 'chin0923',3 , '�i����', 'A456789013', '1985-09-12', '�k', '0900000031', 'test31@gmail.com', '�x�_���U�ذ�', '�n�s�I', '���s', '2024-07-01', '2024-07-03', '200W', 0, 0, 0, 150, 150,NULL, '2024-06-20T11:08:00'),
('T0032', 'insuranceco2024',3,'��p��', 'A567890124', '1995-11-23', '�k', '0900000032', 'test32@gmail.com', '�s�_�����M��', '�n�s�I', '���s', '2024-07-15', '2024-07-18', '200W', 0, 0, 0, 180, 180,NULL, '2024-07-12T11:08:00'),
('T0033', 'froggychiu01111',4,'���j��', 'A678901235', '1990-02-15', '�k', '0900000033', 'test33@gmail.com', '���������s��', '�n�s�I', '�ɤs', '2024-08-20', '2024-08-24', '200W', 0, 0, 0, 200, 200,NULL, '2024-08-20T11:08:00'),
('T0034', 'chin0923',3,'�L�p�R', 'A789012346', '1982-07-18', '�k', '0900000034', 'test34@gmail.com', '�x�n�������', '�n�s�I', '�����s', '2024-04-28', '2024-04-28', '100W', 0, 0, 0, 170, 170,NULL, '2024-04-10T11:08:00'),
('T0035', 'chin0923',3,'�f�j��', 'A890123457', '1978-04-25', '�k', '0900000035', 'test35@gmail.com', '�x�����_�ٰ�', '�n�s�I', '�����s', '2024-09-05', '2024-09-05', '100W', 0, 0, 0, 190, 190,NULL, '2024-09-01T11:08:00'),
('T0036', 'binchen01222',2,'�B�R��', 'A901234578', '1999-05-20', '�k', '0900000036', 'test36@gmail.com', '��饫�t�s��', '�n�s�I', '�����y�s', '2024-06-22', '2024-06-25', '200W', 0, 0, 0, 130, 130,NULL, '2024-06-01T11:08:00'),
('T0037', 'binchen01222',3,'�L�|��', 'A012345689', '1980-11-29', '�k', '0900000037', 'test37@gmail.com', '�x�n���w����', '�n�s�I', '�j�Q�y�s', '2024-08-10', '2024-08-11', '200W', 0, 0, 0, 150, 150,NULL, '2024-07-20T11:08:00'),
('T0038', 'froggychiu01111',4,'���j��', 'A123456791', '1971-07-10', '�k', '0900000038', 'test38@gmail.com', '��������s��', '�n�s�I', '�_�ܤs', '2024-10-01', '2024-10-02', '200W', 0, 0, 0, 220, 220,NULL, '2024-12-25T11:08:00'),
('T0039', 'binchen01222',4,'���C�T', 'A234567892', '1995-03-15', '�k', '0900000039', 'test39@gmail.com', '�x�_���j�w��', '�n�s�I', '���s', '2024-06-03', '2024-06-03', '200W', 0, 0, 0, 200, 200,NULL, '2024-05-05T11:08:00'),
('T0040', 'jason8884',5,'�J���c', 'A345678903', '1988-05-25', '�k', '0900000040', 'test40@gmail.com', '�s�˥��F��', '�n�s�I', '�C�P�s', '2024-09-18', '2024-09-18', '100W', 0, 0, 0, 250, 250,NULL, '2024-09-01T11:08:00');


--��stable���Ϥ�--
UPDATE dbo.travelClient2
SET profilePicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java�M�D2_�`���_Spring_front_1_31\profile����\profile1.jpg', SINGLE_BLOB) AS Image
)
WHERE insuranceNumber IN ('T0001', 'T0002', 'T0003', 'T0004', 'T0005', 'T0006', 'T0007', 'T0008', 'T0009',
'T0010', 'T0031', 'T0032', 'T0033', 'T0034', 'T0035', 'T0036', 'T0037', 'T0038', 'T0039', 'T0040');

--�������ƫ��A--
ALTER TABLE travelClient2 ALTER COLUMN startTime DATE;
ALTER TABLE travelClient2 ALTER COLUMN endTime DATE;


--���q�H���
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
('T0001', '���H', '���j��', 'A178594789', '1994-10-10', '�k', '0900000001', '�x�_���n���'),
('T0002', '�t��', '���p��', 'H240779262', '1995-08-15', '�k', '0900000002', '��饫����'),
('T0003', '���l', '���j�Y', 'A123341925', '1990-08-15', '�k', '0900000003', '�s�_���O����'),
('T0004', '���l', '�i�ӱj', 'Z123456789', '1980-01-20', '�k', '0900000004', '�������d����'),
('T0005', '���k', '�B�Q��', 'L287654321', '1978-04-15', '�k', '0900000005', '�x�_���j�w��'),
('T0006', '�t��', '�i�j��', 'Z134567890', '1992-03-10', '�k', '0900000006', '�x�����n��'),
('T0007', '�t��', '�i�p��', 'Z245678901', '1995-07-25', '�k', '0900000007', '�s�_���éM��'),
('T0008', '�t��', '���ӱj', 'L156789012', '1985-09-30', '�k', '0900000008', '�������e���'),
('T0009', '���k', '�L��Z', 'L267890123', '1987-12-05', '�k', '0900000009', '�x�n���F��'),
('T0010', '(�~)�]�l�k', '���p��', 'W178901234', '1970-05-18', '�k', '0900000010', '�x�����_��'),

('T0031', '���H', '�i����', 'A198745692', '1985-09-12', '�k', '0900000031', '�x�_���Q�s��'),
('T0032', '�t��', '�L���R', 'H256789104', '1990-03-20', '�k', '0900000032', '�s�_���T����'),
('T0033', '���l', '���j��', 'A143567892', '1988-07-15', '�k', '0900000033', '�������e���'),
('T0034', '���l', '���p�j', 'Z145678902', '1992-11-25', '�k', '0900000034', '�x�����_��'),
('T0035', '���k', '�B�p��', 'L287456123', '1983-05-15', '�k', '0900000035', '�x�_���h�L��'),
('T0036', '�t��', '���j��', 'Z134789025', '1994-02-22', '�k', '0900000036', '�x�n���F��'),
('T0037', '�t��', '�i�z��', 'Z245789103', '1989-08-15', '�k', '0900000037', '�s�˥����s��'),
('T0038', '�t��', '���Ӱ�', 'L156780923', '1987-12-30', '�k', '0900000038', '�������p���'),
('T0039', '���k', '�L�q��', 'L267801234', '1984-10-05', '�k', '0900000039', '�x�n���n��'),
('T0040', '(�~)�]�l�k', '���j��', 'W178902345', '1975-06-18', '�k', '0900000040', '�x������ٰ�');

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

drop table InsuranceProduct;
drop table InsuranceCategory;


--�ӫ~����
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
	VALUES ('�ȥ��I'),('�n�s�I'),('�����I'),('�N�~�I'),('���I');

INSERT INTO InsuranceProduct 
	VALUES 
    ('�ꤺ�~�ȥ��I', NULL, '�O�ٰꤺ�~�ȹC�������N�~�ƬG�P�����ݨD', 1, 1),
    ('�n�s�I', NULL, '�n�s���ʱM�ݫO�١A�[�\�N�~�������O��', 2, 1),
    ('��|�����O�I', NULL, '��|�����������O�Υ����O��', 3, 1),
('���j�e�f�I', NULL, '�[�\�C�����׭��j�e�f�S�s�O��', 3, 1),
    ('�ˮ`�O�I', NULL, '�N�~���˪������P���v�O��', 4, 0),
    ('����~�� �ˮ`�O�I', NULL, '�u�@���I�L�~�A�M�~�O���H��', 4, 1),
   ('���u�~�� �w�����I', NULL,  '�u�ʦ~���A�O�٦w�ߡA�������P�H�Ͷ��q�ݨD', 5, 0),
('�p�B�ר����I', NULL, '�C���e�ר��O�١A���P�u�@���R����',5,1),
('�j�B�ר����I', NULL, '���B�O�١A�]�I�ǩӡA���a�Hí�T������',5,0)

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java�M�D2_�`���_Spring_front_1_31\�O�I���~�Ϥ�\�ꤺ�~�ȥ��I.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 1;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java�M�D2_�`���_Spring_front_1_31\�O�I���~�Ϥ�\�n�s�I.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 2;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java�M�D2_�`���_Spring_front_1_31\�O�I���~�Ϥ�\��|�����I.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 3;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java�M�D2_�`���_Spring_front_1_31\�O�I���~�Ϥ�\���j�e�f�I.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 4;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java�M�D2_�`���_Spring_front_1_31\�O�I���~�Ϥ�\�ˮ`�O�I.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 5;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java�M�D2_�`���_Spring_front_1_31\�O�I���~�Ϥ�\�~�ȷN�~�I.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 6;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java�M�D2_�`���_Spring_front_1_31\�O�I���~�Ϥ�\�w�����I.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 7;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java�M�D2_�`���_Spring_front_1_31\�O�I���~�Ϥ�\�p�B�ר����I.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 8;

UPDATE InsuranceProduct
SET ProductPicture = (
    SELECT BulkColumn
    FROM OPENROWSET(BULK N'C:\Users\user\Desktop\Java�M�D2_�`���_Spring_front_1_31\�O�I���~�Ϥ�\�j�B�ר����I.jpg', SINGLE_BLOB) AS Image
)
WHERE ProductID = 9;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

  drop table InsuranceClaim;

CREATE TABLE InsuranceClaim (
    policyNumber VARCHAR(50) PRIMARY KEY,           -- �O�渹�X (��r�A�D��)
	id_number VARCHAR(50),                          --�����Ҧr��
    policyName NVARCHAR(100) NOT NULL,               -- �O��W�� (��r)
    clientName NVARCHAR(100) NOT NULL,            -- �W�r (��r)

    proveFile NVARCHAR(100),                        -- �ҩ����
	idCopy NVARCHAR (100),                             --������
    accountCopy NVARCHAR(100),                       -- �b��v���ɮ� (PDF �ɮ׸��|)
    claimStatus NVARCHAR(100),					-- �z�߶i�� (��r)
    
    applicationDate DATE NOT NULL,                  -- �ӽФ�� (���)
	comment NVARCHAR(300),                         --�Ƶ���
    claimAmount VARCHAR(50),                        --�z�ߪ��B

 
   
    address NVARCHAR(500),                   -- �~��a�}
    phone VARCHAR(20),                      -- ��ʹq��
    email VARCHAR(100),            -- �q�l�l��]����A�Ω�q���^
    accidentReason NVARCHAR(300),                    -- �ƬG��]
    
    claimCategories NVARCHAR(255),           -- �z�����O�]�h��A�γr�����j�s�x�^
    beneficiaryName NVARCHAR(100),            -- ���q�H�m�W
	beneficiaryID VARCHAR(20),              --���q�H�����Ҧr��
    bankCode VARCHAR(10),                   -- �Ȧ�N��
    accountCode VARCHAR(100),                -- ��w�b��
	signature VARCHAR(max),                     -- ñ�W�ɮ� base64
    reviewer NVARCHAR(20),                     --�f�֤H��
   	
)				 

INSERT INTO InsuranceClaim (
    policyNumber, policyName, clientName, applicationDate, claimStatus,email
) VALUES
('T0005', '�ȥ��I', '���ӱj', '2025-01-31', '�ݼf��','30439lucy@gmail.ocm'),
('T0006', '�ȥ��I', '������', '2025-01-30', '�ݼf��','30439lucy@gmail.ocm');



    update travelClient2
set id_number = 'A123456789'
where insuranceNumber IN('T0002','T0003','T0004','T0001','T0005')



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--���Q�ӫ� �ӫ~--
CREATE TABLE bonusproduct (

productno	decimal(4)	PRIMARY KEY,			--�ӫ~�s��
productname 	varchar(100)	NOT NULL,		--�ӫ~�W��
category varchar(30)	NOT NULL,				--�ӫ~����
cost	int	NOT NULL,							--�ݭn�I��
productimage	varchar(MAX),					--�Ϥ�
count int	NOT NULL,							--�I������
);

INSERT INTO bonusproduct (productno, productname, category, cost, productimage, count)
VALUES 
(1001, '�W�ӧ����25��', '�K�Q�ͬ�', 25, '/BonusMallPic/�W�ӧ����25��.jpg', 100),
(1002, '�W�ӧ����50��', '�K�Q�ͬ�', 50, '/BonusMallPic/�W�ӧ����50��.jpg', 101),
(1003, '�W�ӧ����100��', '�K�Q�ͬ�', 100, '/BonusMallPic/�W�ӧ����100��.jpg', 130),
(1004, 'City Cafe ���M�������@��', '�K�Q�ͬ�', 35, '/BonusMallPic/City Cafe ���M�������@��.jpg', 150),
(1005, 'City Cafe �j�M�������@��', '�K�Q�ͬ�', 45, '/BonusMallPic/City Cafe �j�M�������@��.jpg', 200),
(1006, 'City Cafe �S�j�M�������@��', '�K�Q�ͬ�', 60, '/BonusMallPic/City Cafe �S�j�M�������@��.jpg', 10),
(1007, 'City Cafe ���M�����K�@��', '�K�Q�ͬ�', 35, '/BonusMallPic/City Cafe ���M�����K�@��.jpg', 20),
(1008, 'City Cafe �j�M�����K�@��', '�K�Q�ͬ�', 45, '/BonusMallPic/City Cafe �j�M�����K�@��.jpg', 30),
(1009, 'City Cafe �S�j�M�����K�@��', '�K�Q�ͬ�', 60, '/BonusMallPic/City Cafe �S�j�M�����K�@��.jpg', 40),
(1010, 'CITY PRIMA ��~����', '�K�Q�ͬ�', 80, '/BonusMallPic/CITY PRIMA ��~����.jpg', 50),
(1011, 'CITY PRIMA ��~�B����', '�K�Q�ͬ�', 80, '/BonusMallPic/CITY PRIMA ��~�B����.jpg', 60),
(1012, 'CITY PRIMA ��~���K', '�K�Q�ͬ�', 80, '/BonusMallPic/CITY PRIMA ��~���K.jpg', 70),
(1013, 'CITY PRIMA ��~�B���K', '�K�Q�ͬ�', 80, '/BonusMallPic/CITY PRIMA ��~�B���K.jpg', 80),
(1014, '�Τ@�W�� �����J', '�K�Q�ͬ�', 10, '/BonusMallPic/�Τ@�W�� �����J.jpg', 0),
(1015, '�Τ@�W�� ����', '�K�Q�ͬ�', 30, '/BonusMallPic/�Τ@�W�� ����.jpg', 20),
(1016, '�P�ڧJ �j�M����', '�P�ڧJ', 180, '/BonusMallPic/�P�ڧJ �j�M����.jpg', 20),
(1017, '�P�ڧJ �j�M�����@��', '�P�ڧJ', 100, '/BonusMallPic/�P�ڧJ �j�M�����@��.jpg', 50),
(1018, '�P�ڧJ �����J�|�զX', '�P�ڧJ', 260, '/BonusMallPic/�P�ڧJ �����J�|�զX.jpg', 50),
(1019, '�P�ڧJ �����J�|�զX', '�P�ڧJ', 260, '/BonusMallPic/�P�ڧJ �����J�|�զX.jpg', 20),
(1020, '�P�ڧJ ���������զX', '�P�ڧJ', 260, '/BonusMallPic/�P�ڧJ ���������զX.jpg', 30),
(1021, 'iRent �T��60�����ɼƨ�', '�ȹC��q', 120, '/BonusMallPic/iRent �T��60�����ɼƨ�.jpg', 10),
(1022, '��W���� 300�������{����Ψ�', '�ȹC��q', 300, '/BonusMallPic/��W���� 300�������{����Ψ�.jpg', 10),
(1023, 'yoxi 50���f����', '�ȹC��q', 50, '/BonusMallPic/yoxi 50���f����.jpg', 50),
(1024, 'yoxi 100���f����', '�ȹC��q', 100, '/BonusMallPic/yoxi 100���f����.jpg', 50);

--�I��--
CREATE TABLE points(
    username NVARCHAR(150) NOT NULL,	-- �ϥΪ̩m�W
    email NVARCHAR(150) NOT NULL,		-- �q�l�l��
    points int NOT NULL,				--�I��
);

INSERT INTO points (
    username, email, points) 
VALUES
('�����J', 'binchen012@gmail.com', 200),
('���ǫ�', 'froggychiu@gmail.com', 200),
('�L�͵�', 'jason@gmail.com', 200),
('�����Y', 'wei0923@hotmail.com', 200);

--�I������--
CREATE TABLE bonushistory(
    id INT IDENTITY(1,1) PRIMARY KEY,   -- �ۼW�D��A�|�۰ʥͦ��ߤ@�� id
    username NVARCHAR(150) NOT NULL,    -- �ϥΪ̩m�W
    email NVARCHAR(150) NOT NULL,       -- �q�l�l��
    productname VARCHAR(100) NOT NULL,  -- �ӫ~�W��
    cost INT NOT NULL,                  -- �ݭn�I��
    date DATE                           -- �I���ɶ�
);


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--QA--
CREATE TABLE QA (
    QA_id decimal(4) primary key ,        
    question NVARCHAR(MAX) NOT NULL,    
    answer NVARCHAR(MAX) NOT NULL,        
  );

INSERT INTO QA (QA_id, question, answer) VALUES 
(1001, '����O�O�I�d���H', '�O�I�d���O�O�I���q�b�O�I�X�P���Ӿ᪺�ߥI�q�ȡC'), 
(1002, '�O�I�z�߻ݭn���ǧ��ơH', '�ݭn�����O�γ�ڡB�f���ҩ�����ơC'), 
(1003, '�z�߼f�ֻݭn�h�[�H', '�q�`�ݭn 7-14 �Ӥu�@�駹���f�֡C'), 
(1004, '����O�O�I���H', '�O�I���O�O�I���q�b�ŦX����U��I���Q�O�I�H�����B�C'),
(1005, '����O��O�H�H', '��O�H�O���P�O�I���q�q�߫O�I�X�P�ä�I�O�I�O���H�C'),
(1006, '����O�Q�O�I�H�H', '�Q�O�I�H�O���b�O�I�X�P���ɦ��O�٪��H�C'),
(1007, '�O�楢�ī���B�z�H', '�z�i�H�ӽЫO��_�ġA�q�`�ݭn�ɥ�O�I�O�M���d�n���C'),
(1008, '�O�I�O�O�p��p�⪺�H', '�O�I�O�O�ھڳQ�O�I�H���~�֡B�ʧO�B���d���p���]���p�⪺�C'),
(1009, '�i�H���e�Ѭ��O�I�ܡH', '�i�H���e�Ѭ��A���i��|�l���@�����h�O���C'),
(1010, '����O�O�I���K�d���ڡH', '�K�d���ڬO���O�I���q���Ӿ���v�d�������p�C'),
(1011, '���Ǳ��p�U�O�I�����v�H', '�p�۱��B�s��r�p�B�Ǹo�欰�����p�A�O�I���q�q�`�����v�C'),
(1012, '����O�O��U�ڡH', '�O��U�ڬO�������㦳�{�����Ȫ��O��i�H�V�O�I���q�ӽжU�ڡC'),
(1013, '�p��d�߫O��H���H', '�z�i�H�q�L�O�I���q�x���ΫȪA���u�d�߫O��H���C'),
(1014, '�O�I�����ݴ��O����H', '���ݴ��O���O��ͮī�@�w�ɶ����A�O�I���q���Ӿ�d���������C'),
(1015, '����O��O�H', '��O�O���b�O�������~�򩵪��O�I�O�٪��@�ؤ覡�C'),
(1016, '�p����O�I�����q�H�H', '�z�i�H�q�L��g���ӽЮѨô���O�I���q��z�C'),
(1017, '�O�I���q�p��B�z�z�ߥӽСH', '�O�I���q�|��ӽжi��f�֡A�T�{�ƬG�O�_�b�O�I�d���d�򤺡C'),
(1018, '����O���I�H', '���I�O�@�إH�Q�O�I�H�ͩR���O�I�Ъ����O�I�C');

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

-- ���J���
INSERT INTO Comment (commentid, topic, content, category, userid) VALUES
(1001, '�����ϥ�����', '�����]�p²����ΡA�ާ@��K�C', '��������', 3), 
(1002, '�z�ߪA�ȵ���', '�z�߹L�{�z���A���ɶ��y���C', '�z�ߪA��', 6),
(1003, '�ȪA�^���t��', '�ȪA�^���ܧ֡A�D�`���N�I', '�ȪA�A��', 7),
(1004, '�O��]�p', '�O����ڲM���A�����ݨD�C', '�O��]�p', 8),
(1005, '�u�f����', '�u�f���ʧl�ޤO�j�A��������������C', '�u�f����', 9),
(1006, '�z�߳t��', '�z�߳t�ש|�i�A���Ʊ���֡C', '�z�ߪA��', 3),
(1007, '�������~�ץ�', '�����s�b�p���~�A���״_���t�C', '��������', 6),
(1008, '�ȪA�M�~��', '�ȪA�D�`�M�~�A�^�����D�ԺɡC', '�ȪA�A��', 7),
(1009, '�z�ߤ��n�D', '�ݭn���Ѫ��z�ߤ��L�h�A�y���·СC', '�z�ߪA��', 8),
(1010, '�Ȥ�^�X����', '�Ʊ��W�[��h�^�X����C', '��L', 9),
(1011, '��I�覡', '��I�覡�F���A��ܦh�ˡC', '��L', 3),
(1012, '������ε{��', '������γ]�p�}�n�A�������|�d�y�C', '��������', 6),
(1013, '�z�ߪ��B�ֺ�', '�z�ߪ��B�z���A�ֺ�ǽT�C', '�z�ߪA��', 7),
(1014, '�ȪA�A��', '�ȪA�A�׼����A�O�H���N�C', '�ȪA�A��', 8),
(1015, '�����t��', '�����[���t�ק֡A����ܦn�C', '��������', 9),
(1016, '�O�I���ڸ���', '���ڸ����M���A�L�ðݡC', '�O��]�p', 3),
(1017, '�O�I�O��', '�O�ά۸����������A���ȱo�H��C', '�O��]�p', 6),
(1018, '�A������', '����A������}�n�A�|���˵��B�͡C', '��L', 7);

-- ��s�Τ�W
UPDATE c
SET c.username = m.username
FROM Comment c
INNER JOIN members m ON c.userid = m.id;

-- �d�߸��
SELECT 
   c.commentid,
   c.topic, 
   c.content,
   c.category,
   c.userid,
   m.username
FROM Comment c
INNER JOIN members m ON c.userid = m.id;

--�d����--
DROP TABLE Reply;
CREATE TABLE Reply (
   replyid INT PRIMARY KEY,
   content VARCHAR(MAX) NOT NULL,
   commentid INT NOT NULL,
   userid INT NOT NULL,
  
   CONSTRAINT FK_Reply_User FOREIGN KEY (userid) REFERENCES members(id)
);

INSERT INTO Reply (replyid, content, commentid, userid) VALUES
-- 1001 �æ����w���j�e�f
(1, '��ĳ�A�i�H���h��|���ӸԲ��ˬd�A����T�E���i��A�ӧ�O�|����O�I�A�]���p�G��O�ɤw�g���g���A����z�ߥi��|����ĳ�C', 1001, 5),
(2, '�ڤ��e�]�O�������p�A��ӵ���T�E�����d�_��~��O���A�o�ˤ�����|���z�ߪȯɡC', 1001, 8),

-- 1002 �z�ߥӽФ��
(3, '�n�S�O�`�N���O�E�_�ҩ��W�n�g���ԲӪ��˶թM�v���L�{�A�ڤ��e�ӽЮɴN�O�]���o�ӳQ�n�D�ɥ�C', 1002, 3),
(4, '�ҫO��O�I���q�O���}�ӽЪ��A��ĳ������|��������󳣷ǳƻ����C', 1002, 7),

-- 1003 ��N�e�O�I�Ը�
(5, '��ĳ�A�i�H�����gemail���ȪA�A��������֡A�ڤW���N�O��email�߰ݪ��C', 1003, 11),

-- 1004 �������U�I��O��ĳ
(6, '�ڤ��e��������O�ɿ�ܤF�~�����u����סA�O�O�t�������|���򭫡C', 1004, 2),
(7, '�i�H�Ҽ{��ܦ��ͫe���e���I����סA�o�˲z�߷|������O�١C', 1004, 9),
(8, '��ĳ��ܦ��ŧK�O�O���ڪ��A�U�@����S���J�]������ξ�ߡC', 1004, 13),

-- 1005 ������O�u�f���
(9, '�O�o�ݲM��ú�O�覡�A�����u�f�u�A�Ω�~ú�C', 1005, 4),

-- 1006 �z�߼f�ֶi�׬d��
(10, '���`�B�z�ɶ��j���O3-4�g�A�p�G�W�L�i�H���q�ܸ߰ݡC', 1006, 6),
(11, '��ĳ�A�ǳƤ@�U���ڥ����A�q�`���|�ݭn�ɥ�C', 1006, 12),

-- 1007 �����O��d�ߥ\�ಧ�`
(12, '�t�κ������ӬO�̪�b��s�A�w�p�o�g�N�|��_�F�C', 1007, 8),

-- 1008 �O�O�վ�Ը�
(13, '�A�i�H�Ҽ{�վ�O�B�A�o�˥i�H���C�@�I�O�O�C', 1008, 1),
(14, '��ĳ��A���~�ȭ��Q�סA�ݬݦ��S����L�X�A���զX�C', 1008, 10),

-- 1009 ����I�z�ߪ��B�ð�
(15, '�A�i�H�n�D�z�߳������ѸԲӪ��z�߭p����ӡA�o�ˤ���n�z�Ѫ��B���ӷ��C', 1009, 5),

-- 1010 �O��Ѭ��Ը�
(16, '�Ѭ��e��ĳ����@�U�Ѭ����A���ɭԷl���Z�j���C', 1010, 7),
(17, '�i�H�Ҽ{��z�O��U�ڡA�o�˫O���٦b�C', 1010, 11),

-- 1011 �s�W�O�٤�׿Ը�
(18, '�o�w�����Z�����A��ĳ�Ҽ{���j�e�f�������C', 1011, 3),

-- 1012 APP�L�k��s�O����
(19, '�ոլݲM��APP�֨��A�ڤ��e�o�˴N�ѨM�F�C', 1012, 9),
(20, '�̪�t�Φb��s�A���X�ѦA�ոլݡC', 1012, 13),

-- 1013 ���g�z�ߥӽЬy�{
(21, '���ݴ��@��O30�ѡA��ĳ�A��������ˬd���i�ǳƦn�C', 1013, 2),
(22, '�O�o�n���W�f�z���i�A�o�ӳ̭��n�C', 1013, 6),
(23, '�i�H����~�ȭ��T�{�@�U�z�߶��ءA�����ˬd�O�Τ]�i�H�ӽСC', 1013, 12),

-- 1014 �O�椺�e�ܧ�A��
(24, '�A�i�H�ոլݩx�����u�W�ܧ�\��A�Y�Ƕ��ؤw�g�i�H�u�W�B�z�F�C', 1014, 4),

-- 1015 ������O�t�ξާ@���D
(25, '��ĳ�A���I�Ϧs�ɡA���᭫�s��g����O�I�C', 1015, 8),
(26, '�ڹJ�L�@�˪����p�A�����s�����N�i�H�F�C', 1015, 11),

-- 1016 �����I��O�~�֭���
(27, '�{�b���Ǥ��q�����X�w��Ѧ~�H���M�סA�O�O�|��������٬O�i�H��O�C', 1016, 1),
(28, '��ĳ��ܹ���I�����A�z�ߤ���S��ĳ�C', 1016, 7),

-- 1017 �z�ߪ��B�����I��
(29, '�����I�ڳq�`�n�D�ʴ��X�ӽСA��ĳ���߰ݲz�߳����C', 1017, 5),

-- 1018 �O��ɴڿԸ�
(30, '�O��ɴڪ��Q�v�@�볣��Ȧ�C�A���n�`�N�ɴڪ��B���n�W�L�O����ȷǳƪ��C', 1018, 10),
(31, '�O�o�n�����ٴگ�O�A�H�K�v�T�O�١C', 1018, 13),

-- 1019 ������O�u�f����
(32, '�ܧ󤺮e�q�`���|�v�T�w�ɦ����u�f�A���٬O��ĳ���T�{�@�U�C', 1019, 3),
(33, '�ڤ��e���ɨ��L�o���u�f�A�Z�E�⪺�C', 1019, 9),

-- 1020 �O�氷�˪A������
(34, '��ĳ�A������~�ȭ����O�氷�ˡA�|����ԲӡC', 1020, 2),
(35, '�u�W�t���٦b�u�Ƥ��A�i��n�A�����C', 1020, 6);



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

