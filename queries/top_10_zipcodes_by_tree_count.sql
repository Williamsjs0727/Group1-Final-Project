
    SELECT zipcode, COUNT(*) as tree_count
    FROM tree_data
    GROUP BY zipcode
    ORDER BY tree_count DESC
    LIMIT 10
