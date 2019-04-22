SELECT * FROM L_EMP;
SELECT * FROM L_DEPT;

SELECT deptid as deptno, count(*) as empcount FROM L_EMP GROUP BY deptid;

SELECT deptno, deptname, empcount FROM (SELECT deptid as deptno, count(*) as empcount FROM L_EMP GROUP BY deptid), L_DEPT WHERE deptno = L_DEPT.deptid;

SELECT deptno, deptname, empcount FROM (SELECT deptid as deptno, count(*) as empcount FROM L_EMP GROUP BY deptid), L_DEPT WHERE deptno = L_DEPT.deptid ORDER BY empcount;

SELECT deptid, max(count(*)) FROM L_EMP GROUP BY deptid;

SELECT deptid FROM L_EMP GROUP BY deptid HAVING count(*) = (SELECT count(*) FROM L_EMP GROUP BY deptid);

SELECT deptid FROM L_EMP GROUP BY deptid HAVING count(*) = (SELECT max(count(*)) FROM L_EMP GROUP BY deptid);

SELECT deptname FROM L_DEPT WHERE deptid = (SELECT deptid FROM L_EMP GROUP BY deptid HAVING count(*) = (SELECT max(count(*)) FROM L_EMP GROUP BY deptid));

SELECT * FROM L_EMP NATURAL JOIN L_DEPT;

SELECT L_EMP.deptid as deptid, empno, empname, deptname FROM L_EMP, L_DEPT WHERE L_EMP.deptid = L_DEPT.deptid;
