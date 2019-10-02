--2강_단일행함수.sql
--[2019-09-26 목]
/*
※ 단일행 함수 - 입력되는 데이터의 종류에 따라
[1] 문자함수 - 입력되는 값(매개변수)이 문자인 함수
[2] 숫자함수
[3] 날짜함수
[4] 형변환함수
[5] 일반 함수(기타함수)
*/
--[1] 문자함수
--initcap() - 영문 첫글자만 대문자로 바꾼다
select id, initcap(id) from student;

select 'pretty girl', initcap('pretty girl') from dual;
--공백 뒤의 문자도 대문자로 바꿔줌

--upper() : 대문자로 변환해줌
--lower() : 소문자로 변환해줌
select id, initcap(id), upper(id), lower(id)
from student;

select lower('JAVA') from dual;

select * from emp
where ename='SCOTT';

/*select * from emp
where upper(ename)='SCOTT';*/

select * from emp
where lower(ename)='scott'; --

--length(), lengthb() - 문자열의 길이를 리턴해주는 함수
--lengthb() - 문자열의 바이트수를 리턴
--(한글 1글자는 2바이트나 3바이트로 처리)
select name, id, length(name) "이름의 길이", lengthb(name) "이름의 바이트수",
    length(id) "id 길이", lengthb(id) "id 바이트수"
from student;    

--concat('','') - 두 문자열을 연결해주는 함수
--3개 이상의 문자열을 연결하려면 || 연산자 이용

select name || position as "교수 이름",
    concat(name, position) "concat 이용",
    name || '-' || position "||연산자 이용"
from professor;

select concat(name,'-',position)
from professor;  --error
    
--substr()- 문자열에서 특정 길이의 문자열을 추출할 때 사용
--substr('문자열',시작위치, 추출할 글자수)
--시작위치를 - 로 하면 뒤에서부터 자리수를 계산함

select substr('abcdefghi',2,3),
    substr('abcdefghi', 6),
    substr('abcdefghi', -5,2) from dual;
--bcd, fghi, ef
--2번째 위치에서 3개 추출
--6번째 위치에서 끝까지 추출
--뒤에서 5번째 위치에서 2개 추출

select substr('java오라클',5,2),
    substr('java오라클',3,3),
    substr('java오라클',6),
    substr('java오라클',-3,1) from dual;
--오라, va오, 라클, 오
    
--캐릭터셋 확인
select parameter, value from nls_database_parameters
where parameter like '%CHAR%';  --AL32UTF8

--student 테이블에서 JUMIN 칼럼을 사용하여 1전공이 101번인 학생들의 
--이름과 생년월일을 출력
select name, jumin, substr(jumin, 1, 6) "생년월일"
from student
where deptno1=101;

--student 테이블에서 JUMIN 칼럼을 사용하여 태어난 달이 8월인 사람의 이름과 
--생년월일을 출력
select name, jumin, substr(jumin, 1, 6) "생년월일"
from student
where substr(jumin, 3, 2)='08';

--instr() - 주어진 문자열이나 컬럼에서 특정 글자의 위치를 찾아주는 함수
--instr('문자열','찾는글자',시작위치, 몇번째인지)
--몇번째의 기본값은 1

select 'A*B*C*', instr('A*B*C*','*'),
    instr('A*B*C*', '*',3), instr('A*B*C*','*',3,2)
from dual;
--2, 4, 6
--앞에서부터 제일 처음 만나는 *의 위치(오라클에서는 위치값이 1부터 시작)
--3번째 위치 이후에 처음 만나는 *의 위치
--3번째 위치 이후에 2번째로 만나는 *의 위치

select 'A*B*C*', instr('A*B*C*','*',-1),
    instr('A*B*C*','*',-2), instr('A*B*C*','*',-2,2),
    instr('A*B*C*','*',-3,2),instr('A*B*C*','*',-3,4)
from dual;
--6, 4,2,2,0
--뒤에서 첫번째 위치 이후 처음 만나는 *의 위치
--뒤에서 2번째 위치 이후 처음 만나는 *의 위치
--뒤에서 2번째 위치 이후 2번째로 만나는 *의 위치
--뒤에서 3번째 위치 이후 2번째로 만나는 *의 위치
--뒤에서 3번째 위치 이후 4번째로 만나는 *의 위치 => 없으면 0을 리턴함

--student 테이블의 TEL 칼럼을 사용하여 학생의 이름과 전화번호, ')'가 나오는 위치를 출력
select name, tel, instr(tel,')')
from student;

--실습 ) student 테이블을 참조해서 1전공이 101번인 학생의 이름과 전화번호와 
--지역번호를 출력. 단, 지역번호는 숫자만 나와야 함
select name, tel, instr(tel,')'), 
    substr(tel, 1, instr(tel,')')-1) 지역번호
from student
where deptno1=101;

--substrb() - 일부 문자열을 바이트수로 추출
select name, substr(name,1,1), substrb(name,1,3),
    substr(name,1,2), substrb(name,1,6)
from student;

--
select 'c:\test\js\example.txt',
    'd:\css\sample\temp\abc.java' from dual;
--=> 폴더 추출  c:\test\js, d:\css\sample\temp
--파일명 추출 example.txt, abc.java
--확장자만 추출 txt, java
--순수 파일명만 추출  example, abc

create table test_file(
    no  number,
    filepath    varchar2(100)
);

insert into test_file
values(1, 'c:\test\js\example.txt');

insert into test_file
values(2, 'd:\css\sample\temp\abc.java');

select * from test_file;

--1234567890123456789012345
--c:\test\js\example.txt

--1) 파일명만 추출 => example.txt, abc.java
select filepath, instr(filepath, '\',-1), 
    substr(filepath, instr(filepath, '\',-1)+1)
 from test_file;

--2) 확장자만 추출=> txt, java
select filepath, instr(filepath, '.',-1), 
    substr(filepath, instr(filepath, '.',-1)+1)
 from test_file;

--3) 폴더 추출=> c:\test\js, d:\css\sample\temp
select filepath, instr(filepath, '\',-1), 
    substr(filepath, 1, 
        instr(filepath, '\',-1)-1)
 from test_file;

--4) 순수 파일명만 추출=> example, abc
select filepath, instr(filepath, '.',-1), instr(filepath, '\',-1), 
    substr(filepath, instr(filepath, '\',-1)+1, 
        instr(filepath, '.',-1)-instr(filepath, '\',-1)-1)
 from test_file;

--LPAD('문자열' 또는 컬럼명, 자리수, '채울문자')
--문자열의 남은 자릿수를 채울문자로 채운다. 왼쪽부터 채워줌
--RPAD() - 오른쪽부터 채워줌
 
--student 테이블에서 1전공이 101번인 학과 학생들의 ID를 총 10자리로 출력하되 
--왼쪽 빈 자리는 '$'기호로 채우세요
select id, lpad(id, 10, '$')
from student
where deptno1=101;

--실습) DEPT2 테이블을 사용하여 DNAME을 다음 결과가 나오도록 쿼리 작성하기
--dname을 총 10바이트로 출력하되 원래 dname이 나오고 나머지 빈 자리는 해당 자리의 
--숫자가 나오면 됨. 즉, 사장실은 이름이 총 6바이트이므로 숫자가 1234까지 나옴
select dname, lpad(dname, 10, '1'),
    lpad(dname, 10, '1234567890')
from dept2;

--student 테이블에서 ID를 12자리로 출력하되 오른쪽 빈 자리에는 '*'기호로 채우세요
select id, rpad(id, 12, '*')
from student;

--ltrim('문자열' 또는 컬럼명, '제거할 문자')
--왼쪽에서 해당 문자를 제거한다
--제거할 문자를 생략하면 공백을 제거한다.

--rtrim() - 오른쪽에서 해당 문자를 제거한다

select ltrim('javaoracle', 'abcdefghijvw'),
    ltrim('javaoracle', 'java'), rtrim('javaoracle','oracle'),
    rtrim('javaoracle', 'abcelmnopqr'),
    '|' || ltrim('       javaoracle'),
    rtrim('javaoracle    ') || '|'
from dual; 
--oracle, oracle, jav, java

--DEPT2 테이블에서 DNAME을 출력하되 왼쪽에 '영'이란 글자를 모두 제거하고 출력
select dname, ltrim(dname, '영')
from dept2;

--DEPT2 테이블에서 DNAME을 출력하되 오른쪽 끝에 '부'라는 글자는 제거하고 출력
select dname, rtrim(dname, '부')
from dept2;

--replace('문자열' 또는 컬럼명, '문자1','문자2')
--문자열에서 문자1이 있으면 문자2로 바꾸어 출력하는 함수
select replace('javajsp','j','J'),
    replace('javajsp','jsp','spring') from dual;
    
--student 테이블에서 학생들의 이름을 출력하되 성 부분은 '#'으로 표시되게 출력
select name, replace(name, '서', '#'), substr(name, 1,1),
    replace(name,  substr(name, 1,1), '#')
from student;   

--실습) student 테이블에서 1전공이 101번인 학생들의 이름을 출력하되 가운데 글자만 '#'으로 표시되게 출력
--실습) student 테이블에서 1전공이 101번인 학생들의 이름과 주민번호를 출력하되 
--주민번호의 뒤 7자리는 '*'로 표시되게 출력
--실습) student 테이블에서 1전공이 102번인 학생들의 이름과 전화번호, 전화번호에서 
--국번 부분만 '#' 처리하여 출력. 단, 모든 국번은 3자리로 간주함

select replace(name, substr(name, 2, 1), '#') as "replace"
from student
where deptno1 = 101;

select name, replace(jumin, substr(jumin,  7, 7), '*******') as "replace2"
from student
where deptno1 = 102;

select name, tel, replace(tel, substr(tel, instr(tel, ')')+1, 3), '###') as "replace3"
from student
where deptno1 = 102;

--[2019-09-27 금]
--[2] 숫자함수
--round(숫자, 원하는 자릿수) - 반올림
select 12345.457, round(12345.457), round(12345.457, 1),
    round(12345.457, 2),
    round(12345.457, -1), round(12345.457, -2),
    round(12345.457, -3)
from dual;
--12345, 12345.5, 12345.46, 12350, 12300, 12000
/*
    자릿수를 안 준경우 : 정수로 반올림(소수이하 1째 자리에서 반올림)
    1: 소수이하 1자리만 남긴다 (소수이하 2째 자리에서 반올림)
    2: 소수이하 2자리만 남긴다
    -1: 1의 자리에서 반올림(자릿수가 음수인 경우에는 소수 이상에서 처리)
    -2: 10의 자리에서 반올림
    -3: 100의 자리에서 반올림
*/

--trunc(숫자, 원하는 자릿수) - 버림
select 12345.457, trunc(12345.457), trunc(12345.457, 1),
    trunc(12345.457, 2),
    trunc(12345.457, -1), trunc(12345.457, -2),
    trunc(12345.457, -3)
from dual;
--12345.457, 12345, 12345.4, 12345.45, 12340, 12300, 12000

--employees에서 salary를 100의 자리에서 반올림, 버림
select first_name, salary, round(salary, -3) 반올림, 
    trunc(salary, -3) "버림"
from employees;

--mod(숫자, 나누는 수) - 나머지를 구하는 함수
--ceil(소수점이 있는 실수) - 올림(주어진 숫자와 가장 근접한 큰 정수 출력)
--floor(실수) - 내림(가장 근접한 작은 정수)
--power(숫자1, 숫자2) - 숫자1의 숫자2승 (지수승)
select mod(13,3), ceil(12.3), floor(17.85),
    power(3,4) from dual;
--1,13,17,81

--[3] 날짜 함수
--sysdate : 현재일자와 시간을 리턴하는 함수
select sysdate from dual;

--며칠 전/며칠 후, 두 날짜 사이의 경과된 일수 

--1) 며칠 전, 며칠 후
/*
오늘부터 100일 후, 100일전
2019-09-27 + 100 => 날짜
2019-09-27 - 100 => 날짜

=> 더하고 빼는 기준은 일수
*/

select sysdate as "현재 일자", sysdate+100 "100일 후",
    sysdate-100 "100일 전",
    sysdate+1 "하루 후", sysdate-1 "하루 전" from dual;

--2일 1시간 5분 10초 후 날짜 구하기
select sysdate, sysdate+2+1/24+5/(24*60)+10/(24*60*60) 
from dual;

--3개월 후, 3개월 전 날짜 구하기
--add_months(날짜, 개월수) : 해당 날짜로부터 개월수만큼 더하거나 뺀 날짜를 구한다
--=> 몇 개월후, 몇 개월전에 해당하는 날짜를 구할 수 있다
select sysdate, add_months(sysdate,3) as "3개월 후",
    add_months(sysdate,-3) as "3개월 전"
from dual;

--1년 후, 1년 전 날짜
select sysdate, add_months(sysdate, 12) "1년 후", 
    add_months(sysdate, -12) "1년 전"
from dual;

--2년 4개월 1일 3시간 10분 20초 후의 날짜 구하기
select sysdate, 
    add_months(sysdate, 28) + 1+3/24+10/(24*30)+20/(24*60*60)
    as "2년 4개월 1일 3:10:20 후"
from dual;

--to_yminterval() : 년/월 interval
--to_dsinterval() : 일/시분초 interval

select sysdate, sysdate + to_yminterval('02-04') "2년 4개월 후",
    sysdate + to_dsinterval('1 03:10:20') "1일 3시간 10분 20초 후",
    sysdate + to_yminterval('02-04')+ to_dsinterval('1 03:10:20')
    as "2년 4개월 1일 3:10:20 후"
from dual;

--2) 두 날짜 사이의 경과된 시간(일수)
--올해 1월 1일부터 며칠 경과되었는지
--2019-09-27 - 2019-01-01 => 숫자

select sysdate - '2019-01-01'  
from dual;  --error

select sysdate - to_date('2019-01-01')   
from dual;  --날짜로 변환해서 처리해야 함
--to_date(문자) => 문자를 날짜 형태로 변환해주는 함수

--어제부터 오늘까지 경과된 일수, 오늘부터 내일까지 남은 일수
select to_date('2019-09-27') - to_date('2019-09-26') "어제와 간격",
    to_date('2019-09-28') - to_date('2019-09-27') "내일과 간격"
from dual;

select sysdate - to_date('2019-09-26') "어제와 간격",
    to_date('2019-09-28') - sysdate "내일과 간격"
from dual;
--=> to_date('2019-09-28') => 2019-09-28 00:00:00 - 현재날짜의 시분초
--=> 1보다 작은 수가 나옴

--시간을 제외한 두 날짜 사이의 간격 구하는 경우
select sysdate, trunc(sysdate),
    to_date('2019-09-28') - trunc(sysdate) "내일과 간격"
from dual;

--두 날짜 사이의 개월수
--months_between() - 두 날짜 사이의 개월수를 구해줌
select months_between('2019-09-27', '2019-06-27') from dual;
select months_between(sysdate, '2019-06-27') from dual;
select months_between('2019-09-27', '2019-06-01') from dual;
select months_between('2019-09-27', '2019-06-30') from dual;

--next_day() 함수
/*
  주어진 날짜를 기준으로 돌아오는 가장 최근 요일의 날짜를 반환
  요일명 대신 숫자를 입력할 수도 있다
  1:일 2:월...7:토  
*/
select sysdate, next_day(sysdate, '월'),
    next_day(sysdate,'화요일'),
    next_day(sysdate,1),
    next_day('2019-10-20','수')
from dual;

--last_day() 함수
--주어진 날짜가 속한 달의 가장 마지막 날을 리턴
select sysdate, last_day(sysdate),
    last_day('2019-10-17'), last_day('2019-02-23'),
    last_day('2020-02-05') from dual;
    
--round() - 정오 기준으로 그 이전에는 오늘 날짜를 리턴하고, 그 이후에는 
--그 다음 날짜를 리턴함

--trunc() - 무조건 오늘 날짜를 리턴함
--=> 모두 시간은 제외됨
select sysdate, round(sysdate), trunc(sysdate),
    round(to_Date('2019-10-01 15:20:45', 'yyyy-mm-dd hh24:mi:ss'))
from dual;    


--emp테이블에서 사원의 입사일 90일 후의 날짜?
select ename, hiredate, hiredate+90 from emp; 

--emp테이블에서 사원의 입사후 1년이 되는 날짜?
select ename,hiredate,add_months(hiredate,12) from emp;

--?오늘부터 크리스마스까지 남은 일수는?
select to_date('2019-12-25') - sysdate from dual;
select to_date('2019-12-25') - trunc(sysdate) from dual;

--오늘부터 크리스마스까지 남은 달수는? (months_between)
select months_between('2019-12-25',sysdate) from dual;

--emp테이블에서 입사한지 오늘까지 몇일 되었나?
select ename,hiredate,sysdate - hiredate from emp;
?
--emp테이블에서 입사한지 오늘까지 몇달 되었나?
select ename,hiredate, months_between(sysdate, hiredate) from emp;
?
--emp테이블에서 입사한지 오늘까지 몇 년이 되었나?
select ename,hiredate,months_between(sysdate,hiredate) /12 from emp;


--현재 날짜에 해당하는 달의 마지막 날짜는? (last_day)
select last_day(sysdate) from dual;

--?2016-02-13에 해당하는 달의 마지막 날짜는?
select last_day('2016-02-13') from dual; 

--[4] 형변환 함수
/*
※ 오라클의 자료형
1) 문자 - char(고정 길이형), varchar2(가변 길이형)
2) 숫자 - number
3) 날짜 - date

※ 형변환
1) 자동 형변환
2) 명시적 형변환
to_char() : 숫자, 날짜를 문자로 변환
to_number() : 문자를 숫자로
to_date() : 문자를 날짜로
*/

--자동 형변환
select 1+'2', 2+'003', '004'
from dual;
--=> 숫자형태의 문자를 연산하면 해당 문자를 숫자로 자동 형변환한 후 연산함
    
select 1+to_number(2), 2+to_number('003') from dual;

select * from student
where birthday>='1978-01-01';

select * from student
where birthday>=to_Date('1978-01-01');

--(1-1) to_char(날짜, 패턴) - 날짜를 문자로 변환한다
select sysdate, to_char(sysdate, 'yyyy'),
    to_char(sysdate, 'mm'), to_char(sysdate, 'dd'),
    to_char(sysdate, 'd'),  --요일 (1:일, 2:월...7:토)
    to_char(sysdate, 'year'),
    to_char(sysdate, 'mon'), to_char(sysdate, 'month'),
    to_char(sysdate, 'ddd'), --1년 중 며칠인지 
    to_char(sysdate, 'day'), --요일을 한글로(월요일, 화요일...)
    to_char(sysdate, 'dy'), --요일(월,화,수)
    to_char(sysdate, 'q') --분기
from dual;

select extract(year from sysdate) "년도",
    extract(month from sysdate) "월",
    extract(day from sysdate) "일" from dual;
    
select sysdate, to_char(sysdate, 'yyyy-mm-dd'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss am'),
    to_char(sysdate, 'yyyy-mm-dd hh:mi:ss pm day'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss d')
from dual;    

select * from nls_session_parameters;

--실습) STUDENT 테이블의 birthday 칼럼을 참조하여 생일이 3월인 학생의 이름과
-- birthday를 출력
select name, birthday from student
where to_char(birthday, 'MM') ='03';

select name, birthday from student
where extract(month from birthday) =3;

--(1-2) to_char(숫자, 패턴) - 숫자를 패턴이 적용된 문자로 변환
/*
9 : 남은 자리를 공백으로 채움
0 : 남은 자리를 0으로 채움
*/
select 1234, to_char(1234, '99999'),
    to_char(1234, '099999'), to_char(1234, '$99999'),
    to_char(1234, 'L99999'), to_char(1234.56, '9999.9'),
    to_char(1234, '99999.99'), to_char(1234, '99999.00'),
    to_char(1234, '99,999'),
    to_char(123456789, '999,999,999'),
    to_char(1234.56, '9999')
from dual;

--Professor 테이블을 참조하여 101번 학과 교수들의 이름과 pay, 연봉을 출력하시오. 
--단 연봉은 (pay*12)+bonus 로 계산하고 천 단위 구분기호로 표시하시오.
select * from professor;

select to_char(pay*12+bonus,'999,999') as "연봉", 
to_char(pay,'99,999') 급여, pay, bonus, name from professor;

--(2) to_date(문자, 패턴) - 문자를 날짜로 변환
select to_date('2019-10-11'), 
    to_date('2019-09-01', 'yyyy-mm-dd'),
    to_date('2019-09-20 16:03:50', 'yyyy-mm-dd hh24:mi:ss')
from dual; 

select * from professor where hiredate>='1995-01-01';  --자동형변환

select '2019-09-27' - '2019-09-26' from dual;  --error

select to_date('2019-09-27') - to_date('2019-09-26') from dual;

--9/07 ~ 9/27 까지의 데이터 조회
select * from pd order by regdate;

select * from pd 
where regdate >= '2019-09-07' 
and regdate < '2019-09-27'
order by regdate; --2019-09-27 00:00:00 기준이므로
--9/27 날짜의 데이터가 조회되지 않음

--=> 하루 뒤의 날짜보다 작은 데이터를 조회하거나
select * from pd 
where regdate >= '2019-09-07' 
and regdate < to_date('2019-09-27')+1
order by regdate;
/*
select * from pd 
where regdate between '2019-09-07' 
    and to_date('2019-09-27')+1
order by regdate;*/

--종료일에 23:59:59 를 지정해서 조회
select * from pd 
where regdate >= '2019-09-07' 
and regdate < to_date('2019-09-27 23:59:59', 'yyyy-mm-dd hh24:mi:ss')
order by regdate;

--등록한지 몇 시간이 지났는지 조회
select no, pdname, regdate,
    sysdate-regdate "경과된 일수",
    (sysdate-regdate)*24 "경과된 시간"
from pd;

--(3) to_number(문자) - 문자를 숫자로 변환
select '10' as "문자", 10 as "숫자1",
    to_number('10') as 숫자2, to_number('003')+20 as 숫자3,
    '005'+30 as 숫자4
from dual;    

--[실습]Professor 테이블을 사용하여 1990년 이전에 입사한 교수명과 입사일, 
--현재 연봉과 10% 인상 후 연봉을 출력하시오.
--연봉은 상여금(bonus)를 제외한 (pay*12)로 계산하고 연봉과 인상 후 연봉은 
--천 단위 구분 기호를 추가하여 출력하시오.

select name, hiredate as "입사일", 
to_char(pay*12, '99,999') as "연봉", 
to_char(pay*12*1.1, '99,999') as "10% 인상 후 연봉" 
from professor
where hiredate < '1990-01-01';

--[5] 일반함수
--nvl(컬럼, 치환할 값) - 해당 컬럼이 null이면 치환할 값으로 바꾸는 함수

select name, bonus, hpage, nvl(bonus, 0), nvl(hpage, '홈페이지 없다')
from professor;

--Professor 테이블에서 101번 학과 교수들의 이름과 급여, bonus, 연봉을 출력하시오. 
--단, 연봉은 (pay*12+bonus)로 계산하고 bonus가 없는 교수는 0으로 계산하시오.
select name, pay, bonus, pay*12+bonus, 
    pay*12+nvl(bonus,0), 
    nvl(pay*12+bonus, pay*12)
from professor
where deptno=101;

--nvl2(col1, col2, col3) : col1이 null이 아니면 col2를 null이면 col3를 출력
select name, bonus, hpage, 
    nvl2(bonus, bonus, 0), nvl2(hpage, hpage,'홈페이지 없음') 
from professor;

select name, pay, bonus, pay*12+bonus, 
    pay*12+nvl(bonus,0), 
    nvl(pay*12+bonus, pay*12),
    nvl2(bonus, pay*12+bonus, pay*12)
from professor
where deptno=101;

--employees 테이블에서 사원아이디, 이름 - 성(예 : Steven-King), 입사일, 
--기본급(salary), 
--수당(salary*commission_pct), 급여(salary+수당),
--연봉(급여*12) 조회하기
--모든 컬럼은 별칭을 사용한다
--nvl, nvl2 이용 - null인 경우도 계산되도록

select employee_id, first_name || '-' || last_name 이름, hire_date, 
    salary,   commission_pct,  
    salary*nvl(commission_pct,0) 수당, 
    nvl(salary+salary*commission_pct, salary) 급여, 
    (salary+salary*commission_pct)*12 연봉,
    (salary+salary*nvl(commission_pct,0))*12 연봉,
    nvl((salary+salary*commission_pct)*12, salary*12) 연봉,
    nvl2(commission_pct,(salary+salary*commission_pct)*12,salary*12) 연봉 
from employees;

--decode() 함수
/*
- if문을 대신하는 함수

  decode(A, B, 참, 거짓) 
  - A가 B와 같으면 참을 처리하고, 그렇지 않으면 거짓을 처리한다
*/

--student에서 grade가 1이면 1학년, 2이면 2학년, 3이면 3학년, 4이면 4학년 출력
select name, grade, decode(grade, 1, '1학년',
                                  2, '2학년',
                                  3, '3학년',
                                  4, '4학년') as "학년",
                    decode(grade, 1, '1학년',
                                  2, '2학년',
                                  3, '3학년',
                                     '4학년') as "학년2"                                  
from student;

--Professor 테이블에서 교수명, 학과번호, 학과명을 출력하되 deptno가 
--101번인 교수만 컴퓨터 공학과로 출력하고 101번이 아닌 교수들은 학과명에 아무것도 
--출력하지 마세요.
select name, deptno, decode(deptno, 101, '컴퓨터 공학과') 학과 
from professor;

--Professor 테이블에서 교수명, 학과번호, 학과명을 출력하되 deptno가 101번인 교수만 
--컴퓨터 공학과로 출력하고 101번이 아닌 교수들은 학과명에 ‘기타학과’로 출력하세요.
select name, deptno, decode(deptno, 101, '컴퓨터 공학과', '기타학과') "학과"
from professor;

--Professor 테이블에서 교수명, 학과명을 출력하되 deptno가 101번이면 ‘컴퓨터 공학과’, 
--102번이면 ‘멀티미디어 공학과’, 103번이면 ‘소프트웨어 공학과’, 나머지는 ‘기타학과’로 출력하세요.
select name, deptno, decode(deptno, 101, '컴퓨터 공학과',
                                    102, '멀티미디어',
                                    103, '소프트웨어',
                                         '기타학과') 
from professor;

--Professor 테이블에서 교수명, 부서번호를 출력하고, deptno가 101번인 부서 중에서 
--이름이 조인형인 교수에게 ‘석좌교수 후보’라고 출력하세요. 나머지는 null 값 출력.
select name, deptno, decode(deptno, 101, decode(name,'조인형','석좌교수후보'))
from professor;

--Professor 테이블에서 교수명, 부서번호를 출력하고, deptno가 101번인 부서 중에서 
--이름이 조인형인 교수에게 비고란에 ‘석좌교수 후보’라고 출력하세요. 
--101번 학과의 조인형 교수 외에는 비고란에 ‘후보아님’을 출력하고 
--101번 교수가 아닐 경우는 비고란이 공란이 되도록 출력.
select name, deptno, 
    decode(deptno, 101, decode(name, '조인형','석좌교수후보','후보아님'))
from professor;

/*
CLERK - 사무원
SALESMAN - 판매원
MANAGER-관리자
그 이외 - 기타
*/
select * from emp; --job

select ename, job, 
    decode(job,'CLERK','사무원','SALESMAN','판매원', 'MANAGER','관리자','기타')
    "직급"
from emp;

--Student 테이블을 사용하여 제 1전공(deptno1)이 101번인 학과 학생들의 이름(name)과 
--주민번호(jumin), 성별을 출력하되 성별은 주민번호 칼럼을 이용하여 7번째 숫자가 
--1일 경우 ‘남자’, 2일 경우 ‘여자’로 출력하세요
select * from student;

select name, jumin, 
DECODE(SUBSTR(jumin, 7, 1), '1','남자','2','여자') "성별"
from student
where deptno1=101;

select name, jumin, 
DECODE(SUBSTR(jumin, 7, 1), '1','남자', '3','남자','여자') "성별"
from student
where deptno1=101;

--Student 테이블에서 제 1전공(deptno1)이 101번인 학생들의 이름(name)과 전화번호(tel),
--지역명을 출력하세요. 지역명은 지역번호가 02는 서울, 031은 경기, 051은 부산,
--052는 울산, 055는 경남으로 출력하세요

select name, tel, 
    DECODE(SUBSTR(tel, 1, INSTR(tel, ')')-1), '02', '서울',
	'031', '경기', '051','부산','052','울산','055','경남') "지역명"
from student
where deptno1=101;

--[2019-09-30 월]
--요일 출력
select sysdate, to_char(sysdate, 'd'),
    decode(to_char(sysdate, 'd'), 1,'일',2,'월',3,'화',4,'수',5,'목',
                                  6,'금',7,'토') 요일
from dual;

--case함수 - if문을 대신하는 함수, 조건이 범위값을 가질 때도 사용 가능
/*
[1] 동일값 비교시 (= 로 비교하는 경우)
    case 조건 when 결과1 then 출력1
             when 결과1 then 출력2
             else 출력3
             end "별칭"
[2] 범위값 비교시
    case when 조건1 then 출력1
         when 조건2 then 출력2
         else 출력3
         end "별칭"
*/
--학년 출력하기
select name, grade, case grade when 1 then '1학년'
                               when 2 then '2학년'
                               when 3 then '3학년'
                               when 4 then '4학년'
                    end "학년",
                    case grade when 1 then '1학년'
                               when 2 then '2학년'
                               when 3 then '3학년'
                               else '4학년'
                    end "학년2"           
from student;

--요일
select sysdate, to_char(sysdate, 'd'),
    case to_char(sysdate, 'd') when '1' then '일'
                               when '2' then '월'
                               when '3' then '화'
                               when '4' then '수'
                               when '5' then '목'
                               when '6' then '금'
                               else '토'
                               end "요일"
from dual;

--Student 테이블에서 학생들의 이름과 전화번호, 지역명을 출력하세요. 
--단, 지역번호가 02는 서울, 031은 경기, 051은 부산,052는 울산, 055는 경남, 
--나머지는 기타로 출력하세요
select name, tel, substr(tel, 1, instr(tel, ')')-1),
    case substr(tel, 1, instr(tel, ')')-1) when '02' then '서울'
                                           when '031' then '경기'
                                           when '051' then '부산'
                                           when '052' then '울산'
                                           when '055' then '경남'
                                           else '기타'
                                           end "지역번호"                                            
from student;

--범위값
--professor에서 pay가 400초과, 300~400사이, 300미만으로 구분
select name, pay,
    case when pay>400 then '400초과'
         when pay between 300 and 400 then '300~400사이'
         else '300미만'
    end "급여범위"
from professor;

--Student 테이블의 JUMIN 칼럼을 참조하여 학생들의 이름과 태어난 달, 분기를 출력하세요. 
--태어난 달이 01~03월은 1/4분기, 04~06월은 2/4분기, 07~09월은 3/4분기, 
--10~12월은 4/4분기로 출력하세요
select name,jumin, substr(jumin, 3, 2) "태어난 달", 
    case when substr(jumin, 3, 2) between '01' and '03' then '1/4분기'
         when substr(jumin, 3, 2) between '04' and '06' then '2/4분기'
         when substr(jumin, 3, 2) between '07' and '09' then '3/4분기'
         else '4/4분기'
    end "분기"     
from student;

--gogak, 성별
select gname, jumin, substr(jumin, 7,1),
    case when substr(jumin, 7,1) in ('1','3') then '남'
         else '여'
    end "성별"     
from gogak;

--exam_01, total을 이용해 학점 구하기
--90이상이면 A, 80이상이면 B, 70이상이면 C, 60이상이면 D, 나머지는 F
--decode(), case 이용
select studno, total, total/10, trunc(total/10), trunc(total,-1),
    decode(trunc(total/10), 10, 'A', 9,'A',8,'B',7,'C',6,'D','F')
    "학점",
    case trunc(total,-1) when 100 then 'A'
                         when 90 then 'A'
                         when 80 then 'B'
                         when 70 then 'C'
                         when 60 then 'D'
                         else 'F'
                         end "학점"
from exam_01;

--gogak, 나이 구하기
select gname, jumin, sysdate, extract(year from sysdate),
    to_char(sysdate, 'yyyy'), substr(jumin, 1, 2),
    case when substr(jumin, 7, 1) in ('1','2') then 1900 else 2000 end,
    to_char(sysdate, 'yyyy')
    - (substr(jumin, 1, 2)+case when substr(jumin, 7, 1) in ('1','2') 
                                     then 1900 else 2000 end)+1 as "나이"
from gogak;

--매월 말일이 월급날, 월급날이 토요일이면 전날인 금요일에
--일요일이면 전전날인 금요일에 월급을 받는다
--월급날 구하기
select sysdate, last_day(sysdate), to_char(last_day(sysdate), 'd'),
    decode(to_char(last_day(sysdate), 'd'), '7', last_day(sysdate)-1, 
                                            '1', last_day(sysdate)-2,
                                                 last_day(sysdate)) "월급날"
from dual;

select last_day('2019-11-02'), to_char(last_day('2019-11-02'), 'd'),
    decode(to_char(last_day('2019-11-02'), 'd'), 
                        '7', last_day('2019-11-02')-1, 
                        '1', last_day('2019-11-02')-2,
                             last_day('2019-11-02')) "월급날"
from dual;

select last_day('2019-06-13'), to_char(last_day('2019-06-13'), 'd'),
    decode(to_char(last_day('2019-06-13'), 'd'), 
                        '7', last_day('2019-06-13')-1, 
                        '1', last_day('2019-06-13')-2,
                             last_day('2019-06-13')) "월급날"
from dual;


--실습 ? Professor 테이블을 조회하여 교수의 급여액수(pay)를 기준으로 200 미만은 4급, 
--201~300은 3급, 301~400은 2급, 401 이상은 1급으로 표시하여 교수의 번호(profno), 
--교수이름(name), 급여(pay), 등급을 출력하세요. 단, pay 칼럼을 내림차순으로 정렬하세요.
select profno, name, pay,
	CASE WHEN pay<200 THEN '4급'
		  WHEN pay BETWEEN 201 AND 300 THEN  '3급'
		  WHEN pay BETWEEN 301 AND 400 THEN '2급'
		ELSE '1급'
	END "등급"
from professor order by pay desc;

--emp 테이블에서 sal 이 2000 보다 크면 보너스는 1000, 1000보다 크면 500, 
--나머지는 0 으로 표시하세요
select ename, sal, 
    case when sal>2000 then 1000
        when sal>1000 then 500
        else 0
    end as "bonus"
from emp;

--emp에서 job이 clerk이면 사무원, manager이면 관리자, salesman 이면 판매원
--나머지는 기타로 표시
select ename, job, 
    case job when 'CLERK' then '사무원'
             when 'SALESMAN' then '판매원'
             when 'MANAGER' then '관리자'
             else '기타'
             end "직급"    
from emp;

--decode
select ename, job, 
    decode(job,'CLERK','사무원','SALESMAN','판매원', 'MANAGER','관리자','기타')
    "직급"
from emp;