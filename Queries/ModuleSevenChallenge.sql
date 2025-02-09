--MODULE 7 CHALLEGE
--Doris B. Cohen
--April 2020


--Table 1 will contain the number of current employees who are about to retire, grouped by job title.
SELECT eti.emp_no, eti.first_name, eti.last_name, eti.salary, ti.from_date, ti.title
INTO timetoretire
FROM emptoo_info AS eti
INNER JOIN titles AS ti ON (eti.emp_no = ti.emp_no);

SELECT * FROM timetoretire;


--Remove duplicates
SELECT DISTINCT ON (ttr.emp_no) ttr.emp_no, ttr.first_name, ttr.last_name, ttr.salary, ttr.from_date, ttr.title
INTO recenttitle
FROM timetoretire as ttr
GROUP BY ttr.emp_no, ttr.first_name, ttr.last_name, ttr.salary, ttr.from_date, ttr.title
ORDER BY ttr.emp_no DESC;

SELECT * FROM recenttitle;


--Group by retirees by title
SELECT title, COUNT (title)
INTO grouptitleret
FROM recenttitle
GROUP BY title;

SELECT * FROM grouptitleret;

--Table 2 will list those employees from Table 1, born in 1965, who are eligible for the mentorship program.
SELECT emp.emp_no, emp.first_name, emp.last_name, emp.birth_date, emp.hire_date, ti.title, ti.from_date, ti.to_date
INTO mentoring
FROM employees AS emp
LEFT JOIN titles AS ti ON (emp.emp_no = ti.emp_no)
WHERE (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (ti.to_date = '9999-01-01')
ORDER BY emp.emp_no;

SELECT * FROM mentoring;


-- Partition the data to show only most recent title per employee
SELECT title, emp_no, first_name, last_name, from_date, to_date,
INTO titlepartition
FROM
(SELECT title, emp_no, first_name, last_name, from_date, to_date, 
 		ROW_NUMBER() OVER (PARTITION BY (emp_no) ORDER BY to_date DESC) rn
 	FROM mentoring
 ) tmp WHERE rn = 1
 ORDER BY emp_no;

SELECT * FROM titlepartition;


--Add salary to mentoring group table
SELECT tip.title, tip.emp_no, tip.first_name, tip.last_name, tip.from_date, tip.to_date, s.salary
INTO tipartsal
FROM titlepartition AS tip
INNER JOIN salaries AS s
ON tip.emp_no = s.emp_no;

SELECT * FROM tipartsal;
--END--

--Group by mentors by title
SELECT title, COUNT (title)
FROM tipartsal
GROUP BY title;