/*
 * 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? 
 */	 
    
	  	CREATE OR REPLACE VIEW v4 AS
	    	SELECT 
	    		value AS avg_salary,
	    		year1
	    	FROM t_ian_alexandr_byma_project_sql_primary_final
	    	GROUP BY year1;
	  
	    	
	    CREATE OR REPLACE VIEW v5 AS
	    	SELECT 
	    		value AS avg_salary,
	    		year1
	    	FROM t_ian_alexandr_byma_project_sql_primary_final
	    	GROUP BY year1;
	    
	   	CREATE OR REPLACE VIEW v6 AS
	    	SELECT
	    		v4.Year1,
	    		round((v5.avg_salary - v4.avg_salary)/v4.avg_salary* 100,2) AS Avg_Salary_Per_Year
	   	 	FROM v4
	    		JOIN v5
	    		ON v4.year1=v5.year1 - 1;
	    	
	    	
	    	
	    CREATE OR REPLACE VIEW v7 AS
	    	SELECT 
	    		round(sum(average_food_price),2) AS average_food_price,
	    		year1
	    	FROM t_ian_alexandr_byma_project_sql_food
	    	GROUP BY year1;
	    	
	    CREATE OR REPLACE VIEW v8 AS
	    	SELECT 
	    		round(sum(average_food_price),2) AS average_food_price1,
	    		year1
	    	FROM t_ian_alexandr_byma_project_sql_food
	    	GROUP BY year1;
	    	´
	    	
	    CREATE OR REPLACE VIEW v9 AS
	    	SELECT
	    		v7.Year1,
	    		round((v8.average_food_price1 - v7.average_food_price)/v7.average_food_price* 100,2) AS Avg_Food_Price_Per_Year
	   	 	FROM v7
	    		JOIN v8
	    		ON v7.year1=v8.year1 - 1;
	    	
	    	
	    CREATE OR REPLACE VIEW v10 AS
	    	SELECT	
	            round(Avg_Salary_Per_Year,2) AS Avg_Salary_Per_Year,
	    		round(Avg_Food_Price_Per_Year,2)AS Avg_Food_Price_Per_Year,
	    		round(Avg_Food_Price_Per_Year - Avg_Salary_Per_Year,2) AS Difference_Between_Values,
	    		v9.Year1
	        FROM v9
	        	JOIN v6
	        	ON  v6.year1 = v9.year1;
        
        
/*
 * Cena potravin nikdy nevzrostla o deset procent proti průměrné mzdě nejblíže tomu pak byl rok 2011,
 * kdy ceny vzrostly o 6,73%
 * a platy pouze o 2.57%
 * rozdíl 4.16%.
 * (Nejvyšší nárůst ceny potravin zaznamenal rok 2016(9.63%),
 * ovšem i platy stouply o 6.84%
 * tudíž rozdíl pouze 2.79%).
 */