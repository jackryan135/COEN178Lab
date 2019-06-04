start clearBTables.sql;

start bankTables.sql;

CREATE or REPLACE TRIGGER display_customer_trig
   AFTER  INSERT on BankCust_6
   FOR EACH ROW	
BEGIN    
	DBMS_OUTPUT.PUT_LINE('From Trigger '||'Customer NO: '||:new.custno||' Customer Name: '||:new.custname);
END;
/
show errors;


insert into BANKCUST_6 values('c1','Smith','32 Lincoln st','SJ');
insert into BANKCUST_6 values('c2','Jones','44 Benton st','SJ');
insert into BANKCUST_6 values('c3','Peters','12 palm st','SFO');
insert into BANKCUST_6 values('c20','Chen','20 san felipo','LA');
insert into BANKCUST_6 values('c33','Williams',' 11 cherry Ave','SFO');


CREATE or REPLACE TRIGGER display_customer_trig
   AFTER  INSERT on BankCust_6
   FOR EACH ROW	
BEGIN    
	DBMS_OUTPUT.PUT_LINE('From Trigger '||'Customer NO: '||:new.custno||' Customer Name: '||:new.custname||' City: '||:new.city);
END;
/
show errors;


insert into BANKCUST_6 values('c4','Ryan','33 Lincoln st','SJ');
insert into BANKCUST_6 values('c5','Hayes','45 Benton st','SJ');
insert into BANKCUST_6 values('c6','Phillips','13 palm st','SFO');
insert into BANKCUST_6 values('c21','Melvin','21 san felipo','LA');
insert into BANKCUST_6 values('c34','Anderson',' 12 cherry Ave','SFO');

