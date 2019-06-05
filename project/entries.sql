INSERT INTO Customers VALUES ('0001', 'Jack', 'jack@scu.edu', '1050 Benton St', '05-JUN-19', 'gold');
INSERT INTO Customers VALUES ('0002', 'Olivia', 'olivia@scu.edu', '178 Langton St', '05-MAY-19', 'regular');
INSERT INTO Customers VALUES ('0003', 'Ally', 'ally@scu.edu', '104 Washington St', '15-MAR-18', 'gold');
INSERT INTO Customers VALUES ('0004', 'Jeff', 'jeff@scu.edu', '450 Market St', '20-DEC-17', 'regular');
INSERT INTO Customers VALUES ('0005', 'Daniel', 'daniel@scu.edu', '450 Market St', '17-SEP-18', 'gold');
INSERT INTO Customers VALUES ('0006', 'Liam', 'liam@scu.edu', '750 Bellomy St', '09-AUG-18', 'regular');


INSERT INTO StoreItems VALUES ('0001', 5.25);
INSERT INTO ComicBooks VALUES ('0001', '0123456789012', '05-JUN-08', 5, 'Green Lantern');
INSERT INTO StoreItems VALUES ('0002', 6.50);
INSERT INTO ComicBooks VALUES ('0002', '9876543210987', '07-APR-07', 2, 'X-Men');
INSERT INTO StoreItems VALUES ('0003', 10.00);
INSERT INTO ComicBooks VALUES ('0003', '5432109876543', '15-DEC-10', 3, 'The Flash');

INSERT INTO StoreItems VALUES ('0004', 12.15);
INSERT INTO TShirts VALUES ('0004', 'L');
INSERT INTO StoreItems VALUES ('0005', 9.75);
INSERT INTO TShirts VALUES ('0005', 'M');
INSERT INTO StoreItems VALUES ('0006', 11.25);
INSERT INTO TShirts VALUES ('0006', 'S');


SELECT * FROM Customers;
SELECT * FROM StoreItems;
SELECT * FROM ComicBooks;
SELECT * FROM TShirts;
