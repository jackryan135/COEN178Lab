CREATE TABLE Student(
    studentid CHAR(3) PRIMARY KEY,
    name VARCHAR(20),
    city VARCHAR(15)
);

CREATE TABLE SummerJob(
    jobid CHAR(5) PRIMARY KEY,
    jobTitle VARCHAR(25),
    company VARCHAR(20),
    city VARCHAR(20),
    hrlyPay FLOAT(4)
);

CREATE TABLE Student_Work(
    studentid CHAR(3) REFERENCES Student(studentid),
    jobid CHAR(5) REFERENCES SummerJob(jobid),
    hrsWorked INTEGER,
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (studentid, jobid)
);
