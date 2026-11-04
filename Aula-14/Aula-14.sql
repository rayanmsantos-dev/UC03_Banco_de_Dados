-- ------------------ Funções de agregação ------------------
USE sakila;
DESCRIBE rental;
SELECT
    COUNT(*)     AS total_alugueis,
	COUNT(return_date)     AS devolvidos
FROM rental;

SELECT
     COUNT(*)       AS pagamento,
     COUNT(DISTINCT customer_id)     AS clientes_que_pagaram
FROM payment;

 DESCRIBE film;
 SELECT
    MIN(length)    AS mais_curto,
    MAX(length)    AS mais_longo,
    AVG(length)    AS media,
    ROUND(AVG(length), 1)    AS media_arredonda
 FROM film;

DESCRIBE payment;
SELECT
     SUM(amount)       AS faturamento,
     COUNT(*)          AS pagamentos,
     ROUND(AVG(amount), 2)          AS ticket_medio 
FROM payment
WHERE payment_date
BETWEEN '2005-07-01 00:00:00' AND '2005-07-31 23:59:59';

-- ---------------- Agrupadores ----------------
SELECT
    staff_id      AS 'funcionário',
    COUNT(*)      AS pagamentos,
    SUM(amount)   AS total_recebido
FROM payment
GROUP BY staff_id;

DESCRIBE film;
SELECT
	rental_duration   AS dias,
    COUNT(*)          AS filmes,
    ROUND(AVG(rental_rate), 2)   AS 'preço_médio'
FROM film
GROUP BY rental_duration
ORDER BY dias DESC;

SELECT
    store_id    AS loja,
    active      AS ativo,
    COUNT(*)    AS clientes
FROM customer
GROUP BY store_id, active
ORDER BY loja, ativo;

SELECT
    customer_id   AS cliente,
    COUNT(*)      AS alugueis_julho
FROM rental
WHERE rental_date
    BETWEEN '2005-07-01 00:00:00' AND '2005-07-31 23:59:59'
GROUP BY customer_id
HAVING COUNT(*) >= 19
ORDER BY alugueis_julho DESC, cliente;

-- ---------------- Funções de texto e data ----------------
SELECT
    CONCAT(first_name, ' ', last_name) AS nome_completo_deste_cliente,
    email
FROM customer
LIMIT 5;

SELECT 
    CONCAT(
    'UPDATE customer SET first_name =' ,
    'teste',
    ' WHERE customer_id = ', customer_id, ';') AS query
FROM customer
LIMIT 5;

SELECT
	address,
    district,
    UPPER(district)  AS distrito_etiqueta
FROM address
LIMIT 5;

SELECT
    rental_id,
    rental_date,
    DATE_FORMAT(rental_date, '%d/%m/%Y %H:%i') AS data_br
FROM rental
LIMIT 5;

SELECT
    YEAR(payment_date)      AS ano,
    MONTH(payment_date)     AS mes,
    CONCAT('Funcionário', staff_id) AS funcionario,
    SUM(amount)             AS total
FROM payment
GROUP BY YEAR(payment_date), MONTH(payment_date), staff_id
ORDER BY ano, mes, staff_id;