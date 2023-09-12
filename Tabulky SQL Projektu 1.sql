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