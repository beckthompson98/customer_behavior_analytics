-- STEP 1: Calculate the Raw Numbers (How much, how often, how recent)
WITH customer_summary AS (
    SELECT 
        Customer_ID,
        -- How many days ago was their last purchase?
        DATEDIFF(day, MAX(purchase_date), CURRENT_DATE) AS recency_days,
        -- How many total purchases did they make?
        COUNT(Customer_ID) AS frequency_count,
        -- How much total money did they spend?
        SUM(Total_Spent) AS total_monetary_value
    FROM 1_staging.stg_customers
    GROUP BY Customer_ID
),

-- STEP 2: Give them a Score from 1 to 5 (1 is lowest, 5 is highest)
rfm_scores AS (
    SELECT 
        *,
        -- NTILE(5) splits customers into 5 equal groups based on their stats
        NTILE(5) OVER (ORDER BY recency_days DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency_count ASC) AS f_score,
        NTILE(5) OVER (ORDER BY total_monetary_value ASC) AS m_score
    FROM customer_summary
)

-- STEP 3: Combine the scores into one final RFM ID
SELECT 
    *,
    (r_score + f_score + m_score) AS total_rfm_score
FROM rfm_scores;
