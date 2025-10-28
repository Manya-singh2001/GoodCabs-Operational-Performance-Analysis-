-- BUSINESS PROBLEMS 

/* Business Request - 1: City—Level Fare and Trip Summary Report

Generate a report that displays the total trips, average fare per km, average fare per trip, and the percentage contribution of each city’s
trips to the overall trips. This report will help in assessing trip volume, pricing efficiency, and each city’s contribution to the overall
trip count.

  Fields:

    city_name
    total_trips
    avg_fare_per_km
    avg_fare_per_trip
    %_contribution_to_total_trips */
    
  SELECT
  d.city_name,
  COALESCE(t.total_trips, 0) AS total_trips,
  -- Weighted average fare per km: total fare divided by total distance (NULL if no distance)
  ROUND(
    CASE WHEN COALESCE(t.total_distance, 0) = 0
         THEN NULL
         ELSE t.total_fare / t.total_distance
    END
  , 2) AS avg_fare_per_km,
  -- Average fare per trip: total fare divided by total trips (NULL if no trips)
  ROUND(
    CASE WHEN COALESCE(t.total_trips, 0) = 0
         THEN NULL
         ELSE t.total_fare / t.total_trips
    END
  , 2) AS avg_fare_per_trip,
  -- Percentage contribution to overall trips (0.00 - 100.00); NULL if overall_trips = 0
  ROUND( COALESCE(t.total_trips, 0) * 100.0 / NULLIF(o.overall_trips, 0), 2 ) 
    AS `%_contribution_to_total_trips`
FROM dim_city d
LEFT JOIN (
  -- aggregate per city from fact_trips
  SELECT
    city_id,
    COUNT(*) AS total_trips,
    SUM(fare_amount) AS total_fare,
    SUM(distance_travelled) AS total_distance
  FROM fact_trips
  GROUP BY city_id
) t ON d.city_id = t.city_id
CROSS JOIN (
  -- overall trips across all cities (used for percentage denominator)
  SELECT COUNT(*) AS overall_trips FROM fact_trips
) o
ORDER BY total_trips DESC;

-- Overall trips 
SELECT COUNT(*) AS overall_trips FROM fact_trips;

-- Sum of per-city totals
SELECT SUM(total_trips) AS sum_per_city
FROM (
  SELECT city_id, COUNT(*) AS total_trips
  FROM fact_trips
  GROUP BY city_id
) x;

-- Sum of exact (unrounded) % contributions should be 100 (or NULL if overall_trips=0)
SELECT ROUND(SUM(total_trips * 100.0 / NULLIF((SELECT COUNT(*) FROM fact_trips), 0)), 6) AS pct_sum
FROM (
  SELECT city_id, COUNT(*) AS total_trips
  FROM fact_trips
  GROUP BY city_id
) x;

        
/* Business Request - 2: Monthly City-Level Trips Target Performance Report

Generate a report that evaluates the target performance for trips at the monthly and city level. For each city and month, compare the actual
total trips with the target trips and categorise the performance as follows:

  If actual trips are greater than target trips, mark it as "Above Target".
  If actual trips are less than or equal to target trips, mark it as "Below Target".

Additionally, calculate the % difference between actual and target trips to quantify the performance gap.

  Fields:

    City_name
    month_name
    actua|_trips
    target_trips
    performance_status
    %_difference  */
    
WITH trips_actual AS 
(SELECT 
 city_id, 
 DATE_FORMAT(date, '%Y-%m-01') AS start_of_month,
 COUNT(trip_id) AS actual_trips 
 FROM fact_trips
 GROUP BY city_id, start_of_month),
 
 dim_date_monthly AS 
 (SELECT 
 start_of_month, 
 month_name
 FROM 
 dim_date 
 GROUP BY 
 start_of_month, month_name)
 
 SELECT
 dim_city.city_name,
 monthly_target_trips.month,
 IFNULL(trips_actual.actual_trips, 0) AS actual_trips,
 IFNULL(monthly_target_trips.total_target_trips, 0) AS target_trips,
 CASE 
 WHEN IFNULL(trips_actual.actual_trips, 0) > IFNULL(monthly_target_trips.total_target_trips, 0) THEN "Above Traget"
 ELSE "Below Target"
 END AS performance_status, 
 CASE 
 WHEN monthly_target_trips.total_target_trips > 0 THEN 
 ROUND ((trips_actual.actual_trips - monthly_target_trips.total_target_trips)* 100 / monthly_target_trips.total_target_trips, 2)
 ELSE 
 NULL 
 END AS percentage_difference 
 
 FROM 
 dim_date 
 LEFT JOIN 
 trips_actual ON dim_date.start_of_month = trips_actual.start_of_month 
 LEFT JOIN 
 dim_city ON dim_city.city_id = trips_actual.city_id
 LEFT JOIN 
 monthly_target_trips ON trips_actual.start_of_month = monthly_target_trips.month
 AND trips_actual.city_id = monthly_target_trips.city_id 
 
 ORDER BY
 dim_city.city_name, dim_date.start_of_month
 
    
/* Business Request - 3: City-Level Repeat Passenger Trip Frequency Report

Generate a report that shows the percentage distribution of repeat passengers by the number of trips they have taken in each city.
Calculate the percentage of repeat passengers who took 2 trips, 3 trips, and so on, up to 10 trips.

Each column should represent a trip count category, displaying the percentage of repeat passengers who fall into that category out of the
total repeat passengers for that city.

This report will help identify cities with high repeat trip frequency, which can indicate strong customer loyalty or frequent usage patterns.

  Fields: 
  city_name, 2-Trips, 3-Trips, 4-Trips, 5-Trips, 6-Trips, 7-Trips, 8-Trips, 9-Trips, 10-Trips  */

    
WITH city_totals AS (
    SELECT
        city_id,
        SUM(repeat_passenger_count) AS total_repeat_passengers
    FROM dim_repeat_trip_distribution
    WHERE trip_count BETWEEN '2-Trips' AND '10-Trips'
    GROUP BY city_id
),

trip_distribution AS (
    SELECT
        d.city_id,
        d.trip_count,
        SUM(d.repeat_passenger_count) AS repeat_passenger_count
    FROM dim_repeat_trip_distribution AS d
    WHERE d.trip_count BETWEEN '2-Trips' AND '10-Trips'
    GROUP BY d.city_id, d.trip_count
)

SELECT
    c.city_name,
    ROUND(SUM(CASE WHEN t.trip_count = '2-Trips' THEN (t.repeat_passenger_count / ct.total_repeat_passengers) * 100 END), 2) AS `2-Trips`,
    ROUND(SUM(CASE WHEN t.trip_count = '3-Trips' THEN (t.repeat_passenger_count / ct.total_repeat_passengers) * 100 END), 2) AS `3-Trips`,
    ROUND(SUM(CASE WHEN t.trip_count = '4-Trips' THEN (t.repeat_passenger_count / ct.total_repeat_passengers) * 100 END), 2) AS `4-Trips`,
    ROUND(SUM(CASE WHEN t.trip_count = '5-Trips' THEN (t.repeat_passenger_count / ct.total_repeat_passengers) * 100 END), 2) AS `5-Trips`,
    ROUND(SUM(CASE WHEN t.trip_count = '6-Trips' THEN (t.repeat_passenger_count / ct.total_repeat_passengers) * 100 END), 2) AS `6-Trips`,
    ROUND(SUM(CASE WHEN t.trip_count = '7-Trips' THEN (t.repeat_passenger_count / ct.total_repeat_passengers) * 100 END), 2) AS `7-Trips`,
    ROUND(SUM(CASE WHEN t.trip_count = '8-Trips' THEN (t.repeat_passenger_count / ct.total_repeat_passengers) * 100 END), 2) AS `8-Trips`,
    ROUND(SUM(CASE WHEN t.trip_count = '9-Trips' THEN (t.repeat_passenger_count / ct.total_repeat_passengers) * 100 END), 2) AS `9-Trips`,
    ROUND(SUM(CASE WHEN t.trip_count = '10-Trips' THEN (t.repeat_passenger_count / ct.total_repeat_passengers) * 100 END), 2) AS `10-Trips`
FROM
    trip_distribution AS t
JOIN
    city_totals AS ct ON t.city_id = ct.city_id
JOIN
    dim_city AS c ON c.city_id = t.city_id
GROUP BY
    c.city_name
ORDER BY
    c.city_name;



/* Business Request - 4: Identify Cities with Highest and Lowest Total New Passengers

Generate a report that calculates the total new passengers for each city and ranks them based on this value. Identify the top 3 cities with
the highest number of new passengers as well as the bottom 3 cities with the lowest number of new passengers, categorising them as "Top 3"
or "Bottom 3" accordingly.

  Fields

    city_name
    total_new_passengers
    city_category ("Top 3" or "Bottom 3")  */
    
    WITH city_new_passengers AS (
    SELECT
        fps.city_id,
        SUM(fps.new_passengers) AS total_new_passengers
    FROM fact_passenger_summary AS fps
    GROUP BY fps.city_id
),

ranked_cities AS (
    SELECT
        c.city_name,
        cn.total_new_passengers,
        RANK() OVER (ORDER BY cn.total_new_passengers DESC) AS rank_desc,
        RANK() OVER (ORDER BY cn.total_new_passengers ASC) AS rank_asc
    FROM city_new_passengers AS cn
    JOIN dim_city AS c ON cn.city_id = c.city_id
)

SELECT
    city_name,
    total_new_passengers,
    CASE
        WHEN rank_desc <= 3 THEN 'Top 3'
        WHEN rank_asc <= 3 THEN 'Bottom 3'
        ELSE NULL
    END AS city_category
FROM ranked_cities
WHERE
    rank_desc <= 3 OR rank_asc <= 3
ORDER BY
    total_new_passengers DESC;
    
    
/* Business Request - 5: Identify Month with Highest Revenue for Each City

Generate a report that identifies the month with the highest revenue for each city. For each city, display the month_name, the revenue amount
for that month, and the percentage contribution of that month’s revenue to the city’s total revenue.

  Fields

    city_name
    highest_revenue_month
    revenue
    percentage_contribution (%)  */
    
    
    WITH city_month_revenue AS (
    SELECT
        ft.city_id,
        DATE_FORMAT(ft.date, '%Y-%m-01') AS start_of_month,
        SUM(ft.fare_amount) AS monthly_revenue
    FROM fact_trips AS ft
    GROUP BY ft.city_id, start_of_month
),

city_total_revenue AS (
    SELECT
        city_id,
        SUM(monthly_revenue) AS total_revenue
    FROM city_month_revenue
    GROUP BY city_id
),

ranked_revenue AS (
    SELECT
        cmr.city_id,
        cmr.start_of_month,
        cmr.monthly_revenue,
        ctr.total_revenue,
        RANK() OVER (PARTITION BY cmr.city_id ORDER BY cmr.monthly_revenue DESC) AS revenue_rank
    FROM city_month_revenue AS cmr
    JOIN city_total_revenue AS ctr
      ON cmr.city_id = ctr.city_id
)

SELECT
    c.city_name,
    d.month_name AS highest_revenue_month,
    rr.monthly_revenue AS revenue,
    ROUND((rr.monthly_revenue / rr.total_revenue) * 100, 2) AS percentage_contribution
FROM ranked_revenue AS rr
JOIN dim_city AS c
  ON rr.city_id = c.city_id
JOIN dim_date AS d
  ON DATE_FORMAT(d.date, '%Y-%m-01') = rr.start_of_month
WHERE rr.revenue_rank = 1
ORDER BY c.city_name;
    
    
/* Business Request - 6: Repeat Passenger Rate Analysis

Generate a report that calculates two metrics:

  1. Monthly Repeat Passenger Rate: Calculate the repeat passenger rate for each city and month by com paring the number of repeat passengers
    to the total passengers.
  2. City-wide Repeat Passenger Rate: Calculate the overall repeat passenger rate for each city, considering all passengers across months.

These metrics will provide insights into monthly repeat trends as well as the overall repeat behaviour for each city.

  Fields:

    city_name
    month
    total_passengers
    repeat_passengers
    monthly_repeat_passenger_rate (%): Repeat passenger rate at the city and month level
    city_repeat_passenger_rate (%): Overall repeat passenger rate for each city, aggregated across months */
    
    WITH monthly_repeat_rate AS (
    SELECT
        fps.city_id,
        fps.month,
        SUM(fps.total_passengers) AS total_passengers,
        SUM(fps.repeat_passengers) AS repeat_passengers,
        ROUND((SUM(fps.repeat_passengers) * 100.0 / NULLIF(SUM(fps.total_passengers), 0)), 2) AS monthly_repeat_passenger_rate
    FROM fact_passenger_summary AS fps
    GROUP BY fps.city_id, fps.month
),

city_repeat_rate AS (
    SELECT
        city_id,
        SUM(total_passengers) AS city_total_passengers,
        SUM(repeat_passengers) AS city_repeat_passengers,
        ROUND((SUM(repeat_passengers) * 100.0 / NULLIF(SUM(total_passengers), 0)), 2) AS city_repeat_passenger_rate
    FROM fact_passenger_summary
    GROUP BY city_id
)

SELECT
    c.city_name,
    d.month_name AS month,
    mrr.total_passengers,
    mrr.repeat_passengers,
    mrr.monthly_repeat_passenger_rate,
    crr.city_repeat_passenger_rate
FROM monthly_repeat_rate AS mrr
JOIN city_repeat_rate AS crr
  ON mrr.city_id = crr.city_id
JOIN dim_city AS c
  ON mrr.city_id = c.city_id
JOIN dim_date AS d
  ON mrr.month = d.month_name
ORDER BY c.city_name, d.month_name;


--------------------------------------------------------------------------------------------------------------------------------------
