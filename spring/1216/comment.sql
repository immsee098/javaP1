--�ڸ�Ʈ ���̺�

/*
--drop table comments cascade constraint;

CREATE TABLE comments (
    no                number        primary key,    --��ȣ
    name             varchar2(20)    not null,            --�̸�    
    pwd              varchar2(20)    not null,            --��й�ȣ
    regdate         date        default  sysdate,    --�ۼ���
    content         varchar2(2000)         null,            --����
    bdNo            number references board(no) on delete cascade not null        --���� �Խ��� �۹�ȣ    
    --boardName	varchar2(50)		null	-- �Խ����̸� : reboard, upboard
);

--drop sequence comments_seq;
create sequence comments_seq
increment by 1
start with 1
nocache;

select * from comments;
*/

--drop table comment2 cascade constraint;

CREATE TABLE comment2 (
    comment_no                number        primary key,    --��ȣ
    user_id             varchar2(20)    not null,                
    reg_date         date        default  sysdate,    --�ۼ���
    comment_content         varchar2(2000)         null            --����   
);

--drop sequence comment2_seq;
create sequence comment2_seq
increment by 1
start with 1
nocache;

select * from comment2;

insert into comment2(comment_no, user_id, comment_content)
values(comment2_seq.nextval, 'hong', 'test');

insert into comment2(comment_no, user_id, comment_content)
values(comment2_seq.nextval, 'kim', 'test2');

commit;