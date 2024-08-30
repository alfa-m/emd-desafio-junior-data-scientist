-- 1 - Quantos chamados foram abertos no dia 01/04/2023?
-- Resposta: 1756 chamados.
SELECT EXTRACT(DATE FROM data_inicio) AS dia, COUNT(data_inicio) AS tickets
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE EXTRACT(DATE FROM data_inicio) = '2023-04-01'
GROUP BY dia;

-- 2 - Qual o tipo de chamado que teve mais teve chamados abertos no dia 01/04/2023?
-- Resposta: Estacionamento irregular (366 chamados).
SELECT EXTRACT(DATE FROM data_inicio) AS dia, tipo, COUNT(data_inicio) AS tickets
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE EXTRACT(DATE FROM data_inicio) = '2023-04-01'
GROUP BY dia, tipo
ORDER BY tickets DESC
LIMIT 1;

-- 3 - Quais os nomes dos 3 bairros que mais tiveram chamados abertos nesse dia?
-- Resposta: Bairro Campo Grande (código 144, 113 chamados), Tijuca (código 33, 89 chamados) e Barra da Tijuca (código 128, 59 chamados).
SELECT EXTRACT(DATE FROM chamados.data_inicio) AS dia, chamados.id_bairro, bairros.nome, COUNT(chamados.data_inicio) AS tickets
FROM `datario.adm_central_atendimento_1746.chamado` AS chamados
FULL OUTER JOIN `datario.dados_mestres.bairro` AS bairros
ON chamados.id_bairro = bairros.id_bairro
WHERE EXTRACT(DATE FROM chamados.data_inicio) = '2023-04-01' AND (bairros.nome IS NOT NULL)
GROUP BY dia, chamados.id_bairro, bairros.nome
ORDER BY tickets DESC
LIMIT 3;

-- 4 - Qual o nome da subprefeitura com mais chamados abertos nesse dia?
-- Resposta: Zona Norte (510 chamados).
SELECT EXTRACT(DATE FROM chamados.data_inicio) AS dia, bairros.subprefeitura, COUNT(chamados.data_inicio) AS tickets
FROM `datario.adm_central_atendimento_1746.chamado` AS chamados
FULL OUTER JOIN `datario.dados_mestres.bairro` AS bairros
ON chamados.id_bairro = bairros.id_bairro
WHERE EXTRACT(DATE FROM chamados.data_inicio) = '2023-04-01' AND (bairros.subprefeitura IS NOT NULL)
GROUP BY dia, bairros.subprefeitura
ORDER BY tickets DESC
LIMIT 1;

-- 5 - Existe algum chamado aberto nesse dia que não foi associado a um bairro ou subprefeitura na tabela de bairros? Se sim, por que isso acontece?
-- Resposta: Sim, houveram 73 chamados não associados a um bairro e/ou subprefeitura. Isso ocorreu pois os chamados foram feitos sem a inclusão da identificação do bairro e também percebe-se que, em sua maioria, foram feitas denúncias relacionadas ao transporte público, o que geralmente não envolve uma localização específica
SELECT EXTRACT(DATE FROM chamados.data_inicio) AS dia, bairros.id_bairro, bairros.subprefeitura, chamados.tipo, COUNT(chamados.tipo) AS tickets
FROM `datario.adm_central_atendimento_1746.chamado` AS chamados
FULL OUTER JOIN `datario.dados_mestres.bairro` AS bairros
ON chamados.id_bairro = bairros.id_bairro
WHERE EXTRACT(DATE FROM chamados.data_inicio) = '2023-04-01' AND (bairros.subprefeitura IS NULL OR chamados.id_bairro IS NULL)
GROUP BY dia, bairros.id_bairro, bairros.subprefeitura, chamados.tipo
ORDER BY tickets DESC
LIMIT 100;

-- 6 - Quantos chamados com o subtipo "Perturbação do sossego" foram abertos desde 01/01/2022 até 31/12/2023 (incluindo extremidades)?


-- 7 - Selecione os chamados com esse subtipo que foram abertos durante os eventos contidos na tabela de eventos (Reveillon, Carnaval e Rock in Rio).


-- 8 - Quantos chamados desse subtipo foram abertos em cada evento?


-- 9 - Qual evento teve a maior média diária de chamados abertos desse subtipo?


-- 10 - Compare as médias diárias de chamados abertos desse subtipo durante os eventos específicos (Reveillon, Carnaval e Rock in Rio) e a média diária de chamados abertos desse subtipo considerando todo o período de 01/01/2022 até 31/12/2023.


