'''

SELECT*
FROM HrDB..hrdata

/* OBJECTIVE:
Creating a database in SQL Server Management Studio, writing SQL query to QA the HR Analytics Dashboard developed using Tableau Desktop and MS Power BI.

	Function Validation – Test each feature work as per the requirement. To verify all the filters and Action filters on the report as per the requirement.

	Data Validation – Check the accuracy and quality of data. To match the values in Tableau and Power BI reports with SQL queries.


	Test Document – Create a Test document that will contain the screenshots and queries used to test the report.*/

--QUERIES:
--EMPLOYEE COUNT:

--Employee Count:
 
SELECT COUNT(emp_no) AS EmpCount
FROM HrDB..Hrdata

--Employee Count Department wise: 

SELECT department, COUNT(emp_no) AS EmpCount
FROM HrDB..Hrdata
GROUP BY department

--Employee Count Education wise:

SELECT education, COUNT(emp_no) AS EmpCount
FROM HrDB..Hrdata
GROUP BY education

--Employee Count Education field wise:

SELECT education_field, COUNT(emp_no) AS EmpCount
FROM HrDB..Hrdata
GROUP BY education_field


--Employee Count Gender wise:

SELECT gender, COUNT(emp_no) AS EmpCount
FROM HrDB..Hrdata
GROUP BY gender

Number of Employees Gender and Age Band wise:
SELECT gender,age_group_num ,age_band, COUNT(emp_no) AS EmpCount
FROM HrDB..Hrdata
GROUP BY gender,age_group_num
ORDER BY gender

--Employee count for each age:

SELECT age, SUM(employee_count) AS emp_for_each_age
FROM  HrDB..hrdata
GROUP BY age
ORDER BY age


--Employee count for each age band:

SELECT age_group_num,age_band, SUM(employee_count) AS emp_for_each_age
FROM  HrDB..hrdata
GROUP BY age_band,age_group_num
ORDER BY age_group_num



--ATTRITION COUNT:

--Attrition count:

SELECT COUNT(active_employee) AS attrition_count
FROM HrDB..hrdata
WHERE active_employee = 0

--Department wise attrition:

SELECT department, COUNT(active_employee) AS attrition_count
FROM HrDB..hrdata
WHERE active_employee = 0
GROUP BY department


--Education wise attrition:

SELECT education,COUNT(active_employee) AS attrition_count
FROM HrDB..hrdata
WHERE active_employee = 0 
GROUP BY education


--Education Field wise attrition:

SELECT education_field,COUNT(active_employee) AS attrition_count
FROM HrDB..hrdata
WHERE active_employee = 0 
GROUP BY education_field


--Gender wise attrition:

SELECT gender,COUNT(active_employee) AS attrition_count
FROM HrDB..hrdata
WHERE active_employee = 0 
GROUP BY gender


--Attrition Gender and age Band wise:

SELECT gender,age_band,COUNT(active_employee) AS attrition_count
FROM HrDB..hrdata
WHERE active_employee = 0 
GROUP BY gender, age_band
ORDER BY gender


--Attrition age wise:

SELECT age,COUNT(active_employee) AS attrition_count
FROM HrDB..hrdata
WHERE active_employee = 0 
GROUP BY age
ORDER BY age


--Attrition age band wise:

SELECT age_group_num,age_band,COUNT(active_employee) AS attrition_count
FROM HrDB..hrdata
WHERE active_employee = 0 
GROUP BY age_band, age_group_num
ORDER BY age_group_num




--ACTIVE EMPLOYEES WORKING IN THE COMPANY:     

--Active employees = (total employees – attrition) 

--Total Active Employee:

SELECT (COUNT(emp_no) - (SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes')) AS active_employees
FROM HrDB..hrdata


--Active employees Department wise:

SELECT (COUNT(emp_no) - (SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND department = 'Sales')) AS active_employees
FROM HrDB..hrdata
WHERE department = 'Sales'


--Active employees Education Field wise:

SELECT (COUNT(emp_no) - (SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND education_field = 'Medical')) AS active_employees
FROM HrDB..hrdata
WHERE education_field = 'Medical
'

--Active employees Education wise: 

SELECT (COUNT(emp_no) - (SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND education = 'High School'))
FROM HrDB..hrdata
WHERE education = 'High School'


--Active employees Gender wise:

SELECT (COUNT(emp_no) - (SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND gender = 'Female')) AS active_employees
FROM HrDB..hrdata
WHERE gender = 'Female'

--Active employees Gender and Age Band wise:

SELECT (COUNT(emp_no) - (SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND gender = 'Female' AND age_group_num = 1)) AS active_employees
FROM HrDB..hrdata
WHERE gender = 'Female' AND age_group_num = 1




--ATTRITION RATE:

--Attrition rate = (Attrition count)/(Total number of Employees)

--Attrition rate:

SELECT ROUND((SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes')/ SUM(employee_count)*100,2) AS attrition_rate
FROM HrDB..hrdata


--Attrition rate Department-wise:

SELECT ROUND((SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND department = 'Sales')/ SUM(employee_count)*100,2) AS attrition_rate
FROM HrDB..hrdata
WHERE department = 'Sales'


--Attrition rate Education-wise:

SELECT ROUND((SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND education = 'High School')/ SUM(employee_count)*100,2) AS attrition_rate
FROM HrDB..hrdata
WHERE education = 'High School'


--Attrition rate Education field wise:

SELECT ROUND((SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND education_field = 'Medical')/ SUM(employee_count)*100,) AS attrition_rate
FROM HrDB..hrdata
WHERE education_field = 'Medical'


--Attrition rate Gender wise:

SELECT ROUND((SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND gender = 'Male')/ SUM(employee_count)*100,2) AS attrition_rate
FROM HrDB..hrdata
WHERE gender = 'Male'


--Attrition rate Gender and Age band wise:

SELECT ROUND((SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND gender = 'Male' AND age_group_num = 1)/ SUM(employee_count)*100,2) AS attrition_rate
FROM HrDB..hrdata
WHERE gender = 'Male' AND age_group_num = 1


--Attrition age band wise:

SELECT ROUND((SELECT COUNT(attrition) FROM HrDB..hrdata WHERE attrition = 'Yes' AND age_group_num = 1)/ SUM(employee_count)*100,2) AS attrition_rate
FROM HrDB..hrdata
WHERE age_group_num=1



--AVERAGE AGE OF ALL EMPLOYEES:

--Avg Age =  sum(age of all employees)/(total number of emlpoyees)


--Average age of all employees combined:

SELECT ROUND(AVG(age),0) AS avg_age
FROM HrDB..hrdata


--Average age Department wise:

SELECT department, ROUND(AVG(age),0) AS avg_age
FROM HrDB..hrdata
GROUP BY department


--Average age Education wise:

SELECT education, ROUND(AVG(age),0) AS avg_age
FROM HrDB..hrdata
GROUP BY education


--Average age Education field wise:

SELECT education_field, ROUND(AVG(age),0) AS avg_age
FROM HrDB..hrdata
GROUP BY education_field


--Average age Gender wise:

SELECT gender, ROUND(AVG(age),0) AS avg_age
FROM HrDB..hrdata
GROUP BY gender



--PIVOT TABLE FOR JOB SATISFACTION RATING:

SELECT *  
FROM  
(SELECT job_role,job_satisfaction, SUM(employee_count) AS count_jobrating
FROM HrDB..hrdata
GROUP BY job_role,job_satisfaction
) AS pivottable  
PIVOT  
(  
    MAX(count_jobrating)  
FOR   
[job_satisfaction]   
    IN ([1],[2],[3],[4])  
) AS convertedtable



--CREATING A NEW COLUMN AND ASSIGNING VALUES TO AGE BANDS:

--Used to order the age band accordingly--

--Creating new column:

ALTER TABLE HrDB..hrdata
ADD age_group_num int


--Updating the values of the newly created column according to the age group:

UPDATE HrDB..hrdata
SET age_group_num = 1
WHERE age_band = 'Under 25';

'''