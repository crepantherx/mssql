
--finds the length of the Name column in the Product table
SELECT length = DATALENGTH(Name), Name  
FROM Production.Product
ORDER BY Name;

--checks a short character string (interesting data) for the starting location of the characters ter
SELECT position = PATINDEX('%ter%', 'interesting data');  

--finds the position at which the pattern ensure starts in a specific row of the DocumentSummary column in the Document table
SELECT position = PATINDEX('%ensure%',DocumentSummary)  
FROM Production.Document  
WHERE DocumentNode = 0x7B40; 

--find the position at which the pattern 'en', followed by any one character and 'ure'
SELECT position = PATINDEX('%en_ure%', 'Please ensure the door is locked!');  

--find the position of a character that is not a number, letter, or space.
SELECT position = PATINDEX('%[^ 0-9A-Za-z]%', 'Please ensure the door is locked!');

--returns the system database names in the first column, the first letter of the database in the second column, and the third and fourth characters in the final column.
SELECT name, SUBSTRING(name, 1, 1) AS Initial ,
SUBSTRING(name, 3, 2) AS ThirdAndFourthCharacters
FROM sys.databases  
WHERE database_id < 5;

--textptr,textvalid,readtext,set textsize,updatetext,writetext