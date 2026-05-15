-- ============================================================
-- Lição 3 — GROUP BY com uma coluna
-- Mês 1 · Fundação
-- ============================================================

-- ============================================================
-- SETUP — Exemplo Guiado
-- ============================================================

DROP TABLE IF EXISTS pedidos CASCADE;

CREATE TABLE pedidos (
    id          SERIAL PRIMARY KEY,
    cliente     VARCHAR(50),
    produto     VARCHAR(50),
    valor       NUMERIC(10, 2),
    status      VARCHAR(20)
);

INSERT INTO pedidos (cliente, produto, valor, status) VALUES
('Ana',    'Licença ERP',     1200.00, 'pago'),
('Bruno',  'Suporte Mensal',   350.00, 'pago'),
('Ana',    'Treinamento',      800.00, 'pendente'),
('Carlos', 'Licença ERP',     1200.00, 'pago'),
('Bruno',  'Migração de BD',  2500.00, 'pago'),
('Ana',    'Suporte Mensal',   350.00, 'pago'),
('Carlos', 'Treinamento',      800.00, 'cancelado'),
('Bruno',  'Licença ERP',     1200.00, 'pendente'),
('Carlos', 'Suporte Mensal',   350.00, 'pago');

-- ============================================================
-- EXEMPLO GUIADO — faturamento por cliente
-- ============================================================

SELECT
    cliente,
    COUNT(*)             AS total_pedidos,
    SUM(valor)           AS receita_total,
    ROUND(AVG(valor), 2) AS ticket_medio
FROM
    pedidos
GROUP BY
    cliente
ORDER BY
    receita_total DESC;

-- ============================================================
-- EXERCÍCIO 1 — pedidos por status
-- ============================================================

SELECT
    status,
    COUNT(*) AS total_pedidos
FROM
    pedidos
GROUP BY
    status
ORDER BY
    total_pedidos DESC;

-- ============================================================
-- EXERCÍCIO 2 — faturamento por produto (somente 'pago')
-- ============================================================

SELECT
    produto,
    SUM(valor) AS receita
FROM
    pedidos
WHERE
    status = 'pago'
GROUP BY
    produto
ORDER BY
    receita DESC;

-- ============================================================
-- SETUP — Exercício 3
-- ============================================================

DROP TABLE IF EXISTS chamados CASCADE;

CREATE TABLE chamados (
    id              SERIAL PRIMARY KEY,
    sistema         VARCHAR(40),
    tipo            VARCHAR(30),
    dias_resolucao  INTEGER
);

INSERT INTO chamados (sistema, tipo, dias_resolucao) VALUES
('ERP Financeiro', 'Bug crítico',       3),
('ERP Financeiro', 'Dúvida de uso',     1),
('ERP Financeiro', 'Solicitação',       5),
('ERP Financeiro', 'Bug crítico',       7),
('RH Online',      'Dúvida de uso',     2),
('RH Online',      'Bug crítico',      10),
('RH Online',      'Solicitação',       4),
('Fiscal Web',     'Bug crítico',       6),
('Fiscal Web',     'Solicitação',       3),
('Fiscal Web',     'Dúvida de uso',     1),
('Fiscal Web',     'Bug crítico',       8),
('Fiscal Web',     'Solicitação',       2);

-- ============================================================
-- EXERCÍCIO 3 — chamados por sistema com métricas
-- ============================================================

SELECT
    sistema,
    COUNT(*)                            AS total_chamados,
    ROUND(AVG(dias_resolucao), 1)       AS media_dias,
    MAX(dias_resolucao)                 AS pior_caso_dias
FROM
    chamados
GROUP BY
    sistema
ORDER BY
    total_chamados DESC;
