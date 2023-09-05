-- Base de dados aberta, disponível em:
--https://dadosabertos.tse.jus.br/dataset/resultados-2022-boletim-de-urna/resource/645504da-69ca-4a18-874e-6b1a79630ac1

--SELECIONANDO E VISUALIZANDO TODOS OS DADOS DA TABELA
SELECT * FROM eleicoes 

-- SELECIONANDO OS CARGOS DOS CANDIDATOS
SELECT DISTINCT 
CD_TIPO_VOTAVEL,
DS_CARGO_PERGUNTA 
FROM eleicoes;

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

-- QUANTIDADE DE VOTOS POR PARA GOVERNADOR NA CIDADE DE NATAL
SELECT
NM_VOTAVEL, 
DS_CARGO_PERGUNTA,
SUM(QT_VOTOS) AS QTD_VOTOS
FROM eleicoes
WHERE NM_MUNICIPIO = 'NATAL' 
AND DS_CARGO_PERGUNTA = 'Governador'
GROUP BY NM_VOTAVEL
ORDER BY QTD_VOTOS DESC
LIMIT 3
;

-- QUANTIDADE DE VOTOS POR PARA PRESIDENTE NA CIDADE DE NATAL
SELECT
NM_VOTAVEL, 
DS_CARGO_PERGUNTA,
SUM(QT_VOTOS) AS QTD_VOTOS
FROM eleicoes
WHERE NM_MUNICIPIO = 'NATAL' 
AND DS_CARGO_PERGUNTA = 'Presidente'
GROUP BY NM_VOTAVEL
ORDER BY QTD_VOTOS DESC
LIMIT 3
;

-- OS 5 MUNICÍPIOS QUE TIVERAM A MAIOR QUANTIDADE DE VOTOS NULOS 
SELECT
NM_MUNICIPIO,
DS_TIPO_VOTAVEL,
SUM(QT_VOTOS) AS QTD_VOTOS
FROM eleicoes
WHERE DS_TIPO_VOTAVEL = 'Nulo'
GROUP BY NM_MUNICIPIO  
ORDER BY QTD_VOTOS DESC
LIMIT 5
;


-- CANDIDATOS QUE TIVERAM A MAIOR QUANTIDADE DE VOTOS POR CARGO 
-- Calcular a soma dos votos para cada candidato por cargo
WITH votos_cand AS (
    SELECT
        DS_CARGO_PERGUNTA,
        NM_VOTAVEL,
        SUM(QT_VOTOS) AS QT_VOTOS,
        CD_TIPO_VOTAVEL = 1
    FROM eleicoes
    GROUP BY DS_CARGO_PERGUNTA, NM_VOTAVEL
),
-- Classificando os candidatos dentro de cada cargo por quantidade de votos em ordem decrescente
ranked_cand AS (
    SELECT
        DS_CARGO_PERGUNTA,
        NM_VOTAVEL,
        QT_VOTOS,
        ROW_NUMBER() OVER (PARTITION BY DS_CARGO_PERGUNTA ORDER BY QT_VOTOS DESC) AS row_number
    FROM votos_cand
)
-- Selecionando apenas os candidatos com classificação 1 em cada cargo
SELECT
    DS_CARGO_PERGUNTA,
    NM_VOTAVEL,
    QT_VOTOS
FROM ranked_cand
WHERE row_number = 1
ORDER BY QT_VOTOS DESC;
--A primeira parte, votos_cand, calcula a soma dos votos para cada candidato por cargo, filtrando os registros onde CD_TIPO_VOTAVEL é igual a 1.
	--A segunda parte, ranked_cand, classifica os candidatos dentro de cada cargo com base na quantidade de votos em ordem decrescente usando a função
	-- ROW_NUMBER() com a cláusula OVER (PARTITION BY DS_CARGO_PERGUNTA ORDER BY QT_VOTOS DESC).
		--Finalmente, a consulta principal seleciona apenas os candidatos com classificação 1 em cada cargo, que são os candidatos mais votados em cada cargo.



