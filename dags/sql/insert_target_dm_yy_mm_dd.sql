INSERT INTO dm_dob_year(year)
SELECT DISTINCT date_part('year', birthdate) FROM public.stg_tbl_users_data AS stud 
WHERE NOT EXISTS(SELECT * FROM dm_dob AS ddb 
				 WHERE dob_optional = ddb.dob_optional
				AND birthdate = ddb.birthdate) ORDER BY 1;
				
INSERT INTO dm_dob_month(month)				
SELECT DISTINCT date_part('month', birthdate) FROM public.stg_tbl_users_data AS stud 
WHERE NOT EXISTS(SELECT * FROM dm_dob AS ddb 
				 WHERE dob_optional = ddb.dob_optional
				AND birthdate = ddb.birthdate) ORDER BY 1;
				
INSERT INTO dm_dob_day(day)				
SELECT DISTINCT date_part('day', birthdate) FROM public.stg_tbl_users_data AS stud 
WHERE NOT EXISTS(SELECT * FROM dm_dob AS ddb 
				 WHERE dob_optional = ddb.dob_optional
				AND birthdate = ddb.birthdate) ORDER BY 1;