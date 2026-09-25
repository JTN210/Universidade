#Liste o nome e o contacto de todos os estafetas, ordenados pelo nome de forma ascendente.
SELECT NOME, CONTACTO
FROM Estafeta
ORDER BY NOME ASC;

# Apresente a designação e o preço por dose de todos os pratos do tipo 'entrada'.
SELECT DESIGNACAO, PRECO_DOSE
FROM Prato
WHERE TIPO="CARNE";

#Mostre os dados completos dos clientes cujo código postal começa por '47'.
SELECT *
FROM Cliente
WHERE COD_POSTAL LIKE '47%';

# Liste todos os pedidos cujo preço está entre 10€ e 50€, ordenados do mais caro para o mais barato. Apresente apenas os 3 mais caros
SELECT * 
FROM Pedido 
WHERE preco BETWEEN '10.0' AND '50.0' ORDER BY preco ASC limit 3;

# Liste os nomes únicos dos clientes que fizeram pelo menos um pedido depois de 1 de janeiro de 2024.

SELECT DISTINCT C.nome
FROM Cliente C , Pedido P
WHERE C.idCliente=P.idCliente AND P.data_pedido>'2024-01-01';

# Mostre a designação do prato, a dose e o preço de cada item de pedido, apenas para os pratos do tipo 'prato principal' ou 'sobremesa'.

SELECT DISTINCT P.designacao, IP.dose, IP.preco
FROM Prato P
LEFT JOIN Item_pedido IP
ON P.idPrato=IP.idPrato
WHERE P.tipo IN ('CARNE', 'VEGANO');

#Apresente o nome do cliente, a data do pedido e o nome do estafeta, apenas para pedidos com estafeta atribuído e realizados durante o ano de 2025
SELECT C.nome, P.data_pedido, E.nome 
FROM Cliente C
INNER JOIN Pedido P 
ON C.idCliente=P.idCliente
INNER JOIN Estafeta E 
ON P.idEstafeta=E.idEstafeta
WHERE P.idEstafeta IS NOT NULL AND YEAR(P.data_pedido)='2025';

# Quantos pedidos existem na base de dados? Apresente o resultado com o alias 'total_pedidos'.
SELECT count(idpedido) AS toal_pedidos
FROM Pedido;

#Qual o preço médio e o preço máximo dos pratos? Use aliases 'preco_medio' e 'preco_maximo'. Arredonde a média a 2 casas decimais.
SELECT ROUND(AVG(preco_dose),2) AS preco_medio, MAX(preco_dose) AS preco_maximo 
FROM Prato; 

# Mostre o número de pedidos realizados por cada cliente. Apresente apenas os clientes com mais de 1 pedido.

SELECT count(idCliente) AS numero_pedidos
FROM Pedido
GROUP BY idCliente
HAVING count(idCliente)>1;

# Apresente o valor total faturado por cada estafeta, com o nome do estafeta. Ordene do maior para o menor.

SELECT idEstafeta, SUM(preco)
FROM Pedido
GROUP BY idEstafeta
ORDER BY SUM(preco) DESC;