/*
 * 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají? 
*/
	
		WITH t_ian_alexandr_byma_project_sql_primary_final1 AS (
		  SELECT DISTINCT
		    year1,
		 	value,
		 	ib_code,
		 	name
	      FROM t_ian_alexandr_byma_project_sql_primary_final
	      ),
	   t_ian_alexandr_byma_project_sql_primary_final2 AS (
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
			t1.ib_code AS Ib_code, 
			t1.name AS Name
		FROM t_ian_alexandr_byma_project_sql_primary_final1 AS t1
			JOIN t_ian_alexandr_byma_project_sql_primary_final2 AS t2 
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