# 오라클을 활용한 데이터베이스 프로젝트
## 교육센터운영 프로그램(Oracle, Sql developer)

**요약 |**
관리자, 교사, 교육생에게 교육센터를 이용시, 필요한 서비스를 제공하는 프로그램


**기간 |**
2021. 05. 24(월) ~ 2021. 06. 04(금) (14일간)


**기획배경 |**
- 교육센터를 중심으로 다양한 이해관계가 형성되어 있어, 다량의 데이터를 활용한 프로젝트에 적합
- 실질적으로 교육센터에서 제공하는 비품 대여 및 관리서비스의 연동 부재

**구현목표 |**
1. 관리자, 교사, 교육생에 필요한 기본 기능 구현

2. 비품 관리 및 대여서비스에 대한 기능 구현 (반납을 모두 완료해야 수료 가능)

3. 코로나 상황에 알맞는 대면(화, 목) / 비대면(월, 수, 금) 출석 구현



**세부 기능 사항 |**

관리자 - 기초 정보 관리, 교사 계정 관리, 개설 과정 관리, 개설 과목 관리, 교육생 관리,
               성적 조회, 비품 관리 기능
교사 - 강의스케줄 조회, 배점 입출력, 성적 입출력, 출결 관리 및 출결 조회, 비품 대여 기능
교육생 - 성적 조회, 출결 관리 및 출결 조회, 비품 대여 기능





**사용기술 |**
- ERD 생성 - exerd 활용	논리 테이블, 물리 테이블
- 테이블 생성 : DDL Script(create, drop)
- 더미 데이터 생성 - Java 활용	: DML Script(insert)
- Text SQL 작성	: DML Script(select, insert, update, delete)
- 뷰 생성
- 함수, 프로시저 생성
- 트리거 생성
- 인덱스 생성


**담당업무 |**
#### 교사 관련 기능
- 로그인, 강의스케줄 관리, 배점 입출력, 성적 입출력, 출결 관리 및 출결 조회, 비품 대여 기능

```
--B000.교사로그인(교사 10명)
--로그인 프로시저(주민번호 뒷자리로 로그인)
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


--B001. 강의 스케줄 관리
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


--B001. 강의 스케줄을 관리 View
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
                
--B002-1-1. 교사 -> 배점 및 시험정보 등록
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

--확인 : 
begin
procT_PointTest_Insert(개설과목번호, 출결배점,  필기배점,  실기배점, 시험 날짜, 시험 문제);
end;
```


**구현화면(ERD) |**
### [논리테이블]
![ERD_논리테이블](https://user-images.githubusercontent.com/76515187/129566082-89d2c447-5d4f-4783-91bc-428a836ac065.png)

### [물리테이블]
![ERD_물리테이블](https://user-images.githubusercontent.com/76515187/129566089-9c6cb3bc-ea21-4d70-b3de-7a4de59f95e5.png)

***

**프로젝트 스토리 |**
Oracle이라는 언어와 SQL Devloper라는 툴로 데이터를 전문적으로 다룰 수 있다는 것 자체가 흥미로웠습니다. 특히 프로젝트를 통해 ERD의 중요성을 크게 느꼈습니다. 프로젝트에서 다양한 데이터가 사용되는 만큼, 각 객체 간의 구조와 연결성을 제대로 파악하고 있어야 그에 알맞은 테이블을 join하고, where 절을 작성할 수 있었습니다. 따라서, 제3 정규화 과정까지 거치면서 ERD의 완성도를 최대한 높일 수 있도록 노력했습니다. 또한, DDL 작성 시 Primary key와 Foreign key 이외에 제약사항들을 걸어 무결성을 깨지 않으려고 노력했습니다.

DB는 포트 포워딩 방식으로 팀원들과 동시다발적으로 DB를 구축했습니다. 이 과정에 있어서 commit의 중요성을 배웠으며, commit의 시점을 잘 기억해놓고 일을 진행하는 것 또한 팀work에서 중요한 부분이라는 것을 알 수 있었습니다. 이번 프로젝트를 통해 관계형 데이터베이스가 어떤 구조로 이루어져 있는지, 어떻게 관계를 설정하며 이 관계를 통해서 전체적인 DB를 구성하게 되는지에 대한 전체적인 감을 익힐 수 있었습니다. 또한, 사용자에게 입력받은 값들이 백엔드에서 어떻게 작업이 이뤄지게 되는지 대략적인 흐름을 파악할 수 있었습니다.
