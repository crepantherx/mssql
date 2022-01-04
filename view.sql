USE [Covid-19DB]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vwDealPipeline_DealSize]
as
    SELECT DISTINCT(CONVERT(INT, REPLACE(REPLACE(REPLACE(substring(DealSize, 1, charindex(' ', TblProjectPipeline.DealSize + ' ')+1), 'M', '000000'), 'K', '000'), ' ', ''))) as deal_size
, TblProjectPipeline.Geography as project_geography, TblProjectMaster.Project_Name as project_name

    FROM
        TblProjectPipeline
        JOIN TblProjectMaster ON TblProjectPipeline.Project_ID = TblProjectMaster.ID 
GO

create view [dbo].[vwDealPipeline_PreSalesLeaderDealCount]
as
    SELECT DISTINCT(CONVERT(INT, REPLACE(REPLACE(REPLACE(substring(DealSize, 1, charindex(' ', TblProjectPipeline.DealSize + ' ')+1), 'M', '000000'), 'K', '000'), ' ', ''))) as deal_size
, count(distinct(TblEmployee_ProjectMapping.Employee_Name)) as project_pre_sales_leader_count,
        TblEmployee_ProjectMapping.Employee_Name as project_pre_sales_leader,
        TblProjectMaster.Project_Name as project_name,
        TblProjectPipeline.Rainmaker as project_rainmaker,
        TblProjectMaster.Project_Start_Date as project_start_date,
        TblProjectMaster.Project_End_Date as project_end_date,
        TblProjectPipeline.ClientName as project_client_name,
        TblProjectPipeline.ExpectedDuration as project_expected_duration,
        TblProjectPipeline.TechnologyRequired as project_requirement,
        TblProjectPipeline.DealSize as project_deal_size
, TblProjectPipeline.ResourcesRequired_Offshore as project_requirement_offshore,
        TblProjectPipeline.ResourcesRequired_Onshore as project_requirement_onshore,
        TblProjectPipeline.Geography as project_geography
    FROM
        TblProjectMaster
        JOIN TblProjectPipeline ON TblProjectMaster.ID = TblProjectPipeline.Project_ID
        JOIN TblEmployee_ProjectMapping on TblProjectPipeline.PreSalesLeader_ID=TblEmployee_ProjectMapping.Employee_ID
        JOIN TblPipelineStage ON TblProjectPipeline.Stage_ID = TblPipelineStage.Stage_ID
    GROUP BY TblProjectPipeline.DealSize,TblProjectMaster.Project_Name,TblProjectPipeline.Rainmaker,TblProjectMaster.Project_Start_Date,TblProjectMaster.Project_End_Date
,TblProjectPipeline.ClientName,TblProjectPipeline.ExpectedDuration,TblProjectPipeline.TechnologyRequired,TblProjectPipeline.DealSize,
TblProjectPipeline.ResourcesRequired_Offshore ,TblProjectPipeline.ResourcesRequired_Onshore ,TblProjectPipeline.Geography,TblEmployee_ProjectMapping.Employee_Name

GO