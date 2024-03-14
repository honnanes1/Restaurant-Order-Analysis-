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
SELECT MIN(order_date) AS min_date,
       MAX(order_date) AS max_date FROM restaurant_db.order_details;
--  How many orders were made within this date range? How many items were ordered within this date range?
SELECT COUNT(DISTINCT order_id) AS orders 
	FROM restaurant_db.order_details;
SELECT COUNT(*) AS items
FROM restaurant_db.order_details;

--  Which orders had the most number of items?
  SELECT * FROM (
      SELECT order_id, count(item_id) AS items FROM restaurant_db.order_details 
      GROUP BY order_id
      ORDER BY items DESC) AS sub
    WHERE items = (SELECT MAX(items) FROM (
      SELECT order_id, count(item_id) AS items FROM restaurant_db.order_details 
      GROUP BY order_id
      ORDER BY items DESC) subsub);
--  How many orders had more than 12 items?
  SELECT count(*) AS orders_over_12_items FROM
    (SELECT order_id, count(item_id) AS num_items
     FROM restaurant_db.order_details
     GROUP BY order_id
     HAVING num_items > 12) AS num_orders;
 --  Combine the menu_items and order_details tables into a single table
  SELECT *
    FROM restaurant_db.order_details 
    LEFT JOIN restaurant_db.menu_items
    ON restaurant_db.order_details.item_id = restaurant_db.menu_items.menu_item_id
    LIMIT 10;

 --  What were the least and most ordered items? What categories were they in?
-- Least ordered item 
SELECT
    item_name AS least_ordered_item,
    category AS category_least_ordered,
    order_count AS order_count_least
FROM
    (SELECT
        item_id,
        COUNT(*) AS order_count
    FROM
        order_details
    GROUP BY
        item_id
    ORDER BY
        order_count ASC
    LIMIT 1) AS od
JOIN
    menu_items ON item_id = item_id;
-- Most ordered item 
SELECT
    item_name AS most_ordered_item,
    category AS category_most_ordered,
    order_count AS order_count_most
FROM
    (SELECT
        item_id,
        COUNT(*) AS order_count
    FROM
        order_details
    GROUP BY
        item_id
    ORDER BY
        order_count DESC
    LIMIT 1) AS od
JOIN
    menu_items ON item_id = item_id;
 --  What were the top 5 orders that spent the most money?
SELECT
    order_id,
    SUM(price) AS total_spent
FROM
    order_details od
JOIN
    menu_items ON item_id = menu_item_id
GROUP BY
    order_id
ORDER BY
    total_spent DESC
 -- View the details of the highest spend order. Which specific items were purchased?
SELECT
    order_id,
    item_name,
    price,
    SUM(price) OVER (PARTITION BY order_id) AS total_order_price
FROM
    order_details
JOIN
    menu_items ON item_id = menu_item_id
WHERE
    order_id = (
        SELECT
            order_id
        FROM
            order_details
        JOIN
            menu_items ON item_id = menu_item_id
        GROUP BY
            order_id
        ORDER BY
            SUM(price) DESC
        LIMIT 1
    );
