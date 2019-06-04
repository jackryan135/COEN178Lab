CREATE TABLE BudgetWatch(
    cmonth VARCHAR(20),
    ctotal NUMBER(10,2)
);

Insert into BudgetWatch values ('January',0);
Insert into BudgetWatch values ('February',0);
Insert into BudgetWatch values ('March',0);
Insert into BudgetWatch values ('April',0);
Insert into BudgetWatch values ('May',0);
Insert into BudgetWatch values ('June',0);
Insert into BudgetWatch values ('July',0);
Insert into BudgetWatch values ('August',0);
Insert into BudgetWatch values ('September',0);
Insert into BudgetWatch values ('October',0);
Insert into BudgetWatch values ('November',0);
Insert into BudgetWatch values ('December',0);

Create Or Replace Trigger ExpenseCheck_trig
/* After inserting on MyExpenses, for each row */
AFTER INSERT ON MyExpenses
FOR EACH ROW
DECLARE
    l_month varchar(20);
    l_total Number(10,2) := 0;
BEGIN
/* Calculate total of values for food, commute, misc (or any other Categories you may have */
    l_total := :NEW.food + :NEW.transportation + :NEW.misc;
    /* Get the month name of the date in MyExpenses */
    l_month := to_char(:NEW.cDate,'fmMonth');
         /* Now update the BudgetWatch table – add the total
    You have calculated to the ctotal column in MyExpenses
    Where the month in BudgetWatch is the same as l_month.*/
    Update BudgetWatch
    set ctotal = ctotal + l_total
    where cmonth = l_month;
END ExpenseCheck_trig;
/
Show Errors;

SELECT * FROM BudgetWatch;

INSERT INTO MyExpenses values('11-MAY-19', 15, 30, 10);
INSERT INTO MyExpenses values('12-MAY-19', 45, 50, 20);

SELECT * FROM BudgetWatch;
