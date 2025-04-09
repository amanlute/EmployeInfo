USE [master]
GO
/****** Object:  Database [Employee]    Script Date: 09-04-2025 15:42:56 ******/
CREATE DATABASE [Employee]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Employee', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\Employee.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Employee_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER2019\MSSQL\DATA\Employee_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Employee] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Employee].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Employee] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Employee] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Employee] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Employee] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Employee] SET ARITHABORT OFF 
GO
ALTER DATABASE [Employee] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Employee] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Employee] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Employee] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Employee] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Employee] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Employee] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Employee] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Employee] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Employee] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Employee] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Employee] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Employee] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Employee] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Employee] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Employee] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Employee] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Employee] SET RECOVERY FULL 
GO
ALTER DATABASE [Employee] SET  MULTI_USER 
GO
ALTER DATABASE [Employee] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Employee] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Employee] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Employee] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Employee] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Employee] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Employee', N'ON'
GO
ALTER DATABASE [Employee] SET QUERY_STORE = OFF
GO
USE [Employee]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 09-04-2025 15:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DeptID] [int] IDENTITY(1,1) NOT NULL,
	[DeptName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[DeptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Designation]    Script Date: 09-04-2025 15:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Designation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DesignationName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 09-04-2025 15:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmpID] [int] IDENTITY(1,1) NOT NULL,
	[EmpCode] [varchar](100) NOT NULL,
	[EmpName] [varchar](100) NOT NULL,
	[Gender] [tinyint] NOT NULL,
	[Department] [varchar](100) NOT NULL,
	[Designation] [int] NULL,
	[ImageURL] [varchar](128) NULL,
	[isActiveEmp] [tinyint] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Department] ON 
GO
INSERT [dbo].[Department] ([DeptID], [DeptName]) VALUES (1, N'DevOps')
GO
INSERT [dbo].[Department] ([DeptID], [DeptName]) VALUES (2, N'Flutter')
GO
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
SET IDENTITY_INSERT [dbo].[Designation] ON 
GO
INSERT [dbo].[Designation] ([ID], [DesignationName]) VALUES (1, N'Traniee')
GO
INSERT [dbo].[Designation] ([ID], [DesignationName]) VALUES (2, N'Intern')
GO
INSERT [dbo].[Designation] ([ID], [DesignationName]) VALUES (3, N'Developer')
GO
SET IDENTITY_INSERT [dbo].[Designation] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (1, N'1201', N'Aman Lute', 1, N'2', 3, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (2, N'123422', N'divyanshuuuu', 2, N'1', 2, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (14, N'1201', N'Aman Lute', 1, N'1,2', 2, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (4, N'9', N'abc', 1, N'1,2', 3, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (15, N'6685', N'AMANLUTE', 1, N'2', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (19, N'090909', N'good', 1, N'1', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (20, N'098765', N'Hitesh Sir', 1, N'2', 2, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (21, N'666666', N'ggggggggggggggg', 1, N'2', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (22, N'09877777777777777', N'Sai Sir', 1, N'2', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (23, N'vfbgdfzzzzzzzzzzzzzzzzzzzzzz', N'fdzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz', 1, N'2', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (33, N'758783-85', N'VC NFSdg', 1, N'1', 2, N'/Uploads/aman.jfif_2025_04_04_102032.jfif', 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (34, N'4632775444444446366666666666', N'g nsjjmuthnnnnnbv', 1, N'1', 3, N'/Uploads/6.jpg_2025_04_04_171301.jpg', 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (35, N'A101', N'Gaurav Meshram', 1, N'1,2', 3, N'/Uploads/6.jpg_2025_04_07_173246.jpg', 1)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (38, N'A104', N'Poonam Mankar', 2, N'2', 1, N'/Uploads/6.jpg_2025_04_07_114139.jpg', 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (44, N'A109', N'Rohit B', 1, N'2', 2, N'/Uploads/10.jpg_2025_04_08_104533.jpg', 1)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (46, N'Aman-1', N'dfgfdhnndgdgadf', 1, N'1', 1, N'/Uploads/1.jfif_2025_04_07_171403.jfif', 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (6, N'678', N'goodd', 2, N'1', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (8, N'5555555555555555555555555555', N'DivyanshuMAtaghar', 1, N'1', 2, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (9, N'1', N'aman', 2, N'1', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (10, N'1', N'aman', 2, N'1', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (11, N'00000000', N'miranju', 2, N'1,2', 2, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (12, N'786', N'sir', 2, N'2', 3, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (13, N'1012', N'punam Mankar', 1, N'1,2', 2, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (16, N'1809', N'Apache1604v', 1, N'1', 3, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (17, N'1800', N'Durga Lute', 2, N'1,2', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (18, N'0000000000000000000000000000', N'google', 1, N'2', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (32, N'65656565', N'Sumit', 1, N'1', 2, N'/Uploads/ccbe5938-660d-4431-a2e7-d63e12184f92.jpg_2025_04_02_173033.jpg', 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (24, N'0012', N'akshay arsade', 1, N'2', 1, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (25, N'6557574593479434778888888888', N'Akash Lute', 1, N'2', 2, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (26, N'848732222723979327723238', N'Devendra Lutet', 1, N'2', 2, NULL, 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (31, N'78', N'Arpit Ghate', 1, N'2', 3, N'/Uploads/ca0a8af6-3317-4818-b831-ae4b27baf9c1.jpg_2025_04_02_112151.jpg', 0)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (39, N'A104', N'Aman Lute', 1, N'1,2', 1, N'/Uploads/5.jpg_2025_04_08_104347.jpg', 1)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (40, N'A105', N'Kunal Kharde', 1, N'1', 2, N'/Uploads/7.jpg_2025_04_08_104403.jpg', 1)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (41, N'A106', N'Pratik D', 1, N'2', 2, N'/Uploads/8.jpg_2025_04_08_104421.jpg', 1)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (42, N'A107', N'Poonam Mankar', 1, N'2', 1, N'/Uploads/4.jpg_2025_04_07_151017.jpg', 1)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (43, N'A108', N'Abhishek D', 1, N'1', 3, N'/Uploads/9.jpg_2025_04_08_104519.jpg', 1)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (45, N'A110', N'Rahul Y', 1, N'2', 3, N'/Uploads/12.jpg_2025_04_08_104854.jpg', 1)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (36, N'A102', N'Sujal Meshram', 1, N'2', 2, N'/Uploads/aman.jfif_2025_04_04_171557.jfif', 1)
GO
INSERT [dbo].[Employee] ([EmpID], [EmpCode], [EmpName], [Gender], [Department], [Designation], [ImageURL], [isActiveEmp]) VALUES (37, N'A103', N'Divyanshu Mataghare', 1, N'2', 3, N'/Uploads/2.jpg_2025_04_08_104328.jpg', 1)
GO
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
ALTER TABLE [dbo].[Employee] ADD  DEFAULT ((1)) FOR [isActiveEmp]
GO
/****** Object:  StoredProcedure [dbo].[Employeecrud]    Script Date: 09-04-2025 15:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Employeecrud]
    @EmpID varchar(56),
	@EmpCode varchar(28),
    @EmpName varchar(128),
    @Gender tinyint,
    @Department varchar(56),
    @Designation int,
	@ImageURL varchar(255),
	@Action varchar(56)
AS
BEGIN
	
	if @Action ='INSERT' 
	BEGIN 
	  if @EmpID>0
	  BEGIN

	  UPDATE Employee
	  SET EmpCode=@EmpCode,
	      EmpName=@EmpName,
		  Gender=@Gender,
		  Department=@Department,
		  Designation=@Designation,
		  ImageURL=@ImageURL
	  WHERE EmpID = @EmpID;
	  END
	  Else
	  BEGIN
	     INSERT into Employee 
		 (
		    EmpCode,
		    EmpName,
		    Gender,
		    Department,
		    Designation,
			ImageURL
		  )
	      values 
		  (
		    @EmpCode,
		    @EmpName,
		    @Gender,
			@Department,
			@Designation,
			@ImageURL
		  );
   end
		  end
  
	if @Action = 'Delete'
	   DELETE FROM Employee
	   WHERE EmpID=@EmpID;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetAllEmployee]    Script Date: 09-04-2025 15:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllEmployee]
AS
Begin
    select * from Employee
	End;
GO
/****** Object:  StoredProcedure [dbo].[sp_getData]    Script Date: 09-04-2025 15:42:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec  [dbo].[sp_getData] @Action ='Employee_View',@empid=27
CREATE procedure [dbo].[sp_getData]

       @Action varchar(16),
	   @EmpID int=0

AS
BEGIN

     if @Action ='Employeeget'
	 BEGIN
	  SELECT EmpID, split.value AS dept
    into #temp
    FROM dbo.Employee e
    CROSS APPLY StRING_SPLiT(e.department, ',') AS split




   SELECT e.EmpID , e.EmpCode, e.EmpName, deptName, DD.designationName, gender,e.ImageURL,e.isActiveEmp
   INTO #temp1
   FROM dbo.Employee e
   inner join #temp t on t.EmpID= e.EmpID
   inNER join dbo.Department d ON t.dept=d.DeptID
   inner join  dbo.Designation DD on DD.ID = e.Designation



	SELECT empid, empCode, empName,
	STUFF ((SELECT ',' + deptName
	FROM #temp1 tt WHERE tt.empid = t.empid
	FOR XML PATH('')), 1, 1,'') AS department_name,designationName,gender,isnull(ImageURL,'') as split,isActiveEmp
	INTO #tt
	FROM #temp1 t
	GROUP BY empid, empCode, empName ,designationName, gender,ImageURL,isActiveEmp

 select * from #tt

	 END

	 else if @Action='Departmentget'

	 BEGIN
	 select DeptID,DeptName from Department
	 END

	 ELSE IF @Action='Designationget'

	 BEGIN
	 SELECT id, designationName FROM Designation
	 END

	 ELSE IF @Action='Edit'

	 BEGIN
	 SELECT * FROM Employee where EmpID=@EmpID
	 END


	 ELSE IF @Action='Delete'

	 BEGIN
	 UPDATE Employee SET isActiveEmp=0 where EmpID=@EmpID
	 END

	else if @Action='MakeActive'
	 BEGIN
	 UPDATE Employee SET isActiveEmp=1 where EmpID=@EmpID
	 END


 if @Action ='Employee_View'
BEGIN
	  SELECT EmpID, split.value AS dept
    into #temp_v
    FROM dbo.Employee e
    CROSS APPLY StRING_SPLiT(e.department, ',') AS split




   SELECT e.EmpID , e.EmpCode, e.EmpName, deptName, DD.designationName, gender,e.ImageURL
   INTO #temp1_v
   FROM dbo.Employee e
   inner join #temp_v t on t.EmpID= e.EmpID
   inNER join dbo.Department d ON t.dept=d.DeptID
   inner join  dbo.Designation DD on DD.ID = e.Designation



	SELECT empid, empCode, empName,
	STUFF ((SELECT ',' + deptName
	FROM #temp1_v tt WHERE tt.empid = t.empid
	FOR XML PATH('')), 1, 1,'') AS department_name,designationName,gender,isnull(ImageURL,'') as ImageURL
	INTO #tt_v
	FROM #temp1_v t
	where empid = @empid
	GROUP BY empid, empCode, empName ,designationName, gender,ImageURL

	select * from #tt_v

	 END
   
END;


GO
USE [master]
GO
ALTER DATABASE [Employee] SET  READ_WRITE 
GO
