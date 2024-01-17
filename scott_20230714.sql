Create or replace Procedure Dept_Insert
(pdeptno  in dept.deptno%type, --괄호 안에 파라메타 쓸 수 있음
 pdname   in dept.dname% type,
 ploc     in dept.loc%type)
 IS
 --변수명
    vNumber number(2);
 begin
    Insert into dept values(Pdeptno, Pdname, Ploc);
    commit;
End;