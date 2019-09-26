select id, initcap(id) from student; --영문 첫글자만 대문자로

select 'pretty girl', initcap('pretty girl') from dual; --공백뒤도 대문자로

select id, initcap(id), upper(id), lower(id)
from student;

select lower('JAVA') from dual;

select * from emp
where ename = 'SCOTT';

select * from emp
where lower(ename) = 'scott';

--length(), lengthb() --문자열 길이 리턴
--lengthb() 바이트 리턴
--한글 1글자는 2~3바이트


select name, id, length(name) "이름의 길이", lengthb(name) "이름의 바이트수", length(id), lengthb(id)
from student;

--contcat('','') - 두 문자열 연결 함수. 세개이상은 || 사용 

select name || position as "교수이름",
concat(name, position) "concat 이용",
name || '-' || position "||연산자 이용"
from professor;

select concat(name, '-', position)
from professor; --error

--substr() 문자열에서 특정 길이의 문자열을 추출할 때 사용
--substr('문자열', 시작위치, 추출할 글자수)
--시작우치를 -로 하면 뒤에서부터 게산

select substr('abcdefghi', 2,3),
    substr('abcdefghi',6),
    substr('abcdefghi', -5, 2)
from dual;

select substr('java오라클', 5,2),
substr('java오라클',3, 3),
substr('java오라클',6),
substr('java오라클',-3,1)
from dual;

--캐릭터셋 확인
select parameter, value from nls_database_parameters
where parameter like '%CHAR%';

--student 테이블에서 JUMIN 칼럼을 사용하여 1전공이 101번인 학생들의 이름과 생년월일을 출력
select name, substr(jumin, 1, 6) as "생년월일" from student
where deptno1=101;

--student 테이블에서 JUMIN 칼럼을 사용하여 태어난 달이8월인 사람의 이름과 생년월일을 출력
--생년월일 출력
select name, substr(jumin, 1, 6) as "생년월일" from student
where substr(jumin, 4, 1) like '8';

--instr() - 주어진 문자열이나 컬럼에서 특정 글자의 위치를 찾아주는 함수
--instr('문자열', '찾는글자', 시작위치, 몇번째인지)
--몇번째의 기본값은 1

select 'A*B*C', instr('A*B*C', '*'),
    instr('A*B*C', '*', 3), instr('A*B*C','*',3,2) --3번째 위치 이후 2번째로 만나는 *위치
from dual;
--이것도 -<<붙일수잇음 위치에 -붙이면 뒤에서 n번째됨


--student 테이블의 TEL 칼럼을 사용하여 학생의 이름과 전화번호, ')'가 나오는 위치를 출력
select name, tel, instr(tel,')')
from student;

--실습 ) student 테이블을 참조해서 1전공이 101번인 학생의 이름과 전화번호와 지역번호를 출력. 단, 지역번호는 숫자만 나와야 함
select name, tel, substr(tel, 1, 3) as "지역번호"
from student;

select name, substrb(name, 1,3)
from student;

--

select 'c:\test\js\example.txt',
    'd:\css\sample\temp\abc.java' from dual;
    --> 파일명만 추출해보자
   
select substr('c:\test\js\example.txt',12),
    substr('d:\css\sample\temp\abc.java',20),
    substr('c:\test\js\example.txt',20),
    substr('d:\css\sample\temp\abc.java',24)
     from dual;
     
create table test_file(
    no number,
    filepath varchar2(100)
    );
    
    insert into test_file
    values(1, 'c:\test\js\example.txt');
    
    insert into test_file
    values(2, 'd:\css\sample\temp\abc.java');
    
select * from test_file;

select
substr(filepath, instr(filepath,'\',-1, 1)+1) as "파일명",
substr(filepath, instr(filepath,'.')+1) as "확장자명"
from test_file;

--student 테이블에서 1전공이 101번인 학과 학생들의 ID를 총 10자리로 출력하되 왼쪽 빈 자리는 '$'기호로 채우세요
select id, lpad(id, 10, '$')
from student
where deptno1=101;


select dname, lpad(dname, 10, '1'),
lpad(dname, 10, '1234567890')
from dept2;

--student 테이블에서 ID를 12자리로 출력하되 오른쪽 빈 자리에는 '*'기호로 채우세요
select id, rpad(id, 12, '*') from student;

--rtrim() 오른쪽해당문자 제거

select ltrim('javaoracle', 'abcdefghijvw'),
ltrim('javaoracle', 'java'),rtrim('javaoracle', 'oracle'),
rtrim('javaoracle', 'abcelmnopqr'),
'|' || ltrim('              javaoracle'),
rtrim('javaoracle              ') || '|'
from dual;


--DEPT2 테이블에서 DNAME을 출력하되 왼쪽에 '영'이란 글자를 모두 제거하고 출력
select dname, ltrim(dname, '영')
from dept2;

--DEPT2 테이블에서 DNAME을 출력하되 오른쪽 끝에 '부'라는 글자는 제거하고 출력
select dname, rtrim(dname, '부')
from dept2;

--replace('문자열' 또는 컬럼명, '문자1', '문자2')
select replace('javajsp', 'j', 'J'),
replace('javajsp', 'jsp', 'spring') from dual;

--student 테이블에서 학생들의 이름을 출력하되 성 부분은 '#'으로 표시되게 출력
select name, replace(name, substr(name, 1,1), '#')
from student;

--실습) student 테이블에서 1전공이 101번인 학생들의 이름을 출력하되 가운데 글자만 '#'으로 표시되게 출력
select name, replace(name, substr(name, 2,1), '#')
from student;

--실습) student 테이블에서 1전공이 101번인 학생들의 이름과 주민번호를 출력하되 주민번호의 뒤 7자리는 '*'로 표시되게 출력
select name, substr(jumin,7,7), replace(jumin, substr(jumin, 7,7), '*******')
from student;


--실습) student 테이블에서 1전공이 102번인 학생들의 이름과 전화번호, 전화번호에서 국번 부분만 '#' 처리하여 출력. 단, 모든 국번은 3자리로 간주함
select tel, replace(tel,substr(tel, 5,3),'###')
from student
where deptno1=102; 