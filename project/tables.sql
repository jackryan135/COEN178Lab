CREATE TABLE StoreItems(
	itemID VARCHAR(4) PRIMARY KEY,
	price NUMBER(9,2)
);

CREATE TABLE ComicBooks(
	itemID VARCHAR(4) REFERENCES StoreItems(itemID),
	ISBN CHAR(13) UNIQUE,
	publishedDate DATE,
	NumCopies INT CHECK (NumCopies >= 0),
	Title VARCHAR(15),
	PRIMARY KEY(itemID)
);

CREATE TABLE TShirts(
	itemID VARCHAR(4) REFERENCES StoreItems(itemID),
	shirtSize CHAR(1),
	PRIMARY KEY(itemID)
);

CREATE TABLE Customers(
	custID VARCHAR(4) PRIMARY KEY,
	name VARCHAR(15),
	email VARCHAR(20) UNIQUE NOT NULL,
	address VARCHAR(20),
	dateJoined DATE,
	membership VARCHAR(7) CHECK (membership = 'regular' OR membership = 'gold')
);

CREATE TABLE Orders(
	orderID VARCHAR(4) PRIMARY KEY,
	custID VARCHAR(4) REFERENCES Customers(custID),
	itemID VARCHAR(4) REFERENCES StoreItems(itemID), 
	dateOrdered DATE,
	numItems INTEGER,
	dateShipped DATE,
	shippingFee NUMBER(9,2) DEFAULT 10.00,
	CONSTRAINT checkTime CHECK (dateShipped >= dateOrdered)
);
