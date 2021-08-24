/* DROP the tables if they already exist */
drop table Student cascade constraints;
drop table Instructor cascade constraints;
drop table Class cascade constraints;
drop table Took cascade constraints;
/* Create the schema for our tables */
create table Student(
studID varchar2(6) primary key, 
name varchar2(10), 
major varchar2(20)
);
create table Instructor(
instID varchar2(6) primary key, 
dept varchar2(20)
);
create table Class(
classID varchar2(6) primary key, 
univ varchar2(30), 
region varchar2(10), 
country varchar2(10)
);
create table Took(
Tnumber number primary key,
studID varchar2(6) , 
instID varchar2(6) , 
classID varchar2(6) , 
score number,
foreign key (studID)references Student,
foreign key (instID)references Instructor,
foreign key (classID)references Class

);

/* Populate the tables with our data */
insert into Student values ('stud1', 'Amy', 'CS');
insert into Student values ('stud2', 'Brian', 'CS');
insert into Student values ('stud3', 'Carol', 'CS');
insert into Student values ('stud4', 'David', 'CS');
insert into Student values ('stud5', 'Emily', 'EE');
insert into Student values ('stud6', 'Frank', 'EE');

insert into Instructor values ('inst1', 'CS');
insert into Instructor values ('inst2', 'EE');
insert into Instructor values ('inst3', 'CS');
insert into Instructor values ('inst4', 'EE');
insert into Instructor values ('inst5', 'EE');

insert into Class values ('class1', 'Stanford', 'CA', 'USA');
insert into Class values ('class2', 'Stanford', 'CA', 'USA');
insert into Class values ('class3', 'Berkeley', 'CA', 'USA');
insert into Class values ('class4', 'MIT', 'MA', 'USA');
insert into Class values ('class5', 'MIT', 'MA', 'USA');
insert into Class values ('class6', 'McGill', 'Quebec', 'Canada');
insert into Class values ('class7', 'McGill', 'Quebec', 'Canada');
insert into Class values ('class8', 'Toronto', 'Ontario', 'Canada');
insert into Class values ('class9', 'Waterloo', 'Ontario', 'Canada');

drop sequence enrolnum;
create sequence enrolnum
minvalue 0
start with 0
increment by 1;

insert into Took values (enrolnum.nextval,'stud1', 'inst1', 'class1', 70);
insert into Took values (enrolnum.nextval,'stud1', 'inst1', 'class2', 75);
insert into Took values (enrolnum.nextval,'stud1', 'inst1', 'class3', 80);
insert into Took values (enrolnum.nextval,'stud1', 'inst1', 'class5', 85);
insert into Took values (enrolnum.nextval,'stud1', 'inst2', 'class1', 90);
insert into Took values (enrolnum.nextval,'stud1', 'inst2', 'class8', 95);
insert into Took values (enrolnum.nextval,'stud1', 'inst2', 'class3', 90);
insert into Took values (enrolnum.nextval,'stud1', 'inst2', 'class2', 85);
insert into Took values (enrolnum.nextval,'stud1', 'inst3', 'class7', 80);
insert into Took values (enrolnum.nextval,'stud1', 'inst3', 'class9', 75);
insert into Took values (enrolnum.nextval,'stud2', 'inst3', 'class8', 60);
insert into Took values (enrolnum.nextval,'stud2', 'inst1', 'class9', 65);
insert into Took values (enrolnum.nextval,'stud2', 'inst2', 'class5', 70);
insert into Took values (enrolnum.nextval,'stud2', 'inst2', 'class3', 75);
insert into Took values (enrolnum.nextval,'stud2', 'inst2', 'class6', 80);
insert into Took values (enrolnum.nextval,'stud2', 'inst2', 'class4', 85);
insert into Took values (enrolnum.nextval,'stud2', 'inst2', 'class7', 90);
insert into Took values (enrolnum.nextval,'stud2', 'inst2', 'class1', 95);
insert into Took values (enrolnum.nextval,'stud2', 'inst2', 'class7', 95);
insert into Took values (enrolnum.nextval,'stud2', 'inst2', 'class8', 90);
insert into Took values (enrolnum.nextval,'stud3', 'inst2', 'class2', 85);
insert into Took values (enrolnum.nextval,'stud3', 'inst2', 'class8', 80);
insert into Took values (enrolnum.nextval,'stud3', 'inst2', 'class5', 75);
insert into Took values (enrolnum.nextval,'stud3', 'inst2', 'class3', 70);
insert into Took values (enrolnum.nextval,'stud3', 'inst3', 'class5', 65);
insert into Took values (enrolnum.nextval,'stud3', 'inst3', 'class2', 60);
insert into Took values (enrolnum.nextval,'stud3', 'inst3', 'class8', 75);
insert into Took values (enrolnum.nextval,'stud3', 'inst3', 'class9', 80);
insert into Took values (enrolnum.nextval,'stud3', 'inst3', 'class3', 85);
insert into Took values (enrolnum.nextval,'stud3', 'inst3', 'class5', 90);
insert into Took values (enrolnum.nextval,'stud4', 'inst3', 'class1', 95);
insert into Took values (enrolnum.nextval,'stud4', 'inst3', 'class7', 90);
insert into Took values (enrolnum.nextval,'stud4', 'inst3', 'class8', 85);
insert into Took values (enrolnum.nextval,'stud4', 'inst3', 'class2', 80);
insert into Took values (enrolnum.nextval,'stud4', 'inst3', 'class8', 75);
insert into Took values (enrolnum.nextval,'stud4', 'inst3', 'class2', 70);
insert into Took values (enrolnum.nextval,'stud4', 'inst4', 'class3', 75);
insert into Took values (enrolnum.nextval,'stud4', 'inst4', 'class5', 80);
insert into Took values (enrolnum.nextval,'stud4', 'inst4', 'class3', 85);
insert into Took values (enrolnum.nextval,'stud4', 'inst4', 'class5', 90);
insert into Took values (enrolnum.nextval,'stud5', 'inst4', 'class6', 95);
insert into Took values (enrolnum.nextval,'stud5', 'inst4', 'class4', 90);
insert into Took values (enrolnum.nextval,'stud5', 'inst4', 'class6', 85);
insert into Took values (enrolnum.nextval,'stud5', 'inst4', 'class4', 80);
insert into Took values (enrolnum.nextval,'stud5', 'inst4', 'class9', 75);
insert into Took values (enrolnum.nextval,'stud5', 'inst4', 'class7', 60);
insert into Took values (enrolnum.nextval,'stud5', 'inst4', 'class1', 65);
insert into Took values (enrolnum.nextval,'stud5', 'inst4', 'class8', 70);
insert into Took values (enrolnum.nextval,'stud5', 'inst5', 'class9', 75);
insert into Took values (enrolnum.nextval,'stud5', 'inst5', 'class8', 80);
insert into Took values (enrolnum.nextval,'stud6', 'inst5', 'class3', 85);
insert into Took values (enrolnum.nextval,'stud6', 'inst5', 'class5', 90);
insert into Took values (enrolnum.nextval,'stud6', 'inst2', 'class3', 95);
insert into Took values (enrolnum.nextval,'stud6', 'inst2', 'class6', 90);
insert into Took values (enrolnum.nextval,'stud6', 'inst3', 'class4', 85);
insert into Took values (enrolnum.nextval,'stud6', 'inst3', 'class6', 80);
insert into Took values (enrolnum.nextval,'stud6', 'inst4', 'class4', 75);
insert into Took values (enrolnum.nextval,'stud6', 'inst4', 'class6', 70);
insert into Took values (enrolnum.nextval,'stud6', 'inst5', 'class4', 65);
insert into Took values (enrolnum.nextval,'stud6', 'inst5', 'class6', 60);

-- Display tables

SELECT * FROM STUDENT;
SELECT * FROM INSTRUCTOR;
SELECT * FROM CLASS;
SELECT * FROM TOOK;

/* question 1*/
select s.name, c.univ, t.score
from took t
inner join student s
on t.studid = s.studid
inner join class c
on t.classid = c.classid
inner join instructor i
on t.instid = i.instid
where s.major != i.dept and c.region = 'CA' and t.score > 80;

/* Question 2*/
select t.studid, t.instid, (round(Avg(t.score),2)) as "Average"
from took t
inner join student s
on t.studid = s.studid
inner join instructor i
on t.instid = i.instid
inner join class c
on t.classid = c.classid
where c.region = 'Quebec'
group by (t.studid,t.instid)
order by t.studid asc;

/*Question 3*/
select t.instid, (round(Avg(t.score),2)) as "Average"
from took t
inner join student s
on t.studid = s.studid
inner join instructor i
on t.instid = i.instid
inner join class c
on t.classid = c.classid
where c.region = 'Quebec'
group by (t.instid)
order by "Average" desc;

/*Question 4*/
select s.major, (round(avg(t.score),2)) as "Average"
from took t
inner join student s
on t.studid = s.studid
group by s.major
order by "Average" desc;

/*Question 5*/
select s.major,i.dept, (round(avg(t.score),2)) as "Average"
from took t
inner join student s
on t.studid = s.studid
inner join instructor i
on t.instid = i.instid
group by (s.major,i.dept)
order by s.major asc;

/*Question 6*/
select c.country, c.region, c.univ,(round(avg(t.score),2)) as "Average"
from took t
inner join class c
on t.classid = c.classid
group by rollup(c.country,c.region,c.univ)
order by c.country asc;

/* Question 7 */
select c.country, c.region, c.univ,(round(avg(t.score),2)) as "Average"
from took t
inner join class c
on t.classid = c.classid
group by cube(c.country,c.region,c.univ)
order by c.country asc;

/*Question 8*/
create view STUDENTSCORE as
select c.country, c.region, c.univ,(round(avg(t.score),2)) as Average
from took t
inner join class c
on t.classid = c.classid
group by rollup(c.country,c.region,c.univ)
order by c.country asc;

select average - ( select average from studentscore where country = 'Canada' and region is null and univ is null) as Difference
from studentscore
where country = 'USA' and region is null and univ is null;


/*Question 9*/

select s.studid, i.instid, c.classid, (round(avg(t.score),2)) as Average
from took t
inner join student s
on t.studid = s.studid
inner join instructor i
on t.instid = i.instid
inner join class c
on t.classid = c.classid
group by cube(s.studid,i.instid,c.classid)
order by s.studid;

/* QUestion 10 */
create view SCORECUBE as
select s.studid, i.instid, c.classid, (round(avg(t.score),2)) as Average
from took t
inner join student s
on t.studid = s.studid
inner join instructor i
on t.instid = i.instid
inner join class c
on t.classid = c.classid
group by cube(s.studid,i.instid,c.classid)
order by s.studid;

/*Question 11*/
select (round(avg(average),0)) as AVERAGE
from scorecube sc
inner join student s
on sc.studid = s.studid
inner join class c
on sc.classid = c.classid
where s.major = 'CS' and c.univ = 'MIT';

drop view studentscore;
drop view scorecube;


