SELECT * FROM Student;
SELECT * FROM SummerJob;
SELECT * FROM Student_Work;

SELECT name, company FROM Student, SummerJob, Student_Work WHERE Student.studentid = Student_Work.studentid AND SummerJob.jobid = Student_Work.jobid;

SELECT name, jobid, jobtitle, company FROM Student JOIN (SummerJob JOIN Student_Work USING(jobid)) USING(studentid);

SELECT company, avg(hrlypay) as AVERAGE_PAY FROM SummerJob GROUP BY company;

SELECT studentid, name FROM Student JOIN (Student_Work JOIN SummerJob USING(jobid)) USING(studentid) WHERE (endDate < CURRENT_DATE OR startDate > CURRENT_DATE);

SELECT UNIQUE company, hrlypay as MAX_AVERAGE_PAY FROM SummerJob WHERE hrlypay = (SELECT max(av) as hrlypay FROM (SELECT avg(hrlypay) as av FROM SummerJob GROUP BY company));

SELECT studentid, jobid, endDate-startDate as DaysWorked FROM Student_Work;

SELECT studentid, name FROM Student JOIN (Student_Work JOIN SummerJob USING(jobid)) USING(studentid) WHERE (endDate < CURRENT_DATE OR startDate > CURRENT_DATE);

SELECT city, count(jobid) as num_jobs FROM SummerJob GROUP BY city;

SELECT company, city, count(studentid) as num_stu_employed FROM SummerJob JOIN Student_Work USING(jobid) GROUP BY company, city;

SELECT studentid, name, Student.city as city FROM Student JOIN (Student_Work JOIN SummerJob USING(jobid)) USING(studentid) WHERE Student.city = SummerJob.city;
