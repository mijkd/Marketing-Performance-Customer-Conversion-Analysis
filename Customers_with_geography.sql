-- Joining customers with geography data

SELECT 
    c.CustomerID,  -- Customer identifier
    c.CustomerName,  -- Name of the customer
    c.Email,  
    c.Gender,  
    c.Age,  
    g.Country,  -- Country from geography table
    g.City  -- City from geography table

FROM 
    dbo.customers AS c  
 LEFT JOIN
-- RIGHT JOIN
-- INNER JOIN
-- FULL OUTER JOIN
    dbo.geography AS g  
ON 
    c.GeographyID = g.GeographyID;  -- Matching customers with location details
