-- Identifying and tagging duplicate records using a CTE  

WITH DuplicateRecords AS (
    SELECT 
        JourneyID,  -- Unique journey identifier  
        CustomerID,  -- Customer identifier  
        ProductID,  -- Product identifier  
        VisitDate,  -- Visit date for tracking interactions  
        Stage,  -- Customer journey stage (e.g., Awareness, Consideration)  
        Action,  -- Customer action (e.g., View, Click, Purchase)  
        Duration,  -- Duration of interaction  

        -- Assign row numbers to detect duplicates  
        ROW_NUMBER() OVER (
            PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action  
            ORDER BY JourneyID  
        ) AS row_num  

    FROM dbo.customer_journey  
)

-- Select duplicate records (row_num > 1)  
SELECT *
FROM DuplicateRecords
-- WHERE row_num > 1  -- Uncomment to filter out only duplicate entries  
ORDER BY JourneyID;

-- Cleaning and standardizing data  

SELECT 
    JourneyID,  -- Journey identifier  
    CustomerID,  -- Customer identifier  
    ProductID,  -- Product identifier  
    VisitDate,  -- Visit date  
    Stage,  -- Standardized stage name  
    Action,  -- Customer action  
    COALESCE(Duration, avg_duration) AS Duration  -- Fill missing durations with daily average  

FROM (
    SELECT 
        JourneyID,  
        CustomerID,  
        ProductID,  
        VisitDate,  
        UPPER(Stage) AS Stage,  -- Convert stage names to uppercase  
        Action,  
        Duration,  
        AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration,  -- Compute average duration per day  

        -- Assign row numbers to identify duplicates  
        ROW_NUMBER() OVER (
            PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action  
            ORDER BY JourneyID  
        ) AS row_num  

    FROM dbo.customer_journey  
) AS subquery  
WHERE row_num = 1;  -- Keep only the first occurrence of each duplicate  
