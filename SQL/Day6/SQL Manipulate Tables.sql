-- Saime juhatuselt uued eelarvenumbrid ning loome nende põhjal uue eelarve tabeli

/*
 * budget_id PK, SERIAL
 * budget_date, DATE
 * sales_rep_name, VARCHAR
 * budget, NUMERIC
 */
	
CREATE TABLE budget_table_new (
budget_id SERIAL NOT NULL PRIMARY KEY,
budget_date DATE,
sales_rep_name VARCHAR(50),
budget_sum NUMERIC(50, 2)
);

SELECT *
FROM budget_table_new;

INSERT INTO budget_table_new (
budget_date,
sales_rep_name,
budget_sum
)
VALUES ('2026-01-31', 'Jane Smith', 20000),
('2026-01-31', 'John Doe', 20000);

-- Lisa müügiesindaja ID (sales_rep_id) tulp
ALTER TABLE budget_table_new
ADD COLUMN sales_rep_id VARCHAR(50);


-- Lisa ID 'SR001' Jane Smithile
UPDATE budget_table_new
SET sales_rep_id = 'SR001'
WHERE sales_rep_name = 'Jane Smith';


-- Lisa ID 'SR002' John Doele
UPDATE budget_table_new
SET sales_rep_id = 'SR002'
WHERE sales_rep_name = 'John Doe';


-- Eemalda müügiesindaja nime tulp
ALTER TABLE budget_table_new
DROP COLUMN sales_rep_name;


-- Kogu info oli vale, kustutame tabeli
DROP TABLE budget_table_new;
