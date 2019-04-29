Create or Replace Procedure DisplayMessage(message in VARCHAR)
As
BEGIN
        DBMS_OUTPUT.put_line('Hello '||message);

END;
/
Show Errors;

exec DisplayMessage('World!');

SELECT ROUND(DBMS_RANDOM.value(10, 100)) FROM DUAL;

SELECT * FROM AlphaCoEmp;

CREATE or REPLACE PROCEDURE setSalaries(low in INTEGER, high in INTEGER)
AS
Cursor Emp_cur IS
    SELECT * FROM AlphaCoEmp;

    l_emprec Emp_cur%rowtype;
    l_salary AlphaCoEmp.salary%type;
BEGIN
    for l_emprec IN Emp_cur
    loop
        l_salary := ROUND(DBMS_RANDOM.VALUE(low, high));

        update AlphaCoEmp
        set salary = l_salary
        where name = l_emprec.name;
    END LOOP;
    commit;
END;
/
show errors;

exec setSalaries(50000, 100000);

SELECT * FROM AlphaCoEmp;

SELECT name, salary FROM AlphaCoEmp WHERE salary BETWEEN 80000 AND 100000;

Create or Replace FUNCTION getEmpSalary(p_name in VARCHAR)
Return NUMBER IS
    l_salary AlphaCoEmp.salary%type;     -- Give the data type

BEGIN

    Select salary into l_salary
    from AlphaCoEmp where name = p_name;

    return l_salary;
END;
/
show errors;

SELECT getEmpSalary('Wilson') FROM Dual;

CREATE TABLE MyExpenses(
    CDate DATE PRIMARY KEY,
    Food Number(10,2),
    Transportation Number(10,2),
    MISC Number(10,2)
);

INSERT INTO MyExpenses VALUES ('28-APR-19', 12.00, 9.00, 29.00);
INSERT INTO MyExpenses VALUES ('29-APR-19', 10.00, 5.00, 30.00);
INSERT INTO MyExpenses VALUES ('30-APR-19', 15.00, 6.00, 10.00);
INSERT INTO MyExpenses VALUES ('01-MAR-19', 25.00, 8.00, 17.00);

Create or Replace Function getExpensesByDate(v_date In Date)
Return Number IS
    l_expense MyExpenses.Food%type;

    l_food MyExpenses.Food%type;
    l_transp MyExpenses.Transportation%type;
    l_misc MyExpenses.Misc%type;

BEGIN
    SELECT Food, Transportation, Misc INTO l_food, l_transp, l_misc FROM MyExpenses WHERE CDate = v_date;
    l_expense := l_food + l_transp + l_misc;
    return l_expense;

END;
/
show errors;

SELECT getExpensesByDate('01-MAR-19') FROM Dual;

Create or Replace Function getExpensesBetweenDates(v_fromdate In Date, v_toDate In Date)Return Number IS
    l_expense MyExpenses.Food%type;

    l_food MyExpenses.Food%type;
    l_transp MyExpenses.Transportation%type;
    l_misc MyExpenses.Misc%type;

    l_date Date;

BEGIN
    l_expense := 0;
    l_date := v_fromdate;
    WHILE l_date <= v_todate
    LOOP
        SELECT Food, Transportation, Misc INTO l_food, l_transp, l_misc FROM MyExpenses WHERE CDate = l_date;
        l_expense := l_expense + l_food + l_transp + l_misc;
        l_date := l_date + 1;
    END LOOP;
    return l_expense;
END;
/
show errors;

SELECT getExpensesBetweenDates('28-APR-19', '30-APR-19') FROM Dual;
