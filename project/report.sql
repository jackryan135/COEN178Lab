
-- the size of one page
SET PAGESIZE 25
-- the size of a line
SET LINESIZE 120

BREAK ON TODAY


/*
To use the system date in the header or elsewhere in the report is to execute a query that returns the current date and use the NEW_VALUE clause of the COLUMN command to get that date into a substitution variable. That substitution variable sticks around for the duration of the session and can be used in subsequent reports.	
*/

/* The NEW_VALUE option of the COLUMN command is used to update the user variable report_date with the current value of SYSDATE as returned from the database. 
*/
COLUMN TODAY NEW_VALUE report_date
SELECT TO_CHAR(SYSDATE, 'fmMonth DD, YYYY') TODAY
FROM DUAL;

-- Sets terminal output off

set termout off
-- Show the title of your report at the top of the page

ttitle center "Customer Order Report" SKIP 2

btitle center report_date

REPHEADER PAGE CENTER 'Customer Information'

--After the SPOOL command, anything entered or displayed on
-- standard output is written to the spool file, report.html.

spool OrderReport.txt

-- change column headings and format number columns
column custID format a10 heading "Customer ID"
column name format a10 heading "Name"
column email format a10 heading "EMail"
column address format a10 heading "Address"
column dateJoined format a10 heading "Date Joined"
column membership format a10 heading "Member Level"
--column transportation format $9999999,999.99 heading "Transportation"
--column misc format $9999999,999.99 heading "Misc."

BREAK ON REPORT ON ROW SKIP 1
--COMPUTE AVG LABEL Average MAX LABEL Maximum SUM LABEL Total OF Food Transportation Misc ON REPORT

-- Run the query
select custID,
	   name,
       email,
       address, dateJoined, membership
from Customers WHERE custID = '0001';
spool off;

--clear all formatting commands ...

CLEAR COLUMNS
CLEAR BREAK
TTITLE OFF 
BTITLE OFF
SET VERIFY OFF 
SET FEEDBACK OFF
SET RECSEP OFF
SET ECHO OFF
set termout on
