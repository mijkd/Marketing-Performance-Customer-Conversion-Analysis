-- Cleaning whitespace issues in review text

SELECT 
    ReviewID,  -- Review identifier
    CustomerID,  -- Customer's unique ID
    ProductID,  -- Product's unique ID
    ReviewDate,  -- Date of the review
    Rating,  -- Customer's rating (e.g., 1 to 5 stars)
    
    -- Replaces double spaces with single spaces for better readability
    REPLACE(ReviewText, '  ', ' ') AS ReviewText  

FROM 
    dbo.customer_reviews;  -- Source table containing customer reviews
