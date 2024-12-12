select*from global_electronics.customer_data;
select*from global_electronics.exchange_data;
select*from global_electronics.products;
select*from global_electronics.sales;
select*from global_electronics.stores;


-- 10 queries to get insights from 5 tables
-- Query to count the number of customers by gender
SELECT 
    COUNT(CASE WHEN Gender = 'Female' THEN 1 END) AS Female_count,
    COUNT(CASE WHEN Gender = 'Male' THEN 1 END) AS Male_count
FROM global_electronics.customer_data;

-- Query to count customers based on their location (continent, country, and state)
SELECT 
    Continent, 
    Country, 
    State, 
    COUNT(*) AS customer_count
FROM global_electronics.customer_data
GROUP BY Continent, Country, State;

-- Query to categorize customers into age groups (minor, adult, old)
SELECT 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(Birthday, '%Y-%m-%d'), CURDATE()) BETWEEN 20 AND 39 THEN '20-39'
        WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(Birthday, '%Y-%m-%d'), CURDATE()) BETWEEN 40 AND 59 THEN '40-59'
        WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(Birthday, '%Y-%m-%d'), CURDATE()) BETWEEN 60 AND 79 THEN '60-79'
        WHEN TIMESTAMPDIFF(YEAR, STR_TO_DATE(Birthday, '%Y-%m-%d'), CURDATE()) >= 80 THEN '80 and above'
    END AS Age_Group,
    COUNT(*) AS Count_Age_Customers
FROM global_electronics.customer_data
GROUP BY Age_Group;

-- Query to calculate the contribution of each currency in the exchange data
SELECT 
    Currency_Code, 
    SUM(Exchange) AS Total_Contribution
FROM global_electronics.exchange_data
GROUP BY Currency_Code
ORDER BY Total_Contribution DESC;

-- Query to get the average exchange rate by year
SELECT 
    YEAR(STR_TO_DATE(Date, '%Y-%m-%d')) AS Year,              
    AVG(Exchange) AS Average_Rate 
FROM global_electronics.exchange_data                     
GROUP BY Year                              
ORDER BY Year;

-- Query to count products by category, subcategory, and product name
SELECT 
    Category, 
    COUNT(DISTINCT Subcategory) AS Subcategory_Count, 
    COUNT(DISTINCT Product_Name) AS Product_Name_Count, 
    COUNT(*) AS Product_Count 
FROM global_electronics.products
GROUP BY Category
ORDER BY Category;

-- Query to analyze product sales by brand
SELECT 
    Brand, 
    SUM(CAST(Unit_Price_USD AS DECIMAL(10, 2))) AS total_sales, 
    COUNT(*) AS product_count 
FROM global_electronics.products
GROUP BY Brand
ORDER BY total_sales DESC;


-- Query to count products by color
SELECT 
    Color,                                        
    COUNT(*) AS product_count                     
FROM global_electronics.products                                  
GROUP BY Color                                      
ORDER BY product_count DESC;                          

-- Query to calculate profit by product subcategory
SELECT 
    Subcategory, 
    SUM(CAST(Unit_Cost_USD AS DECIMAL(10, 2))) AS total_manufacturing_cost, 
    SUM(CAST(Unit_Price_USD AS DECIMAL(10, 2))) AS total_selling_cost, 
    SUM(CAST(Unit_Price_USD AS DECIMAL(10, 2))) - SUM(CAST(Unit_Cost_USD AS DECIMAL(10, 2))) AS total_profit 
FROM global_electronics.products
GROUP BY Subcategory
ORDER BY total_profit DESC;

-- Query to get the total sales quantity by year
SELECT 
    YEAR(STR_TO_DATE(Order_Date, '%Y-%m-%d')) AS year,                 
    SUM(Quantity) AS total_quantity           
FROM global_electronics.sales                                  
GROUP BY year                                       
ORDER BY year;

-- Query to calculate the sales contribution of each currency
SELECT 
    Currency_Code, 
    SUM(Quantity) AS total_quantity, 
    ROUND(SUM(Quantity) / (SELECT SUM(Quantity) FROM global_electronics.sales) * 100, 2) AS contribution_percentage
FROM global_electronics.sales
GROUP BY Currency_Code
ORDER BY total_quantity DESC;

-- Query to calculate total store counts and square meters by country
SELECT 
    Country,                                  
    COUNT(*) AS total_stores,                 
    SUM(Square_Meters) AS total_square_meter    
FROM global_electronics.stores                                 
GROUP BY Country                                  
ORDER BY total_square_meter DESC;






