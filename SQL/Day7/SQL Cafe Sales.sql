-- Analyze cafe sales and compare them to budget 

-- 1.1. Cafe sales by Year-Month 

SELECT ROUND(sum(total_spent_calc), 0) AS total_spent,
to_char(transaction_date, 'YYYY-MM') as year_month
FROM cafe_sales_cleaned
GROUP BY year_month
ORDER BY total_spent DESC;

-- 1.2. Monthly sales vs monthly budget

SELECT *
FROM (SELECT ROUND(sum(total_spent_calc), 0) AS total_spent,
	to_char(transaction_date, 'YYYY-MM') as year_month
	FROM cafe_sales_cleaned
	GROUP BY year_month
	ORDER BY total_spent DESC) AS ms
LEFT JOIN cafe_budget as cb
ON ms.year_month = cb.year_month;

-- Alternatiivne lahendus 1
WITH monthly_sales AS (
	SELECT ROUND(sum(total_spent_calc), 0) AS total_spent,
	to_char(transaction_date, 'YYYY-MM') as year_month
	FROM cafe_sales_cleaned
	GROUP BY year_month
	ORDER BY total_spent DESC
)
SELECT cb.year_month, cb.budget_sum, ms.total_spent 
FROM cafe_budget AS CB
FULL OUTER JOIN monthly_sales AS ms
ON cb.year_month = ms.year_month; 

-- Alternatiivne lahendus 2
SELECT 
    b.year_month, SUM(c.total_spent_calc) AS actual_sales,
    b.budget_sum
FROM cafe_sales_cleaned c
LEFT JOIN cafe_budget b
    ON TO_CHAR(c.transaction_date, 'YYYY-MM') = b.year_month
GROUP BY b.year_month,b.budget_sum
ORDER BY b.year_month;

-- 1.3. Cafe sales by item 

SELECT item_cleaned, ROUND(sum(total_spent_calc), 0) AS total_spent
FROM cafe_sales_cleaned
GROUP BY item_cleaned
ORDER BY total_spent DESC;

-- 1.4. Compare average sale sum per item to average sale sum for all items

SELECT item_cleaned,
ROUND(AVG(total_spent_calc), 2) AS average_sale_price,
(SELECT ROUND(AVG(total_spent_calc), 2) AS all_sales_average_price FROM cafe_sales_cleaned),
ROUND(AVG(total_spent_calc), 2) - (SELECT ROUND(AVG(total_spent_calc), 2) FROM cafe_sales_cleaned) AS average_sales_price_difference
FROM cafe_sales_cleaned
GROUP BY item_cleaned
ORDER BY average_sale_price DESC;

-- 1.5. Filter out only items where sales were more than 10 000

SELECT item_cleaned, total_spent
FROM(
		SELECT item_cleaned, ROUND(sum(total_spent_calc), 0) AS total_spent
		FROM cafe_sales_cleaned
		GROUP BY item_cleaned
		ORDER BY total_spent DESC
)
WHERE total_spent > 10000;

-- Alternatiivne lahendus 1
SELECT item_cleaned,
       SUM(total_spent_calc) AS kogumyyk
FROM cafe_sales_cleaned
GROUP BY item_cleaned
HAVING SUM(total_spent_calc) > 10000
ORDER BY kogumyyk DESC;

-- 1.6. What were sales by payment method?

SELECT payment_method_cleaned, ROUND(sum(total_spent_calc), 0) AS total_spent
FROM cafe_sales_cleaned
GROUP BY payment_method_cleaned
ORDER BY total_spent DESC;

-- 1.7. Compare average sale sum by location to average sale sum

SELECT location_cleaned,
ROUND(AVG(total_spent_calc), 2) AS average_sale_price,
(SELECT ROUND(AVG(total_spent_calc), 2) AS all_sales_average_price FROM cafe_sales_cleaned),
ROUND(AVG(total_spent_calc), 2) - (SELECT ROUND(AVG(total_spent_calc), 2) FROM cafe_sales_cleaned) AS average_sales_price_difference
FROM cafe_sales_cleaned
GROUP BY location_cleaned;

-- 1.8. What were sales by location?

SELECT location_cleaned, ROUND(sum(total_spent_calc), 0) AS total_spent
FROM cafe_sales_cleaned
GROUP BY location_cleaned
ORDER BY total_spent DESC;

-- 1.9. How many units per item were sold?

SELECT item_cleaned, sum(quantity)
FROM cafe_sales_cleaned
GROUP BY item_cleaned
ORDER BY sum(quantity) DESC;

-- 1.10. Filter out only items where more than 3000 units were sold

SELECT item_cleaned, sum_quantity
FROM(
	SELECT item_cleaned, sum(quantity) AS sum_quantity
	FROM cafe_sales_cleaned
	GROUP BY item_cleaned
	ORDER BY sum(quantity) DESC
)
WHERE sum_quantity > 3000;

