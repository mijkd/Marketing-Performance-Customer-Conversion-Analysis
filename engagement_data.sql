-- Cleaning and normalizing engagement data

SELECT 
    EngagementID,  -- Engagement record ID
    ContentID,  -- Content ID
    CampaignID,  -- Marketing campaign ID
    ProductID,  -- Product ID

    -- Standardizing "Socialmedia" to "Social Media" and converting to uppercase
    UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType,  

    -- Extracting Views (substring before '-')
    LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS Views,  

    -- Extracting Clicks (substring after '-')
    RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks,  

    Likes,  -- Number of likes  

    -- Formatting date as dd.mm.yyyy
    FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate  

FROM 
    dbo.engagement_data  -- Source table  

WHERE 
    ContentType != 'Newsletter';  -- Excluding 'Newsletter' content  
