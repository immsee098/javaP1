--10강_sys계정_사용자관리.sql
--[2019-10-14 월]
--사용자 계정 정보 조회
select * from dba_users;

--데이터파일에 대한 정보 조회
select * from dba_data_files;

--테이블스페이스에 대한 정보 조회
select * from dba_tablespaces;

/*
    오라클 데이터베이스의 논리적 저장구조
    1) 데이터블럭(data block)-최소 저장 단위,
        데이터블럭의 default size: 8K
    2) 익스텐트(extent) - 8개의 데이터블럭이 모여서 하나의 익스텐트가 됨
    3) 세그먼트(segment) - 하나 이상의 익스텐트로 구성
    4) 테이블스페이스(tablespace) - 세그먼트들을 저장하는 논리적인 공간이름
    
    하나의 테이블스페이스는 최소 1개의 데이터파일(물리적 파일)로 구성됨    
*/
--데이터 블럭의 size조회 - 8K
select value from v$parameter
where name='db_block_size';

--테이블스페이스 생성
/*
    create tablespace 테이블스페이스명
    datafile 데이터파일의 경로 size 크기
    autoextend on next 크기 -- 자동 증가 옵션(선택)
*/
create tablespace tb_test2
datafile 'D:\myoracle\data\tb_test2.dbf' size 48M
autoextend on next 10M;

select * from dba_data_files;
select * from dba_tablespaces;

--
create tablespace tb_test3
datafile 'D:\myoracle\data\tb_test3_01.dbf' size 48M
autoextend on maxsize 1000M,
         'D:\myoracle\data\tb_test3_02.dbf' size 48M
autoextend on maxsize 1000M,
         'D:\myoracle\data\tb_test3_03.dbf' size 48M
autoextend on maxsize 1000M;

--테이블스페이스 제거
/*
    drop tablespace 테이블스페이스명;
    
    drop tablespace 테이블스페이스명
        including contents and datafiles;  --물리적인 데이터파일까지 삭제
*/   
drop tablespace tb_test3
including contents and datafiles;

--사용자 계정 만들기
/*
    create user 사용자이름
    identified by 비밀번호
    default tablespace 테이블스페이스명;
*/
--tb_test2 테이블스페이스를 사용하는 사용자계정 만들기
create user testuser3
identified by testuser123
default tablespace tb_test2;

select * from dba_users where username like 'TEST%';

--권한 조회
select * from dba_sys_privs where grantee='TESTUSER2'; --권한조회
select * from dba_ROLE_privs where grantee='TESTUSER2'; --권한조회

--사용자에게 권한 부여하기
--create session 권한 부여(접속 권한)
grant create session to testuser2;

/*
create table tbl_test1
(
    no  number  primary key,
    name    varchar2(50)
)tablespace tb_test2;

*/

--테이블 생성 권한 부여하기
grant create table to testuser2;
grant unlimited tablespace to testuser2;

--권한 박탈
--revoke 권한 from 사용자명;
revoke create session from testuser2;

--testuser3사용자에게 resource, connect role 부여하기
grant connect, resource to testuser3;

select * from dba_sys_privs where grantee='TESTUSER3'; --권한조회
select * from dba_ROLE_privs where grantee='TESTUSER3'; --권한조회

select * from dba_sys_privs where grantee='RESOURCE';
select * from dba_sys_privs where grantee='CONNECT';

select * from dba_sys_privs where grantee='HR'; 
select * from dba_ROLE_privs where grantee='HR';
 
--사용자 삭제
--DROP USER 사용자이름;
drop user testuser3;

select * from dba_users where username like 'TEST%';

--잠긴 계정 열기
--alter user 사용자ID account unlock;
alter user testuser2 account unlock;

--계정 잠그기
--alter user 사용자ID account lock;
alter user testuser2 account lock;

--기존 계정의 암호 변경하기
--alter user 사용자ID identified by 새로운 암호;
alter user testuser2 identified by testuser123;

--오라클이 제공하는 role 조회
select * from dba_roles;

--전역 데이터베이스명 조회-xe, orcl
select * from global_name;

--object 권한 주기
--해당 object의 소유자 계정에서 권한을 부여하거나 박탈할 수 있다
--testuser3에게 hr 계정의 employees 테이블을 조회하고 수정할 수 있는 권한 부여
--(hr계정에서 처리 가능)
grant select on hr.employees to testuser3;

--select권한 박탈
revoke select on hr.employees from testuser3;

--update권한 부여
grant update on hr.employees to testuser3;

--update권한 박탈
revoke update on hr.employees from testuser3;

/*
    testuser3 계정에서 처리
    
    update hr.employees
    set salary=20000
    where employee_id=100;
*/

/*
with grant option
-권한을 위임하는 기능
또 다른 사용자에게 권한을 할당해 줄 수 있게 됨
object 권한에서 사용
*/

grant resource, connect to testuser4;

revoke select on hr.employees from testuser3;

grant select on hr.employees to testuser3 with grant option;

/*
testuser3에서 처리
grant select on hr.employes to testuser4;
=> testuser3 계정이 testuser4계정에게 hr의 employees에 select 할 수 있는 권한을 부여함

=> testuser4로 접속해서 hr의 employees를 select하면 조회됨
*/

/*
with admin option
- 권한을 위임하는 기능
또 다른 사용자에게 권한을 할당해줄 수 있게 됨
system 권한에서 사용
*/

grant resource, connect to testuser5 with admin option;

/*
testuser5로 접속해서 testuser6에게 resource, connect 권한 부여하기
grant resource, connect to testuser6;
*/

select * from user_views;
select * from hr.v_emp;

--hr계정의 v_emp뷰에 select 할 수 있는 권한을 testuser6에게 부여하기
grant select on hr.v_emp to testuser6;

--data dictionary
/*
 -데이터베이스 내에 저장된 모든 객체의 정보를 제공해주는 테이블
 
 Data Dictionary의 종류
 1)DBA_XXX : 데이터베이스 관리를 위한 정보 제공
 2)ALL_XXX :자신이 생성한 object와 다른 사용자가 생성한 object중에 자신이 볼 수 있는 정보를 제공
            -사용자가 접근 가능한 모든 스키마의 정보를 제공
            -권한을 부여받음으로써 가능
 3)USER_XXX : 자신이 생성한 object 정보를 제공
              현재 데이터베이스에서 접속한 사용자가 소유한 객체의 정보를 제공
     
*/

--모든 자료의 사전의 정보를 출력
select * from dictionary where table_name like 'USER_%';
select * from dictionary where table_name like 'DBA_US%';

--자료사전 테이블의 각 컬럼에 대한 설명을 출력
select * from dict_columns
where table_name='USER_CONS_COLUMNS';

select * from USER_CONS_COLUMNS;

--[1]User_XXX
select * from user_objects;
select * from user_tables;

select * from user_constraints;
select * from user_cons_columns;

select * from user_indexes;
select * from user_ind_columns;

select * from user_sequences;
select * from user_views;
select * from user_source;

--[2] all_XXX
select owner, table_name
from all_tables where table_name='EMPLOYEES';


--[3] dba_XXX
select * from dba_users;
select * from dba_data_files;
select * from dba_tablespaces;

select * from dba_roles;
select * from dba_sys_privs;
select * from dba_role_privs;