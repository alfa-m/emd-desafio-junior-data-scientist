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
-- Resposta: 46.857 chamadas de 'Perturbação do sossego' em 729 dias.
SELECT tipo, COUNT(tipo) AS tickets
FROM `datario.adm_central_atendimento_1746.chamado`
WHERE tipo = 'Perturbação do sossego'
      AND EXTRACT(DATE FROM data_inicio) BETWEEN '2022-01-01' AND '2023-12-31'
GROUP BY tipo
ORDER BY tickets DESC;

-- 7 - Selecione os chamados com esse subtipo que foram abertos durante os eventos contidos na tabela de eventos (Reveillon, Carnaval e Rock in Rio).
SELECT data_inicial, data_final, evento
FROM `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`
ORDER BY data_inicial;

WITH eventos as (
SELECT data_inicial, data_final,
(CASE WHEN data_inicial IN (SELECT DISTINCT(data_inicial) FROM `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` WHERE (evento='Rock in Rio' AND data_inicial='2022-09-02')) THEN 'Rock in Rio (S1)' ELSE (CASE WHEN data_inicial IN (SELECT DISTINCT(data_inicial) FROM `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos` WHERE (evento='Rock in Rio' AND data_inicial='2022-09-08')) THEN 'Rock in Rio (S2)' ELSE evento END) END) AS evento_2
FROM `datario.turismo_fluxo_visitantes.rede_hoteleira_ocupacao_eventos`
LIMIT 50)
SELECT chamados.tipo, COUNT(chamados.tipo) AS tickets, EXTRACT(DATE FROM chamados.data_inicio) as dia
FROM `datario.adm_central_atendimento_1746.chamado` AS chamados
WHERE chamados.tipo = 'Perturbação do sossego'
AND (chamados.data_inicio BETWEEN (SELECT data_inicial FROM eventos WHERE evento_2 = 'Rock in Rio (S1)') AND (SELECT data_final FROM eventos WHERE evento_2 = 'Rock in Rio (S1)')
OR chamados.data_inicio BETWEEN (SELECT data_inicial FROM eventos WHERE evento_2 = 'Rock in Rio (S2)') AND (SELECT data_final FROM eventos WHERE evento_2 = 'Rock in Rio (S2)')
OR chamados.data_inicio BETWEEN (SELECT data_inicial FROM eventos WHERE evento_2 = 'Reveillon') AND (SELECT data_final FROM eventos WHERE evento_2 = 'Reveillon')
OR chamados.data_inicio BETWEEN (SELECT data_inicial FROM eventos WHERE evento_2 = 'Carnaval') AND (SELECT data_final FROM eventos WHERE evento_2 = 'Carnaval'))
GROUP BY chamados.tipo, dia
ORDER BY dia;

-- 8 - Quantos chamados desse subtipo foram abertos em cada evento?
-- Resposta: 548 chamados no Rock in Rio 2022 em 7 dias; 87 chamados no Reveillon 2022 em 3 dias; e 212 chamados no Carnaval 2023 em 4 dias.

-- 9 - Qual evento teve a maior média diária de chamados abertos desse subtipo?
-- Resposta: Rock in Rio 2022, com média de 78,29 chamados por dia (78,29 no Rock in Rio; 29 no Reveillon 2022; e 53 no Carnaval 2023).

-- 10 - Compare as médias diárias de chamados abertos desse subtipo durante os eventos específicos (Reveillon, Carnaval e Rock in Rio) e a média diária de chamados abertos desse subtipo considerando todo o período de 01/01/2022 até 31/12/2023.
-- Resposta: Média diária de chamados de 78,29 no Rock in Rio 2022; 29 no Reveillon 2022; 53 no Carnaval 2023; e 64,28 durante o período de 01/01/2022 a 31/12/2023. A média diária do período de análise geral só fica abaixo da média durante o Rock in Rio 2022.
