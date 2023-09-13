/*
 * 2. Kolik je možné si koupit kilogramů chleba a litrů mléka 
 * za první a poslední srovnatelné období z dat, které jsou pro tyto 
 * údaje k dispozici?
 */
				
		CREATE OR REPLACE VIEW view_food_price AS 
			SELECT	
		 		food, 
		 		average_food_price,
		 		unit,
		 		food_unit,
		 		food_year1
		 	FROM t_ian_alexandr_byma_project_sql_primary_final
		 	WHERE food IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
		    	AND year1 IN (2006,2018)
		    GROUP BY food_year1, food;
		
		CREATE OR REPLACE VIEW view_average_salary AS
		 	SELECT
		 		year1 AS Year2,
		 		round(avg(value),2) AS Salary
			FROM t_ian_alexandr_byma_project_sql_primary_final
		 	WHERE year1 IN (2006,2018)
		 	GROUP BY year1;
		
		CREATE OR REPLACE VIEW view_average_salary_and_food_price AS
		 	SELECT 
		 		Food,
		 		Average_food_price,
		 		Food_year1,
		 		Salary,
		 		round(salary / average_food_price,2) AS value_of_unit_for_average_salary,
		 		CASE 
		 			WHEN food = 'Chléb konzumní kmínový' THEN 'kg'
		 			ELSE 'l'
		 		END AS Unit 
		 	FROM view_food_price AS v1
		 		JOIN view_average_salary AS v2
		 			ON V1.food_year1 = V2.year2
		 	ORDER BY food_year1, food;
		 
	   WITH difference1 AS (
		 SELECT 
		 	food,
		 	food_year1,
		 	Value_Of_Unit_For_Average_Salary AS Unit_For_Average_Salary1,
		 	unit
		 FROM view_average_salary_and_food_price AS v3
		 WHERE food_year1 = 2006 
		 GROUP BY unit
		 ),
	   difference2 AS (
		 SELECT
		 	food,
		 	food_year1,
		 	Value_Of_Unit_For_Average_Salary AS Unit_For_Average_Salary2,
		 	unit
		 FROM view_average_salary_and_food_price AS v3
		 WHERE food_year1 = 2018
		 GROUP BY unit
		 )
		 SELECT 
		 	concat(2006,'-',2018) AS Years,
		 	difference1.Food,
		 	Unit_For_Average_Salary2 - Unit_For_Average_Salary1 AS Difference_For_Years,
		 	difference1.Unit
		 FROM difference1
		 	INNER JOIN difference2
		 		ON difference1.unit = difference2.unit; 
	 
/*
 * V roce 2006(první období s kompletnímí hodnotami) jsme za průměrnou výplatu(20 677.0375 kč) mohli koupit:
 * 1282.42 kg Chleba
 * 1432.13 l Mléka
 * V roce 2018(poslední období s kompletnímí hodnotami) jsme za průměrnou výplatu(32 485.0875kč) mohli koupit:
 * 1340.24 kg Chleba 
 * 1639.07 l Mléka
 * Rozdíl je (2006 -2018)
 * V roce 2018 jsme mohli za průměrnou výplatu koupit o 57.82 kg Chleba více než v roce 2006.
 * V roce 2018 jsme mohli za průměrnou výplatu koupit o 206.94 l Mléka více než v roce 2006.
 */