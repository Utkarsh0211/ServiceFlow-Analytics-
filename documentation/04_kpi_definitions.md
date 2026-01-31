KPI Definitions & Business Rules

## KPI 1: Invoice Handoff Delay (Completed Jobs)

### Business Question
Which completed jobs have not yet been invoiced, and how long have they been pending?

### Definition
This KPI identifies operational handoff delays between job completion and invoice creation.

### Business Logic
- A job is considered **Completed** when its job status is "COMPLETED".
- A job is considered **Invoiced** when it appears in at least one invoice line item.
- Any completed job without a linked invoice is classified as "Completed but Not Invoiced".
- Days Pending is calculated as:
Current Date − Job Completed Date
- Cancelled jobs are excluded from this KPI.

### Why This KPI Matters
This KPI exposes breakdowns between Operations and Finance, helping teams reduce invoicing delays, improve handoff discipline, and accelerate cash flow.

## KPI 2: Days Sales Outstanding (DSO)

### Business Question
How long, on average, does it take the company to collect cash after issuing an invoice?

### Definition
Days Sales Outstanding (DSO) measures the average number of days between invoice issuance and final payment collection. It reflects the efficiency of the company’s accounts receivable process.

### Business Logic
- DSO is calculated using fully paid invoices only to measure completed collection cycles.
- The number of days is calculated from invoice date to final payment date.
- Partial payments are excluded until the invoice is fully paid.
- DSO is calculated as the average collection period across fully paid invoices.
- DSO can be analyzed by customer, region, or time period.
- Open or partially paid invoices are excluded to avoid inflating DSO with incomplete collection cycles.

### Why This KPI Matters
A high DSO indicates slow cash collection, which can strain working capital and limit operational flexibility. Monitoring DSO helps leadership assess collection efficiency, evaluate credit policies, and forecast cash flow reliability.


## KPI 3: Job Cost Variance

### Business Question
Which jobs are running over or under budget, and by how much?

### Definition
Job Cost Variance measures the difference between estimated job cost and actual job cost. It highlights cost overruns or savings at the individual job level.

### Business Logic
- Estimated cost is defined during job planning and approved before execution.
- Jobs with estimated cost = 0 are excluded to avoid distortion.
- Actual cost is calculated as the sum of all recorded job costs (labor, materials, equipment, subcontracting).
- Cost variance is calculated as:
  - Absolute variance= Actual Cost − Estimated Cost
  - Percentage variance= (Actual Cost − Estimated Cost) / Estimated Cost
- Jobs without recorded actual costs will return blank variance results.
- Cost variance can be analyzed by job, service type, crew, region, or time period.

### Why This KPI Matters
Cost overruns directly reduce job profitability and often go unnoticed until month-end. Tracking cost variance enables early corrective action, improves future estimates, and protects operating margins.


## KPI 4: Unbilled Revenue Exposure 

### Business Question
Which completed jobs have not yet been invoiced, and how much revenue is at risk?

### Definition
Unbilled Revenue Exposure measures the financial value of completed jobs that have not yet been invoiced.

### Business Logic
- A job is considered Completed when its job status is "COMPLETED".
- A job is considered Invoiced when it is linked to at least one invoice through invoice line items.
- Jobs with completed status and no associated invoice are classified as Unbilled.
- The total unbilled value is calculated using estimated job revenue for unbilled completed jobs.
- Cancelled jobs are excluded from this KPI.

### Why This KPI Matters
This KPI highlights revenue at risk due to delayed invoicing. It supports cash flow forecasting, revenue assurance, and prioritization of high-value billing items.


## KPI 5: Job Cycle Time

### Business Question

How long does it take to complete a job from the scheduled service date to actual completion?

### Definition

Job Cycle Time measures the number of days taken to complete a job from its scheduled date to the date it is marked as completed, reflecting operational execution efficiency.

### Business Logic

- A job is considered Completed when its job status is "COMPLETED".
- Job cycle time is calculated as:
Completed Date − Scheduled Date
- Cancelled jobs are excluded from the calculation.
- Jobs that are not yet completed are excluded from cycle time analysis.
- Jobs with missing scheduled or completion dates are excluded.
- Job cycle time can be analyzed by service type, crew, region, priority, or time period.

### Why This KPI Matters
Long job cycle times delay invoicing, increase operational costs, and negatively impact cash flow. Tracking this KPI helps Operations identify execution delays, improve scheduling discipline, and support faster operations-to-cash conversion.