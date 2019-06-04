CREATE TABLE EMP7(
    empid varchar(5) Primary Key,
    empName varchar(20),
    deptId varchar(5),
    salary NUMBER (10,2)
);

CREATE TABLE Project7 (
    projectID varchar(5) Primary Key,
    title varchar(20),
    budget NUMBER(10,2),
    startDate Date,
    endDate Date,
    managerId varchar(5)
);

CREATE TABLE EMP_Project (
    projectID varchar(5),
    empid varchar(5),
    commission NUMBER(10,2)
);

insert into EMP7 values ('e1','J.Smith','d1',100000);
insert into EMP7 values ('e2','M.Jones','d1',120000);
insert into EMP7 values ('e3','D.Clark','d2',200000);
insert into EMP7 values ('e4', 'J.Ryan', 'd2', 250000);
insert into EMP7 values ('e5', 'O.Hayes', 'd3', 150000);
insert into Project7 values ('pj1','Research', 1000000, '10-Jan-2019','20-Feb-2020','e1');
insert into Project7 values ('pj2','Research', 100000, '10-Feb-2019','20-Apr-2019','e2');
insert into Project7 values ('pj3', 'Development', 1500000, '10-Apr-2019', '10-May-2019', 'e3');
insert into Project7 values ('pj4', 'Development', 200000, '10-May-2019', '10-Jun-2019', 'e4');
insert into EMP_Project values ('pj1', 'e1', 9000);
insert into EMP_Project values ('pj2','e2',10000);
insert into EMP_Project values ('pj3', 'e3', 15000);
insert into EMP_Project values ('pj4', 'e4', 12500);
