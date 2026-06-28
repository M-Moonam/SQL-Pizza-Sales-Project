-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT name, Revenue  FROM
(SELECT category, name, revenue,
rank() over(partition by category ORDER BY Revenue DESC) as rn
FROM
(SELECT pizza_types.category, pizza_types.name,
SUM((order_details.quantity) * pizzas.price) as Revenue
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category, pizza_types.name) as a) as b
WHERE rn <= 3;