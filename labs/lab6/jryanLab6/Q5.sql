Create Or Replace Trigger NoUpdatePK_trig
After UPDATE ON BANKCUST_6
For each row
BEGIN
 if updating ('custno')  then
	raise_application_error (-20999,'Cannot update a Primary Key');	
	End if;
END;
/
show errors;

SELECT * FROM Bankcust_6;

UPDATE BANKCUST_6 Set custno='c99' Where custno='c1';

SELECT * FROM Bankcust_6;
