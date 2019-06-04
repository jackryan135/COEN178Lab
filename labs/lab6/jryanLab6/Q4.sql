DROP TABLE Accounts_6;
DROP TABLE Totals_6;

Create table ACCOUNTS_6 (
	AccountNo VARCHAR(5) Primary Key,
	accountType VARCHAR(10), 
	amount NUMBER(10,2), 
	custno varchar(5),
	CONSTRAINT accounts_fkey FOREIGN Key (custno)REFERENCES BANKCUST_6(custno)
);

Create table TOTALS_6 (
	custno VARCHAR(5), 
	totalAmount Number(10,2), 
	CONSTRAINT totals_fkey FOREIGN Key (custno)REFERENCES BANKCUST_6(custno)
);

Create Or Replace Trigger Acct_Cust_Trig
AFTER INSERT OR UPDATE ON Accounts_6
FOR EACH ROW	
BEGIN	
	If inserting then
		update totals_6
		set totalAmount = totalAmount + :new.amount
		where custno = :new.custno;	
		
		insert into totals_6 (select :new.custno, :new.amount from dual
	where not exists (select * from TOTALS_6 where custno = :new.custno));
	END IF;
	if updating then
		update totals_6
		set totalAmount = totalAmount - :old.amount + :new.amount
		where custno = :new.custno;
	end if; 
END;
/
Show Errors;


insert into ACCOUNTS_6 values('a1523','checking',2000.00,'c1');
insert into ACCOUNTS_6 values('a2134','saving',5000.00,'c1');
insert into ACCOUNTS_6 values('a4378','checking',1000.00,'c2');
insert into ACCOUNTS_6 values('a5363','saving',8000.00,'c2');
insert into ACCOUNTS_6 values('a7236','checking',500.00,'c33');
insert into ACCOUNTS_6 values('a8577','checking',150.00,'c20');

SELECT * FROM Totals_6;

SELECT * FROM Accounts_6;

SELECT * FROM Totals_6 WHERE custno = 'c1';


update Accounts_6 set amount = 1000 where accountno = 'a1523';


SELECT * FROM Totals_6;

SELECT * FROM Accounts_6;

SELECT * FROM Totals_6 WHERE custno = 'c1';

