--04.tblSubject.sql
--과목목록 더미데이터

insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '자바', 30, 1);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '오라클', 32, 2);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'JDBC', 60, 3);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'Python', 20, 4);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '빅데이터플랫폼', 40, 5);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'HTML', 40, 6);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'CSS', 32, 7);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'JavaScript', 48, 8);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'jQuery', 20, 9);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'JSP', 30, 10);

insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'Spring', 60, 7);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'myBatis', 40, 5);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '데이터베이스 구조 설계 및 활용', 16, 10);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'Front-end 화면 설계 및 인터랙티브 UI 구현', 32, 16);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'Spring Framework 기반 백엔드 설계 및 구축', 60, 3);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'R 프로그램', 40, 7);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '머신러닝', 16, 17);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '딥러닝', 20, 15);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '인공지능', 16, 4);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '인공지능과 머신러닝 기법 활용하기', 30, 16);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'AWS 기반 통합 프로젝트', 60, 19);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'AWS 클라우드 등록 설정 및 구축', 32, 1);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '클라우드 시스템 개요 및 AWS 서비스 요소', 48, 6);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'UML을 사용한 시스템 분석', 20, 11);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '웹 애플리케이션구현', 16, 10);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, 'JSP 웹 프로그래밍', 32, 18);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '형상관리', 30, 16);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '반응형 웹 프로젝트', 16, 11);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '빅데이터시스템개발', 40, 4);
insert into tblSubject (subject_seq, subject_name, subject_term, book_seq) values (seqSubject.nextVal, '빅데이터분석', 28, 19);

--업데이트(과목번호 10번 과목기간 '24'일로 업데이트)
update tblSubject set subject_term = 24 where subject_seq = 10;