/*
 * 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší procentuální meziroční nárůst)?
 */	 
	 
		WITH t1 AS(
		 	SELECT 
		 		food,
		 		code,
		 		Average_food_price,
		 		year1
		 	FROM t_ian_alexandr_byma_project_sql_food
		 	GROUP BY food, year1
		 	),
	    t2 AS(
	 	 	SELECT 
		 		food,
		 		code,
		 		Average_food_price,
		 		year1
		 	FROM t_ian_alexandr_byma_project_sql_food
		 	GROUP BY food, year1
		 	),
		t3 AS(
		 	SELECT 
		 		t1.Food,
		 		t1.Year1 AS Previous_Year,
		 		t1.Average_food_price Average_Food_Price_Previous_Year,
		 		t2.Year1 AS Next_Year,
		 		t2.Average_food_price AS Average_Food_Price_Next_Year,
		 		round((t2.Average_food_price-t1.Average_food_price) / t1.Average_food_price *100,2) AS Difference_cost
		 	FROM t1
		 	 JOIN t2
		 	 	ON t1.Year1 = t2.Year1 - 1
		 	 	AND t1.Food =  t2.Food
		 	 	AND t1.Code = t2.Code
		 	ORDER BY Difference_cost DESC
		 	)
		 	SELECT
		 	 	concat('       ',2006,'-',2018) AS Relevant_Years,
		 		Food,
		 		round(avg(difference_cost),2) AS Average_Grow_Of_Cost,
		 		MIN(difference_cost) AS Min_Grow,
		 		MAX(difference_cost) AS Max_Grow
		 	FROM t3
			GROUP BY Food
	    	ORDER BY Average_Grow_Of_Cost;
  
    
/*
 * Nejnižší průměrný meziroční růst se objevuje u kategorie Cukr Krystalový(-1.92%) tz. zlevnil.
 */	   