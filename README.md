Esse projeto faz análises de uma base de dados das eleições de 2022. 
Para isso, o foi usado SQL como intuito de mostrar o aprendizado aplicado a realidade. 

Várias análises foram feitas e estão no arquivo anexado. 

Scripts em SQL para contagem de votos (listado abaixo) assim como outros, estão descritos. 
```
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
```

Boa leitura
