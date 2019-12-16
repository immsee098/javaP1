--�ڷ�� ���̺�
drop table reboard  cascade constraint;
create table reboard
(
    no                number        primary key,    --��ȣ
    name         varchar2(20)    not null,            --�̸�    
    pwd              varchar2(20)    not null,            --��й�ȣ
    title             varchar2(100)   not  null,            --����
    email          varchar2(80)    null,            --�̸���
    regdate     date        default  sysdate,    --�ۼ���    
    readcount    number        default 0     null,        --��ȸ��
    content         clob         null,            --����
    groupNo            number          default 0,           --�׷��ȣ
    step           number           default 0,          --���� �ܰ� 
    sortNo         number           default 0,       --���� ���ļ���
    delFlag         char     default 'N',             --���� Flag
    fileName    varchar2(60)     null,                      --���ε����ϸ�
    fileSize    number            default 0,                      --���ϻ����� 
    downCount    number     default 0,            --�ٿ��
    originalFileName    varchar2(60)     null               --������ ���ϸ�	
);

drop sequence reboard_seq;
create sequence reboard_seq
increment by 1
start with 1
nocache;

select * from reboard order by no desc;

update reboard 
set downcount = downcount+1 
where no=2;

exec delete_reboard(2,2,0);

