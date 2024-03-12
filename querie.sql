--  View the menu_items table and write a query to find the number of items on the menu
    SELECT count(*) AS menu_items FROM restaurant_db.menu_items;
-- What are the least and most expensive items on the menu?
-- Most expensive item
SELECT
    item_name as most_expensive_item,
    price 
FROM
    menu_items
ORDER BY
    price DESC
limit 1; 
-- Least expensive item
SELECT
    item_name as least_expensive_item,
    price 
FROM
    menu_items
ORDER BY
    price asc
limit 1; 
-- How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu?
-- How many Italian dishes are on the menu?
select
    COUNT(item_name) AS italian_dish_count
FROM
    menu_items
WHERE
    category = 'Italian';

-- what are the least and most expensive Italian dishes on the menu? 
SELECT
    item_name AS least_expensive_italian_dish,
    price AS least_expensive_price
FROM
    menu_items
WHERE
    category = 'Italian'
ORDER BY
    price ASC
LIMIT 1;

SELECT
    item_name AS most_expensive_italian_dish,
    price AS most_expensive_price
FROM
    menu_items
WHERE
    category = 'Italian'
ORDER BY
    price DESC
LIMIT 1;

-- How many dishes are in each category? What is the average dish price within each category?
select
    category,
	count(item_name) as num_dishes, 
    AVG(price) AS average_dish_price
FROM
    menu_items
GROUP BY
    category;
-- View the order_details table. What is the date range of the table?

--  How many orders were made within this date range? How many items were ordered within this date range?

--  Which orders had the most number of items?

--  How many orders had more than 12 items?

 --  Combine the menu_items and order_details tables into a single table


 --  What were the least and most ordered items? What categories were they in?

 --  What were the top 5 orders that spent the most money?

 -- View the details of the highest spend order. Which specific items were purchased?

