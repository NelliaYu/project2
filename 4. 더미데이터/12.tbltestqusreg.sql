--12.tbltestqusreg.sql
--시험문제 더미데이터

insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'1.traffic_accident. 각 교통 수단 별(지하철, 철도, 항공기, 선박, 자동차) 발생한 총 교통 사고 발생 수, 총 사망자 수, 사건 당 평균 사망자 수를 가져오시오.','1.select 
    trans_type,
    count(trans_type),
    sum(total_acct_num),
    sum(death_person_num)
from traffic_accident
    group by trans_type;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'2.tblVideo, tblRent, tblMember. ''뽀뽀할까요'' 라는 비디오를 빌려간 회원의 이름은?','2.select m.name
from  tblMember m inner join tblRent r
    on m.seq = r.member
        inner join tblVideo v
            on r.video = v.seq
where v.name = ''뽀뽀할까요'';');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'3.tblCustomer, tblSales. 상품을 2개(단일상품) 이상 구매한 회원의 연락처, 이름, 구매상품명, 수량을 가져오시오.','3.select c.name, c.tel, s.item, s.qty
from tblCustomer c inner join tblSales s
    on c.seq = s.cseq
where count(s.regdate) > 2;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'4.employees, jobs. 사원들의 정보와 직위명을 가져오시오.','4.select e.*,
        j.job_title
from employees e inner join jobs j
    on e.job_id = j.job_id;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'5.locations, countries. location_id 가 2900인 도시가 속한 국가 이름을 가져오시오.','5.select c.country_name
from countries c inner join locations l
    on c.country_id = l.country_id
where l.location_id = 2900;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'6.employees, departments. locations.  ''Seattle''에서(LOC) 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 가져오시오.','6.select e.first_name || '' '' || e.last_name,e.job_id, d.department_id,d.department_name
from employees e inner join departments d
    on e.department_id = d.department_id
        inner join locations l
            on d.location_id = l.location_id
where l.city = ''Seattle'';');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'7.employees, departments. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급을 가져오시오.','7.select d.department_id, d.department_name, e.first_name || '' '' || e.last_name, e.salary
from employees e inner join departments d
    on e.department_id = d.department_id
where d.department_id = 10;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'8.employees. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력하되 각각의 컬럼명을 ''사원번호'', ''사원이름'', ''관리자번호'', ''관리자이름''으로 하여 가져오시오.','8.select e1.employee_id as 사원번호, e1.first_name || '' '' || e1.last_name as 사원이름, e2.employee_id as 관리자번호, e2.first_name || '' '' || e2.last_name as 관리자이름
from employees e1 right outer join employees e2
    on e1.employee_id = e2.manager_id;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'9.employees, jobs. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 가져오시오. 년도를 기준으로 오름차순 정렬.','9.select e.hire_date, avg(e.salary)
from employees e inner join jobs j
    on e.job_id = j.job_id
where j.job_title = ''Sales Manager''
group by e.hire_date
order by e.hire_date asc;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'10.employees. 자신의 매니저보다 먼저 고용된 사원들의 first_name, last_name, 고용일을 가져오시오.',
'10.select e.first_name || '' '' || e.last_name, e.hire_date
from employees e inner join employees e2
    on e.manager_id = e2.employee_id
where e.hire_date < e2.hire_date;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'11.tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.','11.select 
    family,
    round(avg(leg))
from tblZoo
    group by family;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'12.tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.','12.select 

from tblZoo;
    group by ');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'13.tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.','13.select 
    family,
    count(family),
    sizeof,
    count(sizeof)
from tblZoo
group by family, sizeof;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'14.tblMen. tblWomen. 서로 짝이 있는 사람 중 남자와 여자의 정보를 모두 가져오시오.','14.select tblMen.name, tblmen.height,tblMen.weight,
    tblWomen.name, tblWomen.height,tblWomen.weight
from tblMen inner join tblWomen
    on tblMen.couple = tblWomen.name;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'15.tblTodo. 완료한 일의 갯수와 완료하지 않은 일의 갯수를 가져오시오.','15.select
    count(completedate) ,
    count(*) - count(completedate)
from tblTodo;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'16.tblAddressBook. 서울에 사는 10대, 20대, 30대, 40대 인원수를 가져오시오.','16.select
    floor(age/10) * 10 || ''대'' as 연령,
    count(*) as 인원수
from tblAddressBook
    where instr(address,''서울'') = 1
        group by floor(age /10)
        order by floor(age/10);');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'17.tblAddressBook. 현재 주소(address)와 고향(hometown)이 같은 지역인 사람들을 가져오시오.','17.select *
from tblAddressBook
where instr(address, hometown) <> 0;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'18.tblStaff, tblProject. 현재 재직중인 모든 직원의 이름, 주소, 월급, 담당프로젝트명을 가져오시오.','18.select s.name,s.address,s.salary,p.project
from tblStaff s inner join tblProject p
    on s.seq = p.staff_seq; ');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'19.tblStaff, tblProejct. ''노조협상''을 담당한 직원의 월급은 얼마인가?','19.select s.salary
from tblStaff s inner join tblProject p
    on s.seq = p.staff_seq
where p.project = ''노조협상'';');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'20.tblVideo, tblRent, tblMember. ''털미네이터'' 비디오를 한번이라도 빌려갔던 회원들의 이름은?','20.select m.name
from tblVideo v inner join tblRent r 
    on v.seq = r.video
        inner join tblMember m
            on r.member = m.seq
where v.name = ''털미네이터'';');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'21.tblStaff, tblProject. 서울시에 사는 직원을 제외한 나머지 직원들의 이름, 월급, 담당프로젝트명을 가져오시오.','21.select s.name,s.salary,p.project
from tblStaff s left outer join tblProject p
    on s.seq = p.staff_seq
where s.address <> ''서울시''
order by s.name asc;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'22.tblCustomer, tblSales. 상품을 2개(단일상품) 이상 구매한 회원의 연락처, 이름, 구매상품명, 수량을 가져오시오.','22.select c.name, c.tel, s.item, s.qty
from tblCustomer c inner join tblSales s
    on c.seq = s.cseq
where count(s.regdate) > 2;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'23.employees, jobs. 사원들의 정보와 직위명을 가져오시오.','23.select e.first_name || '' '' || e.last_name, 
        d.department_id, 
        d.department_name
from employees e inner join departments d
    on e.department_id = d.department_id;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'24.employees, jobs. 직무(job_id)별 최고급여(max_salary) 받는 사원 정보를 가져오시오.','24.select e.*,
        j.job_title
from employees e inner join jobs j
    on e.job_id = j.job_id;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'25.departments, locations. 모든 부서와 각 부서가 위치하고 있는 도시의 이름을 가져오시오.','25.select e.*,j.max_salary
from employees e inner join jobs j
    on e.job_id = j.job_id
where e.salary = j.max_salary;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'26.locations, countries. location_id 가 2900인 도시가 속한 국가 이름을 가져오시오.','26.select *
from locations l inner join departments d
    on l.location_id = d.location_id;');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'27.employees. 급여를 12000 이상 받는 사원과 같은 부서에서 근무하는 사원들의 이름, 급여, 부서번호를 가져오시오.','27.select c.country_name
from countries c inner join locations l
    on c.country_id = l.country_id
where l.location_id = 2900; ');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'28.employees, departments. locations.  ''Seattle''에서(LOC) 근무하는 사원의 이름, 직위, 부서번호, 부서이름을 가져오시오.','28.select first_name || '' '' || last_name, salary,department_id
from employees 
where department_id in  (select department_id
                                        from employees
                                        where salary>= 12000);');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'29.employees, departments. first_name이 ''Jonathon''인 직원과 같은 부서에 근무하는 직원들 정보를 가져오시오.','29.select *
from employees
where department_id in (select department_id from employees where first_name = ''Jonathon'');');
insert into tblTestQusReg (testQuestion_seq,test_question,test_answer) values (seqTestQusReg.nextval,'30.employees, departments. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 출력하는데 월급이 3000이상인 사원을 가져오시오.','30.select e.first_name || '' '' || e.last_name, d.department_name, e.salary
from employees e inner join departments d
    on e.department_id = d.department_id
where e.salary >= 3000;');

