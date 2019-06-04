DROP TABLE M_Student;
DROP TABLE M_Course;
DROP TABLE M_CoursesTaken;
DROP TABLE M_CourseRegister;
DROP TABLE M_PreReqCourse;

/* A table to hold student data */
Create table M_Student (stno varchar(3) primary key, name varchar(20));

/* A table to hold course info.*/
Create table M_Course (courseno varchar(5) primary key, units Integer);

/* A table to hold the info of courses taken by a student */
Create table M_CoursesTaken (stno varchar(3),courseno varchar(5));

/* A table to hold registration of a student into a course.*/
Create table M_CourseRegister(stno varchar(3),courseno varchar(5));

/* A table to hold course and its prerequisites.*/
Create table M_PreReqCourse (courseno varchar(5), prereq varchar(5));


CREATE or Replace TRIGGER CheckPrereq_Trig
AFTER insert ON M_CourseRegister
FOR EACH ROW
DECLARE
	l_cnt Integer;
	l_no Integer;
BEGIN	
	Select Count(prereq) into l_no 
	from M_PrereqCourse 
	WHERE CourseNo = :NEW.courseno
		And 
	prereq NOT IN (Select courseno from M_CoursesTaken where stNo=:NEW.stNo);

	IF l_no > 0 THEN
		Select Count(prereq) into l_cnt 
		from M_PreReqCourse 
		WHERE CourseNo=:NEW.courseno
			AND 
		prereq NOT IN (Select courseno from M_CoursesTaken where stNo=:NEW.stNo);

		IF l_cnt > 0 THEN
			DBMS_OUTPUT.PUT_LINE ('No prereq');
			RAISE_APPLICATION_ERROR(-20010,'prereqs not done');
		END IF;
	END IF;

	insert into M_CoursesTaken values (:NEW.stNo,:NEW.CourseNo);
	
END CheckPrereq_Trig;
/
Show Errors;


/* Student data */
insert into M_Student values ('s1','smith');
insert into M_Student values ('s2','jones');

/* Course data */
insert into M_course values ('c1',4);
insert into M_Course values ('c2',2);
insert into M_course values ('c3',4);
insert into M_Course values ('c4',2);

/* Prerequisite data */
insert into M_PrereqCourse values('c3','c1');
insert into M_PrereqCourse values('c4','c1');
insert into M_PrereqCourse values('c4','c2');
insert into M_PrereqCourse values('c1',NULL);
insert into M_PrereqCourse values('c2',NULL);


/* This should succeed, since c1 does not have any prereqs */
insert into M_CourseRegister values ('s1','c1');

/* This should succeed, since c3  has c1 as prereq, which s1 has taken. */
insert into M_courseRegister values('s1','c3');
Select * from M_CoursesTaken;

/* This should fail and fire the trigger, since c4  has c1 and c2 as prereqs 
And s1 has taken only one. */
insert into M_courseRegister values('s1','c4');
Select * from M_CoursesTaken; 
/*This should show only two courses(c1 and c3) for s1 so far. */

/* This should succeed, since c2 does not have any prereqs */
insert into M_courseRegister values('s1','c2');

/* This should succeed now, since s1 has completed the two prereqs */	
insert into M_courseRegister values('s1','c4');

Select * from M_CoursesTaken;
/* Will this fail ? */
insert into M_courseRegister values('s2','c4');
