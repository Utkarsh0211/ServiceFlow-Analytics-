# ServiceFlow Analytics  
## Operations-to-Cash Performance Intelligence

ServiceFlow Analytics is an end-to-end Business Analysis and Analytics project focused on improving visibility across the Operations-to-Cash lifecycle for a fictional field services company, **GreenScape Services Inc.**

The project demonstrates how operational data and financial data can be unified to identify invoicing delays, revenue exposure, collections risk, and cost overruns using SQL and Power BI.

> ⚠️ All data used in this project is synthetic and created solely for portfolio and demonstration purposes.

---

## Business Context

GreenScape Services Inc. operates in the landscaping and grounds maintenance industry, serving commercial clients through recurring maintenance and project-based work.

Although the intended workflow is straightforward  
**Job Completion → Invoicing → Payment Collection**,  
The organisation faces frequent breakdowns between Operations and Finance.

### Key Problems Addressed
- Completed jobs not invoiced on time
- Revenue exposure from unbilled work
- Late identification of overdue invoices
- Job cost overruns discovered too late
- Manual reconciliation between systems
- Delayed and unreliable leadership reporting

---

## Project Objectives

This project aims to:
- Track jobs end-to-end from execution to cash collection
- Identify completed but not invoiced work
- Quantify unbilled revenue exposure
- Monitor receivables health and overdue risk
- Highlight job-level cost variance
- Reduce manual reconciliation effort
- Provide leadership-ready performance dashboards

---

## Solution Overview

### Technology Stack
- **Database:** PostgreSQL  
- **Analytics:** SQL (joins, aggregations, window functions)  
- **Visualization:** Power BI  
- **Documentation:** BA artifacts (BRD, FRD, KPIs, Assumptions)

### Core Entities
- Jobs / Work Orders
- Customers
- Invoices
- Payments
- Job Costs
- Regions, Services, Status Dimensions

---

## Dashboards Overview

### Page 1 – Executive Summary  
High-level snapshot for leadership covering operational throughput, revenue exposure, and collections health.

![Executive Summary](dashboards/page_1_executive_summary.png)

**Key KPIs**
- Total Jobs
- Completed Jobs
- Completed but Not Invoiced
- Unbilled Revenue Exposure
- Days Sales Outstanding (DSO)
- Overdue Invoice Count

---

### Page 2 – Operational Performance  
Execution-focused view for Operations teams.

![Operational Performance](dashboards/page_2_operations_performance.png)

**Insights Covered**
- Job completion trends
- Job status distribution
- Job cycle time by region
- Service type performance
- Job-level drilldown

---

### Page 3 – Finance & Collections  
Receivables and cash flow monitoring for Finance.

![Finance & Collections](dashboards/page_3_finance_collections.png)

**Insights Covered**
- Average DSO vs target
- Outstanding and overdue invoices
- AR aging buckets
- Outstanding amount by region/service
- Invoice-level drilldown

---

### Page 4 – Reconciliation & Exceptions  
Exception-focused view highlighting operational-to-financial gaps.

![Reconciliation & Exceptions](dashboards/page_4_reconciliation_exceptions.png)

**Insights Covered**
- Completed but not invoiced jobs
- Unbilled revenue exposure
- Jobs with cost overruns
- Exception distribution by region/service

---

## Key Insights (Sample)

- **1,500 total jobs** processed
- **1,037 jobs completed**
- **73 completed jobs not invoiced**
- **$563K unbilled revenue exposure**
- Oldest unbilled job pending **344 days**
- **Average DSO: 29 days** (within target of <35 days)
- **$2.34M total outstanding receivables**
- **290 overdue invoices**
- **817 jobs with cost overruns**
- Highest job cost variance: **$23.6K**

---

## Recommendations

- Implement automated alerts for completed-but-not-invoiced jobs
- Prioritize invoicing for aged unbilled work
- Introduce early warning thresholds for cost overruns
- Monitor DSO and overdue trends weekly, not monthly
- Use exception dashboards as part of month-end close
- Reduce manual reconciliation through standardized KPIs

---

## Project Documentation

Detailed business and functional documentation is available in the `/documentation` folder:

- Business Requirements Document (BRD)
- Functional Requirements Document (FRD)
- Stakeholders, Scope & Assumptions
- KPI Definitions & Business Rules
- Data Dictionary
- Insights & Recommendations
- Testing Checklist
- User Stories

---

## Disclaimer

This project is a **portfolio case study**.  
GreenScape Services Inc. is fictional, and all data, metrics, and scenarios are simulated to reflect realistic business conditions.
