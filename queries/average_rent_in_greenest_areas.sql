
    WITH TopTreeZipCodes AS (
        SELECT zipcode, COUNT(*) as tree_count
        FROM tree_data
        GROUP BY zipcode
        ORDER BY tree_count DESC
        LIMIT 10
    )
    SELECT t.zipcode, TO_CHAR(AVG(z.rent_price), 'FM9,999,999.00') as average_rent
    FROM TopTreeZipCodes t
    JOIN zillow_data z ON t.zipcode = z.zipcode AND z.data_date = '2024-01-31'
    GROUP BY t.zipcode, t.tree_count
    ORDER BY t.tree_count DESC
