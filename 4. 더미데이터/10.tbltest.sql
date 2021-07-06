--10.tbltest.sql
--시험 더미데이터

insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,1,to_date('2021-01-31','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,2,to_date('2021-03-02','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,3,to_date('2021-05-02','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,4,to_date('2021-05-22','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,5,to_date('2021-07-01','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,6,to_date('2021-01-03','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,7,to_date('2021-08-30','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,8,to_date('2021-03-12','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,9,to_date('2021-06-19','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,10,to_date('2021-06-16','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,11,to_date('2021-06-27','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,12,to_date('2021-10-10','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,13,to_date('2021-07-07','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,14,to_date('2021-06-23','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,15,to_date('2021-07-08','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,16,to_date('2021-06-05','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,17,to_date('2021-02-03','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,18,to_date('2021-11-14','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,19,to_date('2021-05-01','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,20,to_date('2021-03-25','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,21,to_date('2021-08-21','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,22,to_date('2021-11-23','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,23,to_date('2021-02-03','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,24,to_date('2021-07-26','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,25,to_date('2021-02-22','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,26,to_date('2021-09-01','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,27,to_date('2021-07-11','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,28,to_date('2021-02-14','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,29,to_date('2021-08-11','yyyy-mm-dd'));
insert into tblTest (test_seq,opensubject_seq,test_date) values (seqTest.nextval,30,to_date('2021-02-10','yyyy-mm-dd'));

update tblTest
set test_date = '2021-01-31'
where opensubject_seq = 1;

update tblTest
set test_date = '2021-03-02'
where opensubject_seq = 7;

update tblTest
set test_date = '2021-05-02'
where opensubject_seq = 13;

update tblTest
set test_date = '2021-05-22'
where opensubject_seq = 19;

update tblTest
set test_date = '2021-06-16'
where opensubject_seq = 25;

commit;