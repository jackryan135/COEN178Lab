exec addItemOrder('0001', '0001', '0001', '02-JUN-19', 1, NULL);
exec addItemOrder('0002', '0004', '0001', '02-JUN-19', 3, NULL);
exec addItemOrder('0003', '0002', '0002', '03-JUN-19', 1, NULL);
exec addItemOrder('0004', '0005', '0003', '03-JUN-19', 2, NULL);
exec addItemOrder('0005', '0002', '0001', '03-JUN-19', 1, NULL);
exec addItemOrder('0006', '0005', '0001', '03-JUN-19', 2, NULL);

SELECT * FROM Orders;

exec setShipDate('0001', '05-JUN-19');
exec setShipDate('0002', '09-JUN-19');
exec setShipDate('0003', '10-JUN-19');
exec setShipDate('0005', '10-JUN-19');

UPDATE Customers SET membership = 'gold' WHERE custID = '0002';
UPDATE Customers SET membership = 'regular' WHERE custID = '0003';

SELECT * FROM Customers;
SELECT * FROM Orders;
