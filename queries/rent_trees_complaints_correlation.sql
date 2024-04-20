
    WITH RentRank AS (
        SELECT zipcode, AVG(rent_price) as average_rent,
        RANK() OVER (ORDER BY AVG(rent_price) DESC) rent_rank_desc,
        RANK() OVER (ORDER BY AVG(rent_price) ASC) rent_rank_asc
        FROM zillow_data
        WHERE data_date = '2024-01-31'
        GROUP BY zipcode
    ),
    TreeCount AS (
        SELECT zipcode, COUNT(*) as tree_count
        FROM tree_data
        GROUP BY zipcode
    ),
    ComplaintCount AS (
        SELECT zipcode, COUNT(*) as complaint_count
        FROM complaints_data
        WHERE created_date >= '2024-01-01' AND created_date < '2024-02-01'
        GROUP BY zipcode
    )
    SELECT r.zipcode,
    TO_CHAR(r.average_rent, 'FM9,999,999.00') as average_rent,
    t.tree_count,
    c.complaint_count
    FROM RentRank r
    JOIN TreeCount t ON r.zipcode = t.zipcode
    LEFT JOIN ComplaintCount c ON r.zipcode = c.zipcode
    WHERE r.rent_rank_desc <= 5 OR r.rent_rank_asc <= 5
    ORDER BY r.average_rent DESC
