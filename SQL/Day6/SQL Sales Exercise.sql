-- 1. Leia müügisummad toodete kaupa – toote ID ja müügisumma

SELECT product_id, ROUND(SUM(sale_sum), 0)
FROM sales_table
GROUP BY product_id
ORDER BY SUM(sale_sum) DESC;


-- 2. Leia müügisummad klientide kaupa – kliendi ID ja müügisumma

SELECT customer_id, ROUND(SUM(sale_sum), 0)
FROM sales_table
GROUP BY customer_id
ORDER BY SUM(sale_sum) DESC;

-- 3. Leia müügisummad müügiesindajate kaupa – kliendiesindaja ID ja müügisumma

SELECT sales_rep_id, ROUND(SUM(sale_sum), 0)
FROM sales_table
GROUP BY sales_rep_id
ORDER BY SUM(sale_sum) DESC;

-- 4. Leia müügisummad aastate kaupa – aasta ja müügisumma

SELECT EXTRACT(year FROM sale_date) AS sale_year, ROUND(SUM(sale_sum), 0)
FROM sales_table
GROUP BY sale_year
ORDER BY SUM(sale_sum) DESC;

-- 5. Lisa müükidele müügisumma kategooriad
-- 		1) Large Sale > 500
--		2) Medium Sale <= 500 and >= 250
--		3) Small Sale < 250

SELECT *,
CASE
  WHEN sale_sum < 250 THEN 'Small Sale'
  WHEN sale_sum BETWEEN 250 AND 500 THEN 'Medium Sale'
  ELSE 'Large Sale'
END AS sale_category
FROM sales_table;

-- 5.1. Lisa loodud tulp müügitabelisse ("sales_table")

-- Loon tabelisse uue veeru
ALTER TABLE sales_table ADD COLUMN sale_category varchar(50);

-- Uuendan tabeli sale_category veergu
UPDATE sales_table SET sale_category =
CASE
  WHEN sale_sum < 250 THEN 'Small Sale'
  WHEN sale_sum BETWEEN 250 AND 500 THEN 'Medium Sale'
  ELSE 'Large Sale'
END;

-- 6. Leia müükide arv ja müügisumma müügisumma kategooriate kaupa - Müügisumma kategooria, müükide arv, müügisumma

/* Esialgne kood enne 6.1.
SELECT count(sale_sum) AS sales_count,
ROUND(sum(sale_sum), 0) AS sales_sum,
CASE
  WHEN sale_sum < 250 THEN 'Small Sale'
  WHEN sale_sum BETWEEN 250 AND 500 THEN 'Medium Sale'
  ELSE 'Large Sale'
END AS sale_category
FROM sales_table
GROUP BY sale_category
ORDER BY sales_sum DESC;
*/

SELECT sale_category, COUNT(*) AS number_of_sales, SUM(sale_sum) as total_sum
FROM sales_table
GROUP BY sale_category
ORDER BY sale_category;
 
-- 7. Mida veel võiks leida?