/*Bit manipulation functions such as moving, retrieving (getting), setting,
 or counting single bits within an integer or binary value, allow you to 
 process and store data more efficiently than with individual bits.
 */
 SELECT LEFT_SHIFT(12345, 5);

 SELECT RIGHT_SHIFT(12345, 5);

 SELECT BIT_COUNT ( 0xabcdef ) as Count;
 SELECT BIT_COUNT ( 17 ) as Count;

 SELECT GET_BIT ( 0xabcdef, 2 ) as Get_2nd_Bit,
GET_BIT ( 17, 5) as Get_5th_Bit;

SELECT SET_BIT ( 0xabcdef, 0, 0 ) as VARBIN2;