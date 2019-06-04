ALTER TRIGGER display_customer_trig disable;

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
AFTER INSERT ON Accounts_6
FOR EACH ROW	
BEGIN	
/*If the custno is already in the Totals_6 table, the update will succeed */
	update totals_6
	set totalAmount = totalAmount + :new.amount
	where custno = :new.custno;	
		
/*If the custno is not in the Totals_6 table, we insert a row into
Totals_6 table. Complete the missing part in the subquery */
insert into totals_6 (select :new.custno, :new.amount from dual
	where not exists (select * from TOTALS_6 where custno= :new.custno));							
END;
/
show errors;


insert into ACCOUNTS_6 values('a1523','checking',2000.00,'c1');
insert into ACCOUNTS_6 values('a2134','saving',5000.00,'c1');
insert into ACCOUNTS_6 values('a4378','checking',1000.00,'c2');
insert into ACCOUNTS_6 values('a5363','saving',8000.00,'c2');
insert into ACCOUNTS_6 values('a7236','checking',500.00,'c33');
insert into ACCOUNTS_6 values('a8577','checking',150.00,'c20');

SELECT * FROM Totals_6;

SELECT * FROM Accounts_6;
