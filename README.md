# financial-loan-risk-and-profitability-analysis
End-to-end banking analytics project analyzing loan performance, default risk, and profitability using MySQL, Python (Pandas), and Power BI with advanced KPI and dashboard development.

🚀 Project Overview
This project presents a complete end-to-end financial loan analysis pipeline, focused on evaluating:
-Loan performance
-Credit risk exposure
-Good vs Bad loan segmentation
-Profitability analysis
-Portfolio health monitoring
The objective is to simulate a real-world banking / credit risk analytics workflow, integrating SQL, Python, and Power BI.

🎯 Business Problem
Financial institutions must continuously monitor loan portfolios to:
-Reduce default risk
-Improve credit underwriting decisions
-Optimize profitability
-Identify high-risk borrower segments
This project analyzes loan-level data to extract actionable insights that support credit risk strategy and portfolio management

🏗️ Project Architecture
Raw Data → MySQL (Cleaning & EDA) → Python (KPI & Risk Analysis) → Power BI (Interactive Dashboard)

1️⃣ MySQL – Data Cleaning & Exploratory Analysis
✔ Data Transformation
-Standardized date formats using STR_TO_DATE()
-Converted interest rate from percentage to numeric
-Created numeric employment length variable
-Removed invalid/null financial records
✔ Core SQL Analysis
-Total loan portfolio value
-Default rate calculation
-Profit estimation (SUM(payment) - SUM(loan_amount))
-Monthly loan issuance trend
-Geographic loan distribution
-Risk analysis by grade & purpose

🔥 Sample KPI Query
SELECT
    loan_status,
    COUNT(id) AS total_loans,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_amount_received,
    SUM(total_payment) - SUM(loan_amount) AS estimated_profit
FROM bank_loan_data
GROUP BY loan_status;

2️⃣ Python – KPI Development & Risk Analytics

Python was used for:
-Feature engineering
-Risk segmentation
# Good vs Bad loan classification
-KPI computation

Financial visualization

📌 Loan Classification

Good Loans → Fully Paid, Current

Bad Loans → Charged Off, Default, Late

df['loan_quality'] = df['loan_status'].apply(
    lambda x: 'Good Loan' if x in ['Fully Paid','Current'] else 'Bad Loan'
)

📊 Key KPIs Built in Python
-Total Loans
-Total Funded Amount
-Total Amount Received
-Default Rate (%)

# Good Loan %
-Estimated Profit
-Loan-to-Income Ratio
-Risk Category (Low / Medium / High DTI)

📈 Visual Analysis
-Loan Status Distribution
-Default Rate by Grade
-DTI vs Default (Boxplot)
-Interest Rate Distribution
-Monthly Loan Issuance Trend
#Good vs Bad Loan Comparis

3️⃣ Power BI – Executive Dashboard

An interactive dashboard was built to visualize:

📌 Executive KPIs
-Total Loans
-Total Funded Amount
-Total Payment Received
-Default Rate
-Estimated Profit

📌 Risk Analysis
-Default Rate by Grade
-Loan Purpose Risk
-Risk Category Exposure
-Geographic Loan Distribution

📌 Advanced DAX Measures
Default Rate (%) =
DIVIDE(
    CALCULATE(COUNT(bank_loan_data[id]),
              bank_loan_data[default_flag] = 1),
    COUNT(bank_loan_data[id])
)

📊 Key Insights

## Dashboard 1 :-   Portfolio Key Outcomes
-38.6K total loan applications
-$435.8M funded | $473.1M received (strong recovery)
-Default Rate: 13.8%
-80.6% loans fully paid
-Loan applications show a steady upward trend throughout the year
-60-month loans (73%) are most preferred
-Highest default risk: Small Business loans
-Higher grades (A & B) show significantly lower default rates

## Dashboard 2 :-  Overview Dashboard 
-Avg DTI: 13.3% → Borrowers maintain moderate debt levels.
-Avg Interest Rate: 12.05% → Balanced pricing strategy.
-Estimated Profit: $37.31M → Portfolio is generating strong returns.
-Defaulted Loans: 5K → Manageable but needs monitoring.
-Credit Grades: Lower grades (F & G) show significantly higher default rates, while A & B are low risk.
-Verification Status: ~42% loans are verified, improving credit reliability.
-Home Ownership: Most applications come from Rent (18K) and Mortgage (17K) customers.
-Geographical Spread: Loan volume is concentrated in a few high-performing states.

## Dashboard 3  :-  Summary Dashboard 
-Total Applications: 38.6K
-Total Funded: $435.8M | Total Received: $473.1M
-Overall Default Rate: 13.8%
- Good Loans (86.2%)
-33K applications
-$370.2M funded
-$435.8M received
👉 Strong repayment performance and healthy portfolio quality.
⚠ Bad Loans (13.8%)
-5K applications
-$65.5M funded
-$37.3M received
👉 Loss exposure exists but remains controlled.

## Recommendations to Increase Profit & Reduce Risk
-Focus on High-Grade Borrower
 Promote and prioritize Grade A & B customers (lowest default rates).
Offer loyalty benefits to retain low-risk borrowers.

-Tighten Risk on Small Business Loans
Since small business loans show highest default rate,
→ Apply stricter credit checks
→ Increase interest margin slightly
→ Improve monitoring after disbursement

-Target High-Performing States
Invest marketing budget in states with high repayment rates.
Reduce exposure in high-default regions

-Optimize Interest Pricing
Align interest rates with risk grades.
Higher-risk grades (F & G) → Risk-adjusted pricing.
Offer competitive rates for safer customers to increase volume.

-Increase Loan Verification
Promote full verification to reduce fraud and defaults.
Encourage documentation-based approvals.

-Promote 36-Month Loans
Encourage shorter-term loans to improve cash flow and reduce long-term risk


💰 Financial Impact
This analysis enables:
-Early identification of risky borrower segments
-Better loan approval strategies
-Improved capital allocation
-Profit optimization through risk control

🛠️ Tools & Technologies

MySQL – Data cleaning & aggregation

Python (Pandas, NumPy, Matplotlib, Seaborn) – Analytics & KPI modeling

Power BI (DAX) – Dashboard & Business Intelligence

📁 Project Structure
Financial-Loan-Analysis/
│
├── SQL/
│   ├── data_cleaning.sql
│   ├── loan_analysis_queries.sql
│
├── Python/
│   ├── Financial_Loan_Analysis.ipynb
│
├── PowerBI/
│   ├── Loan_Risk_Dashboard.pbix
│
├── PPT/
│   ├── Financial_Loan_Risk_Analysis_Project_Presentation.pptx
│
└── README.md
🎓 Skills Demonstrated

Data Cleaning & Transformation
-Credit Risk Analytics
-KPI Development
-Financial Performance Analysis
-SQL Aggregations & CASE Logic
-DAX Measure Development
-Data Visualization
-End-to-End Analytics Workflow

🏆 Why This Project Stands Out
-Unlike basic EDA projects, this work demonstrates:
-Business-driven thinking
-Financial domain understanding
-Portfolio-level KPI modeling
-Integration across multiple analytics tools
-Interview-ready explanations

This project is suitable for:
-Data Analyst (Finance)
-BI Analyst
-Credit Risk Analyst
-Banking Analytics Roles

📬 Author
Arya Gadade
Aspiring Data Analyst | Finance & Risk Analytics
LinkedIn: https://www.linkedin.com/in/arya-gadade
GitHub: https://github.com/arya-data-analyst



