USE [Employee]
GO
/****** Object:  Schema [employees]    Script Date: 18-10-2021 15:09:03 ******/
CREATE SCHEMA [employees]
GO
/****** Object:  Table [employees].[departments]    Script Date: 18-10-2021 15:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [employees].[departments](
	[dept_no] [nchar](4) NOT NULL,
	[dept_name] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_departments_dept_no] PRIMARY KEY CLUSTERED 
(
	[dept_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [departments$dept_name] UNIQUE NONCLUSTERED 
(
	[dept_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [employees].[dept_emp]    Script Date: 18-10-2021 15:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [employees].[dept_emp](
	[emp_no] [int] NOT NULL,
	[dept_no] [nchar](4) NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL,
 CONSTRAINT [PK_dept_emp_emp_no] PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC,
	[dept_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [employees].[dept_manager]    Script Date: 18-10-2021 15:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [employees].[dept_manager](
	[emp_no] [int] NOT NULL,
	[dept_no] [nchar](4) NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL,
 CONSTRAINT [PK_dept_manager_emp_no] PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC,
	[dept_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [employees].[employees]    Script Date: 18-10-2021 15:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [employees].[employees](
	[emp_no] [int] NOT NULL,
	[birth_date] [date] NOT NULL,
	[first_name] [nvarchar](14) NOT NULL,
	[last_name] [nvarchar](16) NOT NULL,
	[gender] [nvarchar](1) NOT NULL,
	[hire_date] [date] NOT NULL,
 CONSTRAINT [PK_employees_emp_no] PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [employees].[salaries]    Script Date: 18-10-2021 15:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [employees].[salaries](
	[emp_no] [int] NOT NULL,
	[salary] [int] NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NOT NULL,
 CONSTRAINT [PK_salaries_emp_no] PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC,
	[from_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [employees].[titles]    Script Date: 18-10-2021 15:09:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [employees].[titles](
	[emp_no] [int] NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[from_date] [date] NOT NULL,
	[to_date] [date] NULL,
 CONSTRAINT [PK_titles_emp_no] PRIMARY KEY CLUSTERED 
(
	[emp_no] ASC,
	[title] ASC,
	[from_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [employees].[titles] ADD  DEFAULT (NULL) FOR [to_date]
GO
ALTER TABLE [employees].[dept_emp]  WITH NOCHECK ADD  CONSTRAINT [dept_emp$dept_emp_ibfk_1] FOREIGN KEY([emp_no])
REFERENCES [employees].[employees] ([emp_no])
ON DELETE CASCADE
GO
ALTER TABLE [employees].[dept_emp] CHECK CONSTRAINT [dept_emp$dept_emp_ibfk_1]
GO
ALTER TABLE [employees].[dept_emp]  WITH NOCHECK ADD  CONSTRAINT [dept_emp$dept_emp_ibfk_2] FOREIGN KEY([dept_no])
REFERENCES [employees].[departments] ([dept_no])
ON DELETE CASCADE
GO
ALTER TABLE [employees].[dept_emp] CHECK CONSTRAINT [dept_emp$dept_emp_ibfk_2]
GO
ALTER TABLE [employees].[dept_manager]  WITH NOCHECK ADD  CONSTRAINT [dept_manager$dept_manager_ibfk_1] FOREIGN KEY([emp_no])
REFERENCES [employees].[employees] ([emp_no])
ON DELETE CASCADE
GO
ALTER TABLE [employees].[dept_manager] CHECK CONSTRAINT [dept_manager$dept_manager_ibfk_1]
GO
ALTER TABLE [employees].[dept_manager]  WITH NOCHECK ADD  CONSTRAINT [dept_manager$dept_manager_ibfk_2] FOREIGN KEY([dept_no])
REFERENCES [employees].[departments] ([dept_no])
ON DELETE CASCADE
GO
ALTER TABLE [employees].[dept_manager] CHECK CONSTRAINT [dept_manager$dept_manager_ibfk_2]
GO
ALTER TABLE [employees].[salaries]  WITH NOCHECK ADD  CONSTRAINT [salaries$salaries_ibfk_1] FOREIGN KEY([emp_no])
REFERENCES [employees].[employees] ([emp_no])
ON DELETE CASCADE
GO
ALTER TABLE [employees].[salaries] CHECK CONSTRAINT [salaries$salaries_ibfk_1]
GO
ALTER TABLE [employees].[titles]  WITH NOCHECK ADD  CONSTRAINT [titles$titles_ibfk_1] FOREIGN KEY([emp_no])
REFERENCES [employees].[employees] ([emp_no])
ON DELETE CASCADE
GO
ALTER TABLE [employees].[titles] CHECK CONSTRAINT [titles$titles_ibfk_1]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'employees.departments' , @level0type=N'SCHEMA',@level0name=N'employees', @level1type=N'TABLE',@level1name=N'departments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'employees.dept_emp' , @level0type=N'SCHEMA',@level0name=N'employees', @level1type=N'TABLE',@level1name=N'dept_emp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'employees.dept_manager' , @level0type=N'SCHEMA',@level0name=N'employees', @level1type=N'TABLE',@level1name=N'dept_manager'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'employees.employees' , @level0type=N'SCHEMA',@level0name=N'employees', @level1type=N'TABLE',@level1name=N'employees'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'employees.salaries' , @level0type=N'SCHEMA',@level0name=N'employees', @level1type=N'TABLE',@level1name=N'salaries'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_SSMA_SOURCE', @value=N'employees.titles' , @level0type=N'SCHEMA',@level0name=N'employees', @level1type=N'TABLE',@level1name=N'titles'
GO
