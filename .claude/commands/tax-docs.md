---
description: Find and summarise all tax-relevant documents for a given tax year
argument-hint: Tax year (e.g. "2025/26" or "2024/25") — defaults to current tax year 2025/26
---

Pull together tax documents for: ${ARGUMENTS:-2025/26 tax year}

The UK tax year runs 6 April to 5 April. Search Paperless for all relevant documents.

Steps:
1. Determine the date range from the tax year argument
2. Search in parallel for each document category:
   - Payslips (search "payslip" or "pay statement")
   - P60 / P45 end of year certificates
   - HMRC correspondence (search "hmrc")
   - Pension statements
   - Bank interest statements
   - Investment/share documents (options exercises, dividends)
   - Benefits in kind / P11D
3. Filter results to the relevant tax year date range
4. For each category, read the documents and extract key figures
5. Produce a structured tax summary:

```
## Tax Year [YYYY/YY] Summary

**Employment income**
- Employer: [name]
- Gross pay (YTD from final payslip): £[amount]
- Income tax paid: £[amount]
- Employee NIC: £[amount]
- Pension contributions (employee): £[amount]
- Pension contributions (employer): £[amount]

**Benefits in kind**
- [list if found]

**Other income**
- [bank interest, dividends, etc. if found]

**Documents found** ([N] total)
- [list with title, date, ID]

**Gaps** (expected but not found)
- [e.g. P60 not yet available]
```

Notes:
- Miles works for Monzo, paid via Deel. Payslips are titled with "deel-Miles_Bryant-..." or "payslip_..."
- Employer pension is via workplace pension scheme (Employer: £1,500/month visible in payslips)
- Tax basis K2 (visible on payslips)
