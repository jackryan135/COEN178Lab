Create or Replace Function calcSalaryRaise( p_name in AlphaCoEmp.name%type, percentRaise IN Integer)
RETURN NUMBER
IS

    l_salary AlphaCoEmp.salary%type;
    l_raise AlphaCoEmp.salary%type;
    l_cnt Integer;
BEGIN
    -- Find the current salary of p_name from AlphaCoEMP table.
    Select salary into l_salary from AlphaCoEmp
    where name = p_name;
-- Calculate the raise amount
    l_raise := l_salary * (percentRaise/100);
      /* return a value from the function */
    return l_raise;
END;
/
Show Errors;


SELECT calcSalaryRaise('Stone', 2) FROM Dual;

SELECT name, title, salary CURRENTSALARY, trunc(calcSalaryRaise(name, 2)) NEWSALARY FROM AlphaCoEmp WHERE upper(name) = upper('Stone');
