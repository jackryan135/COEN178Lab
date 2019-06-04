DROP TABLE ItemOrder;
Create table ItemOrder (orderNo VARCHAR(5) Primary key, qty Integer);

CREATE OR REPLACE TRIGGER ItemOrder_after_insert_trig
AFTER INSERT
   ON ItemOrder
   FOR EACH ROW

DECLARE
   v_quantity Integer;

BEGIN
   SELECT qty
   INTO v_quantity
   FROM ItemOrder
   WHERE orderNo = 'o1';

END;
/
Show Errors;

Insert into ItemOrder values ('o1',100);
