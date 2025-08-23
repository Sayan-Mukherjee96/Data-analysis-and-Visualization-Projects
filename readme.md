## B2B Sales Analysis
### Project Overview
This project analyzes B2B hardware sales data stored in a CRM system using MySQL.
The aim was to evaluate sales performance, conversion efficiency, and deal closure patterns across different agents, managers, products, and sectors.

### The dataset included:

sales_pipeline → Deal-level information (stage, value, engage & close dates).

sales_teams → Details about agents, managers, and regional offices.

products → Information about product offerings.

accounts → Customer account and sector details.

## Objectives
Identify top-performing agents by revenue and deal closure efficiency.

Measure conversion rates by sector.

Analyze deal cycle durations and time taken to close deals.

Evaluate manager-level win/loss ratios.

Assess product-wise win rates and contribution to overall success.

## SQL Queries Implemented

Some key queries developed during analysis:

Top Sales Agents by Deal Value

    Found the sales agent with the highest average close value.

    Identified the agent with the highest number of “Won” deals.    

Regional Deal Distribution

    Compared agents with the most and least product deals in each region.

Fastest Deal Closers

    Calculated the minimum number of months taken to close a deal.

Sector-wise Conversion Rate

    Evaluated how efficiently deals converted from engagement to closure across sectors.

Average Time to Close a Deal

    Measured average closure duration (in days) per agent.

Managerial Effectiveness

    Calculated Win/Loss ratio per manager to evaluate leadership performance.

Product Performance

    Analyzed Win Rate per Product to identify strong and weak market performers.

## Key Insights

Rosalina Dieter achieved the highest average deal close value (≈ 4,081).

Darcel Schlecht closed the most deals (166), while Wilburn Farren closed the fewest (24).

Anna Snelling was the fastest closer, averaging just 1 month.

Entertainment sector had the highest conversion rate (69.57%), while Employment sector was lowest (62.07%).

Deal closing times varied widely: fastest agents averaged ~53 days, while slower ones took ~77 days.

Cara Losch had the best manager win/loss ratio (2.14).

GTK 500 product had the highest win rate (73.33%), while MG Advanced was the lowest performer.


## Recommendations

Share best practices from faster closers to improve efficiency across the team.

Provide targeted coaching to agents with consistently low deal values.

Investigate regional performance gaps to standardize sales strategies.

Focus on sectors/products with lower conversion rates by adjusting messaging & pricing.

Continue monitoring manager win/loss ratios for proactive performance improvement.


## Skills Applied

SQL (Joins, CTEs, Aggregations, Window Functions)

Business Performance Analysis

Data-Driven Sales Insights

Query Optimization