start clear.sql
start tables.sql

CREATE OR REPLACE VIEW CurrentProjects AS
SELECT projectid, title, managerid FROM Project7
WHERE CURRENT_DATE < endDate;

CREATE OR REPLACE VIEW PastProjects AS
SELECT title, managerid FROM Project7
WHERE CURRENT_DATE > endDate;

SELECT * FROM CurrentProjects;
SELECT * FROM PastProjects;

insert into CurrentProjects values ('p99','Testing','e2');
SELECT * FROM Project7;

insert into PastProjects values ('Testing','e2');

CREATE OR REPLACE VIEW ManagedProjects AS
SELECT projectid, title as Project_Title, empName as ManagerName FROM EMP7, Project7
WHERE Emp7.empid = Project7.managerid;
SELECT * FROM ManagedProjects;

insert into ManagedProjects values ('p88','Design','Mary Mason');
