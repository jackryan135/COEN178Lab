SELECT * FROM L_EMP;
SELECT * FROM L_DEPT;

SELECT empname FROM L_EMP INNER JOIN L_DEPT ON L_EMP.deptid = L_DEPT.deptid WHERE deptname = 'Testing';
