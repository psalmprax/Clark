INSERT INTO dm_action_type(type, category)
SELECT DISTINCT stud.type as type, 3 FROM public.stg_tbl_users_data AS stud
WHERE NOT EXISTS(SELECT * FROM dm_action_type as dat WHERE type = stud.type)
ORDER BY type