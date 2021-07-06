--C001.교육생 개인정보 조회
--[메인] > [교육생] > [개인정보 조회]
-- 교육생번호를 조회할 수 있다.
-- 이름을 조회할 수 있다.
-- 전화번호를 조회할 수 있다.
-- 등록일을 조회할 수 있다.
-- 과정명을 조회할 수 있다.
-- 과정 기간을 조회할 수 있다.
-- 과정 강의실을 조회할 수 있다.

create or replace procedure procStudent(
    pstudent_seq number
)
is
    vstudent tblStudent%rowtype;
    vopencourse_name tblOpenCourse.opencourse_name%type;
    vclassroom_name tblopencourse.classroom_name%type;
    vcourse_term tblCourse.course_term%type;
begin
    select * into vstudent
    from tblStudent s 
    where s.student_seq = pstudent_seq;
   
    select oc.opencourse_name, c.course_term ,oc.classroom_name
    into vopencourse_name,vcourse_term,vclassroom_name
    from tblStudent s 
    inner join tblOpenCourse oc on s.opencourse_seq = oc.course_seq
    inner join tblCourse c on oc.course_seq = c.course_seq
    where s.student_seq = pstudent_seq;
   
    dbms_output.put_line('학생번호' || ' ' || '학생이름' || '   ' || '전화번호' || '         ' ||
        '등록일' || '         ' || '과정이름' || '                                   ' || '강의실' || '   ' ||'기간');
    dbms_output.put_line('-------------------------------------------------------------------------------------------------------');
    dbms_output.put_line(vstudent.student_seq || '       ' || vstudent.student_name || '     ' 
        || vstudent.student_tel || '   ' || vstudent.student_regdate || ' ' 
        || vopencourse_name || ' ' || vclassroom_name
        || ' ' || vcourse_term);
end;

begin
    procStudent(2);
end;

select s.student_seq as 교육생번호, s.student_name as 교육생이름, s.student_tel as 교육생전화번호, 
    s.student_regdate as 교육생등록일, oc.opencourse_name as 수강과정명, c.course_term as 수강과정기간,oc.classroom_name as 수강과정강의실
from tblStudent s 
inner join tblOpenCourse oc on s.opencourse_seq = oc.course_seq
inner join tblCourse c on oc.course_seq = c.course_seq
where s.student_seq = 1; --로그인한 학생으로 변경

--C002.교육생 성적 조회
--C002-1
--[메인] > [교육생] > [성적 조회] > [과목 목록]
-- 과목번호를 조회할 수 있다.
-- 과목명을 조회할 수 있다.
-- 과목의 시작 날짜를 조회할 수 있다.
-- 과목의 종료 날짜를 조회할 수 있다.
-- 과목의 성적등록여부를 조회할 수 있다.

create or replace procedure procScore(
    pstudent_seq number
)
is
    vsubject_seq tblopensubject.subject_seq%type;
    vopensubject_startdate tblopensubject.opensubject_startdate%type;
    vopensubject_finishdate tblopensubject.opensubject_finishdate%type;
    vsubject_name tblsubject.subject_name%type;
    vscore_reg tblscore.score_reg%type;
    
    cursor vcursor is select os.subject_seq as 과목번호, sub.subject_name as 과목명,
                    os.opensubject_startdate as 시작날짜, os.opensubject_finishdate as 종료날짜,
                    score.score_reg as 성적등록여부
                    from tblStudent s 
                    inner join tblOpenCourse oc on s.opencourse_seq = oc.opencourse_seq
                    inner join tblOpenSubject os on oc.opencourse_seq = os.opencourse_seq
                    inner join tblSubject sub on os.subject_seq = sub.subject_seq
                    inner join tblScore score on s.student_seq = score_seq
                    where s.student_seq = pstudent_seq;
begin
    open vcursor;
        loop
            fetch vcursor into vsubject_seq,vsubject_name,vopensubject_startdate,vopensubject_finishdate,vscore_reg;
            exit when vcursor%notfound;
            dbms_output.put_line(vsubject_seq || ' ' || vsubject_name || ' ' 
                                || vopensubject_startdate || ' ' || vopensubject_finishdate || ' ' 
                                || vscore_reg);
        end loop;
    close vcursor;
end procScore;

begin
    procScore(1);
end;

select os.subject_seq as 과목번호, sub.subject_name as 과목명,
    os.opensubject_startdate as 시작날짜, os.opensubject_finishdate as 종료날짜,
    score.score_reg as 성적등록여부
from tblStudent s 
inner join tblOpenCourse oc on s.opencourse_seq = oc.opencourse_seq
inner join tblOpenSubject os on oc.opencourse_seq = os.opencourse_seq
inner join tblSubject sub on os.subject_seq = sub.subject_seq
inner join tblScore score on s.student_seq = score_seq
where s.student_seq = 1; --로그인 하는 학생

--C002-1-1
--[메인] > [교육생] > [성적 조회] > [과목 목록] > [특정 개설 과목]
-- 과목번호를 조회할 수 있다.
-- 과목명을 조회할 수 있다.
-- 과목의 시작 날짜를 조회할 수 있다.
-- 과목의 종료 날짜를 조회할 수 있다.
-- 과목의 교재명을 조회할 수 있다.
-- 과목의 교사명을 조회할 수 있다.
-- 과목별 배점정보를 조회할 수 있다.
--- 출결 배점을 조회할 수 있다.
--- 필기 배점을 조회할 수 있다.
--- 실기 배점을 조회할 수 있다.
-- 과목별 성적을 조회할 수 있다.
--- 출결 점수를 조회할 수 있다.
--- 필기 점수를 조회할 수 있다.
--- 실기 점수를 조회할 수 있다.
-- 과목별 시험날짜를 조회할 수 있다.
-- 과목별 시험문제를 조회할 수 있다.
create view vwScore
as
select s.student_seq as 학생번호,os.subject_seq as 과목번호, sub.subject_name as 과목명, 
        os.opensubject_startdate as 시작날짜, os.opensubject_finishdate as 종료날짜,
        b.book_name as 교재명, t.teacher_name as 교사명,
        p.check_point as 출결배점, p.note_point as 필기배점, p.skill_point as 실기배점,
    (select note_score from tblScore where student_seq = s.student_seq and point_seq = p.point_seq) as 필기,
    (select skill_score from tblScore where student_seq = s.student_seq and point_seq = p.point_seq) as 실기,
    (select check_score from tblScore where student_seq = s.student_seq and point_seq = p.point_seq) as 출결,
    test.test_date as 시험날짜,
    tq.test_question as 시험문제
    
--    s.student_seq as sseq,
--    p.point_seq as pseq,
    
--    score.check_score as 출결점수, score.note_score as 필기점수, score.skill_score as 실기점수
from tblStudent s 
inner join tblOpenCourse oc on s.opencourse_seq = oc.opencourse_seq
inner join tblOpenSubject os on oc.opencourse_seq = os.opencourse_seq
inner join tblSubject sub on os.subject_seq = sub.subject_seq
inner join tblBook b on sub.book_seq = b.book_seq
inner join tblTeacher t on oc.teacher_seq = t.teacher_seq 
inner join tblPoint p on os.opensubject_seq = p.opensubject_seq
--inner join tblScore score on s.student_seq = score.student_seq    
inner join tblTest test on os.opensubject_seq = test.opensubject_seq
inner join tblTestBookReg tb on test.test_seq = tb.test_seq
inner join tbltestqusreg tq on tb.testquestion_seq = tq.testquestion_seq;

select *
from vwScore
where 학생번호 = 1;

--C003.교육생 출결 현황 및 내역 조회
--[메인] > [교육생] > [출결 현황 및 내역 조회]
--C003-1
--[메인] > [교육생] > [출결 현황 및 내역 조회] > [출결 현황 관리]
-- 입실 시간을 입력할 수 있다.
-- 퇴실 시간을 입력할 수 있다.

create or replace procedure procCheck(
    pstudent_seq number
)
is
    vcnt number;
    ventertime varchar2(20);
    vleavetime varchar2(20);
    vstate varchar2(10);
begin
    select count(*) into vcnt
    from tblCheck
    where to_char(sysdate,'yyyy-mm-dd') = (select to_char(max(check_date),'yyyy-mm-dd') from tblCheck where student_seq = pstudent_seq);

    if vcnt = 0 then
            insert into tblCheck values (seqcheck.nextval,pstudent_seq,to_char(sysdate,'yyyy-mm-dd'),to_char(sysdate,'hh24:mi:ss'),null,'입실');
    else
        select enter_time  into ventertime
        from tblCheck
        where check_date = to_char(sysdate,'yyyy-mm-dd') and student_seq = pstudent_seq;
        
        select leave_time into vleavetime
        from tblCheck
        where check_date = to_char(sysdate,'yyyy-mm-dd') and student_seq = pstudent_seq;

        if vleavetime is null then
            
            if (to_char(sysdate,'hh24:mi:ss') >= '18:00:00') and ventertime > '09:00:00' then
                vstate := '지각';
            elsif (to_char(sysdate,'hh24:mi:ss') >= '18:00:00') then
                if to_char(sysdate,'d') in (2,4,6) then
                    vstate := '비대면';
                elsif to_char(sysdate,'d') in (3,5) then
                    vstate := '대면';
                end if;
            elsif to_char(sysdate,'hh24:mi:ss') < '18:00:00' then
                vstate := '조퇴';
            end if;
        elsif vleavetime is not null then
            vstate := '외출';
        end if;
        
        update tblCheck
        set leave_time = to_char(sysdate,'hh24:mi:ss'), check_state = vstate
        where check_date = to_char(sysdate,'yyyy-mm-dd');
        
    end if;
end procCheck;

begin
    procCheck(1);
end;

-- 트리거를 사용하여 출결상황 변동에 의해 안내멘트 추가
create or replace trigger trgtblCheck
    after
    insert or update on tblCheck
    for each row
begin
    dbms_output.put_line('출결상황에 변동이 생겼습니다.');
    dbms_output.put_line('확인바랍니다.');
    dbms_output.put_line('입실시간: ' || :old.enter_time || ' ' || '변동시간: ' || :new.enter_time);
    dbms_output.put_line('퇴실시간: ' || :old.leave_time || ' ' || '변동시간: ' || :new.leave_time);
    dbms_output.put_line('출결상태: ' || :old.check_state || ' ' || '변동사항: ' || :new.check_state);
end;

--C003-2
--[메인] > [교육생] > [출결 현황 및 내역 조회] > [출결 내역 조회]
-- 교육생의 출결 현황을 조회한다.
-- 교육생 번호를 출력한다.
-- 교육생 이름을 출력한다.
-- 교육생 출근시간을 조회할 수 있다.
-- 교육생 퇴근시간을 조회할 수 있다.
-- 근태 상황(정상, 지각, 조퇴, 외출, 병가, 기타)을 출력한다.
create or replace view vwCheck
as
select c.student_seq as 학생번호, s.student_name as 학생이름, c.check_date as 출석날짜
    ,c.enter_time as 입실시간, c.leave_time as 퇴실시간, c.check_state as 출결상태
from tblCheck c inner join tblStudent s on c.student_seq = s.student_seq
order by c.check_date;

select *
from vwCheck
where 학생번호 = 1;


--C003-2-1.
--[메인] > [교육생] > [출결 현황 및 내역 조회] > [출결 내역 조회] > [기간 검색]
-- 날짜를 입력하여 기간별(년,월,일)로 조회할 수 있다
-- 시작날짜를 입력한다.
-- 끝 날짜를 입력한다.
-- 출결현황(정상,지각,조퇴,외출,병가,기타)을 출력한다.

create or replace procedure procGroupCheck(
    pstudent_seq number,
    pnum1 date,     --시작날짜
    pnum2 date      --종료날짜
)
is
    cursor vcursor is select check_date,check_state
                        from tblcheck
                        where check_date between pnum1 and pnum2 and student_seq = pstudent_seq
                        order by check_date;
    
    vcheck_date tblCheck.check_date%type;
    vcheck_state tblCheck.check_state%type;
begin
    open vcursor;
        dbms_output.put_line('출결날짜' || '      ' || '출결상태');
        dbms_output.put_line('------------------------');
        loop
            fetch vcursor into vcheck_date,vcheck_state;
            exit when vcursor%notfound;
            dbms_output.put_line(vcheck_date || '     ' || vcheck_state);
        end loop;
    close vcursor;
end procGroupCheck;

begin
    procGroupCheck(1,'2021-01-01','2021-12-31');
end;

set serverOutput on;


--C004
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

--C004-1
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
