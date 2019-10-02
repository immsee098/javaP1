--[ 오라클 3강 ]

--(1)교수 테이블에서 직급(position)이 전임강사, 조교수인 이름(name), 아이디(id), 직급(position), 급여(pay) 데이터가져오기
select name, id, position, pay
from professor
where position in ('전임강사','조교수');
 
--(2) pd 테이블에서 등록일(regdate) 이  2019-09-07 ~ 2019-09-27 일 사이의 데이터만 조회하기
--to_date 함수 이용하기
select * from pd
where regdate>='2019-09-07' 
and regdate<to_date('2019-09-27')+1;

--(3)교수테이블에서 교수의 이름(name), 직급(position),급여(pay), 보너스(bonus), 연봉(pay*12+bonus)  데이터 가져오기
--bonus가 null이면 0으로 계산되도록 처리한다 -  nvl 함수 사용하기
select name, position, pay, bonus, pay*12+nvl(bonus,0)  as 연봉 from professor;

--(4)학생 테이블에서 학생의 평균키와 가장큰키, 가장작은키, 전체 학생 수 구하기
select avg(nvl(height,0)),max(height),min(height),count(*) from student;

--(5)학생테이블에서 학과(deptno1)별로 학생의 평균키 구하기
--평균키는 소수 이하 한자리만 나오도록 반올림한다(round 함수 이용)
select deptno1,avg(height), round(avg(nvl(height,0)),1) from student 
group by deptno1;

--(6) 교수테이블에서 학과(deptno)별, 직급(position)별로 급여(pay)의 합 구하기
select deptno, position,sum(pay) from professor
group by deptno, position;


--(7) student에서 grade가 1이면 1학년, 2이면 2학년, 3이면 3학년,4이면 4학년이라고 출력
--decode() 이용
select name, grade, decode(grade, 1, '1학년', 
                                  2, '2학년',
                                  3, '3학년',
                                  4, '4학년') as "학년",
 decode(grade, 1, '1학년', 2,'2학년',3,'3학년','4학년') 
    as "학년2"                                    
from student;


--(8) gogak에서 jumin을 이용하여 성별을 출력 (1, 3 이면 남,  2, 4이면 여)
--case 이용

select gname, jumin, substr(jumin, 7, 1),
    case substr(jumin,7,1) when '1' then '남'
                           when '3' then '남'
                           else '여'
    end as "성별",
    case when substr(jumin, 7, 1) in ('1','3') then '남'
         else '여'
    end as "성별2"
 from gogak;


--(9) panmae 테이블에서 상품코드(p_code)별로 판매금액(p_total)의 합계, 수량(p_qty)의 합계, 건수, 판매금액(p_total)의 평균 구하기
--그 결과에서 판매금액(p_total)의 합계가 10000 이상이고, 수량(p_qty)의 합계가 15 이상인 데이터만 조회
select p_code, sum(p_total), sum(p_qty), count(*) , avg(nvl(p_total, 0)) 
from panmae
group by p_code
having  sum(p_total)>=10000 and sum(p_qty) >= 15
order by p_code;

--(10) Professor 테이블을 조회하여 교수의 급여액수(pay)를 기준으로 
--200 미만은 4급, 201~300은 3급, 301~400은 2급, 401 이상은 1급으로 표시하여 교수의 번호(profno), 교수이름(name), 급여(pay), 등급을 출력하세요. 
--단, pay 칼럼을 내림차순으로 정렬하세요.
select profno, name, pay,
    CASE WHEN pay<200 THEN '4급'
          WHEN pay BETWEEN 201 AND 300 THEN  '3급'
          WHEN pay BETWEEN 301 AND 400 THEN '2급'
        ELSE '1급'
    END "등급"
from professor order by pay desc;

--(11) panmae 테이블에서 판매일(p_date)별로 판매금액(p_total)의 합계 구하기
select p_date, sum(p_total) from panmae
group by p_date;

--(12) panmae 테이블에서 수량(p_qty)이 3개 이상인 데이터에 대해 판매일(p_date)별, 판매점(p_store)별로 
--판매금액(p_total)의 합계, 건수 구하기
--그 결과에서 건수가 2 이상인 데이터만 조회
select p_date, p_store, sum(p_total), count(*) from panmae
where p_qty>=3
group by p_date, p_store
having count(*) >=2;

--(13) panmae 테이블에서 판매점(p_store)별, 상품코드(p_code)별로 판매금액(p_total)의 합계, 평균 구하기
select p_store, p_code, sum(p_total), avg(nvl(p_total, 0)) from panmae
group by p_store, p_code
order by p_store, p_code;



--(14) professor 테이블을 조회하여 각 학과별로 입사일이 가장 오래된(최소값) 교수 조회하기
select deptno, min(hiredate) 
from professor 
group by deptno
order by deptno;


--(15) exam_01 테이블에서 total을 이용해서 학점 구하기
--90이상이면 A, 80이상이면 B, 70이상이면 C, 60이상이면 D, 나머지는 F
--case 이용

 select studno, total, trunc(total/10), trunc(total, -1),
    decode( trunc(total/10), 10, 'A',9,'A',8,'B',7,'C',6,'D','F') "학점",
    case trunc(total, -1) when 100 then 'A'
                                  when  90 then 'A'
                                  when 80 then 'B'
                                  when 70 then 'C'
                                  when 60 then 'D'
                                  else 'F'
     end "학점"                               
 from exam_01;
 
 --(16) gogak테이블에서 jumin을 이용해서 나이 구하기

 select gname, jumin, 
    to_char(sysdate, 'yyyy'), 
    substr(jumin, 1,2),
    substr(jumin,7,1), 
    case when substr(jumin,7,1) in ('1','2') then 1900
            else 2000
    end,
    to_char(sysdate, 'yyyy')- 
    (substr(jumin, 1,2)+case when substr(jumin,7,1) in ('1','2') then 1900
                                          else 2000
                                   end)  +1   "나이"     
 from gogak;
 

 --(17) select sql문의 실행순서를 쓰시오.
    
    5. select 컬럼
    1. from 테이블
    2. where 조건
    3. group by 그룹핑할 컬럼
    4. having 조건
    6. order by 컬럼    

--(18) professor 테이블에서 학과별, 직급별 평균 기본급을 구하시오.
--roll up, cube를 각각 이용

select deptno "학과", position "직급", round(avg(nvl(pay,0)),1) "평균기본급"
from professor
group by deptno, position
order by deptno, position;

select deptno "학과", position "직급", round(avg(nvl(pay,0)),1) "평균기본급"
from professor
group by rollup(deptno, position)
order by deptno, position;

--cube
select deptno "학과", position "직급", round(avg(nvl(pay,0)),1) "평균기본급"
from professor
group by cube(deptno, position)
order by deptno, position;

