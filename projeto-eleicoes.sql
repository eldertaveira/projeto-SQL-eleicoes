-- Base de dados aberta, disponível em:
--https://dadosabertos.tse.jus.br/dataset/resultados-2022-boletim-de-urna/resource/645504da-69ca-4a18-874e-6b1a79630ac1

--SELECIONANDO E VISUALIZANDO TODOS OS DADOS DA TABELA
SELECT * FROM eleicoes 

-- LISTANDO TOSOS OS PARTIDOS 
SELECT DISTINCT 
SG_PARTIDO
FROM eleicoes;

-- LISTANDO TOSOS OS PARTIDOS, MAS NESSE CASO, APLICA-SE IS NOT NULL PARA PEGAR APENAS AS SIGLAS DO PARTIDO
SELECT
COUNT(DISTINCT(SG_PARTIDO)) AS QTD_SIGLAS
FROM eleicoes
WHERE SG_PARTIDO IS NOT NULL
;

-- SOMA DE VOTOS POR PARTIDO, ORDENADO PELO PARTIDO QUE MAIS RECEBEU VOTOS
SELECT
SG_PARTIDO,
SUM(QT_VOTOS) AS VOTOS
FROM eleicoes
GROUP BY SG_PARTIDO  
ORDER BY QT_VOTOS DESC
;

-- QUANTIDADE DE VOTOS DE PT E PL, SELECIONANDO A CAPITAL NATAL 
SELECT
SG_PARTIDO,
SUM(QT_VOTOS) AS VOTOS
FROM eleicoes
WHERE NM_MUNICIPIO = 'NATAL'
AND SG_PARTIDO IN ('PT', 'PL')
GROUP BY SG_PARTIDO  
ORDER BY QT_VOTOS DESC
;