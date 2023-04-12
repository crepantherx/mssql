/*
All cursor functions are nondeterministic. 
In other words, these functions do not always return the same results each time they execute, 
even with the same set of input values.


Deterministic functions always return the same result any time they're called with a specific 
set of input values and given the same state of the database. 
Nondeterministic functions may return different results each time they're called with a 
specific set of input values even if the database state that they access remains the same. 
For example, the function AVG always returns the same result given the qualifications stated above, 
but the GETDATE function, which returns the current datetime value, always returns a different result.
*/


/*
This example first declares a cursor, and then uses SELECT to display the value of @@CURSOR_ROWS. 
The setting has a value of 0 before the cursor opens and then has a value of -1, 
to indicate that the cursor keyset populates asynchronously.
*/
SELECT @@CURSOR_ROWS;  
DECLARE Name_Cursor CURSOR FOR  
SELECT LastName ,@@CURSOR_ROWS FROM Person.Person;  
OPEN Name_Cursor;  
FETCH NEXT FROM Name_Cursor;  
SELECT @@CURSOR_ROWS;  
CLOSE Name_Cursor;  
DEALLOCATE Name_Cursor;

--This example uses @@FETCH_STATUS to control cursor activities in a WHILE loop.

DECLARE Employee_Cursor CURSOR FOR  
SELECT BusinessEntityID, JobTitle  
FROM HumanResources.Employee;  
OPEN Employee_Cursor;  
FETCH NEXT FROM Employee_Cursor;  
WHILE @@FETCH_STATUS = 0  
   BEGIN  
      FETCH NEXT FROM Employee_Cursor;  
   END;  
CLOSE Employee_Cursor;  
DEALLOCATE Employee_Cursor;