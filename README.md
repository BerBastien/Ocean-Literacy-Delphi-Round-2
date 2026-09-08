# Delphi Round 2: redes de agrupación temática

Análisis en R de 27 respuestas a un ejercicio de agrupación de temas sobre mares, biodiversidad y clima. Genera conexiones entre temas asignados al mismo grupo por cada participante, visualizaciones de redes, curvas de umbrales y agrupaciones jerárquicas. Incluye una aplicación Shiny para explorar las redes.

## Datos públicos y privacidad

Los datos públicos están anonimizados mediante IDs neutros `Expert_001`–`Expert_027`, consistentes entre archivos. Se retiraron identificadores directos, atributos personales y comentarios abiertos. Los patrones de respuesta y títulos temáticos se conservan: técnicamente es seudonimización y no garantiza impedir la reidentificación mediante información externa. Véase `ANONYMIZATION_NOTES.md`.

## Estructura

```text
app/app.R                      Aplicación Shiny
src/01_prepare_connections.R   Respuestas → conexiones
src/02_export_networks.R       Redes por experto y agregadas
src/03_thresholds.R            Curvas y umbrales
src/04_clusters.R              Agrupaciones temáticas
data/raw/                     Excel públicos de respuestas y diccionario
data/processed/               Conexiones regeneradas por el pipeline
data/reference/               Conexiones históricas y tabla auxiliar anonimizada
outputs/figures/               Figuras regeneradas; reference/ conserva agregados históricos
outputs/tables/                Resultados nuevos y agrupaciones históricas
docs/                         Diccionario, cambios y validación
scripts/                      Instalación y comprobaciones
renv.lock                     Versiones de R y dependencias
run_analysis.R                Ejecución ordenada
```

## Requisitos y ejecución

Se probó con R 4.5.3. Las dependencias directas son readxl, dplyr, tidyr, stringr, igraph, ggraph, ggplot2, fs, inflection, writexl y shiny. `renv.lock` registra sus versiones y dependencias transitivas. La instalación requiere acceso a CRAN; algunas plataformas pueden necesitar herramientas de compilación.

Desde la raíz del repositorio, restaure el entorno:

```r
install.packages("renv", repos = "https://cloud.r-project.org")
renv::restore(project = ".", prompt = FALSE)
```

Como el repositorio no activa automáticamente renv, ejecute con su biblioteca explícita:

```sh
Rscript -e 'renv::load(project="."); source("run_analysis.R")'
Rscript -e 'renv::load(project="."); source("scripts/validate.R")'
Rscript -e 'renv::load(project="."); shiny::runApp("app")'
```

Alternativa sin aislamiento: `Rscript scripts/install_dependencies.R`, seguido de `Rscript run_analysis.R`. Esta alternativa instala las versiones disponibles, no necesariamente las fijadas en el lockfile.

El pipeline sobrescribe solamente las salidas derivadas de la copia pública. Se puede ejecutar cada script de `src/` en el orden indicado desde la raíz. No necesita archivos privados, credenciales ni servicios remotos para el análisis o la aplicación local.

## Alcance científico y resultados históricos

Se mantiene la generación de pares por experto y grupo, la exclusión de “Indeciso” y “Tema Independiente”, las redes no dirigidas, el diseño espectral (`eigen`) de agregados y el agrupamiento jerárquico por distancia euclídea y enlace promedio. Los diseños individuales usan Fruchterman–Reingold (`fr`) con semilla fija.

Las 4,668 conexiones válidas regeneradas coinciden con las referencias. Las particiones finales coinciden con las históricas, aunque sus números de cluster cambian por el orden de los IDs. No interprete esos números como rangos o categorías sustantivas.

Las figuras `MM_*` y la tabla `legacy_edges.csv` se conservan como material histórico: los scripts activos originales no contienen una receta completa para regenerarlas. No se usan como entradas del pipeline principal. Las referencias gráficas conservan sus limitaciones visuales originales. Véase `docs/CHANGES.md`.

No se incluye una licencia inventada: el titular puede añadir la licencia apropiada para código y datos antes de distribuirlos bajo términos explícitos.
