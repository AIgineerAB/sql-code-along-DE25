# Sakila
## Dashboard Demonstration

```sql film_ratings
SELECT 
    rating,
    COUNT(*) AS number_film
FROM sakila.film
GROUP BY rating
```

<BarChart
    data = {film_ratings}
    x = rating
    y = number_film
    title = "No of films by rating"
/>
