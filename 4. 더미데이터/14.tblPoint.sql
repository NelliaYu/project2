--14.tblPoint.sql
--배점등록 더미데이터

--공통(개설과목번호 1~6번 : 자바) >> 배점 같음
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 1, 0.2, 0.4, 0.4);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 2, 0.2, 0.4, 0.4);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 3, 0.2, 0.4, 0.4);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 4, 0.2, 0.4, 0.4);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 5, 0.2, 0.4, 0.4);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 6, 0.2, 0.4, 0.4);

--공통(개설과목번호 7~12번 : 오라클) >> 배점 같음
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 7, 0.4, 0.5, 0.1);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 8, 0.4, 0.5, 0.1);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 9, 0.4, 0.5, 0.1);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 10, 0.4, 0.5, 0.1);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 11, 0.4, 0.5, 0.1);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 12, 0.4, 0.5, 0.1);

--공통(개설과목번호 13~18번 : JDBC) >> 배점 같음
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 13, 0.4, 0.4, 0.2);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 14, 0.4, 0.4, 0.2);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 15, 0.4, 0.4, 0.2);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 16, 0.4, 0.4, 0.2);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 17, 0.4, 0.4, 0.2);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 18, 0.4, 0.4, 0.2);

--개별과목 (나머지 12개)
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 19, 0.2, 0.5, 0.3);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 20, 0.3, 0.4, 0.3);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 21, 0.2, 0.2, 0.6);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 22, 0.4, 0.2, 0.4);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 23, 0.3, 0.4, 0.3);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 24, 0.2, 0.1, 0.7);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 25, null, null, null);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 26, 0.4, 0.3, 0.3);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 27, 0.3, 0.3, 0.4);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 28, null, null, null);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 29, 0.3, 0.1, 0.6);
insert into tblPoint (point_seq, opensubject_seq, check_point, note_point, skill_point) values (seqPoint.nextVal, 30, null, null, null);