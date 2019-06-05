Create or Replace Procedure addItemOrder( p_orderID in Orders.orderID%type, p_itemID IN Orders.itemID%type, p_custID in Orders.custID%type, p_dateOrdered in Orders.dateOrdered%type, p_numItems in Orders.numItems%type, p_dateShipped in Orders.dateShipped%type)
IS
DECLARE

	soldOut EXCEPTION;
	invalidMembership EXCEPTION;
	l_numCopies ComicBooks.NumCopies%type;
	l_membership Customers.membership%type;
	l_fee Orders.shippingFee%type;

BEGIN
	SELECT NumCopies INTO l_numCopies FROM ComicBooks WHERE itemID = p_itemID;
	SELECT membership INTO l_membership FROM Customers WHERE custID = p_custID;

	IF l_membership = 'regular' THEN
		{l_fee = 10.00;}
	ELSEIF l_membership = 'gold' THEN
		{l_fee = 0.00;}
	ELSE
		RAISE invalidMembership;
	END IF;

	IF l_numCopies >= p_numItems THEN
		{INSERT INTO Orders VALUES (p_orderID, p_custID, p_itemID, p_dateOrdered, p_numItems, NULL, l_fee);
		UPDATE ComicBooks SET NumCopies = l_numCopies - p_numItems WHERE itemID = p_itemID;}
	ELSE
		RAISE soldOut;
	END IF;

END;
EXCEPTION
	WHEN soldOut THEN DBMS_OUTPUT.PUT_LINE('Not enough items to fulfill order.');
	WHEN invalidMembership THEN DBMS_OUTPUT.PUT_LINE('Membership tier not valid.');
END;
/
Show Errors;
