-- soal 1 --
SELECT p.productCode,p.productName,p.productLine,pl.textDescription,p.productDescription,p.quantityInStock,p.buyPrice
FROM products p ,productlines pl
WHERE p.productLine=pl.productLine

-- soal 2 --
SELECT o.orderNumber,orderDate,o.status,o.customerNumber,c.customerName,c.phone,od.productCode,p.productName,od.priceEach,od.orderLineNumber,
       od.quantityOrdered*od.priceEach AS subtotal
FROM orders o,orderdetails od,products p,customers c
WHERE o.orderNumber=od.orderNumber AND o.customerNumber=c.customerNumber
    AND od.productCode=p.productCode

-- soal 3 --
SELECT DISTINCT o.orderNumber,orderDate,o.customerNumber,c.customerName,
                od.quantityOrdered*od.priceEach AS subtotal
FROM orders o,orderdetails od,products p,customers c
WHERE o.orderNumber=od.orderNumber AND o.customerNumber=c.customerNumber
AND (od.quantityOrdered*od.priceEach) IN
(SELECT MAX(od.quantityOrdered*od.priceEach) AS maks FROM orders o,orderdetails od
WHERE o.orderNumber=od.orderNumber)

-- soal 4 --
SELECT c.customerNumber,c.customerName,c.phone,p.amount
FROM customers c,payments p
WHERE c.customerNumber=p.customerNumber
  AND p.amount > (SELECT AVG(amount) FROM payments);

-- soal 5 --
CREATE TABLE products_gt50
SELECT * FROM products WHERE buyprice>50;

-- soal 6 --
-- cara biasa --
UPDATE products_gt50 SET buyprice=buyprice+(buyprice*0.1)
WHERE buyprice>100;
-- cara menggunakan subquery --
UPDATE products_gt50 SET buyprice=buyprice+(buyprice*0.1)
WHERE productCode IN (SELECT productCode FROM products_gt50 WHERE buyprice>100)

-- soal 7 --
CREATE VIEW vcustomerUFJ AS
SELECT customerName,phone,city,country
FROM customers WHERE country IN ('USA','France','Japan');
SELECT * FROM vcustomerUFJ;

-- soal 8 --
CREATE UNIQUE INDEX idxproductcode ON products_gt50(productcode);