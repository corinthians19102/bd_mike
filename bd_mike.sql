/*Exercício 1: Listar todos os pedidos com detalhes do cliente:Escreva uma consulta SQL que retorne o ID do pedido, a data do pedido, o nome completo do cliente e o email para todos os pedidos. Use um JOIN para combinar as tabelas Orders e Customers.*/
SELECT 
    Orders.order_id,
    Orders.order_date,
    Customers.first_name,
    Customers.last_name,
    Customers.email
FROM 
    Orders
INNER JOIN 
    Customers ON Orders.customer_id = Customers.customer_id;
    
/*Exercício 2: Encontrar todos os produtos pedidos por um cliente específico:Escreva uma consulta SQL que retorne o nome do produto e a quantidade pedida para todos os produtos pedidos por um cliente com um customer_id específico (por exemplo, customer_id = 1). Essa consulta deve combinar as tabelas Order_Items, Orders e Products.*/

SELECT 
    Products.product_name,
    Order_Items.quantity
FROM 
    Order_Items
JOIN 
    Orders ON Order_Items.order_id = Orders.order_id
JOIN 
    Products ON Order_Items.product_id = Products.product_id
WHERE 
    Orders.customer_id = 1;
    
/*Exercício 3: Calcular o total gasto por cada cliente:Escreva uma consulta SQL que calcule o total gasto por cada cliente. O resultado deve incluir o nome completo do cliente e o total gasto. Essa consulta deve usar JOINs para combinar as tabelas Customers, Orders, Order_Items e Products, e deve usar uma função de agregação para calcular o total.*/

SELECT 
    c.first_name || ' ' || c.last_name AS full_name,
    SUM(oi.quantity * p.price) AS total_spent
FROM 
    Customers c
JOIN 
    Orders o ON c.customer_id = o.customer_id
JOIN 
    Order_Items oi ON o.order_id = oi.order_id
JOIN 
    Products p ON oi.product_id = p.product_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name;

/*Exercício 4: Encontrar os clientes que nunca fizeram um pedido:Escreva uma consulta SQL que retorne os nomes dos clientes que nunca fizeram um pedido. Para isso, use um LEFT JOIN entre as tabelas Customers e Orders e filtre os resultados para encontrar clientes sem pedidos.*/

SELECT 
    c.first_name,
    c.last_name
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.customer_id = o.customer_id
WHERE 
    o.order_id IS NULL;

/*Exercício 5: Listar os produtos mais vendidos:Escreva uma consulta SQL que retorne o nome do produto e a quantidade total vendida, ordenando os resultados pelos produtos mais vendidos. Combine as tabelas Order_Items e Products, e utilize uma função de agregação para somar a quantidade vendida de cada produto.*/

SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM 
    Order_Items oi
JOIN 
    Products p ON oi.product_id = p.product_id
GROUP BY 
    p.product_name
ORDER BY 
    total_quantity_sold DESC;
