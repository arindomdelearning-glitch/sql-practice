-- ==========================================================
-- SQL PRACTICE QUESTIONS - 180 DAYS (BASIC → ADVANCED)
-- Based on your ER Diagram:
-- Employees, Departments, Customers, Orders, OrderItems, Products, UserLogins
-- ==========================================================


----------------------------------------------------------
-- MONTH 1 – CORE SQL & JOINS (Days 1–30)
----------------------------------------------------------

-- Day 1
-- Q1: Select all columns from Employees.
SELECT *
FROM [dbo].[Employees];

-- Q2: Select first_name, last_name, and salary from Employees.
SELECT  first_name,
        last_name,
        salary
FROM [dbo].[Employees];

-- Q3: Select all products with alias names for each column.
SELECT  product_id          AS ID,
        product_name        AS PRODUCTNAME,
        category            AS PRODUCTCATAGORY,
        unit_price          AS PRICE,
        is_active           AS ACTIVESTATUS
FROM [dbo].[Products];

-- Day 2
-- Q1: Employees with salary > 70000.
SELECT  emp_id              AS ID,
        first_name          AS FIRSTNAME,
        last_name           AS LASTNAME,
        salary              AS SALARY
FROM [dbo].[Employees]
WHERE salary > 70000;

-- Q2: Products with unit_price BETWEEN 100 AND 500.
SELECT  product_id          AS ID,
        product_name        AS PRODUCTNAME,
        unit_price          AS PRICE
FROM [dbo].[Products]
WHERE unit_price BETWEEN 100 AND 500;

-- Q3: Customers from country IN ('India','Germany').
SELECT *
FROM [dbo].[Customers]
WHERE COUNTRY IN ('India','Germany');

-- Day 3
-- Q1: Customers from India AND Active.
SELECT *
FROM [dbo].[Customers]
WHERE COUNTRY = 'India'
AND STATUS = 'Active';

-- Q2: Orders where status = 'Completed' OR 'Refunded'.
SELECT *
FROM [dbo].[Orders]
WHERE STATUS = 'Completed'
    OR STATUS = 'Refunded';

-- Q3: Employees NOT in department 2.
SELECT *
FROM [dbo].[Employees]
WHERE dept_id != 2
    OR dept_id IS NULL;

-- Day 4
-- Q1: Employees ordered by salary DESC.
SELECT *
FROM [dbo].[Employees]
ORDER BY salary DESC;

-- Q2: Customers ordered by signup_date ASC.
SELECT *
FROM [dbo].[Customers]
ORDER BY signup_date ASC;

-- Q3: Products ordered by category then price.
SELECT *
FROM [dbo].[Products]
ORDER BY category, unit_price; 

-- Day 5
-- Q1: Distinct job_titles.
SELECT DISTINCT job_title
FROM [dbo].[Employees];

-- Q2: Distinct dept_id values.
SELECT DISTINCT dept_id
FROM [dbo].[Employees];

-- Q3: Distinct customer countries.
SELECT DISTINCT country     AS Customer_Country
FROM [dbo].[Customers];

-- Day 6
-- Q1: Employee names in UPPER().
SELECT  UPPER(first_name)    AS FIRST_NAME,
        UPPER(last_name)     AS LAST_NAME
FROM [dbo].[Employees];

-- Q2: Length of first_name for all employees.
SELECT  LEN(first_name)      AS LENGTH_OF_FIRST_NAME,
        first_name
FROM [dbo].[Employees];

-- Q3: Concatenate first_name + last_name.
SELECT first_name + ' ' + last_name     AS EMPLOYEE_NAME
FROM [dbo].[Employees];

-- Day 7
-- Q1: Employees with salary > 60000 sorted by hire_date.
SELECT  first_name + ' ' + last_name     AS EMPLOYEE_NAME,
        salary,
        hire_date
FROM [dbo].[Employees]
WHERE salary > 60000
ORDER BY hire_date DESC;

-- Q2: Active customers whose name starts with 'A'.
SELECT *
FROM [dbo].[Customers]
WHERE   status = 'Active'
    AND customer_name LIKE 'A%'; 

-- Q3: Products priced > 200 sorted by name.
SELECT *
FROM [dbo].[Products]
WHERE unit_price > 200
ORDER BY product_name DESC;

-- Day 8
-- Q1: Count number of employees.
SELECT COUNT(emp_id)
FROM [dbo].[Employees];

-- Q2: Max salary in Employees.
SELECT MAX(salary)  AS MAX_SALARY
FROM [dbo].[Employees];

-- Q3: Avg unit_price from Products.
SELECT AVG(unit_price)  AS AVG_UNIT_PRICE
FROM [dbo].[Products];

-- Day 9
-- Q1: Count active customers.
SELECT COUNT(*)
FROM [dbo].[Customers]
WHERE status = 'Active'

-- Q2: Count orders in last 1 year.
SELECT COUNT(*)     AS ORDER_COUNT
FROM [dbo].[Orders]
WHERE order_date >= DATEADD(YEAR, -1, CAST(GETDATE() AS DATE))

-- Q3: Sum total_amount for completed orders.
SELECT SUM(total_amount)
FROM [dbo].[Orders]
WHERE status = 'Completed'

-- Day 10
-- Q1: Count employees per dept_id.
SELECT  dept_id             AS DEPT_ID,
        COUNT(emp_id)       AS EMP_COUNT
FROM [dbo].[Employees]
GROUP BY dept_id;

-- Q2: Count customers per country.
SELECT  country,
        COUNT(customer_id)      AS CUST_COUNT
FROM [dbo].[Customers]
GROUP BY country

-- Q3: Count products per category.
SELECT  category,
        COUNT(product_id)
FROM [dbo].[Products]
GROUP BY category


-- Day 11
-- Q1: Departments with more than 3 employees.
SELECT  DEPT_ID
FROM [dbo].[Employees]
GROUP BY dept_id
HAVING COUNT(emp_id) > 3

-- Q2: Countries with more than 1 customer.
SELECT country
FROM [dbo].[customers]
GROUP BY country
having count(customer_id) > 1

-- Q3: Product categories with avg price > 200.
SELECT  category
FROM [dbo].[Products]
GROUP BY category
HAVING AVG(unit_price) > 200

-- Day 12
-- Q1: Employees count per (dept_id, job_title).
SELECT  dept_id,
        job_title,
        COUNT(emp_id)   AS EMP_COUNT
FROM [dbo].[Employees]
GROUP BY dept_id,
         job_title
ORDER BY dept_id

-- Q2: Orders count per (customer_id, status).
SELECT  customer_id,
        Status,
        Count(order_id)     AS ORDER_COUNT
FROM [dbo].[Orders]
GROUP BY customer_id,
         status
ORDER BY customer_id

-- Q3: Revenue per (customer_id, order_date).
SELECT  customer_id,
        CAST(order_date AS DATE)    AS ORDER_DATE,
        SUM(total_amount)           AS REVENUE
FROM [dbo].[Orders]
GROUP BY customer_id,
         CAST(order_date AS DATE)
ORDER BY customer_id,
         CAST(order_date AS DATE)   

-- Day 13
-- Q1: Employees with department names.
SELECT  EMP.first_name+' '+EMP.last_name     AS EMP_NAME,
        DEPT.Dept_name                       AS DEPARTMENT_NAME
FROM [dbo].[employees]              AS EMP
LEFT JOIN [dbo].[departments]       AS DEPT
     ON EMP.dept_id = DEPT.dept_id
ORDER BY EMP_NAME


-- Q2: Orders with customer names.
SELECT  CUST.customer_name,
        ORD.order_id
FROM [dbo].[Orders]             AS ORD
LEFT JOIN [dbo].[Customers]     AS CUST
    ON ORD.customer_id = CUST.customer_id
ORDER BY CUST.customer_name

-- Q3: OrderItems with product names.
SELECT  ORDI.order_item_id  AS ORDER_ITEM,
        P.product_name      AS PRODUCT_NAME
FROM [dbo].[OrderItems]     AS ORDI 
LEFT JOIN [dbo].[Products]  as P
    ON ORDI.product_id = P.product_id
ORDER BY ORDI.order_item_id

-- Day 14
-- Q1: Customer, product, quantity for each order item.
SELECT  ORDI.order_item_id          AS ORDER_ITEM,
        CUST.customer_name          AS CUSTOMER_NAME,
        P.product_name              AS PRODUCT_NAME,
        ORDI.quantity               AS ORDER_QUANTITY
FROM [dbo].[OrderItems]             AS ORDI
INNER JOIN [dbo].[Orders]           AS ORD
    ON ORDI.order_id = ORD.order_id
LEFT JOIN [dbo].[Customers]         AS CUST
    ON ORD.customer_id = CUST.customer_id
LEFT JOIN [dbo].[Products]          AS P
    ON ORDI.product_id = P.product_id
ORDER BY ORDI.order_item_id,
         CUST.customer_name,
         P.product_name,
         ORDI.quantity

-- Q2: Employee, department, salary.
SELECT  EMP.first_name+' '+EMP.last_name     AS EMP_NAME,
        DEPT.Dept_name                       AS DEPARTMENT_NAME,
        EMP.salary                           AS SALARY
FROM [dbo].[employees]              AS EMP
LEFT JOIN [dbo].[departments]       AS DEPT
     ON EMP.dept_id = DEPT.dept_id
ORDER BY EMP_NAME,
         DEPARTMENT_NAME,
         SALARY

-- Q3: Customer, order_date, total_amount.
SELECT CUST.customer_name               AS CUSTOMER_NAME,
       CAST(ORD.order_date  AS DATE)    AS ORDER_DATE,
       ORD.total_amount                 AS TOTAL_AMOUNT
FROM [dbo].[Orders]                     AS ORD
 LEFT JOIN [dbo].[Customers]            AS CUST
    ON ORD.customer_id = CUST.customer_id

-- Day 15
-- Q1: All customers and orders (LEFT JOIN).
SELECT CUST.customer_name           AS CUSTOMER_NAME,
       CUST.country                 AS COUNTRY,
       CUST.status                  AS ACTIVE_STATUS,
       ORD.order_id                 AS ORDER_ID,
       CAST(ORD.order_date AS DATE) AS ORDER_DATE,
       ORD.total_amount             AS TOTAL_COST,
       ORD.status                   AS ORDER_STATUS
FROM [dbo].[customers]          AS CUST
LEFT JOIN [dbo].[Orders]        AS ORD
    ON CUST.customer_id = ORD.customer_id
ORDER BY CUST.customer_name

-- Q2: All departments and employees.
SELECT  DEPT.Dept_name                       AS DEPARTMENT_NAME,
        DEPT.location                        AS DEPT_LOCATION,
        EMP.first_name+' '+EMP.last_name     AS EMP_NAME
FROM [dbo].[departments]       AS DEPT
LEFT JOIN [dbo].[employees]    AS EMP
     ON  DEPT.dept_id = EMP.dept_id
ORDER BY DEPARTMENT_NAME,
         EMP_NAME
        
-- Q3: All products and order items.
SELECT  P.product_id,
        P.product_name,
        P.category,
        P.unit_price,
        ORDI.order_id,
        ORDI.order_item_id,
        ORDI.quantity
FROM [dbo].[Products]           AS P
LEFT JOIN [dbo].[OrderItems]    AS ORDI
       ON P.product_id = ORDI.product_id;

-- Day 16
-- Q1: FULL JOIN on Employees–Departments.
SELECT  EMP.first_name+' '+EMP.last_name    AS EMP_NAME,
        DEPT.dept_name                      AS DEPARTMENT_NAME,
        EMP.job_title                       AS JOB_TITLE,
        EMP.salary                          AS SALARY,
        EMP.hire_date                       AS HIRE_DATE,
        DEPT.[location]                     AS DEPT_LOCATION
FROM [dbo].[Employees]          AS EMP
FULL JOIN [dbo].[Departments]   AS DEPT
    ON EMP.dept_id = DEPT.dept_id
ORDER BY COALESCE(EMP.first_name+' '+EMP.last_name, DEPT.dept_name)

-- Q2: FULL JOIN on Customers–Orders.
SELECT  CUST.customer_name              AS CUSTOMER_NAME,
        CUST.signup_date                AS SIGNUP_DATE,
        CUST.country                    AS COUNTRY,
        CUST.[status]                   AS CUST_STATUS,
        ORD.order_id                    AS ORDER_NO,
        CAST(ORD.order_date AS DATE)    AS ORDER_DATE,
        ORD.[status]                    AS ORDER_STATUS,
        ORD.total_amount                AS TOTAL_AMOUNT  
FROM [DBO].[Customers]      AS CUST
FULL JOIN [dbo].[Orders]    AS ORD
    ON CUST.customer_id = ORD.customer_id
ORDER BY COALESCE(CUST.customer_name, 'Unknown Customer');

-- Q3: FULL JOIN on Products–OrderItems.
SELECT  P.product_name      AS PRODUCT_NAME,
        P.category          AS PRODUCT_CATEGORY,
        P.unit_price        AS PRODUCT_UNIT_PRICE,
        P.is_active         AS PRODUCT_STATUS,
        ORDI.quantity       AS QUANTITY,
        ORDI.unit_price     AS ORDER_ITEM_UNIT_PRICE
FROM [dbo].[Products]       AS P
FULL JOIN dbo.OrderItems    AS ORDI
    ON P.product_id = ORDI.product_id
ORDER BY COALESCE(P.product_name, 'Unknown Product');

-- Day 17
-- Q1: Employee–department join using aliases.
SELECT  EMP.first_name+' '+EMP.last_name    AS EMP_NAME,
        DEPT.dept_name                      AS DEPARTMENT_NAME,
        EMP.job_title                       AS JOB_TITLE,
        EMP.salary                          AS SALARY,
        EMP.hire_date                       AS HIRE_DATE,
        DEPT.[location]                     AS DEPT_LOCATION
FROM [dbo].[Employees]          AS EMP
LEFT JOIN [dbo].[Departments]   AS DEPT
    ON EMP.dept_id = DEPT.dept_id
ORDER BY COALESCE(EMP.first_name+' '+EMP.last_name, DEPT.dept_name)

-- Q2: Customer–order join using aliases.
SELECT  CUST.customer_name              AS CUSTOMER_NAME,
        CUST.signup_date                AS SIGNUP_DATE,
        CUST.country                    AS COUNTRY,
        CUST.[status]                   AS CUST_STATUS,
        ORD.order_id                    AS ORDER_NO,
        CAST(ORD.order_date AS DATE)    AS ORDER_DATE,
        ORD.[status]                    AS ORDER_STATUS,
        ORD.total_amount                AS TOTAL_AMOUNT
FROM [dbo].[customers]          AS CUST
LEFT JOIN [dbo].[orders]        AS ORD
    ON CUST.customer_id = ORD.customer_id
ORDER BY COALESCE(CUST.customer_name, 'Unknown Customer')

-- Q3: Product–order_items join using aliases.
SELECT P.product_name      AS PRODUCT_NAME,
        P.category          AS PRODUCT_CATEGORY,
        P.unit_price        AS PRODUCT_UNIT_PRICE,
        P.is_active         AS PRODUCT_STATUS,
        ORDI.quantity       AS QUANTITY,
        ORDI.unit_price     AS ORDER_ITEM_UNIT_PRICE
FROM [dbo].[products]       AS P
LEFT JOIN dbo.OrderItems    AS ORDI
    ON P.product_id = ORDI.product_id
ORDER BY COALESCE(P.product_name, 'Unknown Product')

-- Day 18
-- Q1: Employee–manager pairs.
-- Q2: Employees who manage others.
-- Q3: Employees sorted by manager_id.

-- Day 19
-- Q1: Total revenue per customer.
-- Q2: Total salary per department.
-- Q3: Total quantity sold per product.

-- Day 20
-- Q1: Customers with total spending > 2000.
-- Q2: Departments with more than 2 employees.
-- Q3: Products sold more than 10 units.

-- Day 21
-- Q1: Customers with latest order date.
-- Q2: Products with total quantity sold (including zero).
-- Q3: Departments with employee count and avg salary.

-- Day 22
-- Q1: First 3 letters of product_name.
-- Q2: TRIM a sample text field.
-- Q3: Extract domain from sample email.

-- Day 23
-- Q1: Orders placed in last 30 days.
-- Q2: Extract month from order_date.
-- Q3: Employees hired in 2020.

-- Day 24
-- Q1: Salary category using CASE.
-- Q2: Order amount bucket (Small/Medium/Large).
-- Q3: Product category: Expensive/Normal.

-- Day 25
-- Q1: Replace NULL manager_id with 0.
-- Q2: Replace NULL total_amount with 0.
-- Q3: Identify customers with NULL signup_date.

-- Day 26
-- Q1: Combine UPPER + SUBSTRING on product_name.
-- Q2: Format full_name using CONCAT and LOWER.
-- Q3: Years of service for employees.

-- Day 27
-- Q1: Employees earning > avg salary.
-- Q2: Customers with spending > avg spending.
-- Q3: Products priced > avg price.

-- Day 28
-- Q1: Customers with order_count column.
-- Q2: Products with total_sold column.
-- Q3: Departments with employee_count column.

-- Day 29
-- Q1: Top 5 customers by spending using subquery in FROM.
-- Q2: Product category revenue ranking.
-- Q3: Highest salary department using subquery.

-- Day 30
-- Q1: JOIN + GROUP BY + HAVING query.
-- Q2: CASE + DATE functions query.
-- Q3: JOIN + subquery + ORDER BY query.


----------------------------------------------------------
-- MONTH 2 – SUBQUERIES, CTEs, SET OPS, DML (Days 31–60)
----------------------------------------------------------

-- Day 31
-- Q1: Employees with salary > dept average (correlated).
-- Q2: Products priced > category average.
-- Q3: Customers with spending > country average.

-- Day 32
-- Q1: Customers who have orders (EXISTS).
-- Q2: Departments that have employees.
-- Q3: Products that have order items.

-- Day 33
-- Q1: Products never ordered (NOT EXISTS).
-- Q2: Customers without orders.
-- Q3: Employees without departments.

-- Day 34
-- Q1: Rewrite customer-with-orders using IN.
-- Q2: Rewrite same using EXISTS.
-- Q3: Compare results.

-- Day 35
-- Q1: Employees earning > ALL salaries in dept 3.
-- Q2: Products cheaper than ANY in category 'Electronics'.
-- Q3: Customers who spent more than ALL customers in Sweden.

-- Day 36
-- Q1: UNION active + inactive customers.
-- Q2: UNION employees from dept 1 & dept 2.
-- Q3: UNION ALL same and compare.

-- Day 37
-- Q1: Demonstrate UNION vs UNION ALL duplicates.
-- Q2: Filter duplicates after UNION ALL.
-- Q3: Count duplicates before & after UNION.

-- Day 38
-- Q1: INTERSECT customers in India AND Germany (emails).
-- Q2: INTERSECT product names across 2 lists.
-- Q3: INTERSECT login users across two months.

-- Day 39
-- Q1: EXCEPT customers in table A not in B.
-- Q2: EXCEPT products missing in another list.
-- Q3: EXCEPT employees absent from department mapping.

-- Day 40
-- Q1: Find duplicate customer names.
-- Q2: Find duplicate employees by first+last+hire_date.
-- Q3: Find duplicate products by name.

-- Day 41
-- Q1: Insert new customer (VALUES).
-- Q2: Insert products using INSERT SELECT.
-- Q3: Insert dummy login records.

-- Day 42
-- Q1: Update salary by 10% for dept 2.
-- Q2: Change order status from Pending to Completed.
-- Q3: Update product price for Electronics.

-- Day 43
-- Q1: Delete test customer.
-- Q2: Delete orders older than year X.
-- Q3: Delete products that are inactive.

-- Day 44
-- Q1: Preview rows before UPDATE using SELECT.
-- Q2: Preview rows before DELETE.
-- Q3: Preview rows for salary change.

-- Day 45
-- Q1: Create simple CTE for dept-wise salary.
-- Q2: Rewrite subquery as CTE.
-- Q3: Use CTE + filter.

-- Day 46
-- Q1: Recursive CTE: manager hierarchy.
-- Q2: Recursive customer referral chain (dummy).
-- Q3: Recursive date generator.

-- Day 47
-- Q1: CTE + aggregation for customer revenue.
-- Q2: CTE + join for product summary.
-- Q3: CTE + HAVING for top categories.

-- Day 48
-- Q1: Refactor nested query into CTE 1.
-- Q2: Refactor nested query into CTE 2.
-- Q3: Refactor nested query into CTE 3.

-- Day 49
-- Q1: Negative amounts in Orders.
-- Q2: Invalid dates (future signup_date).
-- Q3: Amount mismatch in OrderItems.

-- Day 50
-- Q1: Orders without customers.
-- Q2: OrderItems without orders.
-- Q3: Products referenced by OrderItems but inactive.

-- Day 51
-- Q1: Design 3 dummy tables.
-- Q2: Write sample joins.
-- Q3: Write sample aggregates.

-- Day 52
-- Q1: BEGIN–COMMIT demo.
-- Q2: ROLLBACK demo.
-- Q3: Transaction-safe update.

-- Day 53
-- Q1: CREATE TABLE with constraints.
-- Q2: Add CHECK constraint.
-- Q3: Add FOREIGN KEY constraint.

-- Day 54
-- Q1: Stored procedure: get orders by customer.
-- Q2: Procedure: update salaries.
-- Q3: Procedure: delete inactive products.

-- Day 55
-- Q1: Create a query that double-counts (bad JOIN).
-- Q2: Fix the double-counting.
-- Q3: Compare results.

-- Day 56
-- Q1: Rewrite correlated subquery as JOIN.
-- Q2: Rewrite JOIN as subquery.
-- Q3: Compare performance mentally.

-- Day 57
-- Q1: CTE to generate temp table.
-- Q2: Transform temp table data.
-- Q3: Final report.

-- Day 58
-- Q1: Highest earning department.
-- Q2: Customer with max orders.
-- Q3: Product with highest revenue.

-- Day 59
-- Q1: Mix JOIN + CTE.
-- Q2: Mix subquery + GROUP BY.
-- Q3: Mix EXISTS + HAVING.

-- Day 60
-- Q1: Write 2 queries on topics you find hard.
-- Q2: Same with JOIN + GROUP BY.
-- Q3: Same with window functions prep.


----------------------------------------------------------
-- MONTH 3 – WINDOW FUNCTIONS (Days 61–90)
----------------------------------------------------------

-- Day 61
-- Q1: SUM() OVER() grand total.
-- Q2: SUM() OVER() per product.
-- Q3: SUM() OVER() per customer.

-- Day 62
-- Q1: ROW_NUMBER() by salary.
-- Q2: ROW_NUMBER() by hire_date.
-- Q3: ROW_NUMBER() by product price.

-- Day 63
-- Q1: ROW_NUMBER() PARTITION BY dept_id.
-- Q2: ROW_NUMBER() PARTITION BY category.
-- Q3: ROW_NUMBER() PARTITION BY country.

-- Day 64
-- Q1: RANK() salary per dept.
-- Q2: DENSE_RANK() salary per dept.
-- Q3: Compare RANK vs DENSE_RANK.

-- Day 65
-- Q1: NTILE(4) for customer revenue.
-- Q2: NTILE(10) for order count.
-- Q3: NTILE(5) for salary.

-- Day 66
-- Q1: Running total revenue per customer.
-- Q2: Running total quantity per product.
-- Q3: Running total order count.

-- Day 67
-- Q1: Running count of orders.
-- Q2: Running count of logins.
-- Q3: Running count of employees hired.

-- Day 68
-- Q1: LAG() order amount change.
-- Q2: LAG() login gap.
-- Q3: LAG() salary change (dummy).

-- Day 69
-- Q1: LEAD() next order date.
-- Q2: LEAD() next login date.
-- Q3: LEAD() next product price change.

-- Day 70
-- Q1: FIRST_VALUE(order_date) per customer.
-- Q2: LAST_VALUE(order_date) per customer.
-- Q3: FIRST_VALUE(login_time) per customer.

-- Day 71
-- Q1: 3-day moving avg sales.
-- Q2: 7-day moving avg logins.
-- Q3: Moving avg quantity.

-- Day 72
-- Q1: Salary % of dept total.
-- Q2: Revenue % of total.
-- Q3: Qty sold % of total.

-- Day 73
-- Q1: Top 3 products by revenue.
-- Q2: Top 3 customers by revenue.
-- Q3: Top 3 departments by salary.

-- Day 74
-- Q1: LAG + running total.
-- Q2: RANK + AVG.
-- Q3: NTILE + SUM.

-- Day 75
-- Q1: CASE + LAG (trend).
-- Q2: CASE + salary band.
-- Q3: CASE + product band.

-- Day 76
-- Q1: JOIN + window revenue.
-- Q2: JOIN + window login count.
-- Q3: JOIN + window salary rank.

-- Day 77
-- Q1: Day-over-day sales.
-- Q2: Month-over-month revenue.
-- Q3: Login difference per customer.

-- Day 78
-- Q1: Identify gaps in orders.
-- Q2: Identify gaps in logins.
-- Q3: Identify gaps in product updates.

-- Day 79
-- Q1: Repeat group totals with window.
-- Q2: Repeat counts with window.
-- Q3: Repeat averages with window.

-- Day 80
-- Q1: Partition tuning—large groups.
-- Q2: Filter partitions for performance.
-- Q3: Avoid ORDER BY in large windows.

-- Day 81
-- Q1: KPIs—total revenue.
-- Q2: KPIs—active users.
-- Q3: KPIs—top product.

-- Day 82
-- Q1: Complex order-by window.
-- Q2: Multi-column window.
-- Q3: Multi-level sorting in windows.

-- Day 83
-- Q1: CTE + LAG.
-- Q2: CTE + ROW_NUMBER.
-- Q3: CTE + moving avg.

-- Day 84
-- Q1: Churn detection—gap > X days.
-- Q2: Churn detection—missing logins.
-- Q3: Churn detection—no orders.

-- Day 85
-- Q1: Salary band + rank.
-- Q2: Revenue band + rank.
-- Q3: Login band + rank.

-- Day 86
-- Q1: Mix ROW_NUMBER, LAG.
-- Q2: Mix RANK + SUM().
-- Q3: Mix NTILE + CASE.

-- Day 87
-- Q1: Subquery + window.
-- Q2: CTE + window.
-- Q3: Derived table + window.

-- Day 88
-- Q1: JOIN + GROUP BY + window.
-- Q2: Window + CASE + ORDER BY.
-- Q3: Window-based KPI reporting.

-- Day 89
-- Q1: Build full analytical query.
-- Q2: Optimise analytical query.
-- Q3: Rewrite analytical query.

-- Day 90
-- Q1: Explain ROW_NUMBER.
-- Q2: Explain LAG.
-- Q3: Explain NTILE.


----------------------------------------------------------
-- MONTH 4 – WAREHOUSING, MODELING, PERFORMANCE (Days 91–120)
----------------------------------------------------------

-- Day 91
-- Q1: Create star schema for sales.
-- Q2: Write daily sales query.
-- Q3: Write monthly sales query.

-- Day 92
-- Q1: Detect SCD Type 1 changes.
-- Q2: Detect SCD Type 2 changes.
-- Q3: Compare two dimension snapshots.

-- Day 93
-- Q1: Records in staging not in target.
-- Q2: Records in target not in staging.
-- Q3: Compare counts across layers.

-- Day 94
-- Q1: Reconcile row counts.
-- Q2: Reconcile revenue numbers.
-- Q3: Reconcile product quantities.

-- Day 95
-- Q1: Fact rows without dimensions.
-- Q2: Orphaned order items.
-- Q3: Orphaned employees.

-- Day 96
-- Q1: Negative amounts in Orders.
-- Q2: Invalid statuses.
-- Q3: Impossible dates.

-- Day 97
-- Q1: Extract bad rows into error table.
-- Q2: Identify null key violations.
-- Q3: Identify data type mismatches.

-- Day 98
-- Q1: Detect inserts for delta load.
-- Q2: Detect updates for delta load.
-- Q3: Detect deletes for delta load.

-- Day 99
-- Q1: Idempotent INSERT logic.
-- Q2: Idempotent UPDATE logic.
-- Q3: Idempotent MERGE logic.

-- Day 100
-- Q1: Soft delete pattern.
-- Q2: Find active/inactive records.
-- Q3: Soft delete reporting.

-- Day 101
-- Q1: Rows updated recently.
-- Q2: Rows inserted recently.
-- Q3: Rows changed in last X days.

-- Day 102
-- Q1: Aggregate fact by date.
-- Q2: Aggregate fact by product.
-- Q3: Aggregate fact by country.

-- Day 103
-- Q1: Daily → Monthly rollup.
-- Q2: Monthly → Yearly rollup.
-- Q3: Product → category rollup.

-- Day 104
-- Q1: Design bridge table.
-- Q2: Query via bridge table.
-- Q3: Many-to-many logic.

-- Day 105
-- Q1: Snapshot fact as-of date.
-- Q2: Compare two snapshots.
-- Q3: Snapshot vs transaction fact.

-- Day 106
-- Q1: Late-arriving dimension.
-- Q2: Fix retroactive changes.
-- Q3: Identify missing dimension rows.

-- Day 107
-- Q1: Normalize customer data.
-- Q2: Denormalize for reporting.
-- Q3: Compare performance.

-- Day 108
-- Q1: Query partitioned fact table.
-- Q2: Query last month partition.
-- Q3: Partition elimination demo.

-- Day 109
-- Q1: Which columns to index?
-- Q2: Compare indexed vs non-indexed.
-- Q3: Explain index scan vs seek.

-- Day 110
-- Q1: Refactor long JOIN query.
-- Q2: Improve readability.
-- Q3: Reduce nested subqueries.

-- Day 111
-- Q1: Track lineage of order amount.
-- Q2: Track lineage of product price.
-- Q3: Track lineage of customer country.

-- Day 112
-- Q1: Verify duplicate-free dimensions.
-- Q2: Validate fact row counts.
-- Q3: Validate total sums.

-- Day 113
-- Q1: Use date_dim multiple times.
-- Q2: Use product_dim multiple times.
-- Q3: Use customer_dim multiple times.

-- Day 114
-- Q1: Warehouse-style KPI query.
-- Q2: Warehouse-style summary table.
-- Q3: Warehouse-style drilldown.

-- Day 115
-- Q1: Optimise slow aggregate query.
-- Q2: Remove unnecessary joins.
-- Q3: Use proper filters.

-- Day 116
-- Q1: High-cardinality example.
-- Q2: Low-cardinality example.
-- Q3: Index selectivity example.

-- Day 117
-- Q1: Star join ordering.
-- Q2: Filter pushdown logic.
-- Q3: Dimension-driven filtering.

-- Day 118
-- Q1: JOIN + aggregate + filter.
-- Q2: JOIN large fact + small dim.
-- Q3: Fact–dimension multi-join.

-- Day 119
-- Q1: Build a small star schema.
-- Q2: Write 5 queries on it.
-- Q3: Add 2 calculated metrics.

-- Day 120
-- Q1: List all DW patterns learned.
-- Q2: Write 1 pattern-based query.
-- Q3: Write 1 validation query.


----------------------------------------------------------
-- MONTH 5 – BIG DATA SQL (Days 121–150)
----------------------------------------------------------

-- Day 121
-- Q1: External table from CSV.
-- Q2: External table from Parquet.
-- Q3: External table SELECT.

-- Day 122
-- Q1: Query Parquet columns.
-- Q2: Select fewer cols for performance.
-- Q3: Column pruning demo.

-- Day 123
-- Q1: Partition filter example.
-- Q2: Query specific partition.
-- Q3: Force full scan demo.

-- Day 124
-- Q1: CTAS summary table.
-- Q2: CTAS partitioned table.
-- Q3: CTAS rollup table.

-- Day 125
-- Q1: Handle missing columns.
-- Q2: Handle schema drift.
-- Q3: COALESCE on semi-structured.

-- Day 126
-- Q1: Extract JSON field.
-- Q2: Parse nested JSON.
-- Q3: JSON filtering.

-- Day 127
-- Q1: Flatten array records.
-- Q2: Explode nested list.
-- Q3: Multi-level explode.

-- Day 128
-- Q1: Bucket by customer_id.
-- Q2: Partition by date.
-- Q3: Hybrid bucket-partition.

-- Day 129
-- Q1: MERGE upsert new rows.
-- Q2: MERGE update existing rows.
-- Q3: MERGE delete rows.

-- Day 130
-- Q1: Incremental load by order_id.
-- Q2: Incremental load by date.
-- Q3: Full vs incremental strategy.

-- Day 131
-- Q1: CTAS snapshot of balances.
-- Q2: Snapshot as-of-date.
-- Q3: Compare two snapshots.

-- Day 132
-- Q1: Error bucket with rules.
-- Q2: Capture invalid JSON.
-- Q3: Capture NULL key rows.

-- Day 133
-- Q1: Handle late-arriving facts.
-- Q2: Update aggregates.
-- Q3: Adjust KPIs.

-- Day 134
-- Q1: Truncate-and-load summary table.
-- Q2: Incremental update summary.
-- Q3: Compare both approaches.

-- Day 135
-- Q1: Bronze query logic.
-- Q2: Silver query logic.
-- Q3: Gold query logic.

-- Day 136
-- Q1: Query wide denormalized table.
-- Q2: Compare vs normalized.
-- Q3: Choose best for reporting.

-- Day 137
-- Q1: Skewed join demo.
-- Q2: Avoid data skew.
-- Q3: Salt skewed key.

-- Day 138
-- Q1: Reduce scanned columns.
-- Q2: Filter early.
-- Q3: Avoid expensive expressions.

-- Day 139
-- Q1: Validate row count.
-- Q2: Validate sums.
-- Q3: Validate min/max.

-- Day 140
-- Q1: Add partition for new month.
-- Q2: Drop old partition.
-- Q3: Query partition meta.

-- Day 141
-- Q1: DAU from events table.
-- Q2: MAU from events table.
-- Q3: Retention calc.

-- Day 142
-- Q1: Count daily active users.
-- Q2: Count monthly active users.
-- Q3: Retention by cohort.

-- Day 143
-- Q1: Funnel step A→B.
-- Q2: Funnel drop-off.
-- Q3: Funnel completion rate.

-- Day 144
-- Q1: Page_view count per user.
-- Q2: Session calculation.
-- Q3: Bounce rate check.

-- Day 145
-- Q1: IoT sensor min/max.
-- Q2: Avg per device.
-- Q3: Hourly trends.

-- Day 146
-- Q1: Combine fact_events with customer_dim.
-- Q2: Event summary by type.
-- Q3: Event summary by device.

-- Day 147
-- Q1: Big-data KPI query.
-- Q2: Big-data rollup.
-- Q3: Big-data join.

-- Day 148
-- Q1: Bronze design.
-- Q2: Silver design.
-- Q3: Gold design.

-- Day 149
-- Q1: Explain SQL in pipeline.
-- Q2: Give 2 pipeline SQL examples.
-- Q3: Write pipeline-style transformation.

-- Day 150
-- Q1: Practice hard concept 1.
-- Q2: Practice hard concept 2.
-- Q3: Practice hard concept 3.


----------------------------------------------------------
-- MONTH 6 – INTERVIEW STYLE (Days 151–180)
----------------------------------------------------------

-- Day 151
-- Q1: Second highest salary.
-- Q2: Second highest order amount.
-- Q3: Second highest spending customer.

-- Day 152
-- Q1: Employees hired last N days.
-- Q2: Salary top 10%.
-- Q3: Salary bottom 10%.

-- Day 153
-- Q1: Customers with monthly orders for 3 months.
-- Q2: Customers with monthly orders for 6 months.
-- Q3: Customers missing a month.

-- Day 154
-- Q1: Customers who ordered once.
-- Q2: Customers who ordered multiple times.
-- Q3: Customers with no orders.

-- Day 155
-- Q1: Products never ordered.
-- Q2: Products ordered by all customers.
-- Q3: Products ordered by top 3 customers.

-- Day 156
-- Q1: Employees with >1 manager (data issue).
-- Q2: Employees with no manager.
-- Q3: Managers with >3 direct reports.

-- Day 157
-- Q1: Departments with no employees.
-- Q2: Employees without departments.
-- Q3: Departments with 1 employee.

-- Day 158
-- Q1: Highest salary per department.
-- Q2: Department with highest earner.
-- Q3: Overall highest salary.

-- Day 159
-- Q1: Monthly revenue.
-- Q2: MoM revenue change.
-- Q3: Highest revenue month.

-- Day 160
-- Q1: Customers who haven’t ordered in 60 days.
-- Q2: Customers who haven’t logged in 60 days.
-- Q3: Customers inactive for both.

-- Day 161
-- Q1: Orders with amount > 3x average.
-- Q2: Customers with anomaly spending.
-- Q3: Products with anomaly sales.

-- Day 162
-- Q1: Top 5% earners.
-- Q2: Top 5% customers.
-- Q3: Top 5% products by revenue.

-- Day 163
-- Q1: Active users last 30 days.
-- Q2: Inactive users last 30 days.
-- Q3: Users inactive but placed orders.

-- Day 164
-- Q1: Users who logged in but didn’t order.
-- Q2: Users who ordered but didn’t log in.
-- Q3: Users who logged in AND ordered.

-- Day 165
-- Q1: Employee tenure in years.
-- Q2: Group employees by tenure range.
-- Q3: Count employees per tenure band.

-- Day 166
-- Q1: 3-month rolling revenue.
-- Q2: 6-month rolling revenue.
-- Q3: Rolling revenue per customer.

-- Day 167
-- Q1: JOIN + window + CTE case 1.
-- Q2: JOIN + window + CTE case 2.
-- Q3: JOIN + window + CTE case 3.

-- Day 168
-- Q1: Compare source vs target.
-- Q2: List mismatched customer rows.
-- Q3: List mismatched order rows.

-- Day 169
-- Q1: Rows changed last X days.
-- Q2: Audit customers changed.
-- Q3: Audit orders changed.

-- Day 170
-- Q1: Identify slow query.
-- Q2: Suggest optimizations.
-- Q3: Suggest index strategies.

-- Day 171
-- Q1: Detect bad data using SQL.
-- Q2: Fix bad data using SQL.
-- Q3: Prevent bad data.

-- Day 172
-- Q1: Create window-function question.
-- Q2: Solve it.
-- Q3: Optimize solution.

-- Day 173
-- Q1: Create subquery question.
-- Q2: Solve it.
-- Q3: Optimize solution.

-- Day 174
-- Q1: Create DW join question.
-- Q2: Solve it.
-- Q3: Validate it.

-- Day 175
-- Q1: Create big-data question.
-- Q2: Solve it.
-- Q3: Validate it.

-- Day 176
-- Q1: Redo day 1 questions.
-- Q2: Redo day 40 questions.
-- Q3: Redo day 100 questions.

-- Day 177
-- Q1: Explain a complex query.
-- Q2: Explain another query.
-- Q3: Explain performance bottleneck query.

-- Day 178
-- Q1: Add your best query to portfolio.
-- Q2: Add another.
-- Q3: Add third.

-- Day 179
-- Q1: List your strongest SQL areas.
-- Q2: List your weakest areas.
-- Q3: Plan how to improve weak areas.

-- Day 180
-- Q1: Likely Sweden/Germany SQL interview question 1.
-- Q2: Likely SQL interview question 2.
-- Q3: Likely SQL interview question 3.

-- END OF FILE