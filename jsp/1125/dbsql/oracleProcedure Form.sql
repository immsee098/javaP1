create or replace procedure delete_reboard  --���ν��� �̸� 
(
--�Ű�����

)
is
--���������

begin
--ó���� ����
    
    commit;

EXCEPTION
    WHEN OTHERS THEN
	raise_application_error(-20001, ' ����!');
        ROLLBACK;
end;