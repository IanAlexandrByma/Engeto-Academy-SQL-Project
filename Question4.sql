/*
 * 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? 
 */	 
    
	  	CREATE OR REPLACE VIEW average_year_salary1 AS
	    	SELECT 
	    		value AS avg_salary,
	    		year1
	    	FROM t_ian_alexandr_byma_project_sql_primary_final
	    	GROUP BY year1;
	  
	    	
	    CREATE OR REPLACE VIEW average_year_salary2 AS
	    	SELECT 
	    		value AS avg_salary,
	    		year1
	    	FROM t_ian_alexandr_byma_project_sql_primary_final
	    	GROUP BY year1;
	    
	   	CREATE OR REPLACE VIEW average_year_salary_all AS
	    	SELECT
	    		v4.Year1,
	    		round((v5.avg_salary - v4.avg_salary)/v4.avg_salary* 100,2) AS avg_salary_per_year
	   	 	FROM average_year_salary1 AS v4
	    		JOIN average_year_salary2 AS v5
	    		ON v4.year1=v5.year1 - 1;
	    	
	    	
	    	
	    CREATE OR REPLACE VIEW average_year_cost1 AS
	    	SELECT 
	    		round(sum(average_food_price),2) AS average_food_price,
	    		food_year1
	    	FROM t_ian_alexandr_byma_project_sql_primary_final
	    	GROUP BY year1;
	    	
	    CREATE OR REPLACE VIEW average_year_cost2 AS
	    	SELECT 
	    		round(sum(average_food_price),2) AS average_food_price1,
	    		food_year1
	    	FROM t_ian_alexandr_byma_project_sql_primary_final
	    	GROUP BY year1;
	    	´
	    	
	    CREATE OR REPLACE VIEW average_year_cost_all AS
	    	SELECT
	    		v7.Food_year1,
	    		round((v8.average_food_price1 - v7.average_food_price)/v7.average_food_price* 100,2) AS avg_food_price_per_year
	   	 	FROM average_year_cost1 AS v7
	    		JOIN average_year_cost2 AS v8     		
	    		ON v7.food_year1=v8.food_year1 - 1;
	    	
	    	
	    CREATE OR REPLACE VIEW total_grow_of_salry_and_cost AS
	    	SELECT	
	            round(avg_salary_per_year,2) AS Avg_salary_per_year,
	    		round(avg_food_price_per_year,2)AS Avg_food_price_per_year,
	    		round(avg_food_price_per_year - Avg_salary_per_year,2) AS Difference_between_values,
	    		v9.Food_year1
	        FROM average_year_cost_all AS v9
	        	JOIN average_year_salary_all AS v6
	        	ON  v6.year1 = v9.food_year1
        	ORDER BY difference_between_values;
        
/*
 * Cena potravin nikdy nevzrostla o deset procent proti průměrné mzdě nejblíže tomu pak byl rok 2011,
 * kdy ceny vzrostly o 6,73%
 * a platy pouze o 2.57%
 * rozdíl 4.16%.
 * (Nejvyšší nárůst ceny potravin zaznamenal rok 2016(9.63%),
 * ovšem i platy stouply o 6.84%
 * tudíž rozdíl pouze 2.79%).
 */