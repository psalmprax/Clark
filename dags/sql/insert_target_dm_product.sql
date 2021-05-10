INSERT INTO dm_product(product, category)
SELECT DISTINCT stud.name as type, 2 FROM public.stg_tbl_users_data AS stud
WHERE type = 'product_ordered' AND
NOT EXISTS(SELECT * FROM dm_product dp WHERE product = stud.name)
ORDER BY name