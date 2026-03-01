1. Customers

Customers can be Active or Inactive

Only Active customers can have:

New jobs

New invoices

Customer types include:

Corporate

HOA

Retail

Municipal

Payment terms vary by customer (Net 30, Net 45, Net 60)

Some customers may have:

Credit limits

Mixed contract types (Recurring + On-Demand)

2. Jobs (Work Orders)

Every job must belong to exactly one customer

Jobs progress through a defined lifecycle:

Scheduled → In Progress → Completed → Invoiced

Not all completed jobs are invoiced immediately

Cancelled jobs:

Have no invoice

May still have cost records

Each job has:

Estimated revenue

Estimated cost

Actual revenue is populated only after invoicing

Completed jobs may exist without invoices (intentional gap)

3. Job Costs

Each job may have multiple cost records

Cost types include:

Labor

Materials

Equipment

Subcontract

Actual costs may:

Match estimates

Exceed estimates (cost overrun scenarios)

Some jobs will intentionally exceed budget by >10%

Cost dates always fall between:

Job start date

Job completion date (if completed)

4. Invoices

Invoices are expected to be issued only after jobs are completed (based on standard process), but exceptions may exist and should be flagged.

An invoice may include:

One job

Multiple jobs (batched billing)

Not all completed jobs are invoiced within the same period

Invoice status lifecycle:

Draft → Sent → Paid

Invoice amounts are derived from:

Job estimated revenue (not cost)

Due date is based on customer payment terms

5. Invoice Line Items

Each invoice line item links:

One invoice

One job

A job appears only once per invoice

Line item amount contributes to total invoice amount

6. Payments

Payments are applied only to invoices

An invoice may have:

No payment (open AR)

Partial payment

Multiple payments

Payment date may be:

On time

Late (after due date)

Payment method varies by transaction

Payments should not exceed the invoice balance (overpayments and credits are treated as exceptions and are out of scope for this dataset).

7. Planned Exception Scenarios (For Analysis)

The following gaps are intentional and required for analytics use cases:

Completed jobs with no invoices

Invoices past due with no payment

Partial payments on invoices

Cost overruns on jobs

Region-level performance variance

These gaps support:

Reconciliation analysis

AR aging

Cost variance reporting

Executive decision-making dashboards
