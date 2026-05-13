SELECT *
FROM implantacoes;

-- Liste todos os clientes com status 'concluido', mostrando apenas as colunas cliente, modulo e go_live.
SELECT cliente,modulo,go_live
FROM implantacoes
WHERE status='concluido';

-- Mostre cliente e dias_prazo de todas as implantações dos módulos 'Estoque' ou 'Fiscal', cujo prazo esteja entre 40 e 90 dias e que ainda não estejam concluídas.
SELECT cliente,dias_prazo
FROM implantacoes
WHERE modulo IN ('Estoque','Fiscal')
AND dias_prazo BETWEEN 40 AND 90
AND status != 'concluido';

-- Liste todos os clientes que ainda não têm data de go_live definida (go_live IS NULL) e
-- cujo módulo não seja 'RH' nem 'Fiscal', ou que estejam com status 'atrasado' e dias_prazo menor que 25. Mostre cliente, modulo, status e dias_prazo.

SELECT cliente, modulo, status, dias_prazo
FROM implantacoes
WHERE (go_live IS NULL AND modulo NOT IN ('RH','Fiscal'))
OR (status = 'atrasado' AND dias_prazo<25);
