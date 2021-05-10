INSERT INTO ft_tbl_data(id, aggregate_id, timestamp, id_cat , category)
SELECT * FROM (
SELECT id, aggregate_id, timestamp, id_cat , category FROM 
(SELECT stud.id, stud.aggregate_id, stud.timestamp, du.id AS id_cat, du.category FROM stg_tbl_users_data AS stud
INNER JOIN dm_users AS du on stud.name = du.name) AS A
UNION ALL
SELECT id, aggregate_id, timestamp, id_cat, category FROM 
(SELECT stud.id, stud.aggregate_id, stud.timestamp, dp.id AS id_cat, dp.category FROM stg_tbl_users_data AS stud
INNER JOIN dm_product AS dp on stud.name = dp.product) AS B
UNION ALL
SELECT id, aggregate_id, timestamp, id_cat, category FROM 
(SELECT stud.id, stud.aggregate_id, stud.timestamp, dp.id AS id_cat, dp.category FROM stg_tbl_users_data AS stud
INNER JOIN dm_action_type AS dp on stud.type = dp.type WHERE stud.type NOT IN ('customer_registered','product_ordered')) AS C) AS D

WHERE NOT EXISTS(SELECT * FROM ft_tbl_data AS ftd WHERE id = ftd.id
				AND aggregate_id = ftd.aggregate_id
				AND timestamp = ftd.timestamp
				AND id_cat = ftd.id_cat
				AND category = ftd.category)