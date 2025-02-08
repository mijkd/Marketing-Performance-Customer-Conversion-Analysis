-- Categorizing products based on price range

SELECT 
    ProductID,  -- Product identifier
    ProductName,  -- Name of the product
    Price,  -- Product price

    CASE  
        WHEN Price < 50 THEN 'Low'  
        WHEN Price BETWEEN 50 AND 200 THEN 'Medium'  
        ELSE 'High'  
    END AS PriceCategory  -- Price category classification

FROM 
    dbo.products;  -- Source table
