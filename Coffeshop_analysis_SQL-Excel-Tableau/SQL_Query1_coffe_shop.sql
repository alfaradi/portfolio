SELECT DISTINCT
	sr.transaction_id,
	DATEADD(day, 0, DATEDIFF(day, 0, sr.transaction_date)) +
    DATEADD(day, 0 - DATEDIFF(day, 0, sr.transaction_time), sr.transaction_time) as date_time,
	FORMAT(sr.transaction_date, 'dddd') as day_of_week,
	sr.sales_outlet_id,
	CONCAT(so.store_address,' ',so.store_city) as outlet_adress,
	so.store_longitude,
	so.store_latitude,
	CONCAT(st.first_name, ' ',st.last_name,'(',st.position,')') as staff_name,
	cus.[customer_first-name],
	genb.generation,
	pr.product_group,
	pr.product_category,
	pr.product_type,
	pr.product,
	sr.quantity,
	sr.unit_price/100 as total_price
FROM coffeshop..sales_reciepts sr
LEFT JOIN coffeshop..sales_outlet so
ON sr.sales_outlet_id = so.sales_outlet_id
LEFT JOIN coffeshop..staff st
ON sr.staff_id = st.staff_id
LEFT JOIN coffeshop..customer cus
ON sr.customer_id = cus.customer_id
LEFT JOIN coffeshop..product pr
ON sr.product_id = pr.product_id
LEFT JOIN
	(SELECT cus.customer_id, cus.birth_year, gen.generation
	FROM coffeshop..customer cus
	LEFT JOIN coffeshop..generations gen
	ON cus.birth_year = gen.birth_year) as genb
ON sr.customer_id = genb.customer_id