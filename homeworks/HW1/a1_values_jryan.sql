INSERT INTO Student VALUES ('111', 'Jack', 'Santa Barbara');
INSERT INTO Student VALUES ('222', 'Ally', 'Bishop');
INSERT INTO Student VALUES ('333', 'Conor', 'New York');
INSERT INTO Student VALUES ('444', 'Olivia', 'San Francisco');
INSERT INTO Student VALUES ('555', 'Connor', 'Sudburry');
INSERT INTO Student VALUES ('666', 'Mike', 'Santa Clara');
INSERT INTO Student VALUES ('777', 'Jeffrey', 'Santa Cruz');

INSERT INTO SummerJob VALUES ('11111', 'Software Engineer', 'Google', 'Mountain View', 40.00);
INSERT INTO SummerJob VALUES ('22222', 'Conservationist', 'SCU', 'Bishop', 8.00);
INSERT INTO SummerJob VALUES ('33333', 'Camera Technician', 'Camera Hut', 'New York', 15.00);
INSERT INTO SummerJob VALUES ('44444', 'PR Coordinator', 'Skillz Inc.', 'San Francisco', 20.00);
INSERT INTO SummerJob VALUES ('55555', 'Salesman', 'Wayfair', 'Boston', 15.00);
INSERT INTO SummerJob VALUES ('66666', 'Software Engineer', 'Google', 'Santa Barbara', 40.00);
INSERT INTO SummerJob VALUES ('77777', 'Developer', 'Camera Hut', 'Los Angeles', 30.00);

INSERT INTO Student_Work VALUES ('111', '11111', 8, TO_DATE('2019-06-15', 'YYYY-MM-DD'), TO_DATE('2019-08-30', 'YYYY-MM-DD'));
INSERT INTO Student_Work VALUES ('222', '22222', 4, TO_DATE('2019-07-09', 'YYYY-MM-DD'), TO_DATE('2019-09-15', 'YYYY-MM-DD'));
INSERT INTO Student_Work VALUES ('333', '33333', 7, TO_DATE('2019-03-15', 'YYYY-MM-DD'), TO_DATE('2020-03-15', 'YYYY-MM-DD'));
INSERT INTO Student_Work VALUES ('444', '44444', 5, TO_DATE('2019-06-15', 'YYYY-MM-DD'), TO_DATE('2019-08-30', 'YYYY-MM-DD'));
INSERT INTO Student_Work VALUES ('555', '55555', 6, TO_DATE('2017-04-27', 'YYYY-MM-DD'), TO_DATE('2022-09-05', 'YYYY-MM-DD'));
INSERT INTO Student_Work VALUES ('666', '66666', 3, TO_DATE('2019-09-01', 'YYYY-MM-DD'), TO_DATE('2019-12-31', 'YYYY-MM-DD'));
INSERT INTO Student_Work VALUES ('777', '77777', 8, TO_DATE('2019-09-01', 'YYYY-MM-DD'), TO_DATE('2019-12-31', 'YYYY-MM-DD'));
