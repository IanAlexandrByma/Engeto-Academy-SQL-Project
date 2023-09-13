/*
 *  Základní tabulky (Tabulka primary_final_pay a primary_final_food) spojené do tabulky 
 *  t_ian_alexandr_byma_project_sql_primary_final.
 *  U 5.otázky vytvořena tabulka secondary_final(economies).
 */	

		CREATE OR REPLACE TABLE t_ian_alexandr_byma_project_sql_primary_final_pay AS
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
			
			
		CREATE OR REPLACE TABLE t_ian_alexandr_byma_project_sql_primary_final_food AS
			SELECT 
				cpc.name AS food, 
				cpc.code, 
				cpc.price_value, 
				cpc.price_unit AS unit, 
				avg(cpr.value) AS average_food_price, 
				year(cpr.date_from) AS year1
			FROM czechia_price AS cpr
				JOIN czechia_price_category AS cpc 
					ON cpr.category_code = cpc.code
			WHERE cpr.region_code IS NULL
				GROUP BY cpc.name, cpc.price_value, cpc.price_unit, cpc.code, year1
				ORDER BY year1;
			
		
		CREATE OR REPLACE TABLE t_ian_alexandr_byma_project_sql_primary_final AS
			SELECT
				spfp.code,	
				spfp.value,
				spfp.unit,
				spfp.name,
				spfp.ib_code,
				spfp.ability,
				spfp.year1,
				spff.food, 
				spff.code AS food_code, 
				spff.price_value, 
				spff.unit AS food_unit, 
				spff.average_food_price, 
				spff.year1 AS food_year1
			FROM t_ian_alexandr_byma_project_sql_primary_final_pay AS spfp
				LEFT JOIN t_ian_alexandr_byma_project_sql_primary_final_food AS Spff
					ON spfp.year1 = spff.year1;