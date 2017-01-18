USE [master]
GO
/****** Object:  Database [ClinicalForm]    Script Date: 1/18/2017 2:59:47 AM ******/
CREATE DATABASE [ClinicalForm]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ClinicalForm', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ClinicalForm.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ClinicalForm_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ClinicalForm_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ClinicalForm] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClinicalForm].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClinicalForm] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClinicalForm] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClinicalForm] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClinicalForm] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClinicalForm] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClinicalForm] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ClinicalForm] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ClinicalForm] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClinicalForm] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClinicalForm] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClinicalForm] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClinicalForm] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClinicalForm] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClinicalForm] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClinicalForm] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClinicalForm] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ClinicalForm] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClinicalForm] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClinicalForm] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClinicalForm] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClinicalForm] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClinicalForm] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ClinicalForm] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClinicalForm] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ClinicalForm] SET  MULTI_USER 
GO
ALTER DATABASE [ClinicalForm] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClinicalForm] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClinicalForm] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClinicalForm] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ClinicalForm]
GO
/****** Object:  StoredProcedure [dbo].[GetAllPatients]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mauro Laurent
-- Create date: 17/01/2017
-- Description:	Return all patients in database
-- =============================================
CREATE PROCEDURE [dbo].[GetAllPatients]
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT	*
	FROM	Patient

END

GO
/****** Object:  StoredProcedure [dbo].[InsertAuditLog]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mauro Laurent
-- Create date: 17 Jan 2017
-- Description:	Insert an audit log
-- =============================================
CREATE PROCEDURE [dbo].[InsertAuditLog]

		@EventTime DATETIME,
		@Message VARCHAR(1500),
		@StackTrace VARCHAR(5000),
		@Ocurrence VARCHAR(100),
		@IsError INT
	
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO 
		dbo.Audit (EventTime, Message, StackTrace, Ocurrence, IsError )
	VALUES
		(@EventTime, @Message, @StackTrace, @Ocurrence, @IsError)

END

GO
/****** Object:  StoredProcedure [dbo].[op_DeletePatient]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mauro Laurent
-- Create date: 17 Jan 2017
-- Description:	Delete a patient
-- =============================================
CREATE PROCEDURE [dbo].[op_DeletePatient]
	
		@id  int
	
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM Patient
	WHERE Patient.id = @id;
END

GO
/****** Object:  StoredProcedure [dbo].[op_GetBloodTypes]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mauro Laurent
-- Create date: 17 Jan 2017
-- Description:	Inserts a patient
-- =============================================
CREATE PROCEDURE [dbo].[op_GetBloodTypes]		

AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		Id, Antigen, RHFactor
	FROM
		dbo.BloodType
	
END

GO
/****** Object:  StoredProcedure [dbo].[op_GetCountries]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mauro Laurent
-- Create date: 17 Jan 2017
-- Description: Gets system countries
-- =============================================
CREATE PROCEDURE [dbo].[op_GetCountries]		

AS
BEGIN
	SET NOCOUNT ON;

	SELECT 
		Id, Name, Acron
	FROM
		dbo.Country
	
END

GO
/****** Object:  StoredProcedure [dbo].[op_InsertPatient]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mauro Laurent
-- Create date: 17 Jan 2017
-- Description:	Inserts a patient
-- =============================================
CREATE PROCEDURE [dbo].[op_InsertPatient]
			
		@FirstName  varchar(100),
		@LastName  varchar(100),
		@DateOfBirth  varchar(20),
		@Country	varchar(50),
		@Diseases	text,
		@Phone	varchar(50),
		@BloodType	varchar(50)

AS
BEGIN
	SET NOCOUNT ON;
	-- LAST ID INSERTED
	DECLARE @id  INT;


	INSERT INTO
		Patient (FirstName, LastName, DateOfBirth, Country,Diseases, Phone,BloodType)
	VALUES
	(@FirstName, @LastName, @DateOfBirth, @Country,@Diseases, @Phone,@BloodType)
	
END

GO
/****** Object:  StoredProcedure [dbo].[op_UpdatePatient]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mauro Laurent
-- Create date: 17 Jan 2017
-- Description:	Updates a patient
-- =============================================
CREATE PROCEDURE [dbo].[op_UpdatePatient]
	
		@id  int,
		@FirstName  varchar(100),
		@LastName  varchar(100),
		@DateOfBirth  varchar(20),
		@Country	varchar(50),
		@Diseases	text,
		@Phone	varchar(50),
		@BloodType	varchar(50)

	
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE
		Patient
	SET
		FirstName = @FirstName,
		LastName  = @LastName,
		DateOfBirth  = @DateOfBirth,
		Country	= @Country,
		Diseases	= @Diseases,
		Phone	= @Phone,
		BloodType = @BloodType
		
	WHERE Patient.id = @id;
END

GO
/****** Object:  Table [dbo].[Audit]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Audit](
	[EventTime] [datetime] NOT NULL,
	[Message] [varchar](1500) NOT NULL,
	[StackTrace] [varchar](5000) NULL,
	[Ocurrence] [varchar](100) NOT NULL,
	[IsError] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BloodType]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BloodType](
	[Id] [uniqueidentifier] NOT NULL,
	[Antigen] [varchar](5) NOT NULL,
	[RHFactor] [varchar](5) NOT NULL,
 CONSTRAINT [PK_BloodType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Acron] [varchar](3) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 1/18/2017 2:59:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patient](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[DateOfBirth] [varchar](20) NOT NULL,
	[Country] [uniqueidentifier] NOT NULL,
	[Diseases] [text] NULL,
	[Phone] [varchar](50) NOT NULL,
	[BloodType] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Audit] ([EventTime], [Message], [StackTrace], [Ocurrence], [IsError]) VALUES (CAST(0x0000A6FF002DE746 AS DateTime), N'ERROR ON NEW PATIENT INSERTION', N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at System.Data.Entity.Infrastructure.Interception.InternalDispatcher`1.Dispatch[TTarget,TInterceptionContext,TResult](TTarget target, Func`3 operation, TInterceptionContext interceptionContext, Action`3 executing, Action`3 executed)
   at System.Data.Entity.Infrastructure.Interception.DbCommandDispatcher.NonQuery(DbCommand command, DbCommandInterceptionContext interceptionContext)
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.<>c__DisplayClass59.<ExecuteStoreCommand>b__57()
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at ClinicalLib.Rules.AuditCRUD.InsertAuditMessage(Audit audit) in c:\Trabajo\Cecropia\TechTest_Upload\trunk\Technical test\ClinicalForm\ClinicalLib\Rules\AuditCRUD.cs:line 32
   at ClinicalLib.Rules.AuditCRUD.CreateAuditMesssageAndInsertMessage(Boolean IsException, String Message, String Ocurrence, String StackTrace) in c:\Trabajo\Cecropia\TechTest_Upload\trunk\Technical test\ClinicalForm\ClinicalLib\Rules\AuditCRUD.cs:line 50
   at ClinicalWebService.Controllers.PatientsController.Post(View_Patient values) in c:\Trabajo\Cecropia\TechTest_Upload\trunk\Technical test\ClinicalForm\ClinicalWebService\Controllers\PatientsController.cs:line 24', N'PatientsController', 1)
GO
INSERT [dbo].[Audit] ([EventTime], [Message], [StackTrace], [Ocurrence], [IsError]) VALUES (CAST(0x0000A6FF002E15AB AS DateTime), N'ERROR ON NEW PATIENT INSERTION', N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at System.Data.Entity.Infrastructure.Interception.InternalDispatcher`1.Dispatch[TTarget,TInterceptionContext,TResult](TTarget target, Func`3 operation, TInterceptionContext interceptionContext, Action`3 executing, Action`3 executed)
   at System.Data.Entity.Infrastructure.Interception.DbCommandDispatcher.NonQuery(DbCommand command, DbCommandInterceptionContext interceptionContext)
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.<>c__DisplayClass59.<ExecuteStoreCommand>b__57()
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at ClinicalLib.Rules.AuditCRUD.InsertAuditMessage(Audit audit) in c:\Trabajo\Cecropia\TechTest_Upload\trunk\Technical test\ClinicalForm\ClinicalLib\Rules\AuditCRUD.cs:line 32
   at ClinicalLib.Rules.AuditCRUD.CreateAuditMesssageAndInsertMessage(Boolean IsException, String Message, String Ocurrence, String StackTrace) in c:\Trabajo\Cecropia\TechTest_Upload\trunk\Technical test\ClinicalForm\ClinicalLib\Rules\AuditCRUD.cs:line 50
   at ClinicalWebService.Controllers.PatientsController.Post(View_Patient values) in c:\Trabajo\Cecropia\TechTest_Upload\trunk\Technical test\ClinicalForm\ClinicalWebService\Controllers\PatientsController.cs:line 24', N'PatientsController', 1)
GO
INSERT [dbo].[Audit] ([EventTime], [Message], [StackTrace], [Ocurrence], [IsError]) VALUES (CAST(0x0000A6FF002EE21F AS DateTime), N'INITIATE NEW PATIENT INSERTION', N'This is a message log', N'PatientsController', 0)
GO
INSERT [dbo].[Audit] ([EventTime], [Message], [StackTrace], [Ocurrence], [IsError]) VALUES (CAST(0x0000A6FF002EE3C1 AS DateTime), N'FINISHED NEW PATIENT INSERTION', N'This is a message log', N'PatientsController', 0)
GO
INSERT [dbo].[Audit] ([EventTime], [Message], [StackTrace], [Ocurrence], [IsError]) VALUES (CAST(0x0000A6FF002F21A0 AS DateTime), N'INITIATE PATIENT UPDATE', N'This is a message log', N'PatientsController', 0)
GO
INSERT [dbo].[Audit] ([EventTime], [Message], [StackTrace], [Ocurrence], [IsError]) VALUES (CAST(0x0000A6FF002F21E8 AS DateTime), N'FINISHED PATIENT UPDATE', N'This is a message log', N'PatientsController', 0)
GO
INSERT [dbo].[Audit] ([EventTime], [Message], [StackTrace], [Ocurrence], [IsError]) VALUES (CAST(0x0000A6FF002F2C31 AS DateTime), N'INITIATE PATIENT DELETION', N'This is a message log', N'PatientsController', 0)
GO
INSERT [dbo].[Audit] ([EventTime], [Message], [StackTrace], [Ocurrence], [IsError]) VALUES (CAST(0x0000A6FF002F2C35 AS DateTime), N'FINISHED PATIENT DELETION', N'This is a message log', N'PatientsController', 0)
GO
INSERT [dbo].[Audit] ([EventTime], [Message], [StackTrace], [Ocurrence], [IsError]) VALUES (CAST(0x0000A6FF002E776D AS DateTime), N'ERROR ON NEW PATIENT INSERTION', N'   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString, Boolean isInternal, Boolean forDescribeParameterEncryption)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, Boolean inRetry, SqlDataReader ds, Boolean describeParameterEncryptionRequest)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean& usedCache, Boolean asyncWrite, Boolean inRetry)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at System.Data.Entity.Infrastructure.Interception.InternalDispatcher`1.Dispatch[TTarget,TInterceptionContext,TResult](TTarget target, Func`3 operation, TInterceptionContext interceptionContext, Action`3 executing, Action`3 executed)
   at System.Data.Entity.Infrastructure.Interception.DbCommandDispatcher.NonQuery(DbCommand command, DbCommandInterceptionContext interceptionContext)
   at System.Data.Entity.Core.Objects.ObjectContext.ExecuteInTransaction[T](Func`1 func, IDbExecutionStrategy executionStrategy, Boolean startLocalTransaction, Boolean releaseConnectionOnSuccess)
   at System.Data.Entity.Core.Objects.ObjectContext.<>c__DisplayClass59.<ExecuteStoreCommand>b__57()
   at System.Data.Entity.SqlServer.DefaultSqlExecutionStrategy.Execute[TResult](Func`1 operation)
   at ClinicalLib.Rules.AuditCRUD.InsertAuditMessage(Audit audit) in c:\Trabajo\Cecropia\TechTest_Upload\trunk\Technical test\ClinicalForm\ClinicalLib\Rules\AuditCRUD.cs:line 32
   at ClinicalLib.Rules.AuditCRUD.CreateAuditMesssageAndInsertMessage(Boolean IsException, String Message, String Ocurrence, String StackTrace) in c:\Trabajo\Cecropia\TechTest_Upload\trunk\Technical test\ClinicalForm\ClinicalLib\Rules\AuditCRUD.cs:line 50
   at ClinicalWebService.Controllers.PatientsController.Post(View_Patient values) in c:\Trabajo\Cecropia\TechTest_Upload\trunk\Technical test\ClinicalForm\ClinicalWebService\Controllers\PatientsController.cs:line 24', N'PatientsController', 1)
GO
INSERT [dbo].[BloodType] ([Id], [Antigen], [RHFactor]) VALUES (N'28792e36-4501-456a-8850-309aea28c65c', N'AB+', N'+')
GO
INSERT [dbo].[BloodType] ([Id], [Antigen], [RHFactor]) VALUES (N'e6ef9b31-da8b-4c33-a4d6-477641786d4b', N'A-', N'-')
GO
INSERT [dbo].[BloodType] ([Id], [Antigen], [RHFactor]) VALUES (N'23fc833e-4f0d-414e-b37d-536d013e6795', N'O-', N'-')
GO
INSERT [dbo].[BloodType] ([Id], [Antigen], [RHFactor]) VALUES (N'7972d836-e37e-4ddb-b618-66b770f1a215', N'A+', N'+')
GO
INSERT [dbo].[BloodType] ([Id], [Antigen], [RHFactor]) VALUES (N'4f835ccf-1daf-4e96-be76-ab31c15a2091', N'AB-', N'-')
GO
INSERT [dbo].[BloodType] ([Id], [Antigen], [RHFactor]) VALUES (N'c929decb-a677-409d-9461-b2211fa46fe5', N'O+', N'+')
GO
INSERT [dbo].[BloodType] ([Id], [Antigen], [RHFactor]) VALUES (N'3ec65608-267d-4437-ac18-dd745b7729cd', N'B+', N'+')
GO
INSERT [dbo].[BloodType] ([Id], [Antigen], [RHFactor]) VALUES (N'd2e2936a-e4e4-4f3c-892e-eefc3b70567c', N'B-', N'-')
GO
INSERT [dbo].[Country] ([Id], [Name], [Acron]) VALUES (N'a7abb350-0e4d-4ea9-9e88-370f77ae000b', N'Japón', N'JPN')
GO
INSERT [dbo].[Country] ([Id], [Name], [Acron]) VALUES (N'498deed9-c85b-4d08-8926-3a2bb6e6aa97', N'Senegal', N'SEN')
GO
INSERT [dbo].[Country] ([Id], [Name], [Acron]) VALUES (N'38b50e62-c063-4db9-84f1-3a5dfc5f7be3', N'Costa Rica', N'CRC')
GO
INSERT [dbo].[Country] ([Id], [Name], [Acron]) VALUES (N'1132a776-6224-4360-9949-5f31d8bb16f6', N'Paraguay', N'PAR')
GO
INSERT [dbo].[Country] ([Id], [Name], [Acron]) VALUES (N'fd7442e5-9344-4844-afd6-886bbc0890e4', N'United States', N'USA')
GO
SET IDENTITY_INSERT [dbo].[Patient] ON 

GO
INSERT [dbo].[Patient] ([id], [FirstName], [LastName], [DateOfBirth], [Country], [Diseases], [Phone], [BloodType]) VALUES (2, N'Mauro', N'Laurent', N'1986-04-10T06:00:00.', N'38b50e62-c063-4db9-84f1-3a5dfc5f7be3', N'Headaches', N'87277716', N'e6ef9b31-da8b-4c33-a4d6-477641786d4b')
GO
INSERT [dbo].[Patient] ([id], [FirstName], [LastName], [DateOfBirth], [Country], [Diseases], [Phone], [BloodType]) VALUES (4, N'Ngabe', N'Tsugoro', N'1975/03/08 00:00:00', N'498deed9-c85b-4d08-8926-3a2bb6e6aa97', N'Diabetes', N'789456132', N'28792e36-4501-456a-8850-309aea28c65c')
GO
INSERT [dbo].[Patient] ([id], [FirstName], [LastName], [DateOfBirth], [Country], [Diseases], [Phone], [BloodType]) VALUES (5, N'Christina', N'Protti', N'1989/10/19 00:00:00', N'1132a776-6224-4360-9949-5f31d8bb16f6', N'Colitis', N'798456132', N'c929decb-a677-409d-9461-b2211fa46fe5')
GO
INSERT [dbo].[Patient] ([id], [FirstName], [LastName], [DateOfBirth], [Country], [Diseases], [Phone], [BloodType]) VALUES (6, N'Chris', N'Carmack', N'1981/12/17 00:00:00', N'fd7442e5-9344-4844-afd6-886bbc0890e4', N'Bulimia', N'748913245', N'7972d836-e37e-4ddb-b618-66b770f1a215')
GO
SET IDENTITY_INSERT [dbo].[Patient] OFF
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_Country_Country] FOREIGN KEY([Id])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_Country_Country]
GO
ALTER TABLE [dbo].[Country]  WITH CHECK ADD  CONSTRAINT [FK_Country_Country1] FOREIGN KEY([Id])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Country] CHECK CONSTRAINT [FK_Country_Country1]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_BloodType] FOREIGN KEY([BloodType])
REFERENCES [dbo].[BloodType] ([Id])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_BloodType]
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Country] FOREIGN KEY([Country])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Patient] CHECK CONSTRAINT [FK_Patient_Country]
GO
USE [master]
GO
ALTER DATABASE [ClinicalForm] SET  READ_WRITE 
GO
