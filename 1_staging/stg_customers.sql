SELECT 
    Customer_ID,
    -- If Age is blank, fill it with 35
    COALESCE(Age, 35) AS age_cleaned,
    -- If Income is blank, fill it with 50000
    COALESCE(Income, 50000) AS income_cleaned,
    Total_Spent,
    -- This makes sure the computer knows this is a date
    Date AS purchase_date
FROM your_raw_data_table
