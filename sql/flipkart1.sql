SELECT * FROM flipkart.flipkart_ecommerce_analytics;

Describe flipkart.flipkart_ecommerce_analytics;
-- total order
SELECT COUNT(*) AS total_orders
FROM flipkart.flipkart_ecommerce_analytics;

-- actual data 
SELECT *
FROM flipkart.flipkart_ecommerce_analytics
LIMIT 10;

SELECT
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    SUM(Quantity) AS total_quantity
FROM flipkart.flipkart_ecommerce_analytics;

 -- check null and missing value
 SELECT
    SUM(Order_ID IS NULL) AS Order_ID_null,
    SUM(Order_Date IS NULL) AS Order_Date_null,
    SUM(Customer_ID IS NULL) AS Customer_ID_null,
    SUM(Customer_Name IS NULL) AS Customer_Name_null,
    SUM(Segment IS NULL) AS Segment_null,
    SUM(City IS NULL) AS City_null,
    SUM(State IS NULL) AS State_null,
    SUM(Category IS NULL) AS Category_null,
    SUM(Sub_Category IS NULL) AS Sub_Category_null,
    SUM(Brand IS NULL) AS Brand_null,
    SUM(Product_Name IS NULL) AS Product_Name_null,
    SUM(Quantity IS NULL) AS Quantity_null,
    SUM(Unit_Price IS NULL) AS Unit_Price_null,
    SUM(Discount_Pct IS NULL) AS Discount_Pct_null,
    SUM(Discount_Amount IS NULL) AS Discount_Amount_null,
    SUM(Sales IS NULL) AS Sales_null,
    SUM(Cost IS NULL) AS Cost_null,
    SUM(Profit IS NULL) AS Profit_null,
    SUM(Payment_Mode IS NULL) AS Payment_Mode_null,
    SUM(Order_Status IS NULL) AS Order_Status_null
FROM flipkart.flipkart_ecommerce_analytics;

-- Duplicate order IDs
select
    Order_ID,
    count(*) as duplicate_count
from flipkart.flipkart_ecommerce_analytics
group by Order_ID
having count(*)>1;

SELECT
    COUNT(*) - COUNT(DISTINCT Order_ID) AS duplicate_order_rows
FROM flipkart.flipkart_ecommerce_analytics;

SELECT
    Order_ID,
    Order_Date,
    Customer_ID,
    Product_Name,
    COUNT(*) AS duplicate_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY
    Order_ID,
    Order_Date,
    Customer_ID,
    Product_Name
HAVING COUNT(*) > 1;

SELECT *
FROM flipkart.flipkart_ecommerce_analytics
WHERE Quantity <= 0;

SELECT *
FROM flipkart.flipkart_ecommerce_analytics
WHERE Quantity <= 0;

SELECT
    MIN(Unit_Price) AS min_price,
    MAX(Unit_Price) AS max_price,
    AVG(Unit_Price) AS avg_price
FROM flipkart.flipkart_ecommerce_analytics;

SELECT *
FROM flipkart.flipkart_ecommerce_analytics
WHERE Discount_Pct < 0
   OR Discount_Pct > 100;
   
   SELECT
    Order_ID,
    Unit_Price,
    Quantity,
    Discount_Pct,
    Discount_Amount,
    ROUND(Unit_Price * Quantity * Discount_Pct / 100, 2) AS calculated_discount
FROM flipkart.flipkart_ecommerce_analytics
WHERE ABS(
    Discount_Amount -
    ROUND(Unit_Price * Quantity * Discount_Pct / 100, 2)
) > 0.01;

SELECT
    Order_ID,
    Unit_Price,
    Quantity,
    Discount_Amount,
    Sales,
    ROUND(
        Unit_Price * Quantity - Discount_Amount,
        2
    ) AS calculated_sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE ABS(
    Sales -
    ROUND(Unit_Price * Quantity - Discount_Amount, 2)
) > 0.01;
-- Sales calculation validation.
SELECT
    Order_ID,
    Order_Status,
    Unit_Price,
    Quantity,
    Discount_Amount,
    Sales,
    ROUND(
        Unit_Price * Quantity - Discount_Amount,
        2
    ) AS calculated_sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
AND ABS(
    Sales -
    ROUND(Unit_Price * Quantity - Discount_Amount, 2)
) > 0.01;

SELECT
    Order_Status,
    COUNT(*) AS orders,
    SUM(Sales) AS total_sales
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Order_Status;

-- Profit calculation validation
select
   Order_ID,
   Order_status,
   Sales,
   Cost,
   Profit,
   round(Sales-Cost,2) AS calculated_profit
from flipkart.flipkart_ecommerce_analytics
where abs(
    Profit - round(Sales - Cost,2)
)   > 0.01;

SELECT
    Order_ID,
    Order_Status,
    Sales,
    Cost,
    Profit,
    ROUND(Sales - Cost, 2) AS calculated_profit
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
AND ABS(
    Profit - ROUND(Sales - Cost, 2)
) > 0.01;

SELECT
    Order_Status,
    COUNT(*) AS order_count,
    SUM(Sales) AS total_sales,
    SUM(Cost) AS total_cost,
    SUM(Profit) AS total_profit
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status IN ('Returned', 'Cancelled')
GROUP BY Order_Status;

-- Profit Margin validation
SELECT
    Order_ID,
    Sales,
    Profit,
    Profit_Margin_Pct,
    ROUND((Profit / Sales) * 100, 2) AS calculated_margin
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
AND Sales > 0
AND ABS(
    Profit_Margin_Pct -
    ROUND((Profit / Sales) * 100, 2)
) > 0.01;

DESCRIBE flipkart.flipkart_ecommerce_analytics;

SELECT
    Order_Date,
    COUNT(*) AS count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Order_Date
ORDER BY Order_Date
LIMIT 20;

SELECT Order_Date
FROM flipkart.flipkart_ecommerce_analytics
WHERE STR_TO_DATE(Order_Date, '%Y-%m-%d') IS NULL;

SELECT
    MIN(Order_Date) AS earliest_date,
    MAX(Order_Date) AS latest_date
FROM flipkart.flipkart_ecommerce_analytics;

SELECT
    Order_ID,
    Order_Date,
    Month
FROM flipkart.flipkart_ecommerce_analytics
WHERE Month <> DATE_FORMAT(Order_Date, '%Y-%m');

SELECT DISTINCT Order_Status
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY Order_Status;

SELECT DISTINCT Payment_Mode
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY Payment_Mode;

SELECT DISTINCT Segment
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY Segment;

SELECT DISTINCT Category
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY Category;

SELECT DISTINCT Sub_Category
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY Sub_Category;

SELECT DISTINCT City
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY City;

SELECT DISTINCT State
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY State;

SELECT DISTINCT Brand
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY Brand;

SELECT COUNT(*) AS blank_brand_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Brand IS NULL
   OR TRIM(Brand) = '';
   
   SELECT
    MIN(Order_Date) AS first_order_date,
    MAX(Order_Date) AS last_order_date,
    COUNT(*) AS total_orders
FROM flipkart.flipkart_ecommerce_analytics;

SELECT COUNT(*) AS missing_order_dates
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Date IS NULL;

SELECT
    Order_ID,
    Order_Date
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Date < '2025-01-01'
   OR Order_Date > '2025-12-31';
   
   SELECT
    Order_ID,
    Order_Date,
    Month,
    DATE_FORMAT(Order_Date, '%Y-%m') AS calculated_month
FROM flipkart.flipkart_ecommerce_analytics
WHERE Month <> DATE_FORMAT(Order_Date, '%Y-%m');

SELECT COUNT(*) AS missing_month
FROM flipkart.flipkart_ecommerce_analytics
WHERE Month IS NULL
   OR TRIM(Month) = '';
   
   SELECT DISTINCT Month
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY Month;

SELECT
    Order_Status,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Order_Status
ORDER BY order_count DESC;

SELECT
    Payment_Mode,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Payment_Mode
ORDER BY order_count DESC;

SELECT
    Segment,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Segment
ORDER BY order_count DESC;

SELECT
    Category,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Category
ORDER BY order_count DESC;

SELECT
    Sub_Category,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Sub_Category
ORDER BY order_count DESC;

SELECT
    Brand,
    COUNT(*) AS product_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Brand
ORDER BY product_count DESC;

SELECT
    COUNT(*) AS rows_with_leading_trailing_spaces
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_ID <> TRIM(Order_ID)
   OR Customer_ID <> TRIM(Customer_ID)
   OR Customer_Name <> TRIM(Customer_Name)
   OR Segment <> TRIM(Segment)
   OR City <> TRIM(City)
   OR State <> TRIM(State)
   OR Category <> TRIM(Category)
   OR Sub_Category <> TRIM(Sub_Category)
   OR Brand <> TRIM(Brand)
   OR Product_Name <> TRIM(Product_Name)
   OR Payment_Mode <> TRIM(Payment_Mode)
   OR Order_Status <> TRIM(Order_Status);
   
   SELECT
    SUM(Order_ID = '') AS blank_order_id,
    SUM(Customer_ID = '') AS blank_customer_id,
    SUM(Customer_Name = '') AS blank_customer_name,
    SUM(Segment = '') AS blank_segment,
    SUM(City = '') AS blank_city,
    SUM(State = '') AS blank_state,
    SUM(Category = '') AS blank_category,
    SUM(Sub_Category = '') AS blank_subcategory,
    SUM(Brand = '') AS blank_brand,
    SUM(Product_Name = '') AS blank_product,
    SUM(Payment_Mode = '') AS blank_payment,
    SUM(Order_Status = '') AS blank_status
FROM flipkart.flipkart_ecommerce_analytics;

SELECT DISTINCT Order_Status
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status NOT IN ('Delivered', 'Returned', 'Cancelled');

SELECT DISTINCT Payment_Mode
FROM flipkart.flipkart_ecommerce_analytics
WHERE Payment_Mode NOT IN (
    'UPI',
    'Credit Card',
    'Debit Card',
    'COD',
    'Net Banking'
);

SELECT DISTINCT Segment
FROM flipkart.flipkart_ecommerce_analytics
WHERE Segment NOT IN (
    'Consumer',
    'Corporate',
    'Home Office'
);

SELECT
    Order_Date,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Order_Date
ORDER BY Order_Date;

SELECT COUNT(*) AS blank_brand_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Brand IS NULL
   OR TRIM(Brand) = '';
   
   SELECT DISTINCT Product_Name
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY Product_Name;

SELECT COUNT(*) AS blank_product_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Product_Name IS NULL
   OR TRIM(Product_Name) = '';
   
   SELECT COUNT(*) AS blank_customer_name_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Customer_Name IS NULL
   OR TRIM(Customer_Name) = '';
   
   SELECT COUNT(*) AS blank_customer_id_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Customer_ID IS NULL
   OR TRIM(Customer_ID) = '';
   
   SELECT COUNT(*) AS blank_order_id_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_ID IS NULL
   OR TRIM(Order_ID) = '';
   
   SELECT
    Order_ID,
    COUNT(*) AS duplicate_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Order_ID
HAVING COUNT(*) > 1;

SELECT *
FROM flipkart.flipkart_ecommerce_analytics
WHERE Quantity <= 0;

SELECT *
FROM flipkart.flipkart_ecommerce_analytics
WHERE Unit_Price <= 0;

SELECT *
FROM flipkart.flipkart_ecommerce_analytics
WHERE Discount_Pct < 0
   OR Discount_Pct > 100;
   
   SELECT
    Order_ID,
    Unit_Price,
    Quantity,
    Discount_Pct,
    Discount_Amount,
    ROUND(Unit_Price * Quantity * Discount_Pct / 100, 2) AS calculated_discount
FROM flipkart.flipkart_ecommerce_analytics
WHERE ABS(
    Discount_Amount -
    ROUND(Unit_Price * Quantity * Discount_Pct / 100, 2)
) > 0.01;

SELECT
    Order_ID,
    Order_Status,
    Unit_Price,
    Quantity,
    Discount_Amount,
    Sales,
    ROUND(Unit_Price * Quantity - Discount_Amount, 2) AS calculated_sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
AND ABS(
    Sales -
    ROUND(Unit_Price * Quantity - Discount_Amount, 2)
) > 0.01;

SELECT *
FROM flipkart.flipkart_ecommerce_analytics
WHERE Cost < 0;

SELECT
    Order_ID,
    Sales,
    Cost,
    Profit,
    ROUND(Sales - Cost, 2) AS calculated_profit
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
AND ABS(
    Profit - ROUND(Sales - Cost, 2)
) > 0.01;

SELECT
    Order_ID,
    Sales,
    Profit,
    Profit_Margin_Pct,
    ROUND((Profit / Sales) * 100, 2) AS calculated_margin
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
  AND Sales > 0
  AND ABS(
      Profit_Margin_Pct -
      ROUND((Profit / Sales) * 100, 2)
  ) > 0.01;


select
   count(*) as blank_payment_mode_count
from flipkart.flipkart_ecommerce_analytics
where Payment_Mode IS NULL
    or trim(Payment_mode) ='';   
    
    SELECT COUNT(*) AS blank_order_status_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status IS NULL
   OR TRIM(Order_Status) = '';


SELECT *
FROM flipkart.flipkart_ecommerce_analytics
WHERE Discount_Amount < 0;

SELECT *
FROM flipkart.flipkart_ecommerce_analytics
WHERE Sales < 0;

SELECT *
FROM flipkart.flipkart_ecommerce_analytics
WHERE Profit < 0;

SELECT COUNT(*) AS zero_cost_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Cost = 0;  

SELECT COUNT(*) AS invalid_delivered_sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
  AND Sales <= 0; 
  
  SELECT
    Order_Status,
    COUNT(*) AS orders,
    SUM(Sales) AS total_sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status IN ('Returned', 'Cancelled')
GROUP BY Order_Status;

SELECT
    Order_Status,
    COUNT(*) AS orders,
    SUM(Profit) AS total_profit
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status IN ('Returned', 'Cancelled')
GROUP BY Order_Status;

SELECT COUNT(*) AS blank_order_date_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Date IS NULL
   OR TRIM(Order_Date) = '';
   
   SELECT Customer_ID
FROM flipkart.flipkart_ecommerce_analytics
WHERE Customer_ID NOT REGEXP '^CUST[0-9]+$'
LIMIT 20;

SELECT Order_ID
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_ID NOT REGEXP '^ORD[0-9]+$'
LIMIT 20;

SELECT Customer_Name
FROM flipkart.flipkart_ecommerce_analytics
WHERE Customer_Name <> TRIM(Customer_Name)
LIMIT 20;

SELECT Brand
FROM flipkart.flipkart_ecommerce_analytics
WHERE Brand <> TRIM(Brand)
LIMIT 20;

SELECT Product_Name
FROM flipkart.flipkart_ecommerce_analytics
WHERE Product_Name <> TRIM(Product_Name)
LIMIT 20;

SELECT DISTINCT
    City,
    State
FROM flipkart.flipkart_ecommerce_analytics
ORDER BY State, City;

SELECT
    City,
    COUNT(DISTINCT State) AS state_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY City
HAVING COUNT(DISTINCT State) > 1;

SELECT
    City,
    State,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY City, State
ORDER BY City, State;

SELECT
    City,
    State,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE
    (City = 'Bangalore' AND State <> 'Karnataka')
 OR (City = 'Chennai' AND State <> 'Tamil Nadu')
 OR (City = 'Delhi' AND State <> 'Delhi')
 OR (City = 'Gurgaon' AND State <> 'Haryana')
 OR (City = 'Hyderabad' AND State <> 'Telangana')
 OR (City = 'Jaipur' AND State <> 'Rajasthan')
 OR (City = 'Kolkata' AND State <> 'West Bengal')
 OR (City = 'Mumbai' AND State <> 'Maharashtra')
 OR (City = 'Noida' AND State <> 'Uttar Pradesh')
GROUP BY City, State
ORDER BY City, State;

SELECT COUNT(*) AS blank_quantity_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Quantity IS NULL;

SELECT COUNT(*) AS blank_unit_price_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Unit_Price IS NULL;

SELECT COUNT(*) AS blank_discount_pct_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Discount_Pct IS NULL;

SELECT COUNT(*) AS blank_discount_amount_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Discount_Amount IS NULL;

SELECT COUNT(*) AS blank_cost_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Cost IS NULL;

SELECT COUNT(*) AS blank_profit_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Profit IS NULL;

SELECT COUNT(*) AS blank_profit_margin_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Profit_Margin_Pct IS NULL;

SELECT 
    COUNT(*) AS blank_month_count
FROM
    flipkart.flipkart_ecommerce_analytics
WHERE
    Month IS NULL OR TRIM(Month) = '';
    
    SELECT COUNT(*) AS invalid_month_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Month <> DATE_FORMAT(STR_TO_DATE(Order_Date, '%Y-%m-%d'), '%Y-%m');

SELECT COUNT(*) AS blank_state_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE State IS NULL
   OR TRIM(State) = '';
   
   SELECT COUNT(*) AS blank_city_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE City IS NULL
   OR TRIM(City) = '';
   
   SELECT COUNT(*) AS blank_category_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Category IS NULL
   OR TRIM(Category) = '';
   
   
   SELECT COUNT(*) AS blank_subcategory_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Sub_Category IS NULL
   OR TRIM(Sub_Category) = '';
   
   SELECT COUNT(*) AS blank_segment_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Segment IS NULL
   OR TRIM(Segment) = '';
   
   SELECT COUNT(*) AS invalid_discount_amount
FROM flipkart.flipkart_ecommerce_analytics
WHERE Discount_Amount > (Unit_Price * Quantity);

SELECT COUNT(*) AS invalid_sales_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Sales > (Unit_Price * Quantity);

SELECT
    Order_ID,
    Order_Status,
    Unit_Price,
    Quantity,
    Discount_Amount,
    Sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE Sales > (Unit_Price * Quantity);

SELECT COUNT(*) AS invalid_sales_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
  AND ABS(
      Sales - ROUND(Unit_Price * Quantity - Discount_Amount, 2)
  ) > 0.01;
  
SELECT COUNT(*) AS negative_margin_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Profit_Margin_Pct < 0;  

SELECT COUNT(*) AS high_margin_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Profit_Margin_Pct > 100;

SELECT COUNT(*) AS invalid_city_state_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE
    (City = 'Bangalore' AND State <> 'Karnataka')
 OR (City = 'Chennai' AND State <> 'Tamil Nadu')
 OR (City = 'Delhi' AND State <> 'Delhi')
 OR (City = 'Gurgaon' AND State <> 'Haryana')
 OR (City = 'Hyderabad' AND State <> 'Telangana')
 OR (City = 'Jaipur' AND State <> 'Rajasthan')
 OR (City = 'Kolkata' AND State <> 'West Bengal')
 OR (City = 'Mumbai' AND State <> 'Maharashtra')
 OR (City = 'Noida' AND State <> 'Uttar Pradesh');
 
 SELECT COUNT(DISTINCT Customer_ID) AS unique_customers
FROM flipkart.flipkart_ecommerce_analytics;

SELECT
    Customer_ID,
    COUNT(DISTINCT Customer_Name) AS name_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Customer_ID
HAVING COUNT(DISTINCT Customer_Name) > 1;

SELECT
    Product_Name,
    COUNT(DISTINCT Brand) AS brand_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Product_Name
HAVING COUNT(DISTINCT Brand) > 1;

SELECT
    Category,
    Sub_Category,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Category, Sub_Category
ORDER BY Category, Sub_Category;

SELECT
    Brand,
    COUNT(DISTINCT Category) AS category_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Brand
HAVING COUNT(DISTINCT Category) > 1;

SELECT
    Brand,
    Product_Name,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Brand, Product_Name
ORDER BY Brand, Product_Name;
   
   
SELECT
    Product_Name,
    COUNT(DISTINCT Category) AS category_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Product_Name
HAVING COUNT(DISTINCT Category) > 1;

SELECT
    Order_Status,
    Payment_Mode,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Order_Status, Payment_Mode
ORDER BY Order_Status, Payment_Mode;

SELECT
    Order_Status,
    Payment_Mode,
    COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Returned'
GROUP BY Order_Status, Payment_Mode
ORDER BY Payment_Mode;

SELECT COUNT(*) AS invalid_month_date_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE LEFT(Order_Date, 7) <> Month;

SELECT
    SUM(Order_ID IS NULL) AS null_order_id,
    SUM(Order_Date IS NULL) AS null_order_date,
    SUM(Customer_ID IS NULL) AS null_customer_id,
    SUM(Customer_Name IS NULL) AS null_customer_name,
    SUM(City IS NULL) AS null_city,
    SUM(State IS NULL) AS null_state,
    SUM(Category IS NULL) AS null_category,
    SUM(Sub_Category IS NULL) AS null_subcategory,
    SUM(Brand IS NULL) AS null_brand,
    SUM(Product_Name IS NULL) AS null_product,
    SUM(Quantity IS NULL) AS null_quantity,
    SUM(Unit_Price IS NULL) AS null_unit_price,
    SUM(Sales IS NULL) AS null_sales,
    SUM(Cost IS NULL) AS null_cost,
    SUM(Profit IS NULL) AS null_profit
FROM flipkart.flipkart_ecommerce_analytics;

SELECT
    City,
    State AS current_state,
    CASE
        WHEN City = 'Bangalore' THEN 'Karnataka'
        WHEN City = 'Chennai' THEN 'Tamil Nadu'
        WHEN City = 'Delhi' THEN 'Delhi'
        WHEN City = 'Gurgaon' THEN 'Haryana'
        WHEN City = 'Hyderabad' THEN 'Telangana'
        WHEN City = 'Jaipur' THEN 'Rajasthan'
        WHEN City = 'Kolkata' THEN 'West Bengal'
        WHEN City = 'Mumbai' THEN 'Maharashtra'
        WHEN City = 'Noida' THEN 'Uttar Pradesh'
        ELSE State
    END AS corrected_state
FROM flipkart.flipkart_ecommerce_analytics
WHERE State <> CASE
    WHEN City = 'Bangalore' THEN 'Karnataka'
    WHEN City = 'Chennai' THEN 'Tamil Nadu'
    WHEN City = 'Delhi' THEN 'Delhi'
    WHEN City = 'Gurgaon' THEN 'Haryana'
    WHEN City = 'Hyderabad' THEN 'Telangana'
    WHEN City = 'Jaipur' THEN 'Rajasthan'
    WHEN City = 'Kolkata' THEN 'West Bengal'
    WHEN City = 'Mumbai' THEN 'Maharashtra'
    WHEN City = 'Noida' THEN 'Uttar Pradesh'
    ELSE State
END
LIMIT 20;


SHOW INDEX FROM flipkart.flipkart_ecommerce_analytics;

ALTER TABLE flipkart.flipkart_ecommerce_analytics
ADD INDEX idx_order_id (Order_ID(20));

UPDATE flipkart.flipkart_ecommerce_analytics
SET State = CASE
    WHEN City = 'Bangalore' THEN 'Karnataka'
    WHEN City = 'Chennai' THEN 'Tamil Nadu'
    WHEN City = 'Delhi' THEN 'Delhi'
    WHEN City = 'Gurgaon' THEN 'Haryana'
    WHEN City = 'Hyderabad' THEN 'Telangana'
    WHEN City = 'Jaipur' THEN 'Rajasthan'
    WHEN City = 'Kolkata' THEN 'West Bengal'
    WHEN City = 'Mumbai' THEN 'Maharashtra'
    WHEN City = 'Noida' THEN 'Uttar Pradesh'
    ELSE State
END
WHERE Order_ID IS NOT NULL;

SELECT COUNT(*) AS invalid_city_state_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE
    (City = 'Bangalore' AND State <> 'Karnataka')
 OR (City = 'Chennai' AND State <> 'Tamil Nadu')
 OR (City = 'Delhi' AND State <> 'Delhi')
 OR (City = 'Gurgaon' AND State <> 'Haryana')
 OR (City = 'Hyderabad' AND State <> 'Telangana')
 OR (City = 'Jaipur' AND State <> 'Rajasthan')
 OR (City = 'Kolkata' AND State <> 'West Bengal')
 OR (City = 'Mumbai' AND State <> 'Maharashtra')
 OR (City = 'Noida' AND State <> 'Uttar Pradesh');
 
 
 SELECT City, State, COUNT(*) AS order_count
FROM flipkart.flipkart_ecommerce_analytics
WHERE City = 'Pune'
GROUP BY City, State
ORDER BY order_count DESC;

UPDATE flipkart.flipkart_ecommerce_analytics
SET State = 'Maharashtra'
WHERE City = 'Pune'
  AND State <> 'Maharashtra'
  AND Order_ID IS NOT NULL;
  
  DESCRIBE flipkart.flipkart_ecommerce_analytics;
  
  SELECT COUNT(*) AS invalid_dates
FROM flipkart.flipkart_ecommerce_analytics
WHERE STR_TO_DATE(Order_Date, '%Y-%m-%d') IS NULL;

ALTER TABLE flipkart.flipkart_ecommerce_analytics
MODIFY COLUMN Order_Date DATE;

DESCRIBE flipkart.flipkart_ecommerce_analytics;

SELECT COUNT(*) AS invalid_months
FROM flipkart.flipkart_ecommerce_analytics
WHERE Month <> DATE_FORMAT(Order_Date, '%Y-%m');

SELECT
    SUM(Quantity IS NULL) AS null_quantity,
    SUM(Unit_Price IS NULL) AS null_unit_price,
    SUM(Discount_Pct IS NULL) AS null_discount_pct,
    SUM(Discount_Amount IS NULL) AS null_discount_amount,
    SUM(Sales IS NULL) AS null_sales,
    SUM(Cost IS NULL) AS null_cost,
    SUM(Profit IS NULL) AS null_profit,
    SUM(Profit_Margin_Pct IS NULL) AS null_profit_margin
FROM flipkart.flipkart_ecommerce_analytics;

SELECT
    Customer_Name,
    SUM(Sales) AS total_sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Customer_Name
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    Product_Name,
    ROUND(SUM(Profit), 2) AS total_profit
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Product_Name
ORDER BY total_profit DESC
LIMIT 10;

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Category
ORDER BY total_sales DESC;

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Category
ORDER BY total_profit DESC;

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Category
ORDER BY profit_margin_pct DESC;

SELECT
    Customer_Name,
    ROUND(SUM(Sales), 2) AS total_sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Customer_Name
HAVING SUM(Sales) > (
    SELECT AVG(customer_sales)
    FROM (
        SELECT SUM(Sales) AS customer_sales
        FROM flipkart.flipkart_ecommerce_analytics
        WHERE Order_Status = 'Delivered'
        GROUP BY Customer_Name
    ) AS customer_summary
)
ORDER BY total_sales DESC;

SELECT
    Product_Name,
    ROUND(SUM(Profit), 2) AS total_profit
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Product_Name
HAVING SUM(Profit) > (
    SELECT AVG(product_profit)
    FROM (
        SELECT SUM(Profit) AS product_profit
        FROM flipkart.flipkart_ecommerce_analytics
        WHERE Order_Status = 'Delivered'
        GROUP BY Product_Name
    ) AS product_summary
)
ORDER BY total_profit DESC;

SELECT
    f.Customer_Name,
    f.City,
    c.total_sales
FROM flipkart.flipkart_ecommerce_analytics AS f
INNER JOIN (
    SELECT
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
) AS c
ON f.Customer_Name = c.Customer_Name
WHERE f.Order_Status = 'Delivered'
LIMIT 10;

SELECT
    c.Customer_Name,
    c.total_sales,
    f.City
FROM (
    SELECT
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
) AS c
LEFT JOIN flipkart.flipkart_ecommerce_analytics AS f
    ON c.Customer_Name = f.Customer_Name
WHERE f.Order_Status = 'Delivered'
LIMIT 10;

SELECT
    c.Customer_Name,
    COALESCE(s.total_sales, 0) AS total_sales
FROM (
    SELECT DISTINCT Customer_Name
    FROM flipkart.flipkart_ecommerce_analytics
) AS c
LEFT JOIN (
    SELECT
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
) AS s
ON c.Customer_Name = s.Customer_Name
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    f.Customer_Name,
    f.City,
    f.Category,
    s.total_sales
FROM flipkart.flipkart_ecommerce_analytics AS f
INNER JOIN (
    SELECT
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
) AS s
ON f.Customer_Name = s.Customer_Name
WHERE f.Order_Status = 'Delivered'
LIMIT 10;

SELECT DISTINCT
    f.Customer_Name
FROM flipkart.flipkart_ecommerce_analytics AS f
WHERE EXISTS (
    SELECT 1
    FROM flipkart.flipkart_ecommerce_analytics AS d
    WHERE d.Customer_Name = f.Customer_Name
      AND d.Order_Status = 'Delivered'
)
LIMIT 10;

SELECT DISTINCT
    Customer_Name
FROM flipkart.flipkart_ecommerce_analytics
WHERE Customer_Name IN (
    SELECT Customer_Name
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Returned'
)
LIMIT 10;

WITH customer_sales AS (
    SELECT
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
)
SELECT
    Customer_Name,
    total_sales
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 10;

WITH category_sales AS (
    SELECT
        Category,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Category
),
category_profit AS (
    SELECT
        Category,
        ROUND(SUM(Profit), 2) AS total_profit
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Category
)
SELECT
    s.Category,
    s.total_sales,
    p.total_profit
FROM category_sales AS s
INNER JOIN category_profit AS p
    ON s.Category = p.Category
ORDER BY total_profit DESC;


WITH category_sales AS (
    SELECT
        Category,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Category
),
category_profit AS (
    SELECT
        Category,
        ROUND(SUM(Profit), 2) AS total_profit
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Category
)
SELECT
    s.Category,
    s.total_sales,
    p.total_profit
FROM category_sales AS s
INNER JOIN category_profit AS p
    ON s.Category = p.Category
ORDER BY total_profit DESC;

WITH customer_sales AS (
    SELECT
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
)
SELECT
    Customer_Name,
    total_sales,
    ROW_NUMBER() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM customer_sales
ORDER BY sales_rank
LIMIT 10;

WITH customer_sales AS (
    SELECT
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
)
SELECT
    Customer_Name,
    total_sales,
    ROW_NUMBER() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM customer_sales
ORDER BY sales_rank
LIMIT 10;

WITH customer_sales AS (
    SELECT
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
)
SELECT
    Customer_Name,
    total_sales,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM customer_sales
ORDER BY sales_rank
LIMIT 10;

WITH customer_sales AS (
    SELECT
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
)
SELECT
    Customer_Name,
    total_sales,
    DENSE_RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM customer_sales
ORDER BY sales_rank
LIMIT 10;

WITH monthly_sales AS (
    SELECT
        Month,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Month
)
SELECT
    Month,
    total_sales,
    LAG(total_sales) OVER (
        ORDER BY Month
    ) AS previous_month_sales
FROM monthly_sales
ORDER BY Month;

WITH monthly_sales AS (
    SELECT
        Month,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Month
),
monthly_comparison AS (
    SELECT
        Month,
        total_sales,
        LAG(total_sales) OVER (
            ORDER BY Month
        ) AS previous_month_sales
    FROM monthly_sales
)
SELECT
    Month,
    total_sales,
    previous_month_sales,
    ROUND(
        ((total_sales - previous_month_sales)
        / previous_month_sales) * 100,
        2
    ) AS mom_growth_pct
FROM monthly_comparison
ORDER BY Month;

WITH monthly_sales AS (
    SELECT
        Month,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Month
)
SELECT
    Month,
    total_sales,
    LEAD(total_sales) OVER (
        ORDER BY Month
    ) AS next_month_sales
FROM monthly_sales
ORDER BY Month;

SELECT
    Month,
    ROUND(SUM(Sales), 2) AS monthly_sales,
    ROUND(
        SUM(SUM(Sales)) OVER (
            ORDER BY Month
        ),
        2
    ) AS running_total_sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Month
ORDER BY Month;

WITH product_profit AS (
    SELECT
        Category,
        Product_Name,
        ROUND(SUM(Profit), 2) AS total_profit
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Category, Product_Name
),
ranked_products AS (
    SELECT
        Category,
        Product_Name,
        total_profit,
        DENSE_RANK() OVER (
            PARTITION BY Category
            ORDER BY total_profit DESC
        ) AS profit_rank
    FROM product_profit
)
SELECT
    Category,
    Product_Name,
    total_profit,
    profit_rank
FROM ranked_products
WHERE profit_rank <= 3
ORDER BY Category, profit_rank;

WITH customer_sales AS (
    SELECT
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
)
SELECT
    Customer_Name,
    total_sales,
    ROUND(
        (total_sales / SUM(total_sales) OVER ()) * 100,
        2
    ) AS sales_contribution_pct
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    Customer_Name,
    COUNT(*) AS delivered_orders
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Customer_Name
HAVING COUNT(*) > 1
ORDER BY delivered_orders DESC;

WITH customer_orders AS (
    SELECT
        Customer_Name,
        COUNT(*) AS delivered_orders
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_Name
)
SELECT
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN delivered_orders > 1 THEN 1
            ELSE 0
        END
    ) AS repeat_customers,
    ROUND(
        SUM(
            CASE
                WHEN delivered_orders > 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS repeat_customer_rate_pct
FROM customer_orders;

SELECT
    City,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(*) AS delivered_orders
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY City
ORDER BY total_sales DESC;

SELECT
    City,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY City
ORDER BY profit_margin_pct DESC;

WITH category_sales AS (
    SELECT
        Category,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Category
)
SELECT
    Category,
    total_sales,
    ROUND(
        total_sales / SUM(total_sales) OVER () * 100,
        2
    ) AS sales_contribution_pct
FROM category_sales
ORDER BY total_sales DESC;

SELECT
    Category,
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN Order_Status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS returned_orders,
    ROUND(
        SUM(
            CASE
                WHEN Order_Status = 'Returned' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS return_rate_pct
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Category
ORDER BY return_rate_pct DESC;

SELECT
    Category,
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN Order_Status = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,
    ROUND(
        SUM(
            CASE
                WHEN Order_Status = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS cancellation_rate_pct
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Category
ORDER BY cancellation_rate_pct DESC;

SELECT
    COUNT(*) AS total_orders,

    SUM(
        CASE
            WHEN Order_Status = 'Delivered' THEN 1
            ELSE 0
        END
    ) AS delivered_orders,

    SUM(
        CASE
            WHEN Order_Status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS returned_orders,

    SUM(
        CASE
            WHEN Order_Status = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,

    ROUND(
        SUM(
            CASE
                WHEN Order_Status = 'Delivered' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS delivery_rate_pct,

    ROUND(
        SUM(
            CASE
                WHEN Order_Status = 'Returned' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS return_rate_pct,

    ROUND(
        SUM(
            CASE
                WHEN Order_Status = 'Cancelled' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS cancellation_rate_pct

FROM flipkart.flipkart_ecommerce_analytics;

SELECT
    ROUND(SUM(Sales), 2) AS total_sales,
    COUNT(*) AS delivered_orders,
    ROUND(
        SUM(Sales) / COUNT(*),
        2
    ) AS average_order_value
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered';

SELECT
    ROUND(SUM(Profit), 2) AS total_profit,
    COUNT(*) AS delivered_orders,
    ROUND(
        SUM(Profit) / COUNT(*),
        2
    ) AS average_profit_per_order
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered';

SELECT
    ROUND(AVG(Discount_Pct), 2) AS avg_discount_pct,
    ROUND(SUM(Discount_Amount), 2) AS total_discount_amount,
    ROUND(SUM(Sales), 2) AS total_sales
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered';

SELECT
    Payment_Mode,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Payment_Mode
ORDER BY total_sales DESC;

SELECT
    Segment,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Segment
ORDER BY total_sales DESC;

SELECT
    Month,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN Order_Status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders,
    SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END) AS returned_orders,
    SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(
        SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS return_rate_pct,
    ROUND(
        SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS cancellation_rate_pct
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Month
ORDER BY Month;

SELECT
    Month,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Month
ORDER BY total_sales DESC;

SELECT
    State,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY State
ORDER BY total_sales DESC
LIMIT 5;

SELECT
    Brand,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Brand
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    CASE
        WHEN Discount_Pct = 0 THEN 'No Discount'
        WHEN Discount_Pct <= 10 THEN '1-10% Discount'
        WHEN Discount_Pct <= 20 THEN '11-20% Discount'
        ELSE 'Above 20% Discount'
    END AS discount_group,
    COUNT(*) AS delivered_orders,
    ROUND(AVG(Discount_Pct), 2) AS avg_discount_pct,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY
    CASE
        WHEN Discount_Pct = 0 THEN 'No Discount'
        WHEN Discount_Pct <= 10 THEN '1-10% Discount'
        WHEN Discount_Pct <= 20 THEN '11-20% Discount'
        ELSE 'Above 20% Discount'
    END
ORDER BY profit_margin_pct DESC;

SELECT
    Category,
    Product_Name,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Category, Product_Name
HAVING SUM(Sales) > 0
ORDER BY profit_margin_pct ASC
LIMIT 10;

SELECT
    Category,
    Product_Name,
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN Order_Status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS returned_orders,
    ROUND(
        SUM(
            CASE
                WHEN Order_Status = 'Returned' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS return_rate_pct
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Category, Product_Name
HAVING COUNT(*) >= 10
ORDER BY return_rate_pct DESC, returned_orders DESC
LIMIT 10;

SELECT
    Customer_ID,
    Customer_Name,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Sales), 2) AS lifetime_sales,
    ROUND(SUM(Profit), 2) AS lifetime_profit
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Customer_ID, Customer_Name
ORDER BY lifetime_sales DESC
LIMIT 10;

WITH customer_rfm AS (
    SELECT
        Customer_ID,
        Customer_Name,
        MAX(Order_Date) AS last_order_date,
        DATEDIFF(
            (SELECT MAX(Order_Date)
             FROM flipkart.flipkart_ecommerce_analytics),
            MAX(Order_Date)
        ) AS recency_days,
        COUNT(*) AS frequency,
        ROUND(SUM(Sales), 2) AS monetary_value
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_ID, Customer_Name
)
SELECT
    Customer_ID,
    Customer_Name,
    last_order_date,
    recency_days,
    frequency,
    monetary_value
FROM customer_rfm
ORDER BY monetary_value DESC
LIMIT 10;

WITH customer_sales AS (
    SELECT
        Customer_ID,
        Customer_Name,
        ROUND(SUM(Sales), 2) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_ID, Customer_Name
)
SELECT
    Customer_ID,
    Customer_Name,
    total_sales,
    CASE
        WHEN total_sales >= 300000 THEN 'High Value'
        WHEN total_sales >= 150000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 20;

WITH customer_sales AS (
    SELECT
        Customer_ID,
        Customer_Name,
        SUM(Sales) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_ID, Customer_Name
),
customer_segments AS (
    SELECT
        Customer_ID,
        total_sales,
        CASE
            WHEN total_sales >= 300000 THEN 'High Value'
            WHEN total_sales >= 150000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_sales
)
SELECT
    customer_segment,
    COUNT(*) AS customer_count,
    ROUND(SUM(total_sales), 2) AS total_sales,
    ROUND(AVG(total_sales), 2) AS average_sales_per_customer
FROM customer_segments
GROUP BY customer_segment
ORDER BY total_sales DESC;

WITH customer_sales AS (
    SELECT
        Customer_ID,
        SUM(Sales) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Customer_ID
),
customer_segments AS (
    SELECT
        total_sales,
        CASE
            WHEN total_sales >= 300000 THEN 'High Value'
            WHEN total_sales >= 150000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS customer_segment
    FROM customer_sales
),
segment_summary AS (
    SELECT
        customer_segment,
        SUM(total_sales) AS segment_sales
    FROM customer_segments
    GROUP BY customer_segment
)
SELECT
    customer_segment,
    ROUND(segment_sales, 2) AS total_sales,
    ROUND(
        segment_sales / SUM(segment_sales) OVER () * 100,
        2
    ) AS sales_contribution_pct
FROM segment_summary
ORDER BY sales_contribution_pct DESC;

SELECT
    Segment,
    Payment_Mode,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / SUM(Sales) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY
    Segment,
    Payment_Mode
ORDER BY
    Segment,
    total_sales DESC;
    
    WITH monthly_category_sales AS (
    SELECT
        Month,
        Category,
        SUM(Sales) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Month, Category
),
sales_comparison AS (
    SELECT
        Month,
        Category,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY Category
            ORDER BY Month
        ) AS previous_month_sales
    FROM monthly_category_sales
)
SELECT
    Month,
    Category,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(previous_month_sales, 2) AS previous_month_sales,
    ROUND(
        (total_sales - previous_month_sales)
        / NULLIF(previous_month_sales, 0) * 100,
        2
    ) AS mom_growth_pct
FROM sales_comparison
ORDER BY Category, Month;

WITH category_profit AS (
    SELECT
        Category,
        ROUND(SUM(Profit), 2) AS total_profit
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Category
),
category_ranking AS (
    SELECT
        Category,
        total_profit,
        DENSE_RANK() OVER (
            ORDER BY total_profit DESC
        ) AS profit_rank
    FROM category_profit
)
SELECT
    Category,
    total_profit,
    profit_rank
FROM category_ranking
ORDER BY profit_rank;

SELECT
    Category,
    Sub_Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Category, Sub_Category
ORDER BY total_profit DESC
LIMIT 10;

SELECT
    Brand,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Brand
ORDER BY total_profit DESC
LIMIT 10;

WITH payment_profit AS (
    SELECT
        Payment_Mode,
        COUNT(*) AS delivered_orders,
        SUM(Profit) AS total_profit
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Payment_Mode
)
SELECT
    Payment_Mode,
    delivered_orders,
    ROUND(total_profit, 2) AS total_profit,
    ROUND(
        total_profit / SUM(total_profit) OVER () * 100,
        2
    ) AS profit_contribution_pct
FROM payment_profit
ORDER BY total_profit DESC;

SELECT
    Segment,
    Payment_Mode,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Segment, Payment_Mode
ORDER BY Segment, total_profit DESC;


SELECT
    Segment,
    Payment_Mode,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) / NULLIF(SUM(Sales), 0) * 100,
        2
    ) AS profit_margin_pct
FROM flipkart.flipkart_ecommerce_analytics
WHERE Order_Status = 'Delivered'
GROUP BY Segment, Payment_Mode
ORDER BY Segment, total_profit DESC;

WITH monthly_sales AS (
    SELECT
        Month,
        SUM(Sales) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Month
)
SELECT
    Month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        total_sales / SUM(total_sales) OVER () * 100,
        2
    ) AS sales_contribution_pct
FROM monthly_sales
ORDER BY Month;

WITH monthly_sales AS (
    SELECT
        Month,
        SUM(Sales) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Month
)
SELECT
    Month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        total_sales / SUM(total_sales) OVER () * 100,
        2
    ) AS sales_contribution_pct
FROM monthly_sales
ORDER BY Month;

WITH monthly_sales AS (
    SELECT
        Month,
        SUM(Sales) AS total_sales
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Month
)
SELECT
    Month,
    ROUND(total_sales, 2) AS monthly_sales,
    ROUND(
        SUM(total_sales) OVER (
            ORDER BY Month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS cumulative_sales
FROM monthly_sales
ORDER BY Month;

WITH product_profit AS (
    SELECT
        Category,
        Product_Name,
        SUM(Profit) AS total_profit
    FROM flipkart.flipkart_ecommerce_analytics
    WHERE Order_Status = 'Delivered'
    GROUP BY Category, Product_Name
),
ranked_products AS (
    SELECT
        Category,
        Product_Name,
        ROUND(total_profit, 2) AS total_profit,
        DENSE_RANK() OVER (
            PARTITION BY Category
            ORDER BY total_profit DESC
        ) AS product_rank
    FROM product_profit
)
SELECT
    Category,
    Product_Name,
    total_profit,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY Category, product_rank;

WITH product_returns AS (
    SELECT
        Category,
        Product_Name,
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN Order_Status = 'Returned' THEN 1
                ELSE 0
            END
        ) AS returned_orders
    FROM flipkart.flipkart_ecommerce_analytics
    GROUP BY Category, Product_Name
)
SELECT
    Category,
    Product_Name,
    total_orders,
    returned_orders,
    ROUND(
        returned_orders * 100.0 / total_orders,
        2
    ) AS return_rate_pct
FROM product_returns
WHERE total_orders >= 10
ORDER BY return_rate_pct DESC
LIMIT 10;

WITH product_metrics AS (
    SELECT
        Category,
        Product_Name,
        COUNT(*) AS total_orders,
        SUM(
            CASE
                WHEN Order_Status = 'Returned' THEN 1
                ELSE 0
            END
        ) AS returned_orders,
        SUM(
            CASE
                WHEN Order_Status = 'Delivered' THEN Sales
                ELSE 0
            END
        ) AS delivered_sales,
        SUM(
            CASE
                WHEN Order_Status = 'Delivered' THEN Profit
                ELSE 0
            END
        ) AS delivered_profit
    FROM flipkart.flipkart_ecommerce_analytics
    GROUP BY Category, Product_Name
)
SELECT
    Category,
    Product_Name,
    total_orders,
    ROUND(
        returned_orders * 100.0 / total_orders,
        2
    ) AS return_rate_pct,
    ROUND(delivered_sales, 2) AS delivered_sales,
    ROUND(delivered_profit, 2) AS delivered_profit,
    ROUND(
        delivered_profit / NULLIF(delivered_sales, 0) * 100,
        2
    ) AS profit_margin_pct
FROM product_metrics
WHERE total_orders >= 10
  AND delivered_sales > 0
ORDER BY return_rate_pct DESC, profit_margin_pct ASC
LIMIT 10;

SELECT
    Month,
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN Order_Status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS returned_orders,
    SUM(
        CASE
            WHEN Order_Status = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,
    ROUND(
        SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS return_rate_pct,
    ROUND(
        SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_pct
FROM flipkart.flipkart_ecommerce_analytics
GROUP BY Month
ORDER BY Month;

SELECT
    COUNT(*) AS total_orders,

    SUM(CASE
        WHEN Order_Status = 'Delivered' THEN 1
        ELSE 0
    END) AS delivered_orders,

    SUM(CASE
        WHEN Order_Status = 'Returned' THEN 1
        ELSE 0
    END) AS returned_orders,

    SUM(CASE
        WHEN Order_Status = 'Cancelled' THEN 1
        ELSE 0
    END) AS cancelled_orders,

    ROUND(SUM(CASE
        WHEN Order_Status = 'Delivered' THEN Sales
        ELSE 0
    END), 2) AS total_sales,

    ROUND(SUM(CASE
        WHEN Order_Status = 'Delivered' THEN Profit
        ELSE 0
    END), 2) AS total_profit,

    ROUND(
        SUM(CASE WHEN Order_Status = 'Delivered' THEN Sales ELSE 0 END)
        / NULLIF(SUM(CASE WHEN Order_Status = 'Delivered' THEN 1 ELSE 0 END), 0),
        2
    ) AS average_order_value,

    ROUND(
        SUM(CASE WHEN Order_Status = 'Delivered' THEN Profit ELSE 0 END)
        / NULLIF(SUM(CASE WHEN Order_Status = 'Delivered' THEN Sales ELSE 0 END), 0)
        * 100,
        2
    ) AS profit_margin_pct,

    ROUND(
        SUM(CASE WHEN Order_Status = 'Returned' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS return_rate_pct,

    ROUND(
        SUM(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_pct

FROM flipkart.flipkart_ecommerce_analytics;