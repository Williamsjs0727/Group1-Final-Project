
    WITH TreeCount AS (
        SELECT z.zipcode, COUNT(*) as tree_count
        FROM tree_data t
        JOIN zipcode_data z ON ST_Contains(z.geom, t.geom)
        GROUP BY z.zipcode
    )
    SELECT zipcode, tree_count
    FROM TreeCount
    ORDER BY tree_count DESC
    LIMIT 10
