--7강_table_제약조건.sql
--[2019-10-07 월]
/*
    DDL - 데이터베이스 오브젝트들을 생성,변경, 삭제, 관리하는 명령어
    [1] create - 오브젝트 생성 명령어
        create 오브젝트타입  오브젝트명...
        예) create table 테이블명...
            create index 인덱스명...            
    
    [2] drop - 오브젝트 제거(영구 소멸)
        drop 오브젝트타입  오브젝트명;
        예) drop table 테이블명;
            drop index 인덱스명;
            
    [3] alter - 오브젝트 구조 변경
        alter 오브젝트타입  오브젝트명...
        예) alter table dept5
            add loc varchar2(20);
            
    [4] truncate 
    truncate table - 테이블의 데이터 삭제
    truncate table 테이블명;
    
    ※ drop, truncate, delete 비교
    1) delete - 메모리상의 데이터를 삭제, rollback으로 되돌릴 수 있다 
    2) truncate - 메모리상의 데이터와 데이터 파일까지 삭제, 자동 커밋됨
                  delete보다 수행속도가 빠름
       => delete, truncate는 데이터만 삭제, 테이블 구조는 살아있다           
    3) drop - 테이블의 구조까지 영구히 소멸시킴
*/

/*
※ 테이블 만들기
create table 테이블명
(
    컬럼명1    데이터타입,
    컬럼명2    데이터타입,
    컬럼명3    데이터타입,
    ....    
);

※ 데이터타입
문자형, 숫자형, 날짜형
[1] 문자형
 1) char(크기) - 고정길이 문자형, 최대 2000byte까지 저장
 2) varchar2(크기) - 가변길이 문자형, 최대 4000byte까지 저장
 3) CLOB 타입(Character Large Object)
    - 크기가 큰 문자열이나 문서의 저장이 가능
    - long 타입이 확장된 형태, 4GB까지 저장
*/
--char, varchar2 비교
create table char_exam1
(
    name1   char(3),  --고정길이 3바이트
    name2   varchar2(3)  --가변길이 3바이트
);

insert into char_exam1
values('AA','AA');

select name1, name2, length(name1), length(name2),
    replace(name1, ' ','*'), replace(name2,' ','*')
from char_exam1;

-- 
drop table char_exam1;
create table char_exam1
(
    names1  char(3),  --생략하면 byte
    names2  varchar2(3),
    names3  char(6 byte),
    names4  char(6 char),
    names5  char(6),
    names6  clob  --4GB까지 저장
);

insert into char_exam1
values('AAA','가','ABCDEF', 'ABCDEFG','AB',null);  --error
--names4 - 6개 문자만 입력가능하므로 에러

insert into char_exam1
values('AAA','가','ABCDEF', '가나다라마바','가나',null);
--인코딩에 따라 한글 1글자는 2바이트나 3바이트
--UTF8 : 한글 1글자가 3바이트  

--[2019-10-08 화]   

insert into char_exam1
values('AAA','가','ABCDEF', '가나다라마바','가나다',null); --error
--names5는 6바이트이므로 한글 2글자만 입력가능

select * from nls_session_parameters
where parameter='NLS_LENGTH_SEMANTICS';
--=> CHAR, VARCHAR2에서 생략하면 byte

insert into char_exam1(names1, names3, names6)
values('ABC','ABCDEF', 'ABCdef가나다 clob 데이터 연습'); 

select * from char_exam1;

--[2] 숫자형 - number
/*
    number
    number(전체 자리수)
    number(전체자리수, 소수이하 자리수)
*/
CREATE TABLE num_temp1(
   n1  number,
   n2  number(9),   --전체 9자리의 수 표현 가능
   n3  number(9,2), --전체 9자리의 수 중 소수이하 2자리까지 표현
                    --소수이하 3째자리에서 반올림
   n4  number(9,1), --전체 9자리의 수 중 소수이하 1자리까지 표현
   n5  number(7),   --전체 7자리의 수 표현, 소수이하 자리수는 표현하지 않음
   n6  number(7,-2),--전체 7자리의 수 표현, 소수이상 2째자리(십의 자리)에서 반올림
   n7  number(6),   
   n8  number(3,5)  --1보다 작은 실수 표현, 소수이하 5자리 중 0이 2개 (5-3) 붙는다
);

insert into num_temp1(n1,n2,n3,n4,n5,n6)
values(1234567.89, 1234567.89,1234567.89,1234567.89,1234567.89,
1234567.89);

insert into num_temp1(n1,n2,n3,n4,n5,n6, n7)
values(1234567.89, 1234567.89,1234567.89,1234567.89,1234567.89,
1234567.89, 1234567.89); --error
--n7은 전체 자리수 6개만 가능, 현재 7개이므로 에러


/*
    n8  number(3,5)
    - 전체 자리수가 소수이하 자리수보다 적은 경우
    - 1보다 작은 실수 표현
    - 전체 자리수 3개, 소수이하 자리수 5개
    => 5-3 => 소수이하 자리수에 2개의 0이 붙게 됨
*/
insert into num_temp1(n8)
values(0.00123);

insert into num_temp1(n8)
values(0.01234); --error

insert into num_temp1(n8)
values(0.0012);

insert into num_temp1(n8)
values(0.000123);

select * from num_temp1;

--[3] 날짜형
/*
    date - 년월일 시분초 까지 표현
    timestamp - 밀리초까지 표현
*/
select sysdate, systimestamp from dual;

select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(systimestamp, 'yyyy-mm-dd hh24:mi:ss.ff')
from dual;    

create table date_exam1
(
    d1 date,
    d2 timestamp
);

insert into date_exam1
values(sysdate, systimestamp);

insert into date_exam1
values(sysdate, sysdate);

insert into date_exam1
values(systimestamp, systimestamp);

select * from date_exam1;

--테이블 만들기 연습
create table tbl_test1
(
    name    varchar2(30), --이름
    ssn     char(14),   --주민번호
    profile clob,       --자기소개
    gender  char, --성별 M/F
    age     number(3), --나이
    regdate date    --등록일
);

insert into tbl_test1
values('홍길동','990102-1112222','자기소개입니다.','M',20,sysdate);

commit;

select * from tbl_test1;

--무결성 제약조건
/*
    ※ 데이터 무결성
    - 오라클 서버에서 데이터를 흠 없이 안정되게 지켜 주는 것
    - 제대로 된 데이터들이 올바르게 저장될 수 있도록 하기 위해
      데이터베이스측에서 제공하는 기능들 => 무결성 제약조건
    - 무결성을 지키기 위해 제약조건들을 제공함
    - 제약조건들은 테이블의 컬럼에 적용됨
    
    ※ 무결성 제약조건(Integrity Constraints)
    [1] null/ not null
    [2] unique
    [3] primary key
    [4] foreign key
    [5] check
    [6] default
*/
--[1] null (not null => C)
/*
    - 데이터가 없음을 의미
    - 컬럼의 속성 중 하나로 해당 컬럼이 null값을 허용하는지 허용하지 않는지 지정
    - 데이터 타입 다음에 명시함
    - null을 허용하면 null, 허용하지 않으면 not null 명시
    - 명시하지 않으면 디폴트값 : null
*/
create table null_exam1
(
    col1    char(3) not null, --null을 허용하지 않음 => 반드시 값을 입력해야 함
    col2    char(3) null, --null을 허용함
    col3    char(3) --생략하면 null 허용
);

insert into null_exam1(col1, col2)
values('AA','BB'); --col3에는 null이 들어감

insert into null_exam1(col2, col3)
values('B2','C2'); --error : col1은 not null이므로 값을 입력해야 함

insert into null_exam1(col1, col2, col3)
values('A2',null,''); --null을 직접 입력하는 경우 : null, '' 입력

insert into null_exam1(col1, col3)
values('A3',' '); --' '은 null이 아님

SELECT * FROM null_exam1;

SELECT * FROM null_exam1 where col3 is null;
SELECT * FROM null_exam1 where col3 is not null;
--=> 필수 입력 항목에는 not null 제약조건을 지정해야 함

--[2] unique (U)
/*
    - 각 레코드를 유일하게 식별할 수 있는 속성
    - 복합키를 unique 제약조건으로 사용할 수 있다
    - 한 테이블에 여러 개의 unique 제약조건이 올 수 있다
    - null을 허용함
*/
create table unique_exam1
(
    col1    varchar2(10)    unique  not null,
    col2    varchar2(10)    unique null,  --null 허용
    col3    varchar2(10)    not null,
    col4    varchar2(10)    not null,
    constraint unique_col   unique(col3, col4)  --outline 제약조건,
                                                --unique 복합키
); 

insert into unique_exam1
values('AA','BB','CC','DD');

insert into unique_exam1(col1, col3, col4)
values('AA','C1','D1'); --error: unique제약조건 위배
                        --col1에 AA가 이미 있으므로 중복될 수 없다
                        
insert into unique_exam1(col1, col3, col4)
values('A4','CC','DD'); --error: col3, col4는 복합키로 unique해야 하므로
                         
insert into unique_exam1(col1, col3, col4)
values('A1','C1','C2');  --col2는 unique이지만, null 허용하므로 입력가능 

insert into unique_exam1
values('A2',null,'C2','D2');

insert into unique_exam1
values('A3','','C3','D3');

select * from unique_exam1;
/*
    null을 허용한 unique에는 값을 입력하지 않을 수 있다
    col2의 값이 null인 레코드가 여러 개
    => unique 대상에서 제외됨
    
    unique 제약조건에는 not null을 지정하는 것이 일반적임
*/

--제약조건 조회
--user_constraints, user_cons_columns 뷰 이용
select * from user_constraints
where table_name like '%EXAM%';

select * from user_cons_COLUMNS
where table_name like '%EXAM%';

select a.TABLE_NAME,a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
 b.COLUMN_NAME, b.POSITION 
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
where a.table_name like '%EXAM%';

--[3] primary key (P)
/*
    - 각 레코드를 유일하게 식별할 수 있는 속성
    - 테이블당 하나만 올 수 있다
    - not null + unique index
    - 복합키도 가능
*/
create table pk_exam1
(
    col1    char(3) primary key,  --inline 제약조건
    --col2  char(3) primary key  --error
    col2    varchar2(4),
    col3    number
);

insert into pk_exam1(col1, col2, col3)
values('A01','AA',1);

insert into pk_exam1(col1, col2, col3)
values('A01','BB',2); --error:unique constraint (HR.SYS_C007095) violated

insert into pk_exam1(col1, col2, col3)
values(null,'CC',3); --error:cannot insert NULL into ("PK_EXAM1"."COL1")
--primary key는 not null이므로, null허용하지 않음

insert into pk_exam1(col1)
values('A02'); 

select * from pk_exam1;

--
create table pk_exam2
(
    col1    char(3),
    col2    varchar2(4),
    col3    number,
    constraint pk1_col1 primary key(col1, col2) --복합키, outline제약조건
);

insert into pk_exam2
values('A01','B01',10);

insert into pk_exam2
values('A01','B01',20); --error:col1, col2가 복합키, unique제약조건 위배

insert into pk_exam2
values('A01','B02',30);

select * from pk_exam2;

update pk_exam2
set col2='B01'
where col1='A01' and col2='B02';  --error: unique제약조건 위배

commit;

--
select a.TABLE_NAME,a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
 b.COLUMN_NAME, b.POSITION 
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
where a.table_name like '%EXAM%';

--[4] foreign key(R) 외래키 제약조건
/*
    - 다른 테이블을 참조하기 위하여 사용되는 속성들
    - 테이블간에 관계를 설정할 때 사용되는 키
    - 부모 테이블의 primary key나 unique는 자식 테이블의 foreign key로 전이된다
    
    - 입력시 부모 테이블을 먼저 insert하고, 그 후에 자식 테이블을 insert해야 함
    - 부모 테이블에 있는 참조컬럼의 값만 자식 테이블에서 사용할 수 있다
    (부모 테이블에 없는 값을 자식 테이블에서 사용하는 것은 불가능)
    
    - 삭제시 자식 테이블을 먼저 삭제하고, 그 후에 부모 테이블을 삭제해야 함
    - foreign key 지정시 on delete cascade 옵션을 주면
      부모 테이블의 레코드를 삭제하면 자식 테이블의 해당 레코드도 삭제됨
*/

--[5] check 제약조건 (C)
/*
    입력되는 값을 체크하여 일정한 조건에 해당되는 값만 입력될 수 있게 하는 제약 조건
    예) 성별(gender) 컬럼 => 남자, 여자만 입력되고 다른 값은 입력될 수 없도록
*/
create table check_exam1
(
    no      number  primary key,
    name    varchar2(30)    not null,
    gender  char(6) check(gender in('남자','여자')), --inline제약조건
    pay     number(10),
    age     number(3),
    --outline 제약조건
    constraint ck_check_exam1_pay check(pay>=0),
    constraint ck_check_exam1_age check(age between 0 and 150)
);

insert into check_exam1(no, name)
values(1,'홍길동');

insert into check_exam1(no, name, gender, pay,age)
values(2,'김길동','남자',5000000, 35);

insert into check_exam1(no, name, gender, pay,age)
values(3,'이길선','여',500000, 25); --error:gender check 제약조건 위배

insert into check_exam1(no, name, gender, pay,age)
values(4,'장길자','여자',-500000, 25); --error:pay check 제약조건 위배

insert into check_exam1(no, name, gender, pay,age)
values(5,'이길동','남자',400000, 155); --error:age check 제약조건 위배

select * from check_exam1;

select a.TABLE_NAME,a.CONSTRAINT_NAME, a.CONSTRAINT_TYPE, a.INDEX_NAME,
 b.COLUMN_NAME, b.POSITION 
from user_constraints a join user_cons_columns b
on a.CONSTRAINT_NAME = b.CONSTRAINT_NAME
where a.table_name like '%EXAM%'
order by a.table_name;

--[6] default
/*
    - 기본값
    - 컬럼에 특정 값을 디폴트 값으로 설정하면 테이블에 데이터를 입력할 때 해당 컬럼에 
      값을 입력하지 않을 경우 디폴트로 설정한 값이 자동으로 입력됨
    - 컬럼 타입 다음에 'default 디폴트값' 을 명시
    - 반드시 데이터 타입 다음에, null이나 not null 앞에 위치시켜야 함
*/
create table default_exam1
(
    no  number  primary key,
    name    varchar2(30),
    gender  char(3) default '남' check(gender in('남','여')),
    hiredate    date    default sysdate not null,
    score   number(3)   default 0   null
);

insert into default_exam1(no, hiredate)
values(1, sysdate);

insert into default_exam1(no)
values(2);

insert into default_exam1(no, name, gender, hiredate, score)
values(3,'홍길동','여',default, 90);

insert into default_exam1
values(4,'김길동',default,default,default);

select * from default_exam1;

--제약조건을 이용하여 테이블 만들기
--1) 부서 테이블 만들기
--부서 (부모) <--> 사원 (자식)

--drop table depart;
drop table depart cascade constraint;
/*
    => 자식 테이블이 참조하고 있는 부모 테이블은 drop할 수 없으나
    참조 제약조건까지 같이 삭제하고 싶으면 drop시  cascade constraint 옵션을 준다   
*/
create table depart
(
    dept_cd     char(3) primary key,  --부서코드
    dept_name   varchar2(50) not null, --부서명
    loc         varchar2(100)   --지역
);

--2) 사원 테이블 만들기
--사원 (부모) <--> 사원가족 (자식)
--drop table employee;
create table employee
(
    empno   number  primary key,    --사원번호
    name    varchar2(30)    not null,
    dcode   char(3) not null constraint fk_employee_dcode
                            references depart(dept_cd),
    sal     number(10)  default 0 check(sal>=0),    --급여
    email   varchar2(50)    unique, 
    hiredate    date    default sysdate --입사일                        
);

--부모인 DEPART 테이블을 강제로 drop=> 자식의 외래키가 삭제됨
select * from user_constraints
where table_name = 'EMPLOYEE';

--자식의 외래키 추가
alter table employee
add constraint fk_employee_dcode foreign key(dcode)
    references depart(dept_cd);

--3) 사원가족 테이블 만들기
--drop table family
create table family
(
    empno   number  not null constraint fk_family_empno
            references employee(empno) on delete cascade,   --사원번호
    name    varchar2(30)    not null,  --가족 이름
    relation    varchar2(50),   --가족관계
    constraint pk_family_name primary key(empno, name) --복합키
);    

--insert
--부모 테이블에 먼저 데이터를 입력한다
--1) 부서 테이블 insert
insert into depart(dept_cd, dept_name, loc)
values('A01','인사부','서울');

insert into depart(dept_cd, dept_name, loc)
values('B01','영업부','부산');

insert into depart(dept_cd, dept_name, loc)
values('C01','총무부','광주');

select * from depart;

--2) 사원 테이블 insert
--부모인 부서 테이블의 레코드가 없으면 자식인 사원 테이블에 insert할 수 없다
insert into employee(empno, name, dcode, sal, email, hiredate)
values(1001, '홍길동','A01', 5000000,'h@nate.com',sysdate);

insert into employee(empno, name, dcode, sal, email)
values(1002, '홍길동2','F01', 5000000,'h2@nate.com'); --error:
--parent key not found

insert into employee(empno, name, dcode, sal, email)
values(1003, '홍길동3','A01', -5000000,'h3@nate.com'); --error:sal check
--제약조건 위배

insert into employee(empno, name, dcode, sal, email)
values(1004, '홍길동4','A01', 500000,'h@nate.com'); --error:unique제약조건 위배

insert into employee(empno, name, dcode, sal, email)
values(1002, '김길동','B01', 2000000,'k@nate.com');

insert into employee(empno, name, dcode, sal, email)
values(1003, '이길동','C01', 3000000,'l@nate.com'); 

select * from employee;

--3) 사원 가족 테이블 insert
insert into family(empno, name, relation)
values(1005, '박길수','부'); --error:parent key not found

insert into family(empno, name, relation)
values(1001, '홍아빠','부');
insert into family(empno, name, relation)
values(1001, '김엄마','모');
 
insert into family(empno, name, relation)
values(1001, '홍아빠','형'); --error:unique제약조건 위배

insert into family(empno, name, relation)
values(1002, '김아버지','부');
insert into family(empno, name, relation)
values(1002, '박어머니','모');
insert into family(empno, name, relation)
values(1002, '김형','형');

select * from depart;
select * from employee;
select * from family;

--delete
--자식이 참조하고 있는 부모 테이블의 레코드를 삭제하는 경우
--1) on delete cascade 옵션을 주지 않은 경우
--=> 부모 테이블의 레코드를 삭제하면 에러 발생
delete from depart
where dept_cd='A01'; --error:child record found
--foreign key 제약조건 위배
--=> 삭제를 반드시 해야 된다면, 자식 레코드를 먼저 삭제한 후 부모 레코드를 삭제한다

--2) on delete cascade 옵션을 준 경우
--=> 부모 테이블의 레코드를 삭제하면 해당 레코드를 참조하는 자식 테이블도 같이 삭제됨
delete from employee
where empno=1001; --family에서 참조하고 있는 레코드 삭제
--=> 부모인 employee의 1001번 레코드가 삭제되면서
--자식인 family의 1001번 레코드들도 같이 삭제됨

/*
    1) 테이블 생성 후 제약조건 추가
    alter table 테이블명
    add constraint 제약조건이름  제약조건종류(컬럼);
    예) alter table emp
        add constraint pk_empno primary key(empno);
        
    2) 테이블을 만들면서 아웃라인 제약조건 지정
    컬럼명을 모두 나열한 이후에
    , constraint 제약조건이름 제약조건종류(컬럼)
    예) , constraint pk_empno primary key(empno);
    
    3) 인라인 제약조건 지정
    컬럼명의 데이터타입 뒤에 제약조건 종류
    예) empno number primary key    
*/

--테이블 생성 후 제약조건 추가하기
create table employee2
(
    empno   number,  --사원번호
    name    varchar2(30)    not null,  --사원이름
    dcode   char(3)         not null,  --부서코드
    sal     number(10)  default 0, --급여
    email   varchar2(50), --이메일
    hiredate    date    default sysdate  --입사일                        
);

--제약조건 추가하기
--primary key 추가
alter table employee2
add constraint pk_employee2_empno primary key(empno);

select * from user_constraints
where table_name='EMPLOYEE2';

--default값 조회
select column_name, data_default 
from user_tab_columns
where table_name='EMPLOYEE2';

--foreign key 추가
alter table employee2
add constraint fk_employee2_empno foreign key(dcode)
    references depart(dept_cd);

--

create table employee3
(
    empno   number,  --사원번호
    name    varchar2(30)    not null,  --사원이름
    dcode   char(3)         not null,  --부서코드
    sal     number(10)  default 0, --급여
    email   varchar2(50), --이메일
    hiredate    date    default sysdate,  --입사일   
    constraint pk_employee3_empno primary key(empno), 
    constraint pk_employee3_dcode foreign key(dcode) references depart(dept_cd),
    constraint pk_employee3_sal check(sal>=0),                 
    constraint pk_employee3_email unique(email) 
);

select * from employee3;

select * from user_constraints
where table_name='EMPLOYEE4';

create table employee4
(
    empno   number,  --사원번호
    name    varchar2(30) constraint nn_employee4_name  not null,  --사원이름 ---constraint를 생략해서 쓰지만 사용할수도잇음
    dcode   char(3)         not null,  --부서코드
    sal     number(10)  default 0, --급여
    email   varchar2(50), --이메일
    hiredate    date    default sysdate,  --입사일   
    constraint pk_employee4_empno primary key(empno), 
    constraint pk_employee4_dcode foreign key(dcode) references depart(dept_cd),
    constraint pk_employee4_sal check(sal>=0),                 
    constraint pk_employee4_email unique(email) 
);

select * from employee4;

--제약조건 이름 변경하기
alter table employee2
rename constraint fk_employee2_empno to fk_employee2_dcode;

select * from user_constraints
where table_name = 'EMPLOYEE2';

--제약조건 제거하기
alter table employee2
drop constraint pk_employee2_empno;

--not null, default 제약조건 변경
alter table employee2
modify name null; --기존에 이미 null이면 null로 바꿀 수 없음

alter table employee2
modify sal default 1000;

/*
회원 테이블 만들기-member2
no - 번호, 기본키
userid 아이디, unique, 반드시 값 입력되도록
name 이름, 반드시 값 입력되도록
pwd 비밀번호 , 반드시 값 입력되도록
email 이메일
hp 휴대폰번호
zipcode 우편번호
address 주소(시도, 구군, 동)
addressDetail 상세주소
regdate 가입일, 기본값:현재일자
mileage 마일리지, 기본값 :0, 0~1000000 사이의 값만 들어가도록
*/
create table member2
(
    no number primary key, --번호, 기본키
    userid varchar2(30) unique, --아이디, unique, 반드시 값 입력되도록
    name varchar2(10) not null,--이름, 반드시 값 입력되도록
    pwd varchar2(20) not null,--비밀번호 , 반드시 값 입력되도록
    email varchar2(50),--이메일
    hp varchar2(13),--휴대폰번호
    zipcode varchar2(5),--우편번호
    address clob,--주소(시도, 구군, 동)
    addressDetail clob, --상세주소
    regdate varchar2(30) default sysdate,--가입일, 기본값:현재일자
    mileage number check(mileage>0 and mileage<1000000)--마일리지, 기본값 :0, 0~1000000 사이의 값만 들어가도록
);

create table employee
(
    empno   number  primary key,    --사원번호
    name    varchar2(30)    not null,
    dcode   char(3) not null constraint fk_employee_dcode
                            references depart(dept_cd),
    sal     number(10)  default 0 check(sal>=0),    --급여
    email   varchar2(50)    unique, 
    hiredate    date    default sysdate --입사일                        
);

/*
zipcode 우편번호
sido 시도
gugun 구군
dong 동
bunji 번지
seq -번호, 기본키

*/

create table zipcode
(
    zipcode varchar2(5), --우편번호
    sido varchar2(40),--시도
    gugun varchar2(50),--구군
    dong varchar2(50),--동
    bunji varchar2(30),--번지
    seq number, --번호, 기본키 
    constraint pk_zipcode_seq primary key(seq),
    constraint pl_zipcode_zipcode foreign key(zipcode) references member2(zipcode)
);
/*
no - 번호, 기본키
userid 아이디, unique, 반드시 값 입력되도록
name 이름, 반드시 값 입력되도록
pwd 비밀번호 , 반드시 값 입력되도록
email 이메일
hp 휴대폰번호
zipcodeno 우편번호 테이블 번호(seq)와 연결-외래키
addressDetail 상세주소
regdate 가입일, 기본값:현재일자
mileage 마일리지, 기본값 :0, 0~1000000 사이의 값만 들어가도록
*/

create table employee4
(
    empno   number,  --사원번호
    name    varchar2(30) constraint nn_employee4_name  not null,  --사원이름 ---constraint를 생략해서 쓰지만 사용할수도잇음
    dcode   char(3)         not null,  --부서코드
    sal     number(10)  default 0, --급여
    email   varchar2(50), --이메일
    hiredate    date    default sysdate,  --입사일   
    constraint pk_employee4_empno primary key(empno), 
    constraint pk_employee4_dcode foreign key(dcode) references depart(dept_cd),
    constraint pk_employee4_sal check(sal>=0),                 
    constraint pk_employee4_email unique(email) 
);

create table family
(
    empno   number  not null constraint fk_family_empno
            references employee(empno) on delete cascade,   --사원번호
    name    varchar2(30)    not null,  --가족 이름
    relation    varchar2(50),   --가족관계
    constraint pk_family_name primary key(empno, name) --복합키
);    