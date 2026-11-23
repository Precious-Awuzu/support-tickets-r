# Customer Support Tickets Analysis (R)

An exploratory data analysis project in **R** examining `customer_support_tickets.csv` (**8,469 tickets** across **17 variables**), covering ticket types, channels, priority levels, top products, and customer satisfaction (CSAT) ratings.

## Tools & Packages
- **R** & **RStudio**
- **`tidyverse`** (`readr`, `dplyr`, `ggplot2`)
- **`janitor`**

## Key Highlights
- Cleaned column names with `janitor::clean_names()` and explored ticket counts across types, channels, and priority levels.
- Summarized CSAT ratings across closed/rated tickets and compared volume across top products.
- Generated charts (`tickets_by_channel.png`, `tickets_by_priority.png`, and `top_10_products.png`) using `ggplot2`.

## Files in This Repository
- `analysis.R` — Main R script for data cleaning, summaries, and plotting.
- `customer_support_tickets.csv` — Source support ticket dataset.
- `tickets_by_channel.png`, `tickets_by_priority.png`, `top_10_products.png` — Exported visualizations.