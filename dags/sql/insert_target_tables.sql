INSERT INTO stg_tbl_users_data
SELECT trim('"' FROM (sub.element->'id')::text) as id,
trim('"' FROM (sub.element->'aggregate_id')::text) as aggregate_id,
trim('"' FROM (sub.element->'type')::text) as type,
((sub.element->>'timestamp')::timestamp)  as timestamp,

CASE WHEN (sub.element->'data'->'name'->0) is not NULL THEN
		trim('"' FROM (sub.element->'data'->'name'->0)::text)
	ELSE trim('"' FROM (sub.element->'data'->'name')::text) END
as name,
CASE WHEN (sub.element->'data'->'name'->1) is not NULL THEN
		(sub.element->'data'->'name'->1)
	ELSE null END
as dob_optional,

((sub.element->'data'->>'birthdate')::timestamp) as birthdate
FROM
 (SELECT json_array_elements('{}') as element) AS sub

where not exists(SELECT * FROM public.stg_tbl_users_data as raw_data where id = raw_data.id
and aggregate_id = raw_data.aggregate_id
and type = raw_data.type
and timestamp = raw_data.timestamp
and name = raw_data.name
and dob_optional = raw_data.dob_optional
and birthdate = raw_data.birthdate);