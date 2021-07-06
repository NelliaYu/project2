--교사
--B001. 강의 스케줄을 관리
--B002. 배점 입력 및 출력
--B003. 성적 입력 및 출력
--B004. 출결 관리 및 출결 조회
--B005. 비품 대여 정보 관리


--B000.교사로그인(교사 10명)
--주민번호 뒷자리로 로그인을 할 수 있다.
--로그인 후 기능들을 사용할 수 있다.
--로그인 프로시저
create or replace procedure procTlogin(
    pssn in varchar2,  --입력할 주민번호
    presult out number --입력한 ssn와 같으면 '1'이 들어가고, 없으면 '0'이 들어갈것
)  -- 매개변수 리스트
is  
begin
    
         select count(*) into presult from tblteacher where teacher_ssn = pssn;
         
exception
        when others then
        dbms_output.put_line('로그인 실패');
end procTlogin;

--확인 procTlogin(주민번호, vresult);
declare
    vresult number;
begin
    procTlogin('1423376', vresult);
    
    if vresult = 1 then
        dbms_output.put_line('로그인 성공');
    else
        dbms_output.put_line('로그인 실패');
     end if;
end;

-------------------------------------------------------------------------------------
--B001. 강의 스케줄을 관리
--과정기간에 따른 강의 진행상태 구분 함수
--fnlecstate_course(과정시작일, 과정종료일) as "강의진행상태"
create or replace function fnlecstate_course(
    popencourse_startdate varchar2,
    popencourse_finishdate varchar2
) return varchar2
is
begin
    return case
            when popencourse_startdate > sysdate then '강의예정'
            when popencourse_finishdate < sysdate then '강의종료'
            else '강의중'
    end;
end fnlecstate_course;


--과목기간에 따른 강의 진행상태 구분 함수
--fnlecstate_subject(과목시작일, 과목종료일) as "강의진행상태"
create or replace function fnlecstate_subject(
    popensubject_startdate varchar2,
    popensubject_finishdate varchar2
) return varchar2
is
begin
    return case
            when popensubject_startdate > sysdate then '강의예정'
            when popensubject_finishdate < sysdate then '강의종료'
            else '강의중'
    end;
end fnlecstate_subject;

--B001. 강의 스케줄을 관리
--[메인] > [교사] > [강의 스케줄 조회]
---교사번호를 출력한다.
--- 개설 과정 번호를 출력한다.
--- 담당 과목 번호를 출력한다.
--- 과정명을 출력한다.
--- 과목명을 출력한다.
--- 개설 과정 시작 날짜를 출력한다.
--- 개설 과정 종료 날짜를 출력한다.
--- 강의실을 출력한다.
--- 강의 진행 상태(강의 예정, 강의 중, 강의 종료)를 구분해서
--출력한다.
CREATE OR REPLACE VIEW vwT_Schedule
AS
select 
    t.teacher_seq as "교사번호", oc.opencourse_seq as "개설과정번호",  vs.subject_seq as "담당과목번호", oc.opencourse_name as "과정명",
    s.subject_name as "과목명", oc.opencourse_startdate as "과정시작일", oc.opencourse_finishdate as "과정종료일", 
    oc.classroom_name as "강의실명", fnlecstate_course(oc.opencourse_startdate, oc.opencourse_finishdate) as "강의진행상태"  
from tblopencourse oc
    inner join tblteacher t
        on oc.teacher_seq = t.teacher_seq
        inner join tblAvailableSubject vs
            on t.teacher_seq = vs.teacher_seq
            inner join tblsubject s
                on vs.subject_seq = s.subject_seq;
    
--확인(교사번호 입력)
select * from vwT_Schedule where "교사번호" = 1;


--B001-1.
--[메인] > [교사] > [강의 스케줄 조회] > [특정 개설 과정의 개설 과목 목록 조회]
--- 개설 과정 번호를 입력한다.
--- 개설 과목 번호를 출력한다.
--- 과목명을 출력한다.
--- 과목 시작 날짜를 출력한다.
--- 과목 종료 날짜를 출력한다.
--- 교재를 출력한다.
--- 교육생 등록 인원을 출력한다.
CREATE OR REPLACE VIEW vwT_Course_SubjectList
AS
select 
    os.opencourse_seq as "개설과정번호", os.opensubject_seq as "개설과목번호", s.subject_name as "과목명",
    os.opensubject_startdate as "과목시작일", os.opensubject_finishdate as "과목종료일", b.book_name as "교재명", 
    (select count(*) from tblstudent where opencourse_seq = os.opencourse_seq) as "교육생등록인원"
from tblOpenSubject os
    right outer join tblSubject s
        on os.subject_seq = s.subject_seq
    left outer join tblbook b
        on b.book_seq = s.book_seq;

--확인(개설과정번호 입력)
select * from vwT_Course_SubjectList where "개설과정번호" = 1;


--B001-1-1.
--[메인] > [교사] > [강의 스케줄 조회] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 과목 교육생 목록 조회]
-- 특정 개설 과목번호를 입력한다.
--- 개설과목 번호를 출력한다.
--- 교육생 번호를 출력한다.
--- 교육생 이름을 출력한다.
--- 교육생 전화번호를 출력한다.
--- 교육생 등록 날짜를 출력한다.
--- 수료 또는 중도 탈락 여부를 출력한다.
CREATE OR REPLACE VIEW vwT_Course_Subject_StudentList
AS
select 
    os.opensubject_seq as "개설과목번호", st.student_seq as "교육생번호", st.student_name as "교육생이름",
    st.student_tel as "교육생 전화번호", st.student_regdate as "교육생 등록날짜", 
    case
        when c.completion_reg_check is null then '(과정진행중)'
        when c.completion_reg_check = '수료' then '수료'
        when c.completion_reg_check = '중도탈락' then '중도탈락'
    end as "수료 또는 탈락여부"
from  tblopensubject os
   right outer join tblopencourse oc
            on os.opencourse_seq = oc.opencourse_seq
    left outer join tblstudent st
        on oc.opencourse_seq = st.opencourse_seq
    left outer join tblcompletionstate c
        on st.student_seq = c.student_seq;

--확인(특정 개설과목번호 입력)
select * from vwT_Course_Subject_StudentList where "개설과목번호" = 1 order by "교육생번호" asc;


-------------------------------------------------------------------------------------
--B002. 배점관리
--B002. 배점 조회하기
--[메인] > [교사] > [배점 입력 관리] > [강의 종료 과목 리스트 조회]
--- 강의를 마친 과목의 목록이 조회된다.
--- 교사번호를 출력한다.
--- 개설 과목 번호를 출력한다.
--- 과목명을 출력한다.
--- 과목 시작 날짜를 출력한다.
--- 과목 종료 날짜를 출력한다.
--- 교재를 출력한다.
--- 교육생 등록 인원을 출력한다.
CREATE OR REPLACE VIEW vwT_FinishCourseList
AS
select 
    ps.teacher_seq as 교사번호, os.opencourse_seq as 개설과정번호, os.opensubject_seq as 개설과목번호,
    s.subject_name as 과목명, os.opensubject_startdate as 과목시작일, os.opensubject_finishdate as 과목종료일,
    b.book_name as 교재명, 
    (select count(*) from tblstudent where opencourse_seq = os.opencourse_seq) as "교육생등록인원"
from tblbook b
    inner join tblsubject s
        on b.book_seq = s.book_seq
    inner join tblopensubject os
        on s.subject_seq = os.subject_seq
    inner join tblAvailableSubject ps
        on ps.subject_seq = os.subject_seq
where os.opensubject_finishdate < sysdate order by os.opencourse_seq asc, os.opensubject_seq asc;

--확인(특정교사의 강의종료 과정-과목 목록)
select * from vwT_FinishCourseList where "교사번호" = 1; 


--B002-1.
--[메인] > [교사] > [배점 입력 관리]> [특정 개설 과정의 개설 과목 목록 조회]
--- 개설 과목 번호를 입력한다.
--- 개설 과목 번호를 출력한다.
--- 과목 명을 출력한다.
--- 과목 시작 날짜를 출력한다.
--- 과목 종료 날짜를 출력한다.
--- 교재를 출력한다.
CREATE OR REPLACE VIEW vwT_FinishSubjectList
AS
select 
    os.opensubject_seq as 개설과목번호, s.subject_name as 과목명, 
    os.opensubject_startdate as 과목시작일, os.opensubject_finishdate as 과목종료일,
    b.book_name as 교재명
from tblbook b
    inner join tblsubject s
        on b.book_seq = s.book_seq
    inner join tblopensubject os
        on s.subject_seq = os.subject_seq
where os.opensubject_finishdate < sysdate order by os.opensubject_seq asc;  

--확인(개설과목번호 입력)
select * from vwT_FinishSubjectList where 개설과목번호 = 7;


--시험입력,수정,삭제 트리거
--트리거 : 시험입력
create or replace trigger trgTest_Insert
    after  
    insert
    on  tblTest
    for each row
declare
begin
    dbms_output.put_line('시험입력 완료');
end trgTest_Insert;

--트리거 : 시험수정
create or replace trigger trgTest_update
    after  
    update
    on  tblTest
    for each row
declare
begin
        dbms_output.put_line('시험수정 완료');
end trgTest_update;

--트리거 : 시험삭제
create or replace trigger trgTest_delete
    after  
    delete
    on  tblTest
    for each row
declare
begin
        dbms_output.put_line('시험삭제 완료');
end  trgTest_delete;


--B002-1-1.시험등록
--[메인] > [교사] > [배점 및 시험 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [배점 및 시험 정보 등록]
--- 개설 과목 번호를 입력한다.
--- 출결 배점을 등록한다.
--- 필기 배점을 등록한다. 
--- 실기 배점을 등록한다.
--- 시험 날짜를 등록한다.
--- 시험 문제를 등록한다.
CREATE OR REPLACE procedure procT_PointTest_Insert(
        popensubject_seq number,       --개설과목번호
        pcheck_point number,                 --등록할 출결배점
        pnote_point number,                   --등록할 필기배점
        pskill_point number,                    --등록할 실기배점
        ptest_date date,                            --등록할 시험날짜
        ptest_question varchar2              --등록할 시험문제
)
is
begin
        --배점등록
        insert into tblpoint(point_seq, opensubject_seq, check_point, note_point, skill_point) 
            values (SEQPOINT.nextval, popensubject_seq, pcheck_point,  pnote_point, pskill_point);
        --시험등록
        insert into tbltest(test_seq, opensubject_seq, test_date) 
            values (SEQTEST.nextval, (select max(opensubject_seq) from tblpoint), ptest_date);
        --시험문제등록
        insert into tblTestQusReg(testquestion_seq, test_question, test_answer) 
            values (SEQTESTQUSREG.nextval, ptest_question, null);
        --시험지등록
        insert into tblTestBookReg(testbook_seq, testbook_reg_date, testbook_reg_check, test_seq, testquestion_seq)
            values (SEQTESTBOOKREG.nextval, null, default, (select max(test_seq) from tblTest), (select max(testquestion_seq) from tblTestQusReg));
        
        COMMIT;
        
end procT_PointTest_Insert;

--확인 procT_PointTest_Insert(개설과목번호, 출결배점,  필기배점,  실기배점, 시험 날짜, 시험 문제)
begin
procT_PointTest_Insert(48, 0.5, 0.2, 0.3, sysdate, '테스트입력');
end;


--B002-1-2.
--[메인] > [교사] > [배점 및 시험 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [배점 및 시험 정보 수정]
--- 개설 과목 번호를 입력한다.
--- 출결 배점을 수정한다.
--- 필기 배점을 수정한다. 
--- 실기 배점을 수정한다.
--- 시험 날짜를 수정한다.
--- 시험 문제를 수정한다.
CREATE OR REPLACE procedure procT_PointTest_Update(
        popensubject_seq number,       --개설과목번호
        pcheck_point number,                 --수정할 출결배점
        pnote_point number,                   --수정할 필기배점
        pskill_point number,                    --수정할 실기배점
        ptest_date date,                            --수정할 시험날짜
        ptest_question varchar2              --수정할 시험문제
)
is
begin
        
        --배점 점수 수정
        update tblpoint set check_point = pcheck_point, 
                                            note_point = pnote_point, 
                                            skill_point = pskill_point
                                    where opensubject_seq = popensubject_seq ;
        --시험날짜 수정
        update tbltest set test_date = ptest_date where opensubject_seq = popensubject_seq;
        --시험문제 수정
        update tblTestQusReg set test_question =  ptest_question 
            where testquestion_seq = (select testquestion_seq from tblTestBookReg 
                                                                    where test_seq = (select  test_seq from tblTest where  opensubject_seq = popensubject_seq));
        COMMIT;
end procT_PointTest_Update;

--확인 procT_PointTest_Insert(개설과목번호, 출결배점,  필기배점,  실기배점, 시험 날짜, 시험 문제)
begin
procT_PointTest_Update(48, 0.2, 0.4, 0.4, sysdate, '테스트수정');
end;


--B002-1-3.
--[메인] > [교사] > [배점 및 시험 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [배점 및 시험 정보 삭제]
--- 삭제할 개설 과목 번호를 선택한다.
--- 삭제 또는 취소한다.
CREATE OR REPLACE procedure procT_PointTest_Delete(
        popensubject_seq number       --삭제할 개설과목번호
)
is
begin
        --배점삭제
        delete from tblpoint where opensubject_seq = popensubject_seq;
        --문제번호
        delete from tblTestQusReg 
                where testquestion_seq = (select testquestion_seq from tblTestBookReg where test_seq =  (select test_seq from  tblTest where opensubject_seq = popensubject_seq ));
        --시험지 삭제
        delete from tblTestBookReg where test_seq = (select  test_seq from tblTest where opensubject_seq =  popensubject_seq);
        --시험삭제
        delete from tbltest where opensubject_seq = popensubject_seq;
        COMMIT;
        
end procT_PointTest_Delete;

--확인 procT_PointTest_Delete(삭제할 과목번호);
begin
procT_PointTest_Delete(48);
end;

-------------------------------------------------------------------------------------
--B003.
--[메인] > [교사] > [성적 정보 관리]
--- 강의를 마친 과목의 목록이 출력된다.
--- 교사번호를 출력한다.
--- 담당 과목번호를 출력한다.
--- 과정 명을 출력한다.
--- 개설 과정 시작 날짜를 출력한다.
--- 개설 과정 종료 날짜를 출력한다.
--- 강의실을 출력한다.
--- 과목명을 출력한다.
--  강의 진행 상태를 구분해서 출력한다.
CREATE OR REPLACE VIEW vwT_FinishCourse
AS
select 
    oc.teacher_seq as "교사번호", os.opensubject_seq as "담당과목번호", c.course_name as "과정명",
    os.opensubject_startdate as "과정시작일", os.opensubject_finishdate as "과정종료일",
    cr.classroom_name as "강의실", s.subject_name as "과목명", 
    fnlecstate_subject(os.opensubject_startdate, os.opensubject_finishdate) as "강의진행상태"
from tblCourse c
    inner join tblOpenCourse oc
        on c.course_seq = oc.course_seq
    right outer join tblClassroom cr
        on cr.classroom_name = oc.classroom_name
    inner join tblOpenSubject os
        on os.opencourse_seq = oc.opencourse_seq
    inner join tblSubject s
        on s.subject_seq = os.subject_seq
where fnlecstate_subject(os.opensubject_startdate, os.opensubject_finishdate) = '강의종료' order by os.opensubject_seq asc;

--확인(교사번호 입력)
select * from vwT_FinishCourse where 교사번호 = 1;


--B003-1.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회]
--- 개설 과목 번호를 입력한다.
--- 개설 과정 번호를 출력한다.
--- 교육생 번호를 출력한다.
--- 교육생 이름을 출력한다.
--- 교육생 전화번호를 출력한다.
--- 수료 또는 중도 탈락 여부를 출력한다.
--- 수료 또는 중도 탈락 날짜를 출력한다.
--- 필기 점수를 출력한다.
--- 실기 점수를 출력한다.
--- 출결 점수를 출력한다.
CREATE OR REPLACE VIEW vwT_FinishCourseStudentinfo
AS
select
    st.opencourse_seq as "개설과정번호", os.opensubject_seq as "개설과목번호", st.student_seq as "교육생번호",
    st.student_name as "교육생이름", st.student_tel as "교육생전화번호",
    case
        when ps.completion_reg_check is null then '(과정진행중)'
        when ps.completion_reg_check = '수료' then '수료'
        when ps.completion_reg_check = '중도탈락' then '중도탈락'
    end as "수료 및 탈락여부", 
    ps.completion_date as "수료 및 탈락날짜",
    (select note_score from tblscore where point_seq = p.point_seq and student_seq = st.student_seq) as "필기점수",
    (select skill_score from tblscore where point_seq = p.point_seq and student_seq = st.student_seq) as "실기점수", 
    (select check_score from tblscore where point_seq = p.point_seq and student_seq = st.student_seq) as "출결점수"
from tblOpenSubject os
    inner join tblOpenCourse oc
        on os.opencourse_seq = oc.opencourse_seq
    inner join tblStudent st
        on st.opencourse_seq = oc.opencourse_seq
    inner join tblPoint p 
        on os.opensubject_seq = p.opensubject_seq
    left outer join tblCompletionState ps
        on ps.student_seq = st.student_seq
        where fnlecstate_subject(os.opensubject_startdate, os.opensubject_finishdate) = '강의종료' order by st.student_seq asc;

--확인(개설과목번호 입력) - 과목이 종료, 과정이 종료된게 아님 > 수료or탈락여부 null값
select * from vwT_FinishCourseStudentinfo where 개설과목번호 = 7;

   
--B003-1-1.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] 
--- 교육생 이름을 출력한다.
--- 교육생 전화번호를 출력한다.
--- 과목 명을 출력한다.
--- 개설 과목 시작 날짜를 출력한다.
--- 개설 과목 종료 날짜를 출력한다.
--- 수강 또는 중도 탈락 여부를 출력한다.
--- 수강 또는 중도 탈락 날짜를 출력한다.
--- 필기 배점을 출력한다.
--- 실기 배점을 출력한다.
--- 출결 배점을 출력한다.
create or replace procedure procStudentScore(
            popencourse_seq number,
            popensubject_seq number,
            pstudent_seq number
)
is
            pstudent_name varchar2(30);
            pstudent_tel varchar2(20);
            psubject_name varchar2(100);
            pos_startdate date;
            pos_finishdate date;
            pc_reg_check varchar2(30);
            pc_date date;
            pnote_score number;
            pskill_score number;
            pcheck_score number;
begin
        
        select
            st.student_name as "교육생이름", st.student_tel as "교육생전화번호",
            j.subject_name as "과목명", os.opensubject_startdate as "과목시작일", os.opensubject_finishdate as "과목종료일", 
            case
                when ps.completion_reg_check is null then '(과정진행중)'
                when ps.completion_reg_check = '수료' then '수료'
                when ps.completion_reg_check = '중도탈락' then '중도탈락'
            end as "수료 또는 탈락여부", 
            ps.completion_date as "수료 또는 탈락날짜",
            (select note_score from tblscore where point_seq = p.point_seq and student_seq = st.student_seq) as "필기점수",
            (select skill_score from tblscore where point_seq = p.point_seq and student_seq = st.student_seq) as "실기점수", 
            (select check_score from tblscore where point_seq = p.point_seq and student_seq = st.student_seq) as "출결점수"
        into pstudent_name, pstudent_tel, psubject_name, pos_startdate, pos_finishdate,
            pc_reg_check, pc_date, pnote_score, pskill_score, pcheck_score
        from tblSubject j
            inner join tblOpenSubject os
                on j.subject_seq = os.subject_seq
            inner join tblOpenCourse oc
                on os.opencourse_seq = oc.opencourse_seq
            inner join tblStudent st
                on st.opencourse_seq = oc.opencourse_seq
            inner join tblPoint p 
                on os.opensubject_seq = p.opensubject_seq
            left outer join tblCompletionState ps
                on ps.student_seq = st.student_seq
    where os.opensubject_finishdate < sysdate and
        oc.opencourse_seq = popencourse_seq and
        os.opensubject_seq = popensubject_seq and st.student_seq = pstudent_seq;
        
        dbms_output.put_line('---------------------------------------------------------------------------------------------------');
        dbms_output.put_line(pstudent_name || chr(9) || pstudent_tel || chr(9) ||
        psubject_name || '  ' || pos_startdate || chr(9) || pos_finishdate || chr(9) ||
            pc_reg_check || chr(9) || pc_date || chr(9) || chr(9) || pnote_score || chr(9) || chr(9) || pskill_score || chr(9) || chr(9)||chr(9)|| pcheck_score);
exception
    when others then
    dbms_output.put_line('종료된 과정과 과목만 성적조회가 가능합니다.');
end procStudentScore;


--확인 procStudentScroe(특정(개설)과정번호, 특정(개설)과목번호, 교육생번호);
begin
    dbms_output.put_line('학생이름'|| chr(9) || chr(9) || '전화번호' || chr(9) ||
        '과목명' || chr(9) || '과목시작일' || chr(9) || '과목종료일' || chr(9) ||
            '수료 및 탈락여부' || chr(9) || '필기점수' || chr(9) || chr(9) || '실기점수' || chr(9) || chr(9) || '출결점수');
    procStudentScore(1,1,1);
end;

--강의예정의 과정-과목을 조회한 경우(예외)
begin
    procStudentScore(2,2,31);
end;


--성적입력,수정,삭제 트리거
--트리거 : 성적입력
create or replace trigger trgScore_Insert
    after  
    insert
    on  tblScore
    for each row
declare
begin
    dbms_output.put_line('성적입력 완료');
end trgScore_Insert;

--트리거 : 성적수정 및 삭제
create or replace trigger trgScore_update
    after  
    update
    on  tblScore
    for each row
declare
begin
        dbms_output.put_line('성적수정 완료');
end trgScore_update;


--B003-1-1.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] > [필기 점수 관리]
--- 필기 점수를 입력, 수정, 삭제할 수 있다.
--B003-1-2.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] > [필기 점수 입력]
--- 필기 점수를 입력한다.
create or replace procedure procScore_InputNote(
    pstudent_seq number,
    popensubject_seq number,
    pnote_score number
)
is
    vpoint_seq tblPoint.point_seq%type;
    vnote_point tblpoint.note_point%type;
    
begin
    --배점번호 불러오기
    select point_seq into vpoint_seq from tblpoint where opensubject_seq = popensubject_seq;
    --필기배점 불러오기
    select note_point into vnote_point from tblpoint where opensubject_seq = popensubject_seq;
    
    --필기점수 tblScore에 등록
    insert into tblScore(score_seq, student_seq, note_score, score_reg, point_seq)
        values (seqScore.nextVal, pstudent_seq, pnote_score * vnote_point, default, vpoint_seq);
    
    COMMIT;    
end procScore_InputNote;

--확인 procScore_InputNote(교육생번호, 개설과목번호, 필기점수)
begin
 procScore_InputNote(1, 1, 50);
end;


--B003-1-3.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] > [필기 점수 수정]
--- 필기 점수를 수정한다.
CREATE OR REPLACE procedure procScore_updateNote(
        pstudent_seq number,    --교육생 번호
        pscore_seq number, --수정할 문제번호
        pnum number  --수정할 필기점수
)
is
begin
        update tblscore set note_score = pnum 
            where student_seq = pstudent_seq 
                and  score_seq = pscore_seq; 

end procScore_updateNote;

--확인 procScore_updateNote(교육생번호, 문제번호, 필기점수)
begin
procScore_updateNote(1,1172,20);
end;

--B003-1-4.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] > [필기 점수 삭제]
--- 필기 점수를 삭제한다.
CREATE OR REPLACE procedure procScore_deleteNote(
        pstudent_seq number,    --교육생 번호
        pscore_seq number       --삭제할 필기 문제번호
)
is
begin
        update tblscore set note_score = null 
            where student_seq = pstudent_seq  
            and  score_seq = pscore_seq; 
        COMMIT;
end procScore_deleteNote;

--확인 procScore_deleteNote(교육생번호, 삭제할 필기 문제번호)
begin
procScore_deleteNote(1,1172);
end;


--B003-1-1.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] > [실기 점수 관리]
--- 실기 점수를 입력, 수정, 삭제할 수 있다.
--B003-1-2.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] > [실기 점수 입력]
--- 실기 점수를 입력한다.
create or replace procedure procScore_InputSkill(
    pstudent_seq number,
    popensubject_seq number,
    pskill_score number
)
is
    vpoint_seq tblPoint.point_seq%type;
    vskill_point tblpoint.skill_point%type;
begin
    --배점번호 불러오기
    select point_seq into vpoint_seq from tblpoint where opensubject_seq = popensubject_seq;
    --실기배점 불러오기
    select skill_point into vskill_point from tblpoint where opensubject_seq = popensubject_seq;
    
    --실기점수 tblScore에 등록
    insert into tblScore(score_seq, student_seq, skill_score, score_reg, point_seq)
    values (SEQScore.nextVal, pstudent_seq, pskill_score * vskill_point, default, vpoint_seq);
   
    COMMIT;    
end procScore_InputSkill;

--확인 procScore_InputSkill(교육생번호, 개설과목번호, 실기점수)
begin
 procScore_InputSkill(1, 1, 50);
end;


--B003-1-3.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] > [실기 점수 수정]
--- 실기 점수를 수정한다.
CREATE OR REPLACE procedure procScore_updateSkill(
        pstudent_seq number,    --교육생 번호
        pscore_seq number, --수정할 문제번호
        pnum number  --수정할 실기점수
)
is
begin
        update tblscore set skill_score = pnum 
            where student_seq = pstudent_seq 
                and  score_seq = pscore_seq; 
         COMMIT;       
end procScore_updateSkill;

--확인 procScore_updateNote(교육생번호, 문제번호, 수정할실기점수)
begin
 procScore_updateSkill(1,1172,20);
end;



--B003-1-4.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] > [실기 점수 삭제]
--- 실기 점수를 삭제한다.
CREATE OR REPLACE procedure procScore_deleteSkill(
        pstudent_seq number,    --교육생 번호
        pscore_seq number       --삭제할 실기 문제번호
)
is
begin
        update tblscore set skill_score = null 
            where student_seq = pstudent_seq  
            and  score_seq = pscore_seq; 
        COMMIT;
end procScore_deleteSkill;

--확인 procScore_deleteSkill(교육생번호, 삭제할 실기 문제번호)
begin
procScore_deleteSkill(1,1172);
end;


--B003-1-1.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] >
--[출결 점수 관리]
--- 출결 점수를 입력, 수정, 삭제할 수 있다.
--B003-1-2.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] > [출결 점수 입력]
--- 출결 점수를 입력한다.
create or replace procedure procScore_InputCheck(
    pstudent_seq number,                    --교육생번호
    popensubject_seq number,          --수정할 과목번호
    pcheck_score number                     --입력할 출결점수
)
is
    vpoint_seq tblPoint.point_seq%type;
    vcheck_point tblpoint.check_point%type;
begin
    --배점번호 불러오기
    select point_seq into vpoint_seq from tblpoint where opensubject_seq = popensubject_seq;
    --출결배점 불러오기
    select check_point into vcheck_point from tblpoint where opensubject_seq = popensubject_seq;
    
    if (pcheck_score * vcheck_point >= 20) then
        --출결점수 tblScore에 등록
        insert into tblScore(score_seq, student_seq, check_score, score_reg, point_seq)
        values (SEQScore.nextVal, pstudent_seq, pcheck_score * vcheck_point, default, vpoint_seq);
        
        COMMIT;
        
    else 
        raise_application_error(-20001, '오류 : 출결점수는 최소 20점 이상입력되어야 합니다. 해당 과목의 출결배점을 확인하세요.');
    end if;
    
end procScore_InputCheck;

--확인procScore_InputCheck(교육생번호, 개설과목번호, 출결점수)
begin
 procScore_InputCheck(1, 1, 40);
end;



--B003-1-3.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] >[출결 점수 수정]
--- 출결 점수를 수정한다.
CREATE OR REPLACE procedure procScore_updateCheck(
        pstudent_seq number,           --교육생 번호
        popensubject_seq number,    --수정할 과목번호
        pscore_seq number,              --수정할 문제번호
        pnum number                         --수정할 출결점수
)
is
        vcheck_point tblpoint.check_point%type;
begin
       
        --출결배점 불러오기
        select check_point into vcheck_point from tblpoint where opensubject_seq = popensubject_seq;
       --출결점수 수정
        if (pnum * vcheck_point >= 20) then
            update tblscore set check_score = pnum * vcheck_point
                where student_seq = pstudent_seq  and  score_seq = pscore_seq; 
            --COMMIT;
        else 
            raise_application_error(-20001, '오류 : 출결점수는 최소 20점 이상 입력되어야 합니다. 해당 과목의 출결배점을 확인하세요.');
        end if;
              
end procScore_updateCheck;

--확인 procScore_updateCheck(교육생번호, 과목번호, 문제번호, 수정할 출결점수)
begin
procScore_updateCheck(1,1, 1172,200);
end;


--B003-1-4.
--[메인]  >  [교사]  > [성적 정보 관리] > [특정 개설 과정의 개설 과목 목록 조회] > [특정 교육생 성적 조회] > [출결 점수 삭제]
--- 출결 점수를 삭제한다.
CREATE OR REPLACE procedure procScore_deleteCheck(
        pstudent_seq number,    --교육생 번호
        pscore_seq number       --삭제할 출결 문제번호
)
is
begin
        update tblscore set check_score = null 
            where student_seq = pstudent_seq  
            and  score_seq = pscore_seq; 
        COMMIT;
end procScore_deleteCheck;

--확인 procScore_deleteCheck(교육생번호, 삭제할 출결 문제번호)
begin
procScore_deleteCheck(1,1172);
end;


--B004. 출결조회
--B004-1
--[메인] > [교사] > [출결 조회] > [담당 개설 과정 조회]
--- 개설 과정 번호를 출력한다.
--- 과정명을 출력한다.
--- 개설 과정 시작 날짜를 출력한다.
--- 개설 과정 종료 날짜를 출력한다.
--- 강의실을 출력한다.
--- 강의 진행 상태를 출력한다.

--확인(교사번호 입력)
select 
    teacher_seq,
    opencourse_seq as 개설과정번호,
    opencourse_name as 과정명,
    opencourse_startdate as 개설과정시작일,
    opencourse_finishdate as 개설과정종료일,
    classroom_name as 강의실,
    fnlecstate_course(opencourse_startdate, opencourse_finishdate) as 강의진행상태
from tblopencourse 
where teacher_seq = 1;

--강사번호 인덱스
create index idx_TOC_TEACHERNUM on tblopencourse (teacher_seq);

--B004-1-1.
--[메인] > [교사] > [출결 조회] > [담당 개설 과정 조회] > [특정 개설 과정의 교육생 목록 조회]
--- 개설 과정 번호를 출력한다.
--- 교육생 이름을 출력한다.
--- 교육생 주민번호 뒷자리를 출력한다.
--- 교육생 전화번호를 출력한다.
--- 교육생 등록 날짜를 출력한다.
--- 교육생 수료 여부를 출력한다.

--수료여부 함수 : 과정종료일과 비품반납일에 따른 수료여부 구분 함수
-- fncompletionstate(비품반납일, 과정종료일)
create or replace function fnlecstate_course(
    pproduct_finishdate date,
    popencourse_finishdate date 
) return varchar2
is
begin 
    if popencourse_finishdate is not null then
    return
            case
                    when pproduct_finishdate <= popencourse_finishdate then  '수료가능(과정진행중)'
                    when pproduct_finishdate > popencourse_finishdate then  '비품반납 후 수료가능'
            end;
            
    else
           return  popencourse_finishdate;
    end if;
end fnlecstate_course;
 
-- 뷰테이블
CREATE OR REPLACE VIEW vwT_CourseStudentInfo
AS
select 
    distinct
    oc.opencourse_seq as 개설과정번호,
    st.student_name as 교육생이름,
    st.student_ssn as 주민번호뒷자리,
    st.student_tel as 전화번호,
    st.student_regdate as 등록날짜,
    fnlecstate_course(ro.product_finishdate, oc.opencourse_finishdate) as "수료여부" 
from tblopencourse oc
full join tblStudent st on oc.opencourse_seq = st.opencourse_seq
full outer join tblCompletionState cs on st.student_seq = cs.student_seq
full outer join tblRentList rl on rl.student_seq = st.student_seq
full outer join tblRentObject ro on ro.rent_seq = rl.rent_seq;

--확인(담당개정번호 입력)
select * from vwT_CourseStudentInfo where 개설과정번호 = 1 order by 교육생이름 asc;

--개설과정번호 인덱스
create index idx_vwTCStudentInfo_coursenum on tblOpenSubject (opencourse_seq);


--B004-1-1.
--[메인] > [교사] > [출결 조회] > [담당 개설 과정 조회] > [특정 개설 과정의 교육생 목록 조회] > [기간 검색] 
--- 날짜를 입력하여 기간별(년,월,일)로 조회할 수 있다
--- 교육생 번호를 입력한다.
--- 시작날짜를 입력한다.
--- 끝 날짜를 입력한다.
--(검색된 교육생 정보)
--- 교육생 번호를 출력한다.
--- 날짜를 출력한다.
--- 출결현황(정상,지각,조퇴,외출,병가,기타)을 출력한다.
create or replace procedure procT_StudentinfoCheck(
    pstudent_seq number,    --교육생번호
    pnum1 date,     --시작날짜
    pnum2 date      --종료날짜
)
is
    cursor vcursor is select check_seq, student_seq, check_date, check_state
                        from tblcheck
                        where check_date between pnum1 and pnum2 and student_seq = pstudent_seq
                        order by check_date;
    
    vcheck_seq tblCheck.check_seq%type;
    vstudent_seq tblCheck.student_seq%type;
    vcheck_date tblCheck.check_date%type;
    vcheck_state tblCheck.check_state%type;
    
begin
    dbms_output.put_line( '출결번호'  || '      ' ||  '교육생번호'  || '         ' ||  '출결날짜' || '         ' || '출결현황');
    open vcursor;
        loop
            fetch vcursor into vcheck_seq, vstudent_seq, vcheck_date, vcheck_state;
            exit when vcursor%notfound;
            dbms_output.put_line( vcheck_seq  || '                    ' ||  vstudent_seq  || '                        ' ||  vcheck_date || '          ' || vcheck_state);
        end loop;
    close vcursor;
end procT_StudentinfoCheck;

--확인 procT_StudentinfoCheck(학생번호, 시작날짜, 종료날짜)
begin
    procT_StudentinfoCheck(1,'2021-01-01','2021-12-31');
end;

2) 뷰테이블
select 교육생번호, 날짜, 근태상황 from vwadmincheck where 교육생번호 = 1 and 날짜 between '2021-01-01' and '2021-12-31' ;


-------------------------------------------------------------------------------------
--B005.
--[메인] > [교육생] > [비품 대여]
--[메인] > [교사] > [비품 대여]
-- 비품 번호를 조회할 수 있다.
-- 비품 이름을 조회할 수 있다.
-- 비품 전체 수량을 조회할 수 있다.
-- 비품 대여 개수를 조회할 수 있다.

create or replace procedure procRentList(
    pstudent_seq number
)
is
    vproduct_seq tblProduct.product_seq%type;
    vproduct_name tblProduct.product_name%type;
    vproduct_total tblProduct.product_total%type;
    vrent_amount tblRentObject.rent_amount%type;
begin
    select p.product_seq as 비품번호, p.product_name as 비품이름, p.product_total as 전체수량, ro.rent_amount as 대여개수
        into vproduct_seq,vproduct_name,vproduct_total,vrent_amount
    from tblStudent s 
    inner join tblRentList r on s.student_seq = r.rent_num
    inner join tblRentObject ro on r.rent_seq = ro.rent_seq
    inner join tblProduct p on ro.product_seq = p.product_seq
    where s.student_seq = pstudent_seq;
    dbms_output.put_line(vproduct_seq || ' ' || vproduct_name || ' ' || vproduct_total || ' ' || vrent_amount);
end;

begin 
    procRentList(1);
end;

--B005-1.
--[메인] > [교육생] > [비품 대여] > [비품 대여하기]
--[메인] > [교사] > [비품 대여] > [비품 대여하기]
-- 비품 번호를 입력해야 한다.
-- 비품 이름을 입력해야 한다.
-- 비품 대여 수량을 입력해야 한다.
-- 비품 대여 시작일 자동으로 입력된다.
-- 비품 대여일수를 입력해야 한다.
-- 비품 대여일수에 따라 반납일이 자동으로 입력된다.
-- 비품을 대여한다.

create or replace procedure procRent(
    pstudent_seq number,
    pteacher_seq number,
    pnum number,
    pname varchar2,
    prentcount number,
    prentdate date
    
)
is
    vleftamount number;
    vopenstudent number;
    vopenteacher number;
begin
    select product_left_amount into vleftamount
    from tblProduct
    where product_seq = pnum;
    
    select s.student_seq  into vopenstudent
    from tblStudent s
    inner join tblOpenCourse oc on s.opencourse_seq = oc.opencourse_seq
    where sysdate between oc.opencourse_startdate and oc.opencourse_finishdate and s.student_seq = pstudent_seq;
    
    select teacher_seq  into vopenteacher
    from tblOpenCourse
    where sysdate between opencourse_startdate and opencourse_finishdate and teacher_seq = vopenteacher;

    if vopenstudent is not null or vopenteacher is not null then
        if vleftamount != 0 then
            insert into tblRentObject 
                values(seqRentObject.nextVal,pnum,sysdate,sysdate + (select rent_datemax from tblKind where kind_seq = pnum) ,prentcount);
            insert into tblRentList values(seqRentList.nextVal,pstudent_seq,pteacher_seq,(select rent_seq from tblRentObject where product_startdate = (select max(product_startdate)from tblRentObject)));
            
            update tblProduct
            set product_left_amount = product_left_amount-1
            where product_seq = pnum;
        end if;
    end if;
end procRent;

--수강중인 학생 리스트
select s.student_seq
from tblStudent s
inner join tblOpenCourse oc on s.opencourse_seq = oc.opencourse_seq

begin
    procRent(401,null,3,'충전기',1,sysdate);
--    procRent(null,1,3,'충전기',1,sysdate);
end;

