INSERT INTO dm_users(name, category,dob_id)
SELECT DISTINCT stud.name, 1, ddb.id as dob_id FROM public.stg_tbl_users_data AS stud 
INNER JOIN dm_dob AS ddb on stud.dob_optional = ddb.dob_optional
AND ddb.dob_optional = ddb.dob_optional
WHERE type = 'customer_registered' AND
NOT EXISTS( SELECT * FROM dm_users AS du 
		  WHERE name = du.name) ORDER BY name