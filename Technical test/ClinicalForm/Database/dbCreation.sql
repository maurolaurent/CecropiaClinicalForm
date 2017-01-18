USE [ClinicalForm]
GO
/****** Object:  StoredProcedure [dbo].[GetAllPatients]    Script Date: 1/17/2017 5:51:19 PM ******/
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
/****** Object:  Table [dbo].[Patient]    Script Date: 1/17/2017 5:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Patient](
	[id] [int] NOT NULL,
	[FirstName] [varchar](100) NOT NULL,
	[LastName] [varchar](100) NOT NULL,
	[DateOfBirth] [varchar](20) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[Diseases] [text] NULL,
	[Phone] [varchar](50) NOT NULL,
	[BloodType] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Patient] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ref.BloodType]    Script Date: 1/17/2017 5:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ref.BloodType](
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
/****** Object:  Table [dbo].[Ref.Country]    Script Date: 1/17/2017 5:51:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ref.Country](
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
INSERT [dbo].[Patient] ([id], [FirstName], [LastName], [DateOfBirth], [Country], [Diseases], [Phone], [BloodType]) VALUES (0, N'Mauro', N'Laurent', N'1986/04/10', N'Costa Rica', N'Hypertension', N'(506) 8727-7716', N'B+')
GO
INSERT [dbo].[Patient] ([id], [FirstName], [LastName], [DateOfBirth], [Country], [Diseases], [Phone], [BloodType]) VALUES (1, N'N', N'1', N'1', N'1', N'1', N'1', N'1')
GO
