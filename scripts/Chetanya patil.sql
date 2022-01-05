
--Difference Between Cast and Convert

--Syntax
cast(expression AS data_type [(length)]) as ConvertedDate
convert(data_type [(length)],expression,[style]) as convertedDate

SELECT GETDATE()

select year(getdate())

select cast(getdate() as nvarchar) as ConvertedDate;

select convert(nvarchar,getdate(),105) as ConvertedDate;     ----105 == dd-mm-yy


---CONVERT DATETIME TO DATE ONLY

SELECT GETDATE();
SELECT CAST(GETDATE() AS DATE) AS gettingDateOnly;
SELECT CONVERT(DATE, GETDATE(),105) AS gettingDateOnly;


---let do something else