SELECT first||last as full_name, salary FROM Staff_2010 WHERE salary = (SELECT max(salary) FROM Staff_2010);

SELECT last, salary FROM Staff_2010 WHERE salary = (SELECT salary FROM Staff_2010 WHERE last = 'Zichal');

SELECT last, salary FROM Staff_2010 WHERE salary = (SELECT salary FROM Staff_2010 WHERE UPPER(last) = 'ZICHAL');

SELECT last, salary FROM Staff_2010 WHERE salary IN (SELECT salary FROM Staff_2010 WHERE UPPER(last) = 'YOUNG');

SELECT count(salary) as SALARIES_100K_ABOVE FROM Staff_2010 WHERE salary > 100000;

SELECT salary, count(salary) as SALARIES_100K_ABOVE FROM Staff_2010 WHERE salary > 100000 group by salary;

SELECT salary, count(salary) as SALARIES_100K_ABOVE FROM Staff_2010 WHERE salary > 100000 group by salary HAVING count(salary) > 9;

SELECT last FROM Staff_2010 WHERE REGEXP_LIKE(last, '([aeiou])\1', 'i');

