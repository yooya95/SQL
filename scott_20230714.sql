Create or replace Procedure Dept_Insert
(pdeptno  in dept.deptno%type, --��ȣ �ȿ� �Ķ��Ÿ �� �� ����
 pdname   in dept.dname% type,
 ploc     in dept.loc%type)
 IS
 --������
    vNumber number(2);
 begin
    Insert into dept values(Pdeptno, Pdname, Ploc);
    commit;
End;