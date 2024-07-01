--Movie Rating



WITH Avg_rating AS (
    SELECT 
        MR.movie_id,
        AVG(MR.rating) AS AVGRATING
    FROM 
        MovieRating MR
    WHERE 
        YEAR(MR.created_at) = 2020 AND MONTH(MR.created_at) = 2
    GROUP BY 
        MR.movie_id
),
Best_movies AS (
    SELECT 
        M.title
    FROM 
        Avg_rating AR
        JOIN Movies M ON M.movie_id = AR.movie_id
    WHERE 
        AR.AVGRATING = (
            SELECT MAX(AVGRATING) FROM Avg_rating
        )
    ORDER BY 
        M.title ASC
    LIMIT 1
),
User_ratings AS (
    SELECT 
        U.name AS results,
        COUNT(MR.movie_id) AS Howmanymovies
    FROM 
        Users U
        JOIN MovieRating MR ON U.user_id = MR.user_id
    GROUP BY 
        U.name
),
Most_movies AS (
    SELECT 
        results
    FROM 
        User_ratings
    WHERE 
        Howmanymovies = (
            SELECT MAX(Howmanymovies) FROM User_ratings
        )
    ORDER BY 
        results ASC
    LIMIT 1
)
SELECT * FROM (
    SELECT results FROM Most_movies
    UNION ALL
    SELECT title FROM Best_movies
) AS final_results;
