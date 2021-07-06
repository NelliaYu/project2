--07tblCourse.sql
--정적과정 테이블

insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, 'Java 기반 임베디드 플랫폼 연동 융합 개발자 양성 과정', 5.5);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, '자바 기반 AWS 클라우드 활용 Full-Stack 개발자 양성 과정', 7);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, '오픈플랫폼(아두이노)을 활용한 융합개발자 양성과정', 7);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, 'JAVA를 활용한 웹 콘텐츠 양성과정', 7);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, '데이터 분석기법을 활용한 데이터융합 개발자 양성과정', 7);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, '자바기반 Full-stack 웹 개발자 양성과정', 6);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, '자바 기반 융합형 SW개발자 양성과정', 7);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, 'Java를 활용한 멀티 플랫폼 융합 SW개발자 양성과정', 7);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, 'JAVA기반의 스마트 웹 앱콘텐츠 양성과정', 6);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, 'JAVA기반 Web Platform Service 구축 Web,App 개발자 양성과정', 5.5);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, '빅데이터와 인공지능을 활용한 디지털 전환 전문가 양성과정', 6);
insert into tblCourse (course_seq, course_name, course_term)values (seqCourse.nextval, 'Java & JavaScript library을 활용한 반응형 웹 개발자 양성과정', 5.5);

SET DEFINE ON; --&
delete from tblCourse;
select * from tblCourse;