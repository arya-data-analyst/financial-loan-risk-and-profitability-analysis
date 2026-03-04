create database NovaTrust_Retail_Bank;

use NovaTrust_Retail_Bank;

select * from financial_loan;

select count(*) from financial_loan;

       -- DATA CLEANING & STANDARDIZATION (CRITICAL)
-- Create Clean Table
CREATE TABLE financial_loan_clean AS
SELECT
    id,
    member_id,
    UPPER(address_state) AS address_state,
    application_type,
    emp_title,

    CASE 
        WHEN emp_length = '10+ years' THEN 10
        WHEN emp_length = '< 1 year' THEN 0
        WHEN emp_length IS NULL THEN NULL
        ELSE CAST(SUBSTRING(emp_length,1,1) AS UNSIGNED)
    END AS emp_length_years,

    grade,
    sub_grade,
    home_ownership,
    STR_TO_DATE(issue_date, '%d-%m-%Y') AS issue_date,
    STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y') AS last_credit_pull_date,
    STR_TO_DATE(last_payment_date, '%d-%m-%Y') AS last_payment_date,
    STR_TO_DATE(next_payment_date, '%d-%m-%Y') AS next_payment_date,

    loan_status,
    purpose,
    term,
    verification_status,

    annual_income,
    dti,
    installment,
    REPLACE(int_rate,'%','')/100 AS int_rate,
    loan_amount,
    total_acc,
    total_payment
FROM financial_loan;

 -- Remove Invalid Records
 set sql_safe_updates = 0;
DELETE FROM financial_loan_clean
WHERE annual_income IS NULL
OR loan_amount IS NULL
OR dti IS NULL;

         -- CORE KPI'S
   --   1 Total Loans & Amount
   SELECT 
    COUNT(*) AS total_loans FROM financial_loan_clean;
   -- MTD LOAN APPLICANTION
   SELECT COUNT(id) AS Total_Applications FROM financial_loan_clean
WHERE MONTH(issue_date) = 12;
-- PMTD LOAN APPLICANTION
   SELECT COUNT(id) AS Total_Applications FROM financial_loan_clean
WHERE MONTH(issue_date) = 11;
   
         -- 2 TOTAL LOAN AMOUNT 
 select SUM(loan_amount) AS total_loan_amount from financial_loan_clean;
   -- MTD TOTAL LOAN AMOUNT
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan_clean
WHERE MONTH(issue_date) = 12;
  -- PMTD TOTAL LOAN AMOUNT
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM financial_loan_clean
WHERE MONTH(issue_date) = 11;
   
          -- 3 TOTAL PAYMENT RECEVIED
   select SUM(total_payment) AS total_payment_received FROM financial_loan_clean;
   -- MTD TOTAL PAYMENT RECEVIED
select SUM(total_payment) AS total_payment_received FROM financial_loan_clean 
where MONTH(issue_date) = 12 ;
  -- PMTD TOTAL PAYMENT RECEVIED
  select SUM(total_payment) AS total_payment_received FROM financial_loan_clean 
where MONTH(issue_date) = 11 ;
   
       -- Loan Status Distribution
SELECT 
    loan_status,
    COUNT(*) AS total_loans,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM financial_loan_clean
GROUP BY loan_status;

     -- Default Rate 
SELECT
    ROUND(
        SUM(CASE WHEN loan_status IN ('Charged Off','Default') THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS default_rate_percentage
FROM financial_loan_clean;

   -- Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM financial_loan_clean;
    -- MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM financial_loan_clean
WHERE MONTH(issue_date) = 12;
    -- PMTD Average Interest
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM financial_loan_clean
WHERE MONTH(issue_date) = 11;
 
      -- Avg DTI
SELECT AVG(dti)*100 AS Avg_DTI FROM financial_loan_clean;
     -- MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM financial_loan_clean
WHERE MONTH(issue_date) = 12;
      -- PMTD Avg DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM financial_loan_clean
WHERE MONTH(issue_date) = 11;
 
        -- CREDIT RISK ANALYSIS 
-- Default Rate by Grade
SELECT
    grade,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status IN ('Charged Off','Default') THEN 1 ELSE 0 END) AS default_loans,
    ROUND(
        SUM(CASE WHEN loan_status IN ('Charged Off','Default') THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*),
        2
    ) AS default_rate
FROM financial_loan_clean
GROUP BY grade
ORDER BY default_rate DESC;

       -- Purpose-wise Risk Analysis
SELECT
    purpose,
    COUNT(*) AS total_loans,
    ROUND(AVG(dti),2) AS avg_dti,
    ROUND(AVG(int_rate)*100,2) AS avg_interest_rate
FROM financial_loan_clean
GROUP BY purpose
ORDER BY avg_dti DESC;

        -- Income Segmentation Analysis
SELECT
    CASE
        WHEN annual_income < 50000 THEN 'Low Income'
        WHEN annual_income BETWEEN 50000 AND 100000 THEN 'Mid Income'
        ELSE 'High Income'
    END AS income_group,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amount),2) AS avg_loan_amount
FROM financial_loan_clean
GROUP BY income_group;

    -- REPAYMENT & PROFITABILITY ANALYSIS
-- Average Payment vs Loan Amount
SELECT
    ROUND(AVG(loan_amount),2) AS avg_loan,
    ROUND(AVG(total_payment),2) AS avg_payment
FROM financial_loan_clean;

       -- Profit Estimation
SELECT
    SUM(total_payment) - SUM(loan_amount) AS estimated_profit
FROM financial_loan_clean;

	   -- TIME-BASED ANALYSIS
-- Monthly Loan Issuance Trend
SELECT
    DATE_FORMAT(issue_date, '%Y-%m') AS issue_month,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount
FROM financial_loan_clean
GROUP BY issue_month
ORDER BY issue_month;

      -- GEOGRAPHICAL ANALYSIS
-- Top 10 States by Loan Amount
SELECT
    address_state,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount
FROM financial_loan_clean
GROUP BY address_state
ORDER BY total_loan_amount DESC
LIMIT 10;

        -- HIGH-RISK BORROWER IDENTIFICATION
SELECT *
FROM financial_loan_clean
WHERE dti > 40
AND loan_status IN ('Charged Off','Late');


          -- LOAN STATUS
	SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        financial_loan_clean
    GROUP BY
        loan_status;
 

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM financial_loan_clean
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

          -- GOOD LOAN ISSUED
-- Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM financial_loan_clean; 
 
-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM financial_loan_clean
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';
 
-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM financial_loan_clean
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM financial_loan_clean
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

            -- BAD LOAN ISSUED
-- Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM financial_loan_clean;
 
-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM financial_loan_clean
WHERE loan_status = 'Charged Off';
 
-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM financial_loan_clean
WHERE loan_status = 'Charged Off';
 
-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM financial_loan_clean
WHERE loan_status = 'Charged Off';
 



