create database sales_db;

use sales_db;

 select * from sales_pipeline;
 select * from sales_teams;
 select * from products;
 select * from accounts;
 
 

/*Find the sales agent who has closed the highest number of 'Won' deals, and also show the average close value per sales agent.*/

select sales_agent, round(avg(close_value),2) as avg_close_value, count(*) as won_deals
from sales_pipeline 
where deal_stage = "won"
group by sales_agent
order by avg_close_value desc
limit 10;

/*Which agent has made the most and the least product deals in each region?*/

WITH agent_counts AS (SELECT st.regional_office, sp.sales_agent, COUNT(*) AS total_deals
FROM sales_pipeline AS sp JOIN sales_teams AS st ON sp.sales_agent = st.sales_agent
WHERE sp.deal_stage = 'Won'
GROUP BY st.regional_office, sp.sales_agent
),
ranked AS (SELECT regional_office, sales_agent, total_deals,
RANK() OVER (PARTITION BY regional_office ORDER BY total_deals DESC) AS rnk_max,
RANK() OVER (PARTITION BY regional_office ORDER BY total_deals ASC) AS rnk_min
    FROM agent_counts
)
SELECT r1.regional_office,
r1.sales_agent AS most_deals_agent,
r1.total_deals AS most_deals_count,
r2.sales_agent AS least_deals_agent,
r2.total_deals AS least_deals_count
FROM ranked r1 JOIN ranked r2 ON r1.regional_office = r2.regional_office
WHERE r1.rnk_max = 1 AND r2.rnk_min = 1
ORDER BY r1.regional_office;

/*Which agent has closed a deal in the minimum number of months*/

WITH deal_months AS (SELECT sales_agent,
(YEAR(close_date) - YEAR(engage_date)) * 12 + (MONTH(close_date) - MONTH(engage_date)) AS months_to_close
FROM sales_pipeline
WHERE deal_stage = 'won'
AND engage_date IS NOT NULL
AND close_date IS NOT NULL
),
min_months AS (
SELECT MIN(months_to_close) AS min_months_to_close
FROM deal_months
WHERE months_to_close >= 1
)
SELECT DISTINCT d.sales_agent, min_months_to_close
FROM deal_months as d JOIN min_months as m 
ON d.months_to_close = m.min_months_to_close
ORDER BY d.sales_agent ASC
LIMIT 1;

/*sector wise conversation rate?*/

SELECT a.sector, COUNT(*) AS total_deals, COUNT(CASE WHEN sp.deal_stage = 'Won' THEN 1 END) AS won_deals,
CONCAT(ROUND(COUNT(CASE WHEN sp.deal_stage = 'Won' THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0), 2),'%') AS conversion_rate
FROM sales_pipeline as sp
JOIN accounts as a ON sp.account = a.account
GROUP BY a.sector
ORDER BY ROUND(COUNT(CASE WHEN sp.deal_stage = 'Won' THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0), 2) DESC;

/*What is the average time (in days) taken to close a deal by an agent*/

select sales_agent, round(avg(datediff(close_date,engage_date)),0) as avg_days_to_close
from sales_pipeline
where deal_stage = 'won'
group by sales_agent
order by avg_days_to_close asc
limit 10;

/*what is the win to loss ratio by manager */

SELECT manager, COUNT(DISTINCT st.sales_agent) AS total_agent,
  SUM(CASE WHEN deal_stage = 'won' THEN 1 ELSE 0 END) AS total_won,
  SUM(CASE WHEN deal_stage = 'lost' THEN 1 ELSE 0 END) AS total_lost,
  ROUND(SUM(CASE WHEN deal_stage = 'won' THEN 1 ELSE 0 END) * 1.0 /
  NULLIF(SUM(CASE WHEN deal_stage = 'lost' THEN 1 ELSE 0 END), 0),2) AS win_loss_ratio
FROM sales_pipeline AS sp INNER JOIN sales_teams AS st ON sp.sales_agent = st.sales_agent
GROUP BY manager
order by win_loss_ratio asc;

/* what is the win rate of agent based on the product ? */

SELECT product, COUNT(*) AS total_deals, SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) AS won_deals,
       CONCAT(ROUND(SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2),'%') AS win_rate
FROM sales_pipeline 
GROUP BY product
order by win_rate desc;
