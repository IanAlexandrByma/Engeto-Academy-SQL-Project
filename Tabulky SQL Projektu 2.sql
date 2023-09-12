
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