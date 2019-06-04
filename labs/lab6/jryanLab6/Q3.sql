update Accounts_6
set amount = 1000
where accountno = 'a1523';

SELECT * FROM Totals_6;

SELECT * FROM Totals_6 WHERE custno = 'c1';

SELECT * FROM Accounts_6 WHERE custno = 'c1';
