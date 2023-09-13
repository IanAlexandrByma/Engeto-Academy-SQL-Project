/*
 * Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, 
 * pokud HDP vzroste výrazněji v jednom roce, 
 * projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
 */        
	        
	    CREATE OR REPLACE VIEW hdp_influence_to_food_price1 As
	        SELECT
	            spsf.Year1,
	        	Grow_of_gdp,
	        	v6.year1 AS Year2,
	        	Avg_salary_per_year,
	        	v9.year1 AS Year3,
	        	Avg_food_price_per_year
	        FROM t_ian_alexanr_byma_project_sql_secondary_final AS spsf
	        JOIN v6
	        	ON spsf.year1 = v6.year1 -1
	        JOIN v9 
	        	ON v6.year1 -1 = v9.year1 -1
	        	AND v6.year1 -1 = spsf.year1;
	        
	        
	          
	    CREATE OR REPLACE VIEW hdp_influence_to_food_price2 As
	        SELECT
	            spsf.Year1,
	        	Grow_of_gdp,
	        	v6.year1 AS Year2,
	        	Avg_salary_per_year,
	        	v9.year1 AS Year3,
	        	Avg_food_price_per_year
	        FROM t_ian_alexanr_byma_project_sql_secondary_final AS spsf
	        JOIN v6
	        	ON spsf.year1 = v6.year1 
	        JOIN v9 
	        	ON v6.year1 = v9.year1 
	        	AND v6.year1 = spsf.year1;
        
/*
 * HDP(gross domestic product) neovlivňuje přímo průměrnou mzdu,
 * lze ale říci že se vzrůstající či klesající hodnotou(GDP) roste i
 * průměrná mzda ovšem ne úměrně vůči hodnotě GDP.
 * Ještě menší má vliv na průměrnou cenu potravin.
 * Hodnota ceny potravin do jisté míry hodnotu GDP kopíruje, 
 * ale je zde patrný vliv externích(vnějších) faktorů (Poptávka, úroda).
 * Nejpatrnější přímý vliv můžeme sledovat hned při prvním sledovaném období(2005-2006):
 * GDP(2005,6.77%)
 * Avg_Salary_Per_Year(2006,7.23%)
 * Avg_Food_Price_Per_Year(2006,6.76%).
 * Vliv GDP na obě hodnoty, lze sledovat maximálně v rozmezí dvou let.
 */