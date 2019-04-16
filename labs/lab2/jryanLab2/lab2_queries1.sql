SELECT custid, firstname||lastname as fullname, city FROM Customer;

SELECT * FROM Customer order by lastname asc;

SELECT * FROM Schedule order by serviceid, custid desc;

SELECT serviceid FROM DeliveryService MINUS SELECT serviceid FROM Schedule;

SELECT firstname||lastname as name FROM Customer where custid in (
    SELECT custid FROM Schedule where day = 'm');

SELECT lastname FROM Customer where custid in (SELECT custid FROM Schedule);

SELECT max(servicefee) as highest_Servicefee FROM DeliveryService;

SELECT day, count(*) as NumScheduled FROM Schedule group by day;

SELECT A.custid, B.custid, city  FROM Customer A JOIN Customer B USING (city) WHERE A.custid < B.custid OR A.custid > B.custid;

SELECT custid, firstname||lastname as name, city, location FROM (SELECT * FROM DeliveryService NATURAL JOIN (SELECT * FROM Customer NATURAL JOIN Schedule)) WHERE city = location;

SELECT max(salary) as max_salary, min(salary) as min_salary FROM Staff_2010;
