	
/*
 *  Základní tabulky (Tabulka primary_final,Tabulka food).
 *  U 5. otázky vytvořena tabulka secondary_final(economies).
 */	



		CREATE OR REPLACE TABLE t_Ian_Alexandr_Byma_project_SQL_primary_final AS
		SELECT 
			cpvt.code AS code,	
			avg(cp.value) AS value,
			cpu.name AS unit,
			cpib.name AS  name,
			cpib.code AS ib_code,
			cpc.name AS  ability,
			cp.payroll_year AS year1
		FROM czechia_payroll AS cp
			LEFT JOIN czechia_payroll_calculation AS cpc
				ON cp.calculation_code = cpc.code
			LEFT JOIN czechia_payroll_industry_branch AS cpib
				ON cp.industry_branch_code = cpib.code
			LEFT JOIN czechia_payroll_unit AS cpu
				ON cp.unit_code = cpu.code
			LEFT JOIN czechia_payroll_value_type AS cpvt
				ON cp.value_type_code = cpvt.code
			WHERE cpvt.code = 5958
				GROUP BY name, year1;
			
			
			
		CREATE OR REPLACE TABLE  t_Ian_Alexandr_Byma_project_SQL_food AS
			SELECT
				cpc.name AS food, 
				cpc.code, 
				cpc.price_value, 
				cpc.price_unit AS unit, 
				avg(cp.value) AS average_food_price, 
				year(cp.date_from) AS year1
			FROM czechia_price cp
				JOIN czechia_price_category cpc 
					ON cp.category_code = cpc.code
			WHERE cp.region_code IS NULL
			GROUP BY cpc.name, cpc.price_value, cpc.price_unit, cpc.code, year1
			ORDER BY year1;
/*
 * 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají? 
*/
	
		WITH t1 AS (
		  SELECT DISTINCT
		    year1,
		 	value,
		 	ib_code,
		 	name
	      FROM t_ian_alexandr_byma_project_sql_primary_final
	      ),
	   t2 AS (
	     SELECT DISTINCT
	         year1,
	         value,
	         ib_code,
	         name
	      FROM t_ian_alexandr_byma_project_sql_primary_final
	      )
		  SELECT 
			t1.year1 AS Previous_Year,
			t1.value AS Value_For_Previous_Year,
			t2.year1 AS Next_Year,
			t2.value AS Value_For_Next_Year,
			round((t2.value - t1.value) / t1.value * 100,2) AS Difference_In_Percent,
			t1.Ib_Code, 
			t1.Name
		FROM t1
			JOIN t2
				ON t1.ib_code = t2.ib_code
				AND t1.year1 = t2.year1 - 1
		WHERE t2.value < t1.value
		ORDER BY difference_in_percent ASC, t1.year1;


/*
 * V horizontu měřených let došlo celkem 30 * k  meziročnímu poklesu mzdy.
 * Nejvíce případu datujeme do let 2008 - 2012(finanční krize) primárně  v oblasti Těžba a dobývání 
 * a oblastí spojené s přímými prodeji.
 * Poté v letech  2019-2020(začátek pandemie koronaviru) v oblasti Ubytování, stravování a pohostinství a Kulturní, zábavní a rekreační činnosti. 
 * Nejvyšší pokles 2012 Peněžnictví a pojišťovnictví (8.91%).
 * Nejnižší pokles 2010 Kulturní, zábavní a rekreační činnosti(0.05%).
 * Meziroční pokles nikdy nepřesáhl 10%.
 * Nejvyšší rozdíl je 4 478.5Kč(2012, Peněžnictví a pojišťovnictví).
*/

/*
 * Kolik je možné si koupit kilogramů chleba a litrů mléka 
 * za první a poslední srovnatelné období z dat, které jsou pro tyto 
 * údaje k dispozici?
 */
				
		CREATE OR REPLACE VIEW V1 AS 
			SELECT	
		 		Food, 
		 		Average_Food_Price,
		 		Year1,
		 		Unit
		 	FROM t_Ian_Alexandr_Byma_project_SQL_food
		 	WHERE food IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované')
		 	AND year1 IN (2006,2018);
		
		CREATE OR REPLACE VIEW V2 AS
		 	SELECT
		 		year1 AS Year2,
		 		avg(value) AS Salary
			FROM t_ian_alexandr_byma_project_sql_primary_final
		 	WHERE year1 IN (2006,2018)
		 	GROUP BY year1;
		
		CREATE OR REPLACE VIEW V3 AS
		 	SELECT 
		 		Food,
		 		Average_Food_Price,
		 		Year1,
		 		Salary,
		 		round(salary / average_food_price,2) AS Value_Of_Unit_For_Average_Salary,
		 		CASE 
		 			WHEN food = 'Chléb konzumní kmínový' THEN 'kg'
		 			ELSE 'l'
		 		END AS Unit 
		 	FROM V1
		 		JOIN V2
		 			ON V1.year1 = V2.year2
		 	ORDER BY year1, food;
		 
	   WITH difference1 AS (
		 SELECT 
		 	food,
		 	year1,
		 	Value_Of_Unit_For_Average_Salary AS Unit_For_Average_Salary1,
		 	unit
		 FROM v3
		 WHERE year1 = 2006 
		 GROUP BY unit
		 ),
	   difference2 AS (
		 SELECT
		 	food,
		 	year1,
		 	Value_Of_Unit_For_Average_Salary AS Unit_For_Average_Salary2,
		 	unit
		 FROM v3
		 WHERE year1 = 2018
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
	 
/*
 * Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší procentuální meziroční nárůst)?
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

    
/*
 * 4) Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)? 
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
 * Cena potravin nikdy nevzrostla o deset procent proti nejblíže tomu pak byl rok 2011,
 * kdy ceny vzrostly o 6,73%
 * a plata pouze o 2.57%
 * rozdíl 4.16%.
 * (Nejvyšší nárůst ceny potravin zaznamenal rok 2016(9.63%),
 * ovšem i platy stouply o 6.84%
 * tudíž rozdíl pouze 2.79%).
 */
    
        
/*
 * Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, 
 * pokud HDP vzroste výrazněji v jednom roce, 
 * projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
 */        
        
	        ALTER TABLE economies RENAME COLUMN year TO Year1;
	      
	    CREATE OR REPLACE TABLE t_ian_alexanr_byma_project_SQL_secondary_final
	    	SELECT
	    	    e1.year1,
	    		e1.country,
	    		round((e2.GDP-e1.GDP)/e1.GDP *100,2) AS Grow_Of_GDP
	    	FROM economies AS e1
	    	JOIN economies AS e2
	    		ON e1.country = e2.country
	    		AND e1.Year1 = e2.Year1 -1
	    	WHERE e1.country = 'Czech republic'
	    	HAVING Grow_Of_GDP IS NOT NULL
	        ORDER BY Year1;
	        
	    CREATE OR REPLACE VIEW v11 As
	        SELECT
	            tss.Year1,
	        	Grow_Of_GDP,
	        	v6.Year1 AS Year2,
	        	Avg_Salary_Per_Year,
	        	v9.Year1 AS Year3,
	        	Avg_Food_Price_Per_Year
	        FROM t_ian_alexanr_byma_project_SQL_secondary_final AS tss
	        JOIN v6
	        	ON tss.year1 = v6.year1 -1
	        JOIN v9 
	        	ON v6.year1 -1 = v9.year1 -1
	        	AND v6.year1 -1 = tss.year1;
	        
	        
	          
	    CREATE OR REPLACE VIEW v12 As
	        SELECT
	            tss.Year1,
	        	Grow_Of_GDP,
	        	v6.Year1 AS Year2,
	        	Avg_Salary_Per_Year,
	        	v9.Year1 AS Year3,
	        	Avg_Food_Price_Per_Year
	        FROM t_ian_alexanr_byma_project_SQL_secondary_final AS tss
	        JOIN v6
	        	ON tss.year1 = v6.year1 
	        JOIN v9 
	        	ON v6.year1 = v9.year1 
	        	AND v6.year1 = tss.year1;
        
/*
 * HDP(gross domestic product) neovlivňuje přímo průměrnou mzdu,
 * lze řici že se vzrůstající či klesající hodnotou(GDP) roste i
 * průměrná mzda ovšem ne úměrně vůči hodnotě GDP.
 * Ještě menší má vliv na průměrnou cenu potravin.
 * Hodnota ceny potravin odráží do jisté míry hodnotu
 * GDP kopíruje, ale je zde patrný vliv externích(vnějších) 
 * faktorů(Poptávka, úroda)
 * Nejpatrnější přímý vliv můžeme sledovat hned při prvním sledovaném období(2005-2006)
 * GDP(2005,6.77%)
 * Avg_Salary_Per_Year(2006,7.23%)
 * Avg_Food_Price_Per_Year(2006,6.76%).
 * Vliv GDP lze sledovat maximálně v rozmezí dvou let.
 */
        	
        
    	
    	
    	
    	
    	
    	
    	
    	
	 
	 

	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 

			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
	










































	
