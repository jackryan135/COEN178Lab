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
AFTER UPDATE OF membership ON Customers
/*FOR EACH ROW*/
DECLARE
	l_custID Orders.custID%type;
	l_fee Orders.shippingFee%type;
	l_membership Customers.membership%type;
BEGIN
/*	BEGIN
		SELECT custID INTO l_custID FROM Customers;
		SELECT membership INTO l_membership FROM Customers;
	END;
*/
	IF membership = 'gold' THEN
		l_fee := 0.00;
	ELSE
		l_fee := 10.00;	  
	END IF;

	UPDATE Orders SET shippingFee = l_fee WHERE Orders.custID = l_custID AND (CURRENT_DATE >= Orders.dateShipped OR Orders.dateShipped = NULL);
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




Create or Replace Procedure orderDetails(p_custID in Orders.custID%type, p_date in Orders.dateOrdered%type)
IS
	l_custID Customers.custID%type;
	l_name Customers.name%type;
	l_email Customers.email%type;
	l_address Customers.address%type;
	l_orderID Orders.orderID%type;
	l_itemID Orders.itemID%type;
	l_title ComicBooks.Title%type;
	l_price StoreItems.price%type;
        l_dateOrdered Orders.dateOrdered%type;
	l_dateShipped Orders.dateShipped%type;
	l_itemTotal StoreItems.price%type;
	l_tax StoreItems.price%type;
	l_fee StoreItems.price%type;
	l_discount StoreItems.price%type;
	l_grandTotal StoreItems.price%type := 0.00;
	l_numItems INTEGER;
	l_subtotal StoreItems.Price%type;
	l_shirtSize TShirts.shirtSize%type;
	CURSOR c_comicBooks IS SELECT orderID, custID, itemID, Title, price, dateOrdered, dateShipped, numItems, shippingFee FROM (ComicBooks JOIN Orders USING(itemID)) JOIN StoreItems USING(itemID) WHERE custID = p_custID AND dateOrdered >= p_date;
	CURSOR c_shirts IS SELECT orderID, custID, itemID, shirtSize, price, numItems, dateOrdered, dateShipped, shippingFee FROM (TShirts JOIN Orders USING(itemID)) JOIN StoreItems USING(itemID) WHERE custID = p_custID AND dateOrdered >= p_date;

BEGIN
        SELECT custID, name, email, address INTO l_custID, l_name, l_email, l_address FROM Customers WHERE custID = p_custID;
	DBMS_OUTPUT.PUT_LINE('Customer Information:');
	DBMS_OUTPUT.PUT_LINE('CustomerID: ' || l_custID || ' Name: ' || l_name || ' EMail: ' || l_email || ' Address: ' || l_address);

	DBMS_OUTPUT.PUT_LINE('Comic Book Orders:');
	OPEN c_comicBooks;
	LOOP
	FETCH c_comicBooks INTO l_orderID, l_custID, l_itemID, l_title, l_price, l_dateOrdered, l_dateShipped, l_numItems, l_fee;
		EXIT WHEN c_comicBooks%notfound;
		l_subtotal := l_price * l_numItems;

        	IF l_fee = 0.00 AND l_subtotal >= 100.00 THEN l_discount := 0.10;
        	ELSE
                	l_discount := 0.00;
        	END IF;

        	l_discount := l_discount * l_subtotal;
        	l_subtotal := l_subtotal - l_discount;
        	l_tax := l_subtotal * 0.05;
        	l_subtotal := l_subtotal + l_tax;

        	l_itemTotal := l_subtotal + l_fee;
		l_grandTotal := l_grandTotal + l_itemTotal;
		DBMS_OUTPUT.PUT_LINE('OrderID: ' || l_orderID || ' ItemID: ' || l_itemID || ' Title:  ' || l_title || ' Price: $' || l_price || ' Date Ordered: ' || l_dateOrdered || ' Number of Items: ' || l_numItems || ' Date Shipped ' || l_dateShipped || ' Shipping Fee: $' || l_fee || ' Discount: $' || l_discount || ' Tax: $' || l_tax || ' Order Total: $' || l_itemTotal);
	END LOOP;
	CLOSE c_comicBooks;

	
	DBMS_OUTPUT.PUT_LINE('TShirt Orders:');
	OPEN c_shirts;
	LOOP
	FETCH c_shirts INTO l_orderID, l_custID, l_itemID, l_shirtSize, l_price, l_numItems, l_dateOrdered, l_dateShipped, l_fee;
		EXIT WHEN c_shirts%notfound;
		l_subtotal := l_price * l_numItems;

        	IF l_fee = 0.00 AND l_subtotal >= 100.00 THEN l_discount := 0.10;
        	ELSE
                	l_discount := 0.00;
        	END IF;

        	l_discount := l_discount * l_subtotal;
        	l_subtotal := l_subtotal - l_discount;
        	l_tax := l_subtotal * 0.05;
        	l_subtotal := l_subtotal + l_tax;

        	l_itemTotal := l_subtotal + l_fee;
		l_grandTotal := l_grandTotal + l_itemTotal;
		DBMS_OUTPUT.PUT_LINE('OrderID: ' || l_orderID || ' ItemID: ' || l_itemID || ' Shirt Size: ' || l_shirtSize || ' Price: $' || l_price || ' Date Ordered: ' || l_dateOrdered || ' Number of Items: ' || l_numItems || ' Date Shipped ' || l_dateShipped || ' Shipping Fee: $' || l_fee || ' Discount: $' || l_discount || ' Tax: $' || l_tax || 'Order Total: $' || l_itemTotal);
	END LOOP;
	CLOSE c_shirts;

	DBMS_OUTPUT.PUT_LINE(' GRAND TOTAL: $' || l_grandTotal);
END;
/
Show Errors;
