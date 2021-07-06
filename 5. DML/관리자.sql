

/*
A000, 로그인
*/
set serveroutput on;
create or replace procedure procTlogin(
    ssn varchar2,
     vresult out number
)  -- 매개변수 리스트
is  
begin
        --입력한 ssn와 같으면 '1'이 들어가고, 없으면 '0'이 들어갈것
         select count(*) into vresult from tblteacher where teacher_ssn = ssn;
         
exception
        when others then
        dbms_output.put_line('로그인 실패');
end procTlogin;

--호출
declare
    vresult number;
begin
    procTlogin('23355', vresult);
    
    if vresult = 1 then
        dbms_output.put_line('로그인 성공');
    else
        dbms_output.put_line('로그인 실패');
     end if;
end procTlogin;



/*
A001, 기초 정보 관리
[메인] > [관리자] > [기초 정보 관리] 
A001-1-1. 과정을 조회한다.
A001-1-2. 과정을 추가한다.
A001-1-3. 과정을 수정한다.
A001-1-4. 과정을 삭제한다.

*/

-- A001-1-1. 과정을 조회한다.

create or replace view vwtblCourse
as
SELECT
    course_seq 과정번호,
    course_name 과정명,
    course_term 과정기간
FROM tblCourse order by course_seq;

select * from vwtblCourse;

-- A001-1-2. 과정을 추가한다.
CREATE OR REPLACE PROCEDURE procAddCourse
(
	pcourse_name IN varchar2,		    --과정명
	pcourse_term IN NUMBER			--기간(일)
)
IS
BEGIN
	INSERT INTO tblCourse VALUES(seqCourse.nextVal, pcourse_name, pcourse_term);
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procAddCourse;

select * from vwtblCourse;
begin
procAddCourse ('DBMS를 통한 오라클 강의',5.5);
end vwtblCourse;


-- A001-1-3. 과정을 수정한다.
CREATE OR REPLACE PROCEDURE procUpdateCourse
(
    pcourse_seq in number,            -- 과정번호
	pcourse_name IN varchar2,		    --과정명
	pcourse_term IN NUMBER			--기간(일)
)
IS

BEGIN
	update tblCourse set  course_name = pcourse_name, course_term = pcourse_term where course_seq = pcourse_seq;
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procUpdateCourse;

select * from vwtblCourse;
begin
procUpdateCourse (41,'Java를 활용한 반응형 웹 개발자 양성과정',5.5);
end procUpdateCourse;

-- A001-1-4. 과정을 삭제한다.
CREATE OR REPLACE PROCEDURE procDeleteCourse
(
    pcourse_seq in number          -- 과정번호

)
IS

BEGIN
	delete from tblCourse where course_seq = pcourse_seq;
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procDeleteCourse;

select * from vwtblCourse;
begin
procDeleteCourse (41);
end;



/*
A001, 기초 정보 관리
[메인] > [관리자] > [기초 정보 관리] 
A001-2-1. 과목을 조회한다.
A001-2-2. 과목을 추가한다.
A001-2-3. 과목을 수정한다.
A001-2-4. 과목을 삭제한다.

*/
-- A001-1-1. 과목을 조회한다.

select * from vwtblsubject;

create view vwtblSubject
as
SELECT 
subject_seq 과목번호,
subject_name 과목명,
subject_term 과목기간,
book_seq 교재번호
FROM tblSubject order by subject_seq;

-- A001-1-2. 과목을 추가한다.
CREATE OR REPLACE PROCEDURE procAddSubject
(
	psubject_name IN varchar2,		    --과목명
	psubject_term IN NUMBER,			--기간(일)
    pbook_seq in number                --교재번호
)
IS
BEGIN
	INSERT INTO tblSubject VALUES(seqSubject.nextVal, psubject_name,psubject_term, pbook_seq);
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procAddSubject;

select * from vwtblsubject;
begin
procAddSubject ('테스트과목입니다.',30,1);
end vwtblSubject;

-- A001-1-3. 과목을 수정한다.
CREATE OR REPLACE PROCEDURE procUpdateSubject
(
    psubject_seq in number,            -- 과목번호
    psubject_name IN varchar2,		    --과목명
	psubject_term IN NUMBER,			--기간(일)
    pbook_seq in number                --교재번호
)
IS
BEGIN
	update tblSubject set  subject_name =  psubject_name, subject_term = psubject_term, book_seq = pbook_seq where subject_seq = psubject_seq;
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procUpdateSubject;

select * from vwtblsubject;
begin
procUpdateSubject (41,'변경된테스트용과목입니다.',30,19);
end procUpdateSubject;

-- A001-1-4. 과목을 삭제한다.
CREATE OR REPLACE PROCEDURE procDeletesubject
(
    psubject_seq in number          -- 과목번호

)
IS

BEGIN
	delete from tblSubject where subject_seq = psubject_seq;
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procDeletesubject;

select * from vwtblsubject;
begin
procDeletesubject (41);
end procDeletesubject;

/*
A001, 기초 정보 관리
[메인] > [관리자] > [기초 정보 관리] 
A001-3-1. 강의실을 조회한다.
A001-3-2. 강의실을 추가한다.
A001-3-3. 강의실을 수정한다.
A001-3-4. 강의실을 삭제한다.

*/

-- A001-3-1. 강의실을 조회한다.

select * from vwtblclassroom;

create view vwtblclassroom
as
SELECT
classroom_name 강의실명,
classroom_population 강의실인원
FROM tblClassroom order by classroom_name;

-- A001-3-2. 강의실을 추가한다.
CREATE OR REPLACE PROCEDURE procAddClassroom
(
	pclassroom_name IN varchar2,		            --강의실명
	pclassroom_population IN NUMBER			--강의인원수
)
IS
BEGIN
	INSERT INTO tblClassroom VALUES(pclassroom_name, pclassroom_population);
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procAddClassroom;

select * from vwtblclassroom;
begin
procAddClassroom ('7강의실',30); 
end;


-- A001-3-3. 강의실인원수를 수정한다.
CREATE OR REPLACE PROCEDURE procUpdateClassroom
(
	pclassroom_name IN varchar2,		            --강의실명
	pclassroom_population IN NUMBER			--강의인원수
)
IS
BEGIN
	update tblClassroom set classroom_population = pclassroom_population where classroom_name = pclassroom_name ;

	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procUpdateClassroom;

select * from vwtblclassroom;
begin
 procUpdateClassroom ('6강의실',30);
end;

 


-- A001-1-4. 과목을 삭제한다.
CREATE OR REPLACE PROCEDURE procDeleteClassroom
(
   pclassroom_name IN varchar2          -- 강의실이름

)
IS

BEGIN
	delete from tblClassroom where classroom_name = pclassroom_name;
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procDeleteClassroom;

select * from vwtblclassroom;
begin
procDeleteClassroom ('6강의실');
end procDeleteClassroom;

/*
A001, 기초 정보 관리
[메인] > [관리자] > [기초 정보 관리] 
A001-4-1. 교재를 조회한다.
A001-4-2. 교재를 추가한다.
A001-4-3. 교재를 수정한다.
A001-4-4. 교재를 삭제한다.

*/

-- A001-4-1. 교재를 조회한다.
select * from vwtblbook;

create or replace view vwtblbook
as
SELECT
book_seq 교재번호,
book_name 교재명,
book_publisher 출판사
FROM tblBook order by book_seq;

-- A001-4-2. 교재를 추가한다.
CREATE OR REPLACE PROCEDURE procAddBook
(
	pbook_name IN varchar2,		        --교재이름
	pbook_publisher IN varchar2			--출판사

)
IS
BEGIN
	INSERT INTO tblBook VALUES(seqTestBookReg.nextVal,pbook_name, pbook_publisher);
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procAddBook;

select * from vwtblbook;
begin
procAddBook ('이것이 테스트다','쌍용교육센터');
end;

-- A001-4-3. 교재를 수정한다.
CREATE OR REPLACE PROCEDURE procUpdateBook
(
    pbook_seq in number,                    --교재번호
	pbook_name IN varchar2,		        --교재이름
	pbook_publisher IN varchar2			--출판사
)
IS
BEGIN
	update tblBook set book_name = pbook_name,book_publisher=pbook_publisher where book_seq = pbook_seq;
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procUpdateBook;

select * from vwtblbook;
begin
    procUpdateBook (201,'이것은 테스트다','쌍용교육');
end;

-- A001-4-4. 교재를 삭제한다.
CREATE OR REPLACE PROCEDURE procDeleteBook
(
       pbook_seq in number           --교재번호

)
IS

BEGIN
	delete from tblBook where book_seq = pbook_seq;
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procDeleteBook;

select * from vwtblbook;
begin
procDeleteBook (201);
end;



/*
A002, 교사 계정 관리하기
[메인] > [관리자] > [기초 정보 관리] 
A002-1. 교사 계정을 등록, 수정, 삭제할 수 있다. 
A002-2. 교사 계정을 전체 조회할 수 있다.
*/


/*
A002-1-1, 교사 계정 등록하기
[메인] > [관리자] > [교사 계정 관리] > [전체 교사 조회] > [교사 등록]
- 교사 번호를 입력한다.
- 교사 이름을 입력한다.
- 교사 주민번호 뒷자리를 입력한다.
- 교사 전화번호를 입력한다.
- 교사 강의진행상태 입력한다

*/
CREATE OR REPLACE PROCEDURE procAddtblTeacher
(
    pteacher_name IN varchar2,    -- 교사이름
    pteacher_ssn	 IN varchar2,       -- 교사주민번호
    pteacher_tel IN varchar2       -- 전화번호

)
IS
BEGIN
	INSERT INTO tblteacher VALUES(seqTeacher.nextVal,pteacher_name, pteacher_ssn,pteacher_tel,'강의예정');
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procAddtblTeacher;

select * from vwtblTeacher;
begin
procAddtblTeacher ('유수영',2034920,'010-4033-8669');
end;


create or replace trigger trgTeacher
    after
    insert or update or delete
    on tblTeacher 
declare
    vmessage varchar2(1000);
begin   

    if inserting then
        vmessage :='교사가 입사하였습니다.';
    elsif updating then
        vmessage :='교사 정보가 수정되었습니다.';
    elsif deleting then
        vmessage :='교사 정보가 삭제되었습니다.';
    end if;
    dbms_output.put_line(vmessage);
end trgTeacher;

/*
A002-1-2, 교사 계정 수정하기
[메인] > [관리자] > [교사 계정 관리] > [전체 교사 조회] >  [교사 정보 수정]
- 교사 정보를 수정할 수 있다.
- 교사 이름을 수정한다.
- 교사 주민번호 뒷자리를 수정한다.
- 교사 전화번호를 수정한다.
- 교사 강의진행상태를 수정한다.
.
*/


CREATE OR REPLACE PROCEDURE procUpdateteacher
(
    pteacher_seq in number,                    --교사번호
	pteacher_name IN varchar2,		            --교사이름
	pteacher_ssn IN varchar2	,		            --교사주민번호뒷자리
    pteacher_tel IN varchar2                   -- 교사전화번호
)
IS
    vresult varchar2(20);
    cnt number;
BEGIN
    select count (*) into cnt from tblOpenCourse where teacher_seq = pteacher_seq;
    
    if cnt > 0 then
     select fnDate(sysdate,opencourse_startdate,opencourse_finishdate) into vresult from
      (select opencourse_startdate,opencourse_finishdate from (select tblOpenCourse.*, rownum from tblOpenCourse where teacher_seq = pteacher_seq order by opencourse_finishdate desc) where rownum =1)
    cross join
    (select sysdate from dual); 
    if vresult = '강의종료' then
    vresult := '강의예정';
    end if;
	update tblteacher set teacher_name = pteacher_name, teacher_ssn=pteacher_ssn, teacher_tel= pteacher_tel,lecture_state= vresult  where teacher_seq = pteacher_seq;
    
    elsif cnt = 0 then
	update tblteacher set teacher_name = pteacher_name, teacher_ssn=pteacher_ssn, teacher_tel= pteacher_tel,lecture_state= '강의예정'  where teacher_seq = pteacher_seq;
    
    end if;
    
	COMMIT;
    
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procUpdateteacher;

-- 과정날짜 비교 함수

create or replace function fnDate(
    nowdate date,
    opendate date,
    finishdate date
)return varchar2 
is
begin
    return case
      when opendate > nowdate then '강의예정'
         when finishdate < nowdate then '강의종료'
            else '강의중'
    end;
end fnDate;

select * from vwtblTeacher;
begin
    procUpdateteacher(341,'백대주','2056442','010-6549-5788');
end;


/*
A002-1-3. 교사 계정 삭제하기
[메인] > [관리자] > [교사 계정 관리] > [전체 교사 조회] > [교사 삭제]
- 교사 목록을 출력한다. 
- 선택한 교사를 교사 테이블에서 삭제할 수 있다.

*/
  
CREATE OR REPLACE PROCEDURE procDeleteteacher
(
       pteacher_seq in number           --교사번호

)
IS

BEGIN
	delete from tblteacher where teacher_seq = pteacher_seq;
	COMMIT;
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procDeleteteacher;

select * from vwtblTeacher;
begin
procDeleteteacher (344);
end;

/*
A002-2, 교사 조회하기
[메인] > [관리자] > [교사 계정 관리] > [전체 교사 조회]
- 기존에 등록되어 있는 교사의 정보를 조회할 수 있다.
- 교사 전체 명단을 출력한다.
- 교사 번호를 출력한다.
- 교사 이름을 출력한다.
- 교사 주민번호 뒷자리를 출력한다.
- 교사 전화번호를 출력한다.
- 교사 강의 진행상태 출력한다.
- 교사 강의 가능한 목록을 출력한다.
*/

select * from vwtblTeacher;

create or replace view vwtblTeacher
as
select 
t.teacher_seq 교사번호,
t.teacher_name 교사이름,
t.teacher_ssn 주민번호뒷자리,
t.teacher_tel 전화번호,
t.lecture_state 강의진행상태,
s.subject_name 강의가능과목
from tblTeacher t
    full outer join tblAvailableSubject a 
        on t.teacher_seq = a.teacher_seq  
            left outer join tblSubject s
                on a.subject_seq =s. subject_seq
                    order by 교사번호;

/*
A002-2-1,교사 조회하기
[메인] > [관리자] > [교사 계정 관리] > [전체 교사 조회]  > [특정 교사 조회]
- 교사번호로 특정 교사를 선택하면 선택한 교사가 담당한 개설 과정을 목록을 출력한다.
- 교사 번호를 출력한다.
- 교사 이름을 출력한다.
- 개설 과정 번호를 출력한다.
- 개설 과정명을 출력한다.
- 개설 과목 시작날짜를 출력한다.
- 개설 과목 종료날짜를 출력한다.
- 개설 과목명을 출력한다.
- 개설 과정 시작날짜를 출력한다.
- 개설 과정 종료날짜를 출력한다.
- 교재명을 출력한다.
- 강의실을 출력한다.
- 강의 진행 여부(강의 예정 / 강의중 / 강의종료)를 출력한다.

*/
 create or replace view vwSearchTeacher
 as
 select 
    t.teacher_seq 교사번호,
    t.teacher_name 교사이름,
    o.opencourse_name 과정명,
    o.opencourse_startdate 과정시작날짜,
    o.opencourse_finishdate 과장종료날짜,
    u.subject_name 과목명,
    s.opensubject_startdate 과목시작날짜,
    s.opensubject_finishdate 과목종료날짜,
    b.book_name 교재명,
    c.classroom_name 강의실명,
    (select fnDate(sysdate,  s.opensubject_startdate,s.opensubject_finishdate) from dual) as 강의상태
    from tblTeacher t
        inner join tblOpenCourse O on t.teacher_seq = O.teacher_seq
            inner join tblOpenSubject S on O.opencourse_seq = s.opencourse_seq
                inner join tblSubject U on s.subject_seq = u.subject_seq
                    inner join tblBook B on u.book_seq = b.book_seq
                        inner join tblClassroom c on o.classroom_name = c.classroom_name;
                            

create or replace procedure procSearchTeacher(

    pteacher_seq in number,                   -- 교사번호
    pcursor out sys_refcursor                   -- cursor 자료형과 동일한 자료형, 반환값타임으로 사용.
)
is 
begin
    
    open pcursor 
    for select * from vwSearchTeacher where 교사번호 = pteacher_seq;

end procSearchTeacher;

declare
    pcursor sys_refcursor;
    vrow vwSearchTeacher%rowtype;
begin
    procSearchTeacher(1,pcursor); --교사번호
    
    -- pcursor + opened..
    loop
        fetch pcursor into vrow;
        exit when pcursor%notfound;
        
        dbms_output.put_line(vrow.교사번호 ||chr(9)|| vrow.교사이름 ||chr(9)|| vrow.과정명 ||chr(9)|| vrow.과정시작날짜 ||chr(9)|| vrow.과목종료날짜 ||chr(9)|| vrow.과목명 ||chr(9)|| vrow.과목시작날짜
                                    ||chr(9)|| vrow.과목종료날짜||chr(9)||vrow.교재명||chr(9)||vrow.강의실명||chr(9)||vrow.강의상태 );
    end loop;
end;

/*
A003. 교육생 정보 관리
[메인] > [관리자] > [교육생 관리]
A003-1. 교육생 계정을 입력, 수정, 삭제할 수 있다. 
A003-2. 교육생 계정을 전체 조회할 수 있다.
A003-3. 교육생 계정을 검색할 수 있다.
A004-4. 수료 완료한 교육생의 계정을 관리할 수 있다.
*/
/*
A003-1-1. 
[메인] > [관리자] > [교육생 관리] > [전체 교육생 조회] > [교육생 정보 등록]
- 교육생 번호를 입력한다.
- 교육생 이름을 입력한다.
- 교육생 전화번호를 입력한다.
- 교육생 주민번호 뒷자리를 입력한다.
- 등록일은 자동으로 입력된다.
- 개설과정번호를 입력한다.
*/
create or replace procedure procStudentReg (
    pstudent_name varchar2,
    pstudent_tel varchar2,
    pstudent_ssn varchar2,
    pstudent_regdate date,
    popencourse_seq number
)
is
begin
    insert into tblStudent (student_seq,student_name,student_tel,student_ssn,student_regdate,opencourse_seq) 
        values (seqStudent.nextVal, pstudent_name, pstudent_tel, pstudent_ssn, sysdate, popencourse_seq);
    --commit;

end procStudentReg;

begin
    procStudentReg('냐냐냐','010-1234-5678', '1234567', sysdate, 5); --교육생이름, 전화번호, 주민등록번호 뒷자리, 개설과정번호 입력
end;

/*
A003-1-2.
[메인] > [관리자] > [교육생 관리] > [전체 교육생 조회] > [교육생 정보 수정]
- 교육생 이름을 수정한다.
- 교육생 주민번호 뒷자리를 수정한다.
- 교육생 전화번호를 수정한다.
*/
create or replace procedure procStudentUpdate (
    psel number, --수정할 컬럼 선택할 번호
    pstudent_seq number, --수정할 교육생 번호
    pcontent varchar2 --수정할 내용
)
is
begin
    if psel = 1 then update tblStudent set student_name = pcontent where student_seq = pstudent_seq;
    elsif psel = 2 then update tblStudent set student_ssn = pcontent where student_seq = pstudent_seq; 
    elsif psel = 3 then update tblStudent set student_tel = pcontent where student_seq = pstudent_seq;
    end if;
end procStudentUpdate;

begin
    procStudentUpdate(1, 160, '냐냐냐');
end;

/*
A003-1-3.
[메인] > [관리자] > [교육생 관리] > [전체 교육생 조회] > [교육생 삭제]
- 교육생 목록을 출력한다. 
- 선택한 교육생을 교육생 테이블에서 삭제할 수 있다.
*/
select * from vwStudentList;

delete from tblStudent where student_seq = 160;

create or replace trigger trgStudentDelete 
    before
    delete
    on tblStudent
    for each row 
declare
begin
    delete from tblCheck where student_seq = :old.student_seq;
    delete from tblRentList where student_seq = :old.student_seq;
    delete from tblScore where student_seq = :old.student_seq;
    
    dbms_output.put_line(:old.student_seq || '번 교육생이 삭제되었습니다.');
end trgStudentDelete;

/*
A003-2-1. 
[메인] > [관리자] > [교육생 관리] > [전체 교육생 조회] 
- 기존에 등록되어 있는 교육생들의 정보를 조회할 수 있다.
- 교육생 전체 명단을 출력한다.
  - 교육생 번호를 출력한다.
  - 교육생 이름을 출력한다.
  - 교육생 전화번호를 출력한다.
  - 교육생 주민번호 뒷자리를 출력한다.
  - 교육생 등록일을 출력한다.
  - 교육생 수강중인 과정을 출력한다.
*/
select * from vwStudentList;

create or replace view vwStudentList
as
select 
    s.student_seq as 교육생번호,
    s.student_name as 이름,
    s.student_tel as 전화번호,
    s.student_ssn as 주민번호뒷자리,
    s.student_regdate as 등록일,
    o.opencourse_name as 수강과정
from tblStudent s
    inner join tblOpenCourse o
        on s.opencourse_seq = o.opencourse_seq;

/*
A003-2-2.
[메인] > [관리자] > [교육생 관리] > [전체 교육생 조회]  > [특정 교육생 조회]
- 교육생 번호로 특정 교육생을 선택하면 선택한 교육생이 신청한 - 수강 중인 / 수강했던 과정 정보 목록을 출력한다.
- 과정 번호를 출력한다.
- 과정명을 출력한다.
- 과정 시작날짜를 출력한다.
- 과정 종료날짜를 출력한다.
- 강의실을 출력한다.
- 수료 및 중도 탈락 여부(수료 / 중도 탈락(중도 탈락 날짜))를 출력한다.
*/
--수료/중도탈락(날짜) 함수 
create or replace function fnCompletionStateDate(
    pcompletion_reg_check varchar2,
    pcompletion_date date
) return varchar2
is
begin
    return case
        when pcompletion_reg_check is null then null
        else pcompletion_reg_check || '(' || to_char(pcompletion_date,'yyyy-mm-dd') || ')'
    end;
end fnCompletionStateDate;
    
create or replace procedure procOneStudent (
    pstudent_seq number
)
is
    vstudent_seq tblStudent.student_seq%type;
    vopencourse_seq tblStudent.opencourse_seq%type;
    vopencourse_name tblOpenCourse.opencourse_name%type;
    vopencourse_startdate tblOpenCourse.opencourse_startdate%type;
    vopencourse_finishdate tblOpenCourse.opencourse_finishdate%type;
    vclassroom_name tblOpenCourse.classroom_name%type;
    vcompletion_reg_check varchar2(30);
    
    cursor vcursor is select 
                        s.opencourse_seq as 과정번호,
                        oc.opencourse_name as 과정명,
                        oc.opencourse_startdate as 과정시작날짜,
                        oc.opencourse_finishdate as 과정종료날짜,
                        oc.classroom_name as 강의실,
                        case
                            when cs.completion_reg_check is null then null
                            else cs.completion_reg_check || '(' || cs.completion_date || ')'
                        end as 수료및중도탈락
                        from tblStudent s
                            inner join tblOpenCourse oc
                                on oc.opencourse_seq = s.opencourse_seq
                                    left outer join tblCompletionState cs
                                        on cs.student_seq = s.student_seq
                            where s.student_seq = pstudent_seq;
begin

    open vcursor;
        loop
            fetch vcursor into vopencourse_seq,vopencourse_name,vopencourse_startdate,vopencourse_finishdate,vclassroom_name,vcompletion_reg_check;
            exit when vcursor%notfound;
            dbms_output.put_line(vopencourse_seq || ' ' 
                                || vopencourse_name || ' ' || vopencourse_startdate || ' ' 
                                || vopencourse_finishdate || ' ' || vclassroom_name || ' ' || vcompletion_reg_check);
        end loop;
        
    close vcursor;

exception
    when others then 
    DBMS_OUTPUT.PUT_LINE(SQLERRM);

end procOneStudent;

begin
    procOneStudent(401);
end;

/*
A003-3-1
[메인] > [관리자] > [교육생 관리] > [교육생 검색 기능]
- 교육생 번호로 특정 교육생의 정보를 검색할 수 있다.
- 과정 번호를 출력한다.
- 과정명을 출력한다.
- 과정 시작날짜를 출력한다.
- 과정 종료날짜를 출력한다.
- 강의실을 출력한다.
- 수료 및 중도 탈락 여부(수료 / 중도 탈락(중도 탈락 날짜))를 출력한다.
*/
create or replace procedure procStudentSearch (
    pstudent_seq number
)
is
    vopencourse_seq tblStudent.opencourse_seq%type;
    vopencourse_name tblOpenCourse.opencourse_name%type;
    vopencourse_startdate tblOpenCourse.opencourse_startdate%type;
    vopencourse_finishdate tblOpenCourse.opencourse_finishdate%type;
    vclassroom_name tblOpenCourse.classroom_name%type;
    vcompletion_state varchar2(30);
begin
    select 
        s.opencourse_seq as 과정번호, oc.opencourse_name as 과정명,
        oc.opencourse_startdate as 과정시작날짜, oc.opencourse_finishdate as 과정종료날짜, oc.classroom_name as 강의실,
        fnCompletionStateDate(cs.completion_reg_check,cs.completion_date) as 수료및중도탈락
    into vopencourse_seq, vopencourse_name,vopencourse_startdate,vopencourse_finishdate,vclassroom_name,vcompletion_state
    from tblStudent s
        inner join tblOpenCourse oc
            on oc.opencourse_seq = s.opencourse_seq
                left outer join tblCompletionState cs
                    on cs.student_seq = s.student_seq
        where s.student_seq = pstudent_seq; 
        
        dbms_output.put_line(vopencourse_seq || ' ' || vopencourse_name || ' ' || 
                                vopencourse_startdate || ' ' || vopencourse_finishdate || ' ' || vclassroom_name || ' ' || vcompletion_state);
        
end procStudentSearch;
    
begin
    procStudentSearch(401);
end;


/*
A003-4
[메인] > [관리자] > [교육생 관리] > [수료 및 중도탈락 여부] 
- 수료 완료한 교육생은 취업상태를 확인할 수 있다.
- 수료 완료한 교육생의 고용보험가입 유무를 확인 할 수 있다.
A003-4-1. 교육생의 사후처리를 등록, 수정 삭제할 수 있다.
A003-4-2. 교육생의 사후처리를 조회할 수 있다.
*/
/*
A003-4-1-1.
[메인] > [관리자] > [교육생 관리] > [수료 및 중도탈락 여부] > [수료 및 중도탈락 여부 등록]
- 수료번호를 등록할 수 있다. 
- 교육생번호를 등록할 수 있다.
- 수료 및 중도탈락 여부를 등록할 수 있다.
- 수료날짜를 등록할 수 있다.
- 교육생의 취업유무를 등록할 수 있다.
- 교육생의 고용보험가입유무를 등록할 수 있다.
*/
create or replace procedure procCompletionStateReg (
    pstudent_seq number,
    pcompletion_reg_check varchar2,
    pcompletion_date date,
    pafterservice_job varchar2,
    pafterservice_insurance varchar2
)
is
    vmax date;
begin
    -- 대여목록중 가장 뒤에있는 대여종료날짜 구하기
    select max(product_finishdate) into vmax from tblrentobject where rent_seq in (select rent_seq from tblrentlist where student_seq=1); 
    -- 입력받은 수료/중도탈락 날짜와 비교하여 대여종료날짜가 더 많이 남았으면 수료일은 대여종료날짜로
    case 
        when vmax < pcompletion_date then vmax := pcompletion_date;
        else vmax := vmax;
    end case;
    
    insert into tblCompletionState (completion_seq, student_seq, completion_reg_check, completion_date, afterservice_job, afterservice_insurance) 
        values (seqCompletionState.nextVal, pstudent_seq, pcompletion_reg_check, vmax, pafterservice_job, pafterservice_insurance);

end procCompletionStateReg;

begin
    procCompletionStateReg(1, '중도탈락', '2021-06-30', '취업', '미등록');
end;

/*
A003-4-1-2.
[메인] > [관리자] > [교육생 관리] > [수료 및 중도탈락 여부] > [수료 및 중도탈락 여부 수정]
- 수료 및 중도탈락 여부를 수정할 수 있다
- 교육생의 취업유무를 수정할 수 있다.
- 교육생의 고용보험가입유무를 수정할 수 있다.
*/
create or replace procedure procCompletionStateUpdate (
    psel number,
    pstudent_seq number,
    pcontent varchar
)
is
begin
    if psel = 1 then update tblCompletionState set completion_reg_check = pcontent where student_seq = pstudent_seq; 
    elsif psel = 2 then update tblCompletionState set afterservice_job = pcontent where student_seq = pstudent_seq; 
    elsif psel = 3 then update tblCompletionState set afterservice_insurance = pcontent where student_seq = pstudent_seq;
    end if;
end procCompletionStateUpdate;

begin
    procCompletionStateUpdate(2, 410, '미취업');
end;


/*
A003-4-1-3.
[메인] > [관리자] > [교육생 관리] > [수료 및 중도탈락 여부] > [수료 및 중도탈락 여부 삭제]
- 교육생의 사후처리 목록을 출력한다. 
- 선택한 교육생의 정보를 사후처리 테이블에서 삭제할 수 있다.
- 수료 및 중도탈락 여부를 삭제할 수 있다.
*/
select * from vwCompletionState;

delete from tblCompletionState where student_seq = 410; --수료 및 중도탈락 정보 삭제할 교육생 번호 선택

--사후처리 데이터 삭제 트리거
create or replace trigger trgCompleteStateDelete
    after
    delete
    on tblCompletionState 
begin
    dbms_output.put_line('입력된 교육생의 사후처리 데이터를 삭제했습니다.');
end;

--사후처리 데이터 삭제 프로시저
create or replace procedure procCompleteState (
    pstudent_seq number
)
is
begin
    delete from tblCompletionState where student_seq = pstudent_seq;
end procCompleteState;

begin
    procCompleteState(410);
end;


/*
A003-4-2.
[메인] > [관리자] > [교육생 관리] > [수료 및 중도탈락 여부] > [수료 및 중도탈락 여부 조회]
- 수료 완료한 교육생의 취업유무를 조회할 수 있다.
- 수료 완료한 교육생의 고용보험가입유무를 조회할 수 있다.
*/
select * from vwCompletionState where 수료및중도탈락 = '수료';

-- 수료 및 중도탈락 테이블 조회 뷰
create or replace view vwCompletionState
as
select 
    cs.completion_seq as 수료번호,
    s.student_seq as 교육생번호,
    s.student_name as 교육생이름,
    cs.completion_reg_check as 수료및중도탈락,
    cs.completion_date as 수료날짜,
    cs.afterservice_job as 취업유무,
    cs.afterservice_insurance as 고용보험가입유무
from tblCompletionState cs
    inner join tblStudent s
        on cs.student_seq = s.student_seq
            order by cs.completion_seq;
            select * from tblCompletionState order by student_seq;
   


/*
[메인] > [관리자] > [개설 과정 관리]
A004-1. 개설 과정을 입력, 수정, 삭제할 수 있다. 
A004-2. 개설 과정을 전체 조회할 수 있다.
*/

/*
A004-1-1. 
[메인] > [관리자] > [개설 과정 관리] > [전체 개설 과정 조회] > [과정 등록]
- 과정 번호를 입력한다.
- 과정 시작날짜를 입력한다.
- 과정 종료날짜를 입력한다.
- 교사번호를 입력한다.
- 강의실 정보를 입력한다.

*/
CREATE OR REPLACE PROCEDURE procAddtblOpenCourse
(
    popencourse_seq in number,                -- 정적 과정 번호
    popencourse_startdate in date,              -- 과정 시작날짜
    pteacher_seq in number,                        -- 과정 담당 교사
    pclassroom_name in varchar2                  -- 과정 강의실이름
    
)
IS
 vname varchar2(100);
 vterm number;

BEGIN

        -- 업무1. 과정목록 출력하기
        select course_name into vname from tblCourse where course_seq=popencourse_seq; 
        -- 업무2. 과정기간 출력하기
        select course_term into vterm from tblCourse where course_seq=popencourse_seq;
        -- 업무2. 과정 목록 추가하기
	INSERT INTO tblOpenCourse VALUES(seqOpenCourse.nextVal,vname,popencourse_startdate,fnAddDate( popencourse_startdate, vterm),pteacher_seq,popencourse_seq,pclassroom_name);
	COMMIT;
    
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procAddtblOpenCourse;

select * from vwtblOpenCourse;
begin
 procAddtblOpenCourse(10,'2025-02-01',1,'1강의실');
end;


-- 날짜 더하는 함수
create or replace function fnAddDate(
    whatDate date,
    addDate number

)return date
is 
begin
    return add_months(whatDate,addDate);
end fnAddDate;

/*
A004-1-2.
[메인] > [관리자] > [개설 과정 관리] > [전체 개설 과정 조회] > [과정 수정]
- 개설 과정 정보를 수정할 수 있다.
- 과정명을 수정한다.
- 과정 시작날짜를 수정한다.
- 과정 종료날짜를 수정한다.
- 강의실 정보를 수정한다.

*/

CREATE OR REPLACE PROCEDURE procUpdatetblOpenCourse
(
    popencourse_seq in number,               -- 개설 과정 번호
    popencourse_name in varchar2,            -- 과정 이름
    popencourse_startdate in date,             -- 과정 시작날짜
    popencourse_finishdate date,                -- 과정 종료 날짜
    pteacher_seq in number,                     -- 과정 담당 교사
    pcourse_seq in number,                      -- 정적과목번호
   pclassroom_name in varchar2                  -- 과정 강의실이름
    
)
IS
BEGIN

	update tblOpenCourse set 
    opencourse_name = popencourse_name, 
    opencourse_startdate=  popencourse_startdate,
    opencourse_finishdate= popencourse_finishdate,
    teacher_seq=pteacher_seq,
    course_seq = pcourse_seq,
    classroom_name=pclassroom_name
    where opencourse_seq = popencourse_seq;
	COMMIT;
    
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procUpdatetblOpenCourse;

select * from vwtblOpenCourse;
begin
procUpdatetblOpenCourse(42,'java테스트과정','2025-02-01','2027-01-02',6,1,'5강의실');
end;


/*
A004-1-3.
[메인] > [관리자] > [개설 과정 관리] > [전체 개설 과정 조회] > [과정 삭제]
- 개설된 과정 목록을 출력한다. 
- 선택한 과정을 개설 과정 테이블에서 삭제할 수 있다.

*/

CREATE OR REPLACE PROCEDURE procDeletetblOpenCourse
(
    popencourse_seq in number               -- 개설 과정 번호
)
IS
BEGIN

    delete from tblOpenCourse where opencourse_seq = popencourse_seq;
	COMMIT;
    
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procDeletetblOpenCourse;

select * from vwtblOpenCourse;
begin
procDeletetblOpenCourse(44);
end;



create or replace trigger trgDeleteCourse
    before
    delete on tblOpenCourse
    for each row
begin
    -- 개설과목의 개설과정 삭제
    delete from tblOpenSubject where opencourse_seq = :old.opencourse_seq;  -- 개설과목의 개설과정 삭제
    dbms_output.put_line('해당과정의 과목이 삭제되었습니다.');

end;


/*
A004-2-1. 
[메인] > [관리자] > [개설 과정 관리] > [전체 개설 과정 조회]
- 기존에 개설되어 있는 전체 과정 목록을 조회할 수 있다.
- 개설 과정 번호를 출력한다.
- 개설 과정명을 출력한다.
- 개설 과정 시작날짜를 출력한다.
- 개설 과정 종료날짜를 출력한다.
- 강의실명을 출력한다.
- 개설 과목 등록 여부(등록, 미등록)를 출력한다.
- 교육생 등록 인원을 출력한다.

*/

select * from vwtblOpenCourse;
create or replace view vwtblOpenCourse
as
select distinct
    o.opencourse_seq 개설과정번호,
    o.opencourse_name 개설과정명,
    o.opencourse_startdate 개설과정시작날짜,
    o.opencourse_finishdate 개설과정종료날짜,
    o.classroom_name 개설강의실명,
    u.subject_name 개설과목명,
    fnOpenSubjectReg((select count(opensubject_seq) from tblopensubject)) as 등록여부,
            (select count(*) from tblStudent group by opencourse_seq having opencourse_seq =o.opencourse_seq) as 등록인원수
        from tblOpenCourse o
            inner join tblOpenSubject s
                on o.opencourse_seq = s.opencourse_seq
                    inner join tblSubject u
                        on u.subject_seq= s.subject_seq
                            inner join tblStudent t
                                on o.opencourse_seq=t.opencourse_seq
                                        order by o.opencourse_seq ;


/*
A004-2-2.
[메인] > [관리자] > [개설 과정 관리] > [전체 개설 과정 조회] > [특정 과정 조회]
- 과정 번호로 특정 과정을 선택하면 해당 과정의 개설 과목 정보와 등록된 교육생 정보를 출력한다.
- 과목번호를 출력한다.
- 과목명을 출력한다.
- 과목 시작날짜를 출력한다.
- 과목 종료날짜를 출력한다.
- 교재명을 출력한다.
- 교사를 출력한다.
- 교육생 번호를 출력한다.
- 교육생 이름을 출력한다.
- 교육생의 주민번호 뒷자리를 출력한다.
- 교육생의 전화번호를 출력한다.
- 교육생의 등록일을 출력한다.
- 수료 및 중도 탈락 여부(수료(수료날짜 지정)/중도 탈락자(제외 처리))를 출력한다.

*/
select * from vwSearchCourse where 과정번호 = 44;

create or replace view vwSearchCourse
as
select distinct
    o.opencourse_seq 과정번호,
    t.subject_seq 과목번호,
    t.subject_name 과목이름,
    b.opensubject_startdate 과목시작날짜,
    b.opensubject_finishdate 과목종료날짜,
    k.book_name 교재이름,
    h.teacher_name 강사명,
    s.student_seq 교육생번호,
    s.student_name 교육생이름,
    s.student_ssn 주민번호뒷자리,
    s.student_tel 전화번호,
    s.student_regdate 등록일,
        (case when c.completion_reg_check is null then '과정중' else c.completion_reg_check end) as 수료및중도탈락
        from tblStudent s 
             full outer  join  tblCompletionState c 
                on c.student_seq = s.student_seq
                    full outer join tblOpenCourse o
                        on s.opencourse_seq = o.opencourse_seq
                             full outer join tblTeacher h
                                on o.teacher_seq = h.teacher_seq
                                    full outer join tblOpenSubject b
                                        on o.opencourse_seq = b.opencourse_seq
                                         full outer join tblSubject t
                                            on b.subject_seq = t.subject_seq
                                                 full outer join tblBook k
                                                      on t.book_seq = k.book_seq
                                                        order by 교육생번호;
                                                        
                                                                                                          

/*
A005,개설 과목 관리하기
[메인] > [관리자] > [개설 과목 관리]
A005-1. 개설 과목을 등록, 수정, 삭제 할 수 있다. 
A005-2. 교사 계정을 전체 조회할 수 있다.
*/

/*
A005-1-1.
[메인] > [관리자] > [개설 과목 관리] > [전체 개설 과목 조회].
- 개설 과목 번호를 출력한다.
- 과목 명을 출력한다.
- 교재를 출력한다. 
- 과목 시작 날짜를 출력한다.
- 과목 종료 날짜를 출력한다
*/

create or replace view vwSearchsubject
as
select
    o.opensubject_seq 개설과목번호,
    s.subject_name 과목명,
    k.book_name 교재명,
    o.opensubject_startdate 과목시작날짜,
    o.opensubject_finishdate 과목종료날짜
    from tblOpenSubject o
        inner join tblSubject s
            on o.subject_seq = s.subject_seq
                inner join tblbook k
                    on s.book_seq = k.book_seq
                        order by o.opensubject_seq;

select * from vwSearchsubject;

/*
A005-1-2.
[메인] > [관리자] > [개설 과목 관리] > [전체 개설 과목 조회] > [개설 과목 등록]
- 과목 번호를 입력한다.
- 과목 명을 입력한다.
- 과목 시작 날짜를 입력한다.
- 과목 종료 날짜를 입력한다.
- 교재를 입력한다.
*/

CREATE OR REPLACE PROCEDURE procAddtblOpenSubject
(
    psubject_seq  in number,                -- 과목 번호
    popencourse_seq in number,              -- 과정 번호
    popensubject_startdate date,                  -- 과목 시작 날짜
    popensubject_finishdate date                  -- 과목 종료 날짜
    )
IS
BEGIN

	INSERT INTO tblOpenSubject VALUES(seqOpenSubject.nextVal, psubject_seq, popencourse_seq,popensubject_startdate,popensubject_finishdate);
	COMMIT;
    
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procAddtblOpenSubject;


begin
procAddtblOpenSubject(3,44,'2025-02-25','2025-06-25');
END;
select * from vwSearchsubject;

/*
A005-1-3.
[메인] > [관리자] > [개설 과목 관리] > [전체 개설 과목 조회] > [개설 과목 수정]
- 개설 과목 번호를 선택하여 개설 과목 정보를 수정한다.
- 과목 시작 날짜를 수정한다.
- 과목 종료 날짜를 수정한다.

*/
CREATE OR REPLACE PROCEDURE procUpdatetblOpenSubject
(
    popensubject_seq in number,             --개설과목번호
    popensubject_startdate date,                  -- 과목 시작 날짜
    popensubject_finishdate date                  -- 과목 종료 날짜
    )
IS
BEGIN

		update tblOpenSubject set 
        opensubject_startdate = popensubject_startdate, 
        opensubject_finishdate=  popensubject_finishdate
    
        where opensubject_seq = popensubject_seq;

	COMMIT;
    
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procUpdatetblOpenSubject;


begin
procUpdatetblOpenSubject(41,'2021-05-26','2022-06-25');
END;
select * from vwSearchsubject;

/*
A005-1-4.
[메인] > [관리자] > [개설 과목 관리] > [전체 개설 과목 조회] > [개설 과목 삭제]
- 삭제할 개설 과목 번호를 선택한다.
- 선택한 개설 과목을 개설 과목 테이블에서 삭제할 수 있다.

*/
CREATE OR REPLACE PROCEDURE procDeletetblOpenSubject
(
    popensubject_seq in number             --개설과목번호
    )
IS
BEGIN

		delete from tblOpenSubject
        where opensubject_seq = popensubject_seq;

	COMMIT;
    
EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
END procDeletetblOpenSubject;

select * from vwSearchsubject;
begin
procDeletetblOpenSubject(41);
END;



/*
A006. 시험 관리 및 성적 조회 
시험 관리 및 성적 조회에 관한 모든 기능을 포함한다.
[메인] > [관리자] > [시험 및 성적 관리]
A006-1. 전체 개설 과정 목록을 조회한다.
A006-2. 성적 정보를 조회한다.
*/
/*
A006-1-1 *
[메인] > [관리자] > [시험 및 성적 관리] > [전체 과정 조회]
- 전체 개설 과정 목록을 조회할 수 있다. 
- 개설 과정 번호를 출력한다.
- 과정명을 출력한다. 
- 과정 시작 날짜를 출력한다.
- 과정 종료 날짜를 출력한다.
- 강의실명을 출력한다.
- 등록 인원을 출력한다. 
- 개설 과목 등록 여부를 출력한다.
- 개설 상태를 출력한다.
*/
select * from vwOpenCourseList;

create or replace view vwOpenCourseList
as
select
    distinct oc.opencourse_seq as 개설과정번호,
    oc.opencourse_name as 과정명,
    oc.opencourse_startdate as 과정시작날짜,
    oc.opencourse_finishdate as 과정종료날짜,
    cr.classroom_name as 강의실명,
    cr.classroom_population as 등록인원,
    /*
    case
        when (select count(opensubject_seq) from tblopensubject ) >= 3 then '등록'
    end as 개설과목등록여부,
     case
        when oc.opencourse_startdate > sysdate then '강의예정'
        when oc.opencourse_finishdate < sysdate then '강의종료'
        else '강의중'
     end as 개설상태
     */
     fnOpenSubjectReg((select count(opensubject_seq) from tblopensubject)) as 개설과목등록여부,
     fnDate(sysdate,oc.opencourse_startdate, oc.opencourse_finishdate) as 개설상태
from tblOpenCourse oc
    inner join tblClassroom cr
        on cr.classroom_name = oc.classroom_name
order by oc.opencourse_seq;

/*
A006-1-1-1
[메인] > [관리자] > [시험 및 성적 관리] > [전체 과정 조회] 
> [특정 개설 과정 선택]
- 개설 과정 번호로 특정 개설 과정을 선택하면 개설 과목 정보를 출력한다.
- 과목번호를 출력한다.
- 과목명을 출력한다.
- 과목 시작 날짜를 출력한다.
- 과목 종료 날짜를 출력한다.
- 교재명을 출력한다.
- 교사명을 출력한다.
*/        
create or replace procedure procOneOpenCourse (
    popencourse_seq number
)
is
    cursor vcursor is select os.subject_seq as 과목번호, s.subject_name as 과목명, os.opensubject_startdate as 과목시작날짜,
                            os.opensubject_finishdate as 과목종료날짜, b.book_name as 교재명, t.teacher_name as 교사명
                      from tblOpenCourse oc 
                        inner join tblOpenSubject os 
                            on oc.opencourse_seq = os.opencourse_seq
                                inner join tblSubject s
                                    on s.subject_seq = os.subject_seq
                                        inner join tblBook b
                                            on b.book_seq = s.book_seq
                                                inner join tblTeacher t
                                                    on t.teacher_seq = oc.teacher_seq
                        where oc.opencourse_seq = popencourse_seq;
    vsubject_seq tblOpenSubject.subject_seq%type;
    vsubject_name tblSubject.subject_name%type;
    vopensubject_startdate tblOpenSubject.opensubject_startdate%type;
    vopensubject_finishdate tblOpenSubject.opensubject_finishdate%type;
    vbook_name tblBook.book_name%type;
    vteacher_name tblTeacher.teacher_name%type;
begin
    open vcursor;
    
        loop
            fetch vcursor into vsubject_seq, vsubject_name, vopensubject_startdate, vopensubject_finishdate, vbook_name, vteacher_name;
            exit when vcursor%notfound;
            
            dbms_output.put_line(vsubject_seq || ' ' || vsubject_name || ' ' || vopensubject_startdate || ' ' || vopensubject_finishdate || ' ' ||
                                vbook_name || ' ' || vteacher_name);
        end loop;
    close vcursor;

end procOneOpenCourse;

begin
    procOneOpenCourse(1);
end;

/*
A006-2-1
[메인] > [관리자] > [시험 및 성적 관리] > [성적 정보 조회] 
> [개설 과목별 조회]
- 성적을 개설 과목별로 조회할 수 있다.
- 개설 과정명을 출력한다.
- 개설 과정 시작 날짜를 출력한다.
- 개설 과정 종료 날짜를 출력한다.
- 강의실명을 출력한다.
- 개설 과목명을 출력한다.
- 교사명을 출력한다.
- 교재명을 출력한다.
- 수강한 모든 교육생들의 정보(교육생 이름, 주민번호 뒷자리, 필기 성적, 실기 성적)를 출력한다. 
*/
create or replace procedure procScoreSubject (
    popensubject_seq number
)
is
    cursor vcursor is select 
                            oc.opencourse_name as 개설과정명,
                            oc.opencourse_startdate as 개설과정시작날짜,
                            oc.opencourse_finishdate as 개설과정종료날짜,
                            cr.classroom_name as 강의실명,
                            s.subject_name as 개설과목명,
                            t.teacher_name as 교사명,
                            b.book_name as 교재명,
                            stud.student_name as 교육생이름,
                            stud.student_ssn as 주민번호뒷자리,
                            sc.note_score as 필기성적,
                            sc.skill_score as 실기성적
                    from tblOpenSubject os
                        inner join tblOpenCourse oc on os.opencourse_seq = oc.opencourse_seq
                                inner join tblClassroom cr on cr.classroom_name = oc.classroom_name
                                        inner join tblSubject s on s.subject_seq = os.subject_seq
                                                inner join tblTeacher t on t.teacher_seq = oc.teacher_seq
                                                        inner join tblBook b on b.book_seq = s.book_seq
                                                                inner join tblPoint p on p.opensubject_seq = os.opensubject_seq
                                                                        inner join tblScore sc on p.point_seq = sc.point_seq
                                                                                inner join tblStudent stud on stud.student_seq = sc.student_seq
                                                                                        
                        where os.opensubject_seq = popensubject_seq; --개설과목 선택
    vopencourse_name tblOpenCourse.opencourse_name%type;
    vopencourse_startdate tblOpenCourse.opencourse_startdate%type;
    vopencourse_finishdate tblOpenCourse.opencourse_finishdate%type;
    vclassroom_name tblClassroom.classroom_name%type;
    vsubject_name tblSubject.subject_name%type;
    vteacher_name tblTeacher.teacher_name%type;
    vbook_name tblBook.book_name%type;
    vstudent_name tblStudent.student_name%type;
    vstudent_ssn tblStudent.student_ssn%type;
    vnote_score tblScore.note_score%type;
    vskill_score tblScore.skill_score%type;
begin
    open vcursor;
    
        loop
        
            fetch vcursor into vopencourse_name,vopencourse_startdate,vopencourse_finishdate,vclassroom_name,vsubject_name,vteacher_name,
                                vbook_name,vstudent_name,vstudent_ssn,vnote_score,vskill_score;
            exit when vcursor%notfound;
            
            dbms_output.put_line(vopencourse_name || ' ' || vopencourse_startdate || ' ' || vopencourse_finishdate || ' ' || vclassroom_name || ' ' ||
                                    vsubject_name || ' ' || vteacher_name || ' ' || vbook_name || ' ' || vstudent_name || ' ' || vnote_score || ' ' || vskill_score);
        
        end loop;
    
    close vcursor;

end procScoreSubject;

begin
    procScoreSubject(1);
end;

/*
A006-2-2
[메인] > [관리자] > [시험 및 성적 관리] > [성적 정보 조회] 
> [교육생 개인별 조회]
- 성적을 교육생 개인별로 조회할 수 있다.
- 교육생 이름을 출력한다.
- 주민번호 뒷자리를 출력한다.
- 개설 과정 시작 날짜를 출력한다.
- 개설 과정 종료 날짜를 출력한다.
- 강의실명을 출력한다.
- 교육생 개인이 수강한 모든 개설 과목에 대한 성적 정보(개설 과목명, 개설 과목 기간, 교사 명, 필기 성적, 실기 성적)를 출력한다.
*/
create or replace procedure procScoreStudent (
    pstudent_seq number
)
is
    cursor vcursor is select 

                        stud.student_name as 교육생이름,
                        stud.student_ssn as 주민번호뒷자리,
                        oc.opencourse_startdate as 개설과정시작날짜,
                        oc.opencourse_finishdate as 개설과정종료날짜,
                        cr.classroom_name as 강의실명,
                        s.subject_name as 개설과목명,
                        os.opensubject_startdate as 개설과목시작날짜,
                        os.opensubject_finishdate as 개설과목종료날짜,
                        t.teacher_name as 교사명,
                        sc.note_score as 필기성적,
                        sc.skill_score as 실기성적
                    from tblOpenSubject os
                        inner join tblOpenCourse oc on os.opencourse_seq = oc.opencourse_seq
                                inner join tblClassroom cr on cr.classroom_name = oc.classroom_name
                                        inner join tblSubject s on s.subject_seq = os.subject_seq
                                                inner join tblTeacher t on t.teacher_seq = oc.teacher_seq
                                                        inner join tblBook b on b.book_seq = s.book_seq
                                                                inner join tblPoint p on p.opensubject_seq = os.opensubject_seq
                                                                        inner join tblScore sc on p.point_seq = sc.point_seq
                                                                                inner join tblStudent stud on stud.student_seq = sc.student_seq
                                                                                        
                        where stud.student_seq = pstudent_seq;
    vstudent_name tblStudent.student_name%type;
    vstudent_ssn tblStudent.student_ssn%type;
    vopencourse_startdate tblOpenCourse.opencourse_startdate%type;
    vopencourse_finishdate tblOpenCourse.opencourse_finishdate%type;
    vclassroom_name tblClassroom.classroom_name%type;
    vsubject_name tblSubject.subject_name%type;
    vopensubject_startdate tblopensubject.opensubject_startdate%type;
    vopensubject_finishdate tblopensubject.opensubject_finishdate%type;
    vteacher_name tblTeacher.teacher_name%type;
    vnote_score tblScore.note_score%type;
    vskill_score tblScore.skill_score%type;
begin
    open vcursor;
    
        loop
        
            fetch vcursor into vstudent_name,vstudent_ssn,vopencourse_startdate,vopencourse_finishdate,vclassroom_name,
                                vsubject_name,vopensubject_startdate,vopensubject_finishdate,vteacher_name,vnote_score,vskill_score;
            exit when vcursor%notfound;
            
            dbms_output.put_line(vstudent_name || ' ' || vstudent_ssn || ' ' || vopencourse_startdate || ' ' || vopencourse_finishdate || ' ' || vclassroom_name 
                                    || ' ' || vsubject_name || ' ' || vopensubject_startdate || ' ' || vopensubject_finishdate || ' ' || vteacher_name 
                                    || ' ' || vnote_score || ' ' || vskill_score);
        
        end loop;
    
    close vcursor;

end procScoreStudent;

begin
    procScoreStudent(1);
end;


/*
A007. 출결 관리 및 출결 조회
[메인] > [관리자] > [출결 관리 및 출결 조회]
A007-1. 전체 개설 과정 목록을 조회할 수 있다.
A007-2. 특정 개설 과정 선택 시, 출결 현황을 조회할 수 있다.
*/
/*
A007-1-1 *
[메인]  > [관리자]  >  [근태 관리 및 출결 조회] > [전체 개설 과정 목록 조회]
- 개설 과정 번호를 출력한다.
- 과정명을 출력한다.
- 과정 시작 날짜를 출력한다.
- 과정 종료 날짜를 출력한다.
   - 강의실명을 출력한다.
   - 교육생등록인원을 출력한다.
   - 개설과목등록여부를 출력한다.
*/
select * from vwOpenCourseList;

create or replace view vwOpenCourseList
as
select
    oc.opencourse_seq as 개설과정번호,
    oc.opencourse_name as 과정명,
    oc.opencourse_startdate as 과정시작날짜,
    oc.opencourse_finishdate as 과정종료날짜,
    cr.classroom_name as 강의실명,
    (select count(opencourse_seq) from tblStudent s where s.opencourse_seq = oc.opencourse_seq group by opencourse_seq) as 등록인원,
    fnOpenSubjectReg((select count(opensubject_seq) from tblopensubject)) as 개설과목등록여부
    /*
    case
        when (select count(opensubject_seq) from tblopensubject ) > 3 then '등록'
        else '미등록'
    end as 개설과목등록여부*/
from tblOpenCourse oc
    inner join tblClassroom cr
        on cr.classroom_name = oc.classroom_name
order by oc.opencourse_seq;

--개설과목 등록/미등록 계산 함수
create or replace function fnOpenSubjectReg(
    popensubject_seq_cnt number
) return varchar2
is
begin
    return case
        when popensubject_seq_cnt = 0 then '미등록'
        else '등록'
    end;
end fnOpenSubjectReg;


/*
A007-2-1
[메인]  > [관리자]  >  [근태 관리 및 출결 조회] > [전체 개설 과정 목록 조회] > [특정 개설 과정 선택] > [출결 현황]
- 개설 과정 번호로 특정 개설 과정을 선택하여 모든 교육생의 출결 현황을 조회한다.
- 개설 과정 번호를 출력한다.
- 과정 명을 출력한다.
- 교육생 번호를 출력한다.
- 교육생 이름을 출력한다.
- 근태 상황(정상, 지각, 조퇴, 외출, 병가, 기타)을 출력한다.
*/
select * from vwAdminCheckOpenCourse where 개설과정번호 = 1;

create or replace view vwAdminCheckOpenCourse
as
select 
    oc.opencourse_seq as 개설과정번호,
    oc.opencourse_name as 과정명,
    stud.student_seq as 교육생번호,
    stud.student_name as 교육생이름,
    c.check_date as 출결날짜,
    c.enter_time as 입실시각,
    c.leave_time as 퇴실시각,
    c.check_state as 근태상황
from tblOpenCourse oc
    inner join tblStudent stud
        on stud.opencourse_seq = oc.opencourse_seq
            inner join tblCheck c
                on c.student_seq = stud.student_seq
        order by oc.opencourse_seq, c.check_date, c.enter_time;

/*
A007-2-1-1
[메인]  > [관리자]  >  [근태 관리 및 출결 조회] > [전체 개설 과정 목록 조회] > [특정 개설 과정 선택] > [출결 현황] > [기간별 조회]
- 날짜를 입력하여 기간별(년,월,일)로 조회할 수 있다.
   - 시작 날짜를 입력한다.
   - 끝 날짜를 입력한다.
(검색된 정보)
   - 날짜(년,월,일)를 출력한다. 
- 개설 과정 번호를 출력한다.
- 과정명을 출력한다.
- 교육생 번호를 출력한다.
- 교육생 이름을 출력한다.
- 근태 상황(정상, 지각, 조퇴, 외출, 병가, 기타)을 출력한다.
*/
select * from vwAdminCheck where 날짜 between '2020-05-30' and '2021-06-16' and 개설과정번호 = 1;


/*
A007-2-1-2
[메인]  > [관리자]  >  [근태 관리 및 출결 조회] > [전체 개설 과정 목록 조회] > [특정 개설 과정 선택] > [출결 현황] > [개인별 조회]
- 교육생 번호를 입력하여 특정 교육생의 출결 현황을 조회할 수 있다.
   - 교육생 번호를 입력한다.
(검색된 정보)
   - 날짜(년,월,일)를 출력한다. 
- 개설 과정 번호를 출력한다.
- 과정명을 출력한다.
- 교육생 번호를 출력한다.
- 교육생 이름을 출력한다.
- 근태 상황(정상, 지각, 조퇴, 외출, 병가, 기타)을 출력한다.
*/
select * from vwAdminCheck where 교육생번호 = 1 and 개설과정번호 = 1;

create or replace view vwAdminCheck
as
select 
    c.check_date as 날짜,
    s.opencourse_seq as 개설과정번호,
    oc.opencourse_name as 과정명,
    s.student_seq as 교육생번호,
    s.student_name as 교육생이름,
    c.check_state as 근태상황
from tblCheck c
    inner join tblStudent s
        on s.student_seq = c.student_seq
            inner join tblOpenCourse oc
                on oc.opencourse_seq = s.opencourse_seq
        order by c.check_date, s.student_seq;



create index idx_tblstudent_seq_oc on tblStudent(student_seq,opencourse_seq);



--A008-1
--[메인] > [관리자] > [비품 대여] > [비품 등록]
-- 비품 번호를 등록할 수 있다.
-- 비품 이름을 등록할 수 있다.
-- 비품 종류를 등록할 수 있다.
-- 비품 전체 수량을 등록할 수 있다.
-- 비품 대여 개수를 등록할 수 있다.
-- 비품 보증금을 등록할 수 있다.

create sequence seqproductnamenum;
create or replace procedure procProductReg(
    pname varchar2,
    pkindseq number,
    ptotal number,
    pproduct_left_amount number,
    pdeposit number
)
is
    vname number;
begin
    
    select count(*) into vname
    from tblProduct
    where product_name = pname;
    
    
    if vname != 0 then
        insert into tblProduct 
            values(seqProduct.nextVal,pname + seqproductnamenum.nextVal ,pkindseq,ptotal ,pproduct_left_amount,pdeposit);
    else
        insert into tblProduct 
            values(seqProduct.nextVal,pname,pkindseq,ptotal ,pproduct_left_amount,pdeposit);
    end if;
end procProductReg;

drop trigger trgProductReg;
begin
    procProductReg('테스트용품',10,10,10,4000);
end;
select * from tblProduct;

--A008-2
--[메인] > [관리자] > [비품 대여] > [비품 수정]
-- 비품 목록을 출력한다.
-- 비품 이름을 수정할 수 있다.
-- 비품 종류를 수정할 수 있다.
-- 비품 전체 수량을 수정할 수 있다.
-- 비품 대여 개수를 수정할 수 있다.
-- 비품 보증금을 수정할 수 있다.

create or replace procedure procProductUpdate(
    pproduct_seq number,
    pname varchar2,
    pkindseq number,
    ptotal number,
    pproduct_left_amount number,
    pdeposit number
)
is
begin
    update tblProduct
    set PRODUCT_NAME = pname,PRODUCT_KINDSEQ = pkindseq, PRODUCT_TOTAL = ptotal, 
        PRODUCT_LEFT_AMOUNT = pproduct_left_amount,PRODUCT_DEPOSIT = pdeposit
    where PRODUCT_SEQ = pproduct_seq;
end procProductUpdate;

desc tblProduct;

begin
    procProductUpdate(42,'테스트용품',9,11,11,1111);
end;


--A008-3
-- [메인] > [관리자] > [비품 대여] > [비품 삭제]
-- 비품 목록을 출력한다.
-- 선택한 비품을 비품테이블에서 삭제 할 수 있다.

create or replace procedure procProductDelete(
    pproduct_seq number
)
is
begin
    delete from tblProduct where product_seq = pproduct_seq;
end procProductDelete;

begin
    procProductDelete(1);
end;

--A008-4
--[메인] > [관리자] > [비품 대여] > [비품 대여자 명단]
-- 비품 대여자 명단을 출력한다.
create view vwRentlist
as 
select rent_num as 대여자번호, student_seq as 학생번호, teacher_seq as 교사번호, rent_seq as 대여번호
from tblRentList
order by rent_num;

select * 
from vwRentlist













