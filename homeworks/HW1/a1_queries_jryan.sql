SELECT * FROM Student;
SELECT * FROM SummerJob;
SELECT * FROM Student_Work;

SELECT name, company FROM Student, SummerJob, Student_Work WHERE Student.studentid = Student_Work.studentid, SummerJob.jobid = Student_Work.jobid;
