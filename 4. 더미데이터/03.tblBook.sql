--03tblBook.sql
--교재 테이블

insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '혼자 공부하는 머신러닝+딥러닝', '이지스퍼블리싱');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, 'Java의 정석', '이지스퍼블리싱');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '자바 ORM 표준 JPA 프로그래밍', '한빛미디어');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '이것이 안드로이드다 with 코틀린', '한빛미디어');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '이것이 자바다', '이지스퍼블리싱');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, 'Do it! 오라클로 배우는 데이터베이스 입문', '한빛아카데미');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '모던 웹을 위한 JavaScript + jQuery 입문', '한빛미디어');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '이것이 안드로이드다 with 코틀린', '책만');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, ' Do it! HTML+CSS+자바스크립트 웹 표준의 정석', '한빛미디어');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, 'Do it! 첫 코딩 with 자바', '이지스퍼블리싱');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '팀 개발을 위한 Git, GitHub 시작하기', '길벗');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, 'Do it! 첫 코딩 with 자바', '이지스퍼블리싱');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, ' Do it! HTML+CSS+자바스크립트 웹 표준의 정석', '이지스퍼블리싱');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, 'Java의 정석', '이지스퍼블리싱');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '이것이 안드로이드다 with 코틀린', '생능출판사');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '명품 JAVA Programming', '이지스퍼블리싱');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '자바 프로젝트 필수 유틸리티', '길벗');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '프로젝트로 배우는 자바 웹 프로그래밍', '생능출판사');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, '이것이 안드로이드다 with 코틀린', '이지스퍼블리싱');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, 'Do it! 첫 코딩 with 자바', '이지스퍼블리싱');
insert into tblBook (book_seq, book_name, book_publisher)values (seqBook.nextval, 'Do it! 지옥에서 온 문서 관리자 깃&깃허브 입문', '이지스퍼블리싱');

SET DEFINE OFF;
delete from tblBook;
select * from tblBook;

