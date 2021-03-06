USE [master]
GO
/****** Object:  Database [SportsClub_DB]    Script Date: 19/12/2015 11:35:17 AM ******/
CREATE DATABASE [SportsClub_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SportsClub_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\SportsClub_DB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SportsClub_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\SportsClub_DB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SportsClub_DB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SportsClub_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SportsClub_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SportsClub_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SportsClub_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SportsClub_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SportsClub_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SportsClub_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SportsClub_DB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SportsClub_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SportsClub_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SportsClub_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SportsClub_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SportsClub_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SportsClub_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SportsClub_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SportsClub_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SportsClub_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SportsClub_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SportsClub_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SportsClub_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SportsClub_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SportsClub_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SportsClub_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SportsClub_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SportsClub_DB] SET RECOVERY FULL 
GO
ALTER DATABASE [SportsClub_DB] SET  MULTI_USER 
GO
ALTER DATABASE [SportsClub_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SportsClub_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SportsClub_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SportsClub_DB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SportsClub_DB', N'ON'
GO
USE [SportsClub_DB]
GO
/****** Object:  StoredProcedure [dbo].[proc_LevelsDelete]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_LevelsDelete]
(
	@LevelID int
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE
	FROM [Levels]
	WHERE
		[LevelID] = @LevelID
	SET @Err = @@Error

	RETURN @Err
END

GO
/****** Object:  StoredProcedure [dbo].[proc_LevelsInsert]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_LevelsInsert]
(
	@LevelID int = NULL output,
	@LevelName nvarchar(300) = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	INSERT
	INTO [Levels]
	(
		[LevelName]
	)
	VALUES
	(
		@LevelName
	)

	SET @Err = @@Error

	SELECT @LevelID = SCOPE_IDENTITY()

	RETURN @Err
END

GO
/****** Object:  StoredProcedure [dbo].[proc_LevelsLoadAll]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_LevelsLoadAll]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[LevelID],
		[LevelName]
	FROM [Levels]

	SET @Err = @@Error

	RETURN @Err
END

GO
/****** Object:  StoredProcedure [dbo].[proc_LevelsLoadByPrimaryKey]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_LevelsLoadByPrimaryKey]
(
	@LevelID int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[LevelID],
		[LevelName]
	FROM [Levels]
	WHERE
		([LevelID] = @LevelID)

	SET @Err = @@Error

	RETURN @Err
END

GO
/****** Object:  StoredProcedure [dbo].[proc_LevelsUpdate]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_LevelsUpdate]
(
	@LevelID int,
	@LevelName nvarchar(300) = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	UPDATE [Levels]
	SET
		[LevelName] = @LevelName
	WHERE
		[LevelID] = @LevelID


	SET @Err = @@Error


	RETURN @Err
END

GO
/****** Object:  StoredProcedure [dbo].[proc_SportClubMembersDelete]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_SportClubMembersDelete]
(
	@SportClubMembersID int
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	DELETE
	FROM [SportClubMembers]
	WHERE
		[SportClubMembersID] = @SportClubMembersID
	SET @Err = @@Error

	RETURN @Err
END

GO
/****** Object:  StoredProcedure [dbo].[proc_SportClubMembersInsert]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_SportClubMembersInsert]
(
	@SportClubMembersID int = NULL output,
	@MemberName nvarchar(300) = NULL,
	@MemberFitness int = NULL,
	@MemberSpeed int = NULL,
	@MemberTallness int = NULL,
	@MemberWeight int = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	INSERT
	INTO [SportClubMembers]
	(
		[MemberName],
		[MemberFitness],
		[MemberSpeed],
		[MemberTallness],
		[MemberWeight]
	)
	VALUES
	(
		@MemberName,
		@MemberFitness,
		@MemberSpeed,
		@MemberTallness,
		@MemberWeight
	)

	SET @Err = @@Error

	SELECT @SportClubMembersID = SCOPE_IDENTITY()

	RETURN @Err
END

GO
/****** Object:  StoredProcedure [dbo].[proc_SportClubMembersLoadAll]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_SportClubMembersLoadAll]
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[SportClubMembersID],
		[MemberName],
		[MemberFitness],
		[MemberSpeed],
		[MemberTallness],
		[MemberWeight]
	FROM [SportClubMembers]

	SET @Err = @@Error

	RETURN @Err
END

GO
/****** Object:  StoredProcedure [dbo].[proc_SportClubMembersLoadByPrimaryKey]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_SportClubMembersLoadByPrimaryKey]
(
	@SportClubMembersID int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @Err int

	SELECT
		[SportClubMembersID],
		[MemberName],
		[MemberFitness],
		[MemberSpeed],
		[MemberTallness],
		[MemberWeight]
	FROM [SportClubMembers]
	WHERE
		([SportClubMembersID] = @SportClubMembersID)

	SET @Err = @@Error

	RETURN @Err
END

GO
/****** Object:  StoredProcedure [dbo].[proc_SportClubMembersUpdate]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[proc_SportClubMembersUpdate]
(
	@SportClubMembersID int,
	@MemberName nvarchar(300) = NULL,
	@MemberFitness int = NULL,
	@MemberSpeed int = NULL,
	@MemberTallness int = NULL,
	@MemberWeight int = NULL
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	UPDATE [SportClubMembers]
	SET
		[MemberName] = @MemberName,
		[MemberFitness] = @MemberFitness,
		[MemberSpeed] = @MemberSpeed,
		[MemberTallness] = @MemberTallness,
		[MemberWeight] = @MemberWeight
	WHERE
		[SportClubMembersID] = @SportClubMembersID


	SET @Err = @@Error


	RETURN @Err
END

GO
/****** Object:  StoredProcedure [dbo].[SearchMember]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SearchMember] @MemberName nvarchar = Null
as

Select S.SportClubMembersID ID , S.MemberName Name , L.LevelName Fitness , L2.LevelName Speed , L3.LevelName Tallness , L4.LevelName Weight
From SportClubMembers S
inner join Levels L on S.MemberFitness = L.LevelID 
inner join Levels L2 on S.MemberSpeed = L2.LevelID 
inner join Levels L3 on S.MemberTallness = L3.LevelID 
inner join Levels L4 on S.MemberWeight = L4.LevelID 
where S.MemberName like ( N'%'+ @MemberName + N'%')

GO
/****** Object:  Table [dbo].[Levels]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Levels](
	[LevelID] [int] IDENTITY(1,1) NOT NULL,
	[LevelName] [nvarchar](300) NULL,
PRIMARY KEY CLUSTERED 
(
	[LevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SportClubMembers]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SportClubMembers](
	[SportClubMembersID] [int] IDENTITY(1,1) NOT NULL,
	[MemberName] [nvarchar](300) NULL,
	[MemberFitness] [int] NULL,
	[MemberSpeed] [int] NULL,
	[MemberTallness] [int] NULL,
	[MemberWeight] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SportClubMembersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Student]    Script Date: 19/12/2015 11:35:17 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[NameKey] [nchar](3) NOT NULL,
	[NumKey] [int] NOT NULL,
	[StudName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[NameKey] ASC,
	[NumKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Levels] ON 

INSERT [dbo].[Levels] ([LevelID], [LevelName]) VALUES (1, N'Low')
INSERT [dbo].[Levels] ([LevelID], [LevelName]) VALUES (2, N'Medium')
INSERT [dbo].[Levels] ([LevelID], [LevelName]) VALUES (3, N'High')
SET IDENTITY_INSERT [dbo].[Levels] OFF
SET IDENTITY_INSERT [dbo].[SportClubMembers] ON 

INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (1, N'Jan', 1, 1, 2, 2)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (2, N'Andrew', 2, 3, 1, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (9, NULL, 1, 1, 1, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (10, NULL, 1, 1, 1, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (11, NULL, 1, 1, 1, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (12, NULL, 1, 1, 1, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (13, NULL, 1, 1, 1, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (15, NULL, 1, 1, 1, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (16, NULL, 2, 1, 3, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (1024, NULL, 1, 1, 1, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (1029, N'Aya', 3, 1, 2, 2)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (1030, N'Ehab', 2, 1, 3, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (1031, N'John', 1, 2, 2, 3)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (1032, N'Fady', 3, 2, 3, 1)
INSERT [dbo].[SportClubMembers] ([SportClubMembersID], [MemberName], [MemberFitness], [MemberSpeed], [MemberTallness], [MemberWeight]) VALUES (1033, N'frwf', 1, 1, 1, 1)
SET IDENTITY_INSERT [dbo].[SportClubMembers] OFF
INSERT [dbo].[Student] ([NameKey], [NumKey], [StudName]) VALUES (N'GR ', 1, NULL)
INSERT [dbo].[Student] ([NameKey], [NumKey], [StudName]) VALUES (N'MAN', 1, N'ahmed')
INSERT [dbo].[Student] ([NameKey], [NumKey], [StudName]) VALUES (N'MAN', 2, NULL)
ALTER TABLE [dbo].[SportClubMembers]  WITH CHECK ADD FOREIGN KEY([MemberFitness])
REFERENCES [dbo].[Levels] ([LevelID])
GO
ALTER TABLE [dbo].[SportClubMembers]  WITH CHECK ADD FOREIGN KEY([MemberSpeed])
REFERENCES [dbo].[Levels] ([LevelID])
GO
ALTER TABLE [dbo].[SportClubMembers]  WITH CHECK ADD FOREIGN KEY([MemberTallness])
REFERENCES [dbo].[Levels] ([LevelID])
GO
ALTER TABLE [dbo].[SportClubMembers]  WITH CHECK ADD FOREIGN KEY([MemberWeight])
REFERENCES [dbo].[Levels] ([LevelID])
GO
USE [master]
GO
ALTER DATABASE [SportsClub_DB] SET  READ_WRITE 
GO
