 --if we want the sumof price by maker and type,by only type,by only maker,and total sum then 

 select * from bike
 go 
 update bike 
 SET type ='Super bike' where ID=7

   select maker,null,sum(price)AS SUM
from bike
group by maker

 union all

 select null,type,sum(price)
 from bike
 group by type
 
 --OR

  select maker,[type],sum(price)
  from bike 
  group by 
       Grouping sets
  (maker,type)

  
   ---------------------------------------------------------------

   select  maker,type,SUM(price) as SUMOFGROUP
from bike
group by maker,type

union all

select maker,null,sum(price)
from bike
group by maker

 union all

 select null,type,sum(price)
 from bike
 group by type

 union all

 select null,null,sum(price)
 from bike
 

 --alternatively this can be achieved by grouping set
 select maker,type,sum(price)
 from bike
 group by
   Grouping sets
   (
   (maker,type),--by maker and type
   (maker),--by maker
   (type),--by type
   ()  --total sum
   )
   ----Roll up_-          
   --aggreagate operation on multiple level heirarchy
   select maker,sum(price)
   from bike
   group by ROLLUP(maker)

--OR can also be written as
 select maker,sum(price)
   from bike
   group by maker with ROLLUP

   ---without using rollup

   select maker,sum(price)
   from bike
   group by maker
 union all
 select null,sum(price)
   from bike
  
  
  --by using grouping sets
  
  select maker,sum(price)
   from bike
   group by 
   grouping sets
   (
   (maker),()
   )

   

   --if want sum of sal by country and type by using roll up

   select maker,type,sum(price)
   from bike
   group by ROLLUP(maker,type)


   --CUBE
   --produces result set by generating all combination of column specified in group by cube()
   select maker,type,Sum(price)
   from bike
   group by cube(maker,type)

   --or can be written as
    select maker,type,Sum(price)
   from bike
   group by maker,type with cube


   --this can be acheived by 
   select maker,type,sum(price)
 from bike
 group by
   Grouping sets
   (
   (maker,type),--by maker and type
   (maker),--by maker
   (type),--by type
   ()  --total sum
   )



   --Grouping function=grouping indicates whether the column in a group by it is aggregated or not .It returns 1 for aggregated or 0 for not aggregated.
   
   select maker,type,sum(price),grouping(maker),grouping(type)
   from bike
   group by ROLLUP(maker,type)

   --replace null value with 
   
   select case 
   when grouping(maker)=1 then 'All'  else isnull(maker,'unknown')end,
   case when grouping(type)=1 then 'All'  else isnull(maker,'unknown')
	end
	 from bike
   group by ROLLUP(maker,type)
--In this we cant use isnull function instead of grouping because it will mislead and if grouping column contain null value it will convert it to all.
