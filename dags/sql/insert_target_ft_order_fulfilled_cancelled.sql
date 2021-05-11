INSERT INTO order_fulfilled_stat(aggregate_id,order_accepted,order_fulfilled_OR_cancelled,difference_in_min,order_fulfilled_status)
SELECT *, EXTRACT(epoch FROM AGE(order_cancelled,order_accepted))/60 AS difference_in_min, 'order_cancelled'
FROM crosstab( 'select * from (select aggregate_id, type, timestamp from stg_tbl_users_data 
			  WHERE type NOT IN (''customer_registered'',''product_ordered'', ''order_fulfilled'', ''order_declined'') order by 1,3) as agg ') 

      AS final_result(aggregate_id TEXT, 
 					 order_accepted timestamp,
   					 order_cancelled timestamp--,
 					 )
	  WHERE order_cancelled IS NOT NULL;


INSERT INTO order_fulfilled_stat(aggregate_id,order_accepted,order_fulfilled_OR_cancelled,difference_in_min,order_fulfilled_status)
SELECT *, EXTRACT(epoch FROM AGE(order_fulfilled,order_accepted))/60 AS difference_in_min, 'order_fulfilled' FROM (SELECT * 
FROM crosstab( 'select * from (select aggregate_id, type, timestamp from stg_tbl_users_data 
			  WHERE type NOT IN (''customer_registered'',''product_ordered'', ''order_cancelled'', ''order_declined'') order by 1,3) as agg ') 

      AS final_result(aggregate_id TEXT, 
 					 order_accepted timestamp,
   					 order_fulfilled timestamp
					 )
	   WHERE order_fulfilled IS NOT NULL) AS A;