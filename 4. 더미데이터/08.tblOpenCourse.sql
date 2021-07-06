--08tblOpenCourse.sql
--개설과정 테이블


--진행중 개설과정
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, 'Java 기반 임베디드 플랫폼 연동 융합 개발자 양성 과정', '2021-01-01', '2021-06-16', 1, 1, '1강의실');
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, '자바 기반 AWS 클라우드 활용 Full-Stack 개발자 양성 과정', '2021-01-01', add_months('2021-01-01', 7), 2, 2, '2강의실');
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, 'Java & JavaScript library을 활용한 반응형 웹 개발자 양성과정', '2021-01-01', add_months('2021-01-01', 7), 3, 3, '3강의실');
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, '오픈플랫폼(아두이노)을 활용한 융합개발자 양성과정', '2021-01-01', add_months('2021-01-01', 7), 4, 4, '4강의실');
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, 'JAVA를 활용한 웹 콘텐츠 양성과정', '2021-01-01', add_months('2021-01-01', 7), 5, 5, '5강의실');
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, '데이터 분석기법을 활용한 데이터융합 개발자 양성과정', '2021-01-01', add_months('2021-01-01', 6), 6, 6, '6강의실');

--진행예정 개설과정
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, '자바기반 Full-stack 웹 개발자 양성과정', '2021-08-05', add_months('2021-08-05', 7), 7, 7, '5강의실');
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, '자바 기반 융합형 SW개발자 양성과정', '2021-08-03', add_months('2021-08-03', 7), 8, 8, '3강의실');
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, 'Java를 활용한 멀티 플랫폼 융합 SW개발자 양성과정', '2021-08-01', add_months('2021-08-01', 6), 9, 9, '1강의실');
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, 'JAVA기반의 스마트 웹 앱콘텐츠 양성과정', '2021-08-02', '2021-11-16', 10, 10, '6강의실');

--종료된 개설과정
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, 'JAVA기반 Web Platform Service 구축 Web,App 개발자 양성과정', '2020-01-01', '2020-06-16', 5, 11, '2강의실');
insert into tblOpenCourse (opencourse_seq, opencourse_name, opencourse_startdate, opencourse_finishdate, teacher_seq, course_seq, classroom_name)values (seqOpenCourse.nextval, '빅데이터와 인공지능을 활용한 디지털 전환 전문가 양성과정', '2020-01-01', add_months('2020-01-01', 7), 6, 12, '1강의실');


SET DEFINE OFF;
select * from tblOpenCourse;
delete from tblOpenCourse;
commit;
