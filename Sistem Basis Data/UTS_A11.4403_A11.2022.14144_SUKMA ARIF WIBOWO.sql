-- Nama : Sukma Arif Wibowo --
-- NIM : A11.2022.14144-
-- Kelp. = A11.4403 --


-- soal 1 --
SELECT c.customerNumber, c.customerName, c.city, c.country, p.checkNumber, p.paymentDate, p.amount
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber;

-- soal 2 --
SELECT o.orderNumber, o.orderDate, c.customerName, c.city, c.country, p.checkNumber, p.amount
FROM orders o
JOIN customers c ON o.customerNumber = c.customerNumber
JOIN payments p ON c.customerNumber = p.customerNumber;

-- soal 3 --
CREATE TABLE customers_usa AS
SELECT *
FROM customers
WHERE country = 'USA';

-- soal 4 --
SELECT cu.customerNumber, cu.customerName, cu.city
FROM customers_usa cu
JOIN (
    SELECT customerNumber, MIN(amount) AS min_amount
    FROM payments
    GROUP BY customerNumber
) AS min_payments ON cu.customerNumber = min_payments.customerNumber;

-- soal 5 --
CREATE VIEW vcustomerUSA AS
SELECT customerName, phone, city, country
FROM customers
WHERE country = 'USA';

-- soal 6 --
CREATE INDEX idxcustomerNumber ON customers_usa (customerNumber);

-- soal 7 --
SELECT cu.city, SUM(p.amount) AS total_amount
FROM customers_usa cu
JOIN payments p ON cu.customerNumber = p.customerNumber
GROUP BY cu.city;

-- soal 8 --
CREATE OR REPLACE FUNCTION fDecAmount(amount NUMERIC, persen NUMERIC)
RETURNS NUMERIC AS
$$
DECLARE
    decreased_amount NUMERIC;
BEGIN
    decreased_amount := amount - (amount * persen / 100);
    RETURN decreased_amount;
END;
$$
LANGUAGE plpgsql;

-- soal 9A --
CREATE TABLE payments_gt100 AS
SELECT *
FROM payments
WHERE amount > 100000;

-- soal 9B --
CREATE OR REPLACE PROCEDURE sp_update_amount(jml_persen NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE payments_gt100
    SET amount = amount - (amount * jml_persen / 100);
END;
$$;

-- soal 10A --
CREATE TABLE orderdetails_gt80 LIKE orderdetails;
INSERT INTO orderdetails_gt80
SELECT *
FROM orderdetails
WHERE quantityOrdered > 80;

-- soal 10B --
ALTER TABLE orderdetails_gt80
ADD COLUMN subtotal DECIMAL(10, 2);
UPDATE orderdetails_gt80
SET subtotal = quantityOrdered * priceEach;

-- soal 11 -- 
CREATE OR REPLACE FUNCTION update_subTotal()
RETURNS TRIGGER AS $$
BEGIN
    NEW.subtotal := NEW.quantityOrdered * NEW.priceEach;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER t_update_subTotal
BEFORE UPDATE OF quantityOrdered, priceEach
ON orderdetails_gt80
FOR EACH ROW
EXECUTE FUNCTION update_subTotal();

-- soal 12 --
CREATE TRIGGER t_hitung_subTotal
AFTER INSERT
ON orderdetails_gt80
FOR EACH ROW
BEGIN
    UPDATE orderdetails_gt80
    SET subtotal = (quantity * unit_price)
    WHERE order_id = NEW.order_id AND product_id = NEW.product_id;
END;
