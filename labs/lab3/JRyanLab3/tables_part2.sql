CREATE TABLE L_EMP (
    empNo INTEGER PRIMARY KEY,
    empname VARCHAR(10),
    deptid VARCHAR(5)
);

CREATE TABLE L_DEPT (
    deptid VARCHAR(5) PRIMARY KEY,
    deptname VARCHAR(10)
);

INSERT INTO L_EMP VALUES (1, 'smith', 'd1');

INSERT INTO L_EMP VALUES (2, 'jones', 'd2');

INSERT INTO L_EMP VALUES (3, 'wayne', 'd1');

INSERT INTO L_EMP VALUES (4, 'moor', 'd3');

INSERT INTO L_EMP VALUES (5, 'king', 'd1');

INSERT INTO L_EMP VALUES (6, 'chen', 'd1');

INSERT INTO L_EMP VALUES (7, 'winger', 'd3');

INSERT INTO L_DEPT VALUES ('d1', 'Research');

INSERT INTO L_DEPT VALUES ('d2', 'Devt');

INSERT INTO L_DEPT VALUES ('d3', 'Testing');

INSERT INTO L_DEPT VALUES ('d4', 'Advert');
