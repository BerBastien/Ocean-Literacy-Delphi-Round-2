# Datos

`data/raw/responses.xlsx`:
- `Responses`: 27 filas, `Expert_ID` y 67 asignaciones. Prefijos `1.1.*` (20 temas de mares), `2.1.*` (24 de biodiversidad), `3.1.*` (23 de clima). Valores: Tema 1–5, Indeciso, Tema Independiente y celdas vacías preservadas.
- `Theme_labels`: los mismos 27 IDs y 18 propuestas de títulos de grupos. Texto original revisado, no usado para formar las aristas del pipeline.

`data/raw/theme_dictionary.xlsx`, hoja `Metadata`: una fila de nombres de temas, con 67 identificadores y tres nombres de categoría adicionales. No contiene perfiles personales.

`data/processed/connections_*.csv`: `Expert_ID`, `theme` (grupo asignado), `from`, `to` (temas conectados). Cada fila es un par no dirigido del mismo grupo de un experto. Se mantienen repeticiones entre expertos; no se simplifica el grafo.

`data/reference/connections_*.csv`: versiones históricas anonimizadas. Incluyen 32 filas con extremos NA en total. La validación las excluye al comparar con las conexiones nuevas, como hacían las visualizaciones originales.

`data/reference/legacy_edges.csv`: 29,109 filas históricas con ID, categoría, código de tema, nombre del tema, grupo y título propuesto. Se preservan filas repetidas y vacíos; su construcción no está completa en los scripts originales. La segunda tabla histórica sin identidad duplicaba esta tabla al retirar la columna de persona y se excluyó por redundancia.

`outputs/tables/reference_theme_clusters.xlsx`: 16 agrupaciones históricas. `theme_clusters.xlsx`: agrupaciones calculadas; los números no son identificadores persistentes. `threshold_curve.csv` y `thresholds.csv`: curva de número de clusters frente a altura y umbrales elegidos.
