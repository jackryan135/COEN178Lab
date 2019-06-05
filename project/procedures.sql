Create or Replace Procedure addItemOrder( p_orderID in Orders.orderID%type, p_itemID IN Orders.itemID%type, p_custID in Orders.custID%type, p_dateOrdered in Orders.dateOrdered%type, p_numItems in Orders.numItems%type, p_dateShipped in Orders.dateShipped%type)
IS

	soldOut EXCEPTION;
	invalidMembership EXCEPTION;
	l_numCopies ComicBooks.NumCopies%type;
	l_membership Customers.membership%type;
	l_fee Orders.shippingFee%type;

BEGIN
	SELECT NumCopies INTO l_numCopies FROM ComicBooks WHERE itemID = p_itemID;
	SELECT membership INTO l_membership FROM Customers WHERE custID = p_custID;

	IF (l_membership = 'regular') THEN l_fee := 10.00;
	ELSIF (l_membership = 'gold') THEN l_fee := 0.00;
	ELSE
		RAISE invalidMembership;
END IF;

	IF (l_numCopies >= p_numItems) THEN INSERT INTO Orders VALUES (p_orderID, p_custID, p_itemID, p_dateOrdered, p_numItems, NULL, l_fee);
		UPDATE ComicBooks SET NumCopies = l_numCopies - p_numItems WHERE itemID = p_itemID;
	ELSE
		RAISE soldOut;
END IF;
EXCEPTION
	WHEN soldOut THEN DBMS_OUTPUT.PUT_LINE('Not enough items to fulfill order.');
	WHEN invalidMembership THEN DBMS_OUTPUT.PUT_LINE('Membership tier not valid.');
END;
/
Show Errors;





CREATE OR REPLACE TRIGGER memberUpdate
AFTER UPDATE ON Customers
FOR EACH ROW
DECLARE
	l_custID Orders.custID%type;
	l_fee Orders.shippingFee%type;
	l_membership Customers.membership%type;
BEGIN
	BEGIN
		SELECT custID INTO l_custID FROM Customers;
		SELECT membership INTO l_membership FROM Customers;
	END;

	IF l_membership = 'gold' THEN
		l_fee := 0.00;
	ELSE
		l_fee := 10.00;	  
	END IF;

	UPDATE Orders SET shippingFee = l_fee WHERE Orders.custID = l_custID;
END;
/
show errors;





Create or Replace Procedure setShipDate(p_orderID in Orders.orderID%type, p_dateShipped in Orders.dateShipped%type)
IS

	invalidDate EXCEPTION;
	l_dateOrdered Orders.dateOrdered%type;

BEGIN
	SELECT dateOrdered INTO l_dateOrdered FROM Orders WHERE orderID = p_orderID;

	IF (l_dateOrdered <= p_dateShipped) THEN
		UPDATE Orders SET dateShipped = p_dateShipped WHERE orderID = p_orderID;
	ELSE
		RAISE invalidDate;
END IF;

EXCEPTION
	WHEN invalidDate THEN DBMS_OUTPUT.PUT_LINE('Ship date before order date.');
END;
/
Show Errors;




CREATE OR REPLACE FUNCTION calcTotal(p_orderID in Orders.orderID%type)
RETURN NUMBER IS
	l_total StoreItems.price%type;

	l_price StoreItems.price%type;
        l_num Orders.numItems%type;
        l_itemID Orders.itemID%type;
        l_fee Orders.shippingFee%type;
        l_discount NUMBER(9,2);
        l_subtotal StoreItems.price%type;
        l_tax StoreItems.price%type;
BEGIN
		SELECT itemID INTO l_itemID FROM Orders WHERE orderID = p_orderID;
		SELECT price INTO l_price FROM StoreItems WHERE itemID = l_itemID;
		SELECT numItems INTO l_num FROM Orders WHERE orderID = p_orderID;
		SELECT shippingFee INTO l_fee FROM Orders WHERE orderID = p_orderID;

		l_subtotal := l_price * l_num;
	BEGIN
		IF l_fee = 0.00 AND l_subtotal >= 100.00 THEN l_discount := 0.10;
		ELSE
			l_discount := 0.00;
	END IF;

	l_discount := l_discount * l_subtotal;
	l_subtotal := l_subtotal - l_discount;
	l_tax := l_subtotal * 0.05;
	l_subtotal := l_subtotal + l_tax;
	
	l_total := l_subtotal + l_fee;

	RETURN l_total;
END;
/
show errors;
