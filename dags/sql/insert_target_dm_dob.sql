INSERT INTO dm_dob(dob_optional, birthdate, dob_year, dob_month, dob_day)
SELECT DISTINCT dob_optional, birthdate, ddy.id AS year_id,ddm.id AS month_id, ddd.id AS day_id FROM public.stg_tbl_users_data AS stud 
INNER JOIN dm_dob_year as ddy on date_part('year',stud.birthdate) = ddy.year
INNER JOIN dm_dob_month as ddm on date_part('month',stud.birthdate) = ddm.month
INNER JOIN dm_dob_day as ddd on date_part('day',stud.birthdate) = ddd.day

WHERE NOT EXISTS(SELECT * FROM dm_dob AS ddb 
				 WHERE dob_optional = ddb.dob_optional
				AND birthdate = ddb.birthdate) ORDER BY 2;
				