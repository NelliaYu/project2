
-- 관리자
CREATE TABLE tblAdmin (
	admin_seq  number       NOT NULL, -- 관리자번호
	admin_name varchar2(30) NOT NULL, -- 이름
	admin_ssn  varchar2(7)  NOT NULL  -- 주민번호 뒷자리
);

-- 관리자 테이블 제약사항
ALTER TABLE tblAdmin
	add CONSTRAINT tbladmin_admin_seq_pk primary key(admin_seq); -- 관리자 기본키

--ALTER TABLE tblAdmin
--	add CONSTRAINT tbladmin_admin_seq_ck check (admin_seq<=5);

-- 관리자 테이블 시퀀스 생성 
CREATE SEQUENCE seqAdmin;


-- 교사
CREATE TABLE tblTeacher (
	teacher_seq   number       NOT NULL, -- 교사번호
	teacher_name  varchar2(30) NOT NULL, -- 교사이름
	teacher_ssn   varchar2(7)  NOT NULL, -- 주민번호뒷자리
	teacher_tel   varchar2(15) NOT NULL, -- 전화번호
	lecture_state varchar2(20) NOT NULL  -- 강의진행상태
);

ALTER TABLE tblTeacher
	add CONSTRAINT tblTeacher_teacher_seq_pk primary key(teacher_seq); 
    
ALTER TABLE tblTeacher
	add CONSTRAINT tblTeacher_lecture_state_ck check (lecture_state in ('강의예정', '강의중')); 

-- 교사 테이블의 시퀀스 생성 
CREATE SEQUENCE seqTeacher;



-- 교재
CREATE TABLE tblBook (
	book_seq       number        NOT NULL, -- 교재번호
	book_name      varchar2(100) NOT NULL, -- 교재명
	book_publisher varchar2(100) NOT NULL  -- 출판사명
);

ALTER TABLE tblBook
	add CONSTRAINT tblBook_book_seq_pk primary key(book_seq); 

-- 교재 테이블의 시퀀스 생성 
CREATE SEQUENCE seqBook;



-- 과목목록
CREATE TABLE tblSubject (
	subject_seq  number        NOT NULL, -- 과목번호
	subject_name varchar2(100) NOT NULL, -- 과목명
	subject_term number        NOT NULL, -- 과목기간
	book_seq     number        NOT NULL  -- 교재번호
);

ALTER TABLE tblSubject
	add CONSTRAINT tblSubject_subject_seq_pk primary key(subject_seq); 
  
ALTER TABLE tblSubject
	add CONSTRAINT tblSubject_book_seq_fk foreign key(book_seq) REFERENCES tblBook(book_seq);

-- 과목목록 테이블의 시퀀스 생성 
CREATE SEQUENCE seqSubject;




-- 강의가능과목
CREATE TABLE tblAvailableSubject (
	available_subject_seq number NOT NULL, -- 강의가능한과목번호
	teacher_seq           number NOT NULL, -- 교사번호
	subject_seq           number NOT NULL  -- 과목번호
);

ALTER TABLE tblAvailableSubject
	add CONSTRAINT tblableSub_able_sub_seq_pk primary key(available_subject_seq); 

ALTER TABLE tblAvailableSubject
	add CONSTRAINT tblableSub_teacher_seq_fk foreign key(teacher_seq) REFERENCES tblTeacher(teacher_seq);

ALTER TABLE tblAvailableSubject
	add CONSTRAINT tblableSub_sub_seq_fk foreign key(subject_seq) REFERENCES tblSubject(subject_seq);

-- 강의가능과목 테이블의 시퀀스 생성
CREATE SEQUENCE seqAvailableSubject;



-- 강의실
CREATE TABLE tblClassroom (
	classroom_name       varchar2(15) NOT NULL, -- 강의실명
	classroom_population number       NOT NULL  -- 강의실인원
);

ALTER TABLE tblClassroom
	add CONSTRAINT tblClassroom_classroom_name_pk primary key(classroom_name); 
alter table tblClassroom add constraint tblClassroom_count_ck check (classroom_name in('1강의실','2강의실','3강의실','4강의실','5강의실','6강의실'));


-- 강의실 테이블의 시퀀스 생성 
CREATE SEQUENCE seqClassroom;




-- 과정목록
CREATE TABLE tblCourse (
	course_seq  number        NOT NULL, -- 과정번호
	course_name varchar2(100) NOT NULL, -- 과정명
	course_term number        NOT NULL  -- 과정기간
);

ALTER TABLE tblCourse
	add CONSTRAINT tblCourse_course_seq_pk primary key(course_seq); 

-- 과정목록 테이블의 시퀀스 생성 
CREATE SEQUENCE seqCourse;


-- 개설과정
CREATE TABLE tblOpenCourse (
	opencourse_seq        number        NOT NULL, -- 개설과정번호
	opencourse_name       varchar2(100) NOT NULL, -- 개설과정명
	opencourse_startdate  date          NOT NULL, -- 과정시작일
	opencourse_finishdate date          NOT NULL, -- 과정종료일
	teacher_seq           number        NOT NULL, -- 교사번호
	course_seq            number        NOT NULL, -- 과정번호
	classroom_name        varchar2(15)  NOT NULL  -- 강의실명
);

ALTER TABLE tblOpenCourse
	add CONSTRAINT tblOpenCourse_oc_seq_pk primary key(opencourse_seq); 

ALTER TABLE tblOpenCourse
	add CONSTRAINT tblOpenCourse_teacher_seq_fk foreign key(teacher_seq) REFERENCES tblTeacher(teacher_seq);

ALTER TABLE tblOpenCourse
	add CONSTRAINT tblOpenCourse_course_seq_fk foreign key(course_seq) REFERENCES tblCourse(course_seq);

ALTER TABLE tblOpenCourse
	add CONSTRAINT tblOpenCourse_class_name_fk foreign key(classroom_name) REFERENCES tblClassroom(classroom_name);


-- 개설과정 테이블의 시퀀스 생성
CREATE SEQUENCE seqOpenCourse;



-- 개설과목
CREATE TABLE tblOpenSubject (
	opensubject_seq       number NOT NULL, -- 개설과목번호
	subject_seq           number NOT NULL, -- 과목번호
	opencourse_seq        number NOT NULL, -- 개설과정번호
	opensubject_startdate  date   NOT NULL, -- 과목시작일
	opensubject_finishdate date   NOT NULL  -- 과목종료일
);

ALTER TABLE tblOpenSubject
	add CONSTRAINT tblOpenSubject_opensub_seq_pk primary key(opensubject_seq); 

ALTER TABLE tblOpenSubject
	add CONSTRAINT tblOpenSubject_subject_seq_fk foreign key(subject_seq) REFERENCES tblSubject(subject_seq);

ALTER TABLE tblOpenSubject
	add CONSTRAINT tblOpenSubject_oc_seq_fk foreign key(opencourse_seq) REFERENCES tblOpenCourse(opencourse_seq);

-- 개설과목 테이블의 시퀀스 생성 
CREATE SEQUENCE seqOpenSubject;



-- 시험
CREATE TABLE tblTest (
	test_seq        number NOT NULL, -- 시험번호
	opensubject_seq number NOT NULL, -- 개설과목번호 
	test_date       date   NULL      -- 시험날짜
);

ALTER TABLE tblTest
	add CONSTRAINT tblTest_test_seq_pk primary key(test_seq); 
ALTER TABLE tblTest
	add CONSTRAINT tblTest_opensubject_seq_fk foreign key(opensubject_seq) REFERENCES tblOpenSubject(opensubject_seq);

-- 시험 테이블의 시퀀스 생성
CREATE SEQUENCE seqTest;



-- 시험지문제
CREATE TABLE tblTestQusReg (
	testquestion_seq       number         NOT NULL, -- 문제번호
    test_question varchar2(1000) NULL,     -- 문제
    test_answer varchar2(1500) NULL      -- 답
);

ALTER TABLE tblTestQusReg
	add CONSTRAINT tblTestQusReg_testbook_seq_pk primary key(testquestion_seq); 

-- 시험지문제 테이블의 시퀀스 생성
CREATE SEQUENCE seqTestBookReg;



-- 시험지등록
CREATE TABLE tblTestBookReg (
	testbook_seq number       NOT NULL, -- 시험지번호
    testbook_reg_date date         DEFAULT sysdate NULL, -- 시험지등록일
	testbook_reg_check varchar2(10) DEFAULT '미등록' NOT NULL, -- 시험지등록여부
	test_seq         number       NOT NULL, -- 시험번호
	testquestion_seq     number       NOT NULL  -- 문제번호
);


ALTER TABLE tblTestBookReg
	add CONSTRAINT tblTestBookReg_seq_pk primary key(testbook_seq); 
ALTER TABLE tblTestBookReg
	add CONSTRAINT tblTestBookReg_test_seq_fk foreign key(test_seq) REFERENCES tblTest(test_seq);
ALTER TABLE tblTestBookReg
	add CONSTRAINT tblTestBookReg_testQus_seq_fk foreign key(testquestion_seq) REFERENCES tblTestQusReg(testquestion_seq);


-- 시험지등록 테이블의 시퀀스 생성 
CREATE SEQUENCE seqTestQusReg;






-- 교육생
CREATE TABLE tblStudent (
	student_seq     number       NOT NULL, -- 교육생번호
	student_name    varchar2(30) NOT NULL, -- 교육생이름
	student_tel     varchar2(15) NOT NULL, -- 전화번호
	student_ssn     varchar2(7)  NOT NULL, -- 주민번호뒷자리
	student_regdate DATE         DEFAULT sysdate NOT NULL, -- 등록일
	opencourse_seq  number       NOT NULL  -- 개설과정번호
);

ALTER TABLE tblStudent
	add CONSTRAINT tblStudent_student_seq_pk primary key(student_seq); 
    
ALTER TABLE tblStudent
	add CONSTRAINT tblStudent_opencourse_seq_fk foreign key(opencourse_seq) REFERENCES tblOpenCourse(opencourse_seq);


-- 교육생 테이블의 시퀀스 생성 
CREATE SEQUENCE seqStudent;



-- 배점등록
CREATE TABLE tblPoint (
	point_seq       number NOT NULL, -- 배점번호
	opensubject_seq number NOT NULL, -- 개설과목번호
	check_point     number NULL,     -- 출결배점
	note_point      number NULL,     -- 필기배점
	skill_point     number NULL      -- 실기배점
);

ALTER TABLE tblPoint
	add CONSTRAINT tblPoint_point_seq_pk primary key(point_seq); 

ALTER TABLE tblPoint
	add CONSTRAINT tblPoint_point_os_seq_fk foreign key(opensubject_seq) REFERENCES tblOpenSubject(opensubject_seq);

ALTER TABLE tblpoint ADD CONSTRAINT tblpoint_check_score_ck CHECK (check_point >=0.2);

ALTER TABLE tblpoint ADD CONSTRAINT tblpoint_total_score_ck CHECK(check_point+note_point+skill_point =1.0);

-- 배점등록 테이블의 시퀀스 생성 
CREATE SEQUENCE seqPoint;


-- 성적조회
CREATE TABLE tblScore (
	score_seq       number       NOT NULL, -- 성적조회
	student_seq     number       NOT NULL, -- 교육생번호
	check_score     number       NULL,     -- 출결점수
	note_score      number       NULL,     -- 필기점수
	skill_score     number       NULL,     -- 실기점수
	score_reg       varchar2(10) DEFAULT '미등록' NOT NULL, -- 성적등록여부
	point_seq       number       NOT NULL  -- 배점번호
);

ALTER TABLE tblScore
	add CONSTRAINT tblScore_score_seq_pk primary key(score_seq); 
ALTER TABLE tblScore
	add CONSTRAINT tblScore_student_seq_fk foreign key(student_seq) REFERENCES tblStudent(student_seq);
ALTER TABLE tblScore
	add CONSTRAINT tblScore_point_seq_fk foreign key(point_seq) REFERENCES tblPoint(point_seq);


-- 성적조회 테이블의 시퀀스 생성 
CREATE SEQUENCE seqScore;




-- 수료 및 중도 탈락여부
CREATE TABLE tblCompletionState (
	completion_seq         number       NOT NULL, -- 수료번호
	student_seq            number       NOT NULL, -- 교육생번호
	completion_reg_check   varchar2(15) NULL,     -- 수료 및 중도탈락여부
	completion_date        DATE         NULL,     -- 수료 및 중도 탈락여부 날짜
	afterservice_job       varchar2(10) NULL,     -- 취업유무
	afterservice_insurance varchar2(10) NULL      -- 고용보험가입유무
);

ALTER TABLE tblCompletionState
	add CONSTRAINT tblCompletionState_cp_seq_pk primary key(completion_seq); 
ALTER TABLE tblCompletionState
	add CONSTRAINT tblCompletionState_st_seq_fk foreign key(student_seq) REFERENCES tblStudent(student_seq);
    
-- 수료 및 중도 탈락여부 테이블의 시퀀스 생성
CREATE SEQUENCE seqCompletionState;



-- 출결
CREATE TABLE tblCheck (
	check_seq   number       NOT NULL, -- 출결번호
	student_seq number       NOT NULL, -- 교육생번호
	check_date  DATE         NULL,     -- 출결날짜
	enter_time  varchar2(20)  NULL,     -- 입실시간
	leave_time  varchar2(20)  NULL,     -- 퇴실시간
	check_state varchar2(10) NULL      -- 근태현황
);

ALTER TABLE tblCheck
	add CONSTRAINT tblCheck_check_seq_pk primary key(check_seq); 
ALTER TABLE tblCheck
	add CONSTRAINT tblCheck_student_seq_fk foreign key(student_seq) REFERENCES tblStudent(student_seq);
    
-- 출결 테이블의 시퀀스 생성
CREATE SEQUENCE seqCheck;



-- 비품 대여 관련 테이블
-- 비품종류
CREATE TABLE tblKind (
	kind_seq     number       NOT NULL, -- 비품종류번호
	kind_name    varchar2(30) NULL,     -- 종류명
	rent_datemax number       NULL      -- 최대대여일수
);
ALTER TABLE tblKind
	add CONSTRAINT tblKind_kind_seq_pk primary key(kind_seq); 
-- 출결 테이블의 시퀀스 생성 
CREATE SEQUENCE seqKind;


-- 비품
CREATE TABLE tblProduct (
	product_seq         number       NOT NULL, -- 비품번호
	product_name        varchar2(30) NOT NULL, -- 비품이름
	product_kindseq     number       NOT NULL, -- 비품종류번호
	product_total       number       NULL,     -- 전체수량
	product_left_amount number       NULL,     -- 남은수량
	product_deposit     number       NULL      -- 보증금
);

ALTER TABLE tblProduct
	add CONSTRAINT tblProduct_product_seq_pk primary key(product_seq); 
ALTER TABLE tblProduct
	add CONSTRAINT tblProduct_product_kindseq_fk foreign key(product_kindseq) REFERENCES tblKind(kind_seq);
    
-- 비품 테이블의 시퀀스 생성
CREATE SEQUENCE seqProduct;



-- 대여
CREATE TABLE tblRentObject (
	rent_seq           number NOT NULL, -- 대여번호
	product_seq        number NOT NULL, -- 비품번호
	product_startdate  date   NULL,     -- 비품대여시작일
	product_finishdate date   NULL,     -- 비품대여반납일
	rent_amount        number NULL      -- 대여수량
);


ALTER TABLE tblRentObject
	add CONSTRAINT tblRentObject_rent_seq_pk primary key(rent_seq); 
ALTER TABLE tblRentObject
	add CONSTRAINT tblRentObject_product_seq_fk foreign key(product_seq) REFERENCES tblProduct(product_seq);
    
-- 대여 테이블의 시퀀스 생성
CREATE SEQUENCE seqRentObject;




-- 대여자명단
CREATE TABLE tblRentList (
	rent_num    number NOT NULL, -- 대여자번호
	student_seq number             NULL,     -- 교육생번호
	teacher_seq number             NULL,     -- 교사번호
	rent_seq    number             NULL      -- 대여번호
);


ALTER TABLE tblRentList
	add CONSTRAINT tblRentList_rent_num_pk primary key(rent_num); 
ALTER TABLE tblRentList
	add CONSTRAINT tblRentList_student_seq_fk foreign key(student_seq) REFERENCES tblStudent(student_seq);
ALTER TABLE tblRentList
	add CONSTRAINT tblRentList_teacher_seq_fk foreign key(teacher_seq) REFERENCES tblTeacher(teacher_seq);
ALTER TABLE tblRentList
	add CONSTRAINT tblRentList_rent_seq_fk foreign key(rent_seq) REFERENCES tblRentObject(rent_seq);
    
-- 대여자명단 테이블의 시퀀스 생성
CREATE SEQUENCE seqRentList;








