-- This is the final table for the Business Team
SELECT
    Customer_ID,
    recency_days,
    frequency_count,
    total_monetary_value,
    total_rfm_score,
    -- Here we give customers "Titles" based on their score
    CASE
        WHEN total_rfm_score >= 14 THEN 'Champions'
        WHEN total_rfm_score >= 11 THEN 'Loyal Customers'
        WHEN total_rfm_score >= 8 THEN 'Potential Loyalists'
        WHEN total_rfm_score >= 5 THEN 'At Risk'
        ELSE 'Hibernating'
    END AS customer_segment
FROM 2_intermediate.int_rfm_metrics;
