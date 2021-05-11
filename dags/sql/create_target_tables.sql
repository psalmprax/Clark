CREATE TABLE IF NOT EXISTS stg_tbl_users_data
(
  	id text,
	aggregate_id text,
	type text,
	timestamp timestamp,
	name text,
	dob_optional text,
	birthdate date

);


CREATE TABLE IF NOT EXISTS ft_tbl_data
(
  	id text,
	aggregate_id text,
	timestamp timestamp,
	id_cat integer,
	category integer
);


CREATE TABLE IF NOT EXISTS order_fulfilled_stat
(
  	aggregate_id text,
	order_accepted timestamp,
   	order_fulfilled_OR_cancelled timestamp,
	difference_in_min DOUBLE PRECISION,
	order_fulfilled_status text
);


CREATE TABLE IF NOT EXISTS dm_dob_year
(
	id SERIAL not null primary key,
  	year int
);


CREATE TABLE IF NOT EXISTS dm_dob_month
(
	id SERIAL not null primary key,
  	month int
);


CREATE TABLE IF NOT EXISTS dm_dob_day
(
	id SERIAL not null primary key,
    	day int
);



CREATE TABLE IF NOT EXISTS dm_dob
(
  	id SERIAL not null primary key,
	dob_optional text,
	birthdate date,
  	dob_year integer references dm_dob_year(id),
	dob_month integer references dm_dob_month(id),
	dob_day integer references dm_dob_day(id)
);

		  
CREATE TABLE IF NOT EXISTS dm_users
(
  	id SERIAL not null primary key,
	name text,
	category integer,
	dob_id integer references dm_dob(id)
);


CREATE TABLE IF NOT EXISTS dm_action_type
(
  	id SERIAL not null primary key,
	type text,
	category integer
);

CREATE TABLE IF NOT EXISTS dm_product
(
  	id SERIAL not null primary key,
	product text,
	category integer
);