/* SA2 - Implementação e manipulação do banco de embalagens
   Aluno(a):
   Antes: execute o embalagens-base-sa2.sql. */
USE embalagens;

-- ETAPA 1: dados de teste (INSERT e UPDATE)

INSERT INTO ordem_producao (data_ordem, qtd_planejada, qtd_boa, qtd_refugo, consumo_kg, unidade_codigo, produto_codigo)
VALUES 
('2026-11-03', 5000, 4800, 200, 60, 1, 1),
('2026-11-03', 5000, 4950, 50, 25, 1, 2),
('2026-11-04', 8000, 7650, 350, 160, 2, 3),
('2026-11-05', 3000, 2880, 120, 18, 3, 2),
('2026-11-05', 4000, 3900, 100, 48, 1, 1);

SELECT * FROM ordem_producao;


INSERT INTO expedicao (data_saida, unidade_codigo, cliente_cnpj)
VALUES 
('2026-11-06', 1, '11.111.111/0001-11'),
('2026-11-06', 2, '22.222.222/0001-22');

SELECT * FROM expedicao;

INSERT INTO item_expedicao (expedicao_numero, produto_codigo, quantidade, preco_cobrado)
VALUES
(1, 1, 2000, 0.45),
(1, 2, 2000, 0.12),
(2, 3, 5000, 0.65);

SELECT * FROM item_expedicao;

UPDATE produto SET preco_tabela = 0.48 WHERE codigo = 1;

SELECT * FROM produto WHERE codigo = 1;


-- ETAPA 2: consultas 1 a 5

-- PRIMEIRA CONSULTA 
SELECT qtd_refugo AS refugo FROM ordem_producao WHERE qtd_refugo > 100 ORDER BY refugo DESC;
-- Existem 3 refugos acima de 100: 350 no número 3 unidade 2, 200 no número 1 unidade 1 e 120 no número 4 unidade 3.


-- SEGUNDA CONSULTA
SELECT produto_codigo, SUM(qtd_refugo) AS total
FROM ordem_producao 
GROUP BY produto_codigo
ORDER BY total DESC;

-- No produto 3 tem houveram 350 refugos, no produto 1 houveram 300 refugos e no produto 2 houveram 170 refugos.

-- TERCEIRA CONSULTA
SELECT qtd_boa FROM ordem_producao WHERE qtd_boa > 5000;
-- Apenas uma, a número 3 unidade 2.


-- QUARTA CONSULTA
SELECT
	 c.razao_social                    AS cliente,
     u.nome                            AS unidade,
     p.nome                            AS produto,
     ie.quantidade                     AS quantidade,
	(ie.quantidade * ie.preco_cobrado) AS valor
     
FROM item_expedicao ie
INNER JOIN expedicao e ON e.numero = ie.expedicao_numero
INNER JOIN cliente c ON c.cnpj = e.cliente_cnpj
INNER JOIN unidade u ON u.codigo = e.unidade_codigo
INNER JOIN produto p ON p.codigo = ie.produto_codigo;

-- QUINTA CONSULTA
SELECT
c.razao_social

FROM expedicao e
RIGHT JOIN cliente c ON c.cnpj = e.cliente_cnpj
WHERE  e.cliente_cnpj IS NULL;


-- ETAPA 3: view, procedure e trigger
CREATE OR REPLACE VIEW vw_refugo_produto AS
SELECT
  p.nome      AS nome_do_produto,
  SUM(o.qtd_refugo) AS total

FROM ordem_producao o
INNER JOIN produto p ON o.produto_codigo = p.codigo
GROUP BY o.produto_codigo
ORDER BY total DESC;



DELIMITER //
CREATE PROCEDURE sp_registrar_item(IN expedicao INT, IN produto INT, IN quantidade INT)
BEGIN
    INSERT INTO item_expedicao(expedicao_numero, produto_codigo, quantidade, preco_cobrado)
    VALUES(expedicao, produto, quantidade, (SELECT 
												preco_tabela AS 'Preço de tabela'
											FROM produto 
                                            WHERE codigo = produto));

END //
DELIMITER ;

CALL sp_registrar_item(2, 4, 5000);


DELIMITER //
CREATE TRIGGER tg_ordem_baixa_resina
AFTER INSERT ON ordem_producao FOR EACH ROW
BEGIN
    UPDATE estoque_resina SET quantidade_kg = quantidade_kg - NEW.consumo_kg
    WHERE unidade_codigo = NEW.unidade_codigo AND produto_codigo = NEW.produto_codigo;
END //
DELIMITER ;


DROP TRIGGER tg_ordem_baixa_resina;

SELECT CURRENT_USER90;
SELECT * FROM ordem_producao;
INSERT INTO ordem_producao (data_ordem, qtd_planejada, qtd_boa, qtd_refugo, consumo_kg, unidade_codigo, produto_codigo)
VALUES ('2026/11/09', '1000', '950', '50', '20');

SELECT * FROM estoque_resina WHERE unidade_codigo = 2;
-- ETAPA 4: privilégios dos perfis e SHOW 


-- SELECT SELECIONE QUAL OU QUAIS COLUNAS VOCÊ QUER RETORNAR
-- FROM  - EM QUAL TABELA EU QUERO CONSULTAR OS DADOS
-- WHERE - QUAL OU QUAIS COLUNAS DA TABELA QUE QUERO USAR COMO FILTRO
-- GROUP BY - AGRUPAR POR COLUNA OU COLUNAS DA TABELA
-- HAVING - CRIA FILTROS DE COLUNAS AGRUPADAS E SEMPRE É USADO COM GROUP BY
-- JOINS - JUNTA OS DADOS DE DUAS OU MAIS TABELAS
-- ORDER BY - É USADO PARA ORDENAR OS DADOS DO MENOR PARA MAIOR OU VIRSE-VERSA









