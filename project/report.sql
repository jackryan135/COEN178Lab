-- the size of one page
SET PAGESIZE 25
-- the size of a line
SET LINESIZE 120

BREAK ON TODAY

COLUMN TODAY NEW_VALUE report_date
SELECT TO_CHAR(SYSDATE, 'fmMonth DD, YYYY') TODAY
FROM DUAL;


set termout off

ttitle center "Customer Order Report" SKIP 2

btitle center report_date

spool OrderReport.txt

column custID format a15 heading "Customer ID"
column name format a10 heading "Name"
column email format a20 heading "EMail"
column address format a20 heading "Address"
column dateJoined format a15 heading "Date Joined"
column membership format a15 heading "Member Level"


select custID, name, email, address, dateJoined, membership
from Customers WHERE custID = '0001';

CLEAR COLUMNS


column orderID format a10 heading "Order ID"
column itemID format a10 heading "Item ID"
column Title format a15 heading "Title"
column ISBN format a15 heading "ISBN"
column numItems format 99 heading "No. Items"
column price format $9999999,999.99 heading "Price"
column dateOrdered format a15 heading "Date Ordered"
column dateShipped format a15 heading "Date Shipped"

select orderID, itemID, Title, ISBN, numItems, price, dateOrdered, dateShipped
from (Orders JOIN StoreItems USING(itemID)) JOIN ComicBooks USING(itemID)  WHERE custID = '0001';

CLEAR COLUMNS


column orderID format a10 heading "Order ID"
column itemID format a10 heading "Item ID"
column shirtSize format a11 heading "Shirt Size"
column numItems format 99 heading "No. Items"
column price format $9999999,999.99 heading "Price"
column dateOrdered format a15 heading "Date Ordered"
column dateShipped format a15 heading "Date Shipped"

select orderID, itemID, shirtSize, numItems, price, dateOrdered, dateShipped
from (Orders JOIN StoreItems USING(itemID)) JOIN TShirts USING(itemID)  WHERE custID = '0001';


spool off;
CLEAR COLUMNS
CLEAR BREAK
TTITLE OFF 
BTITLE OFF
REPHEADER OFF
SET VERIFY OFF 
SET FEEDBACK OFF
SET RECSEP OFF
SET ECHO OFF
set termout on
set serverout on
