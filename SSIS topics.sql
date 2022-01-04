/*
 Data flow task
 Execute SQL task
 Expression task
 Script task
 For loop container
 For each container
: Sequence container


Data flow task:-
The most important task in SSIS is the Data Flow Task.
The SSIS Data Flow Task can be selected directly from the SSDT Toolbox, 
and then the source and destinations are defined within the task. 
The Data Flow Task isn’t merely a mapping transform for input and output columns.
This task has its own design surface like the Control Flow, 
where you can arrange task-like components called transforms to manipulate data 
as it flows in a pipeline from the source to a destination

Data Flow-->
Data flow in SSIS defines the flow of data from a source to a destination.
The Data Flow Task is the most frequently used task in SSIS, 
which contains the data transformation logic (ETL processes). 
It moves the data from source to destination and adds transforms in them to merge,
update or split data.

In data flow, SSIS toolbox, components are classified into
1.Data connection
 -> favourites
 -> other source
 -> other destinations

2.data transformation
  -> common
  -> other transformation
**********************************************************************************************

Execute SQL task:
SSIS Expression Task: creates and evaluates expressions that set variable values at runtime.
Variables: can be evaluated as an expression

Script task:
The Script task provides code to perform functions that are not available
in the built-in tasks and transformations that SQL Server Integration Services provides.
The Script task can also combine functions in one script instead of using multiple tasks
and transformations

For each container:

 */
