--Product Sales Analysis I

SELECT Product.product_name, Sales.year, Sales.price
FROM Product
JOIN Sales ON (Sales.product_id = Product.product_id);
