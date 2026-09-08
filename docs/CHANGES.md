# Cambios y exclusiones

## Código

- El script general de preparación se convirtió en `01_prepare_connections.R`. La selección posicional se sustituyó por identificadores de pregunta explícitos para adaptarse a los campos personales retirados y evitar incluir comentarios y títulos como si fueran asignaciones.
- Se reemplazó la construcción de nombres abreviados por el ID presente en los datos públicos. No se genera un ID diferente en cada ejecución.
- Los scripts de figuras, umbrales y clusters pasan a `02`–`04`; todas las rutas apuntan a las carpetas del repositorio. Las instalaciones se separaron del análisis.
- La aplicación autocontenida se conserva en `app/app.R`; los archivos separados de interfaz y servidor se excluyeron por duplicación. Se agregó una comprobación de selecciones sin aristas y una semilla para el diseño.
- El borrador exploratorio para una sola categoría se excluyó: duplicaba la preparación, contenía una selección personal y usaba una variable no definida en su gráfico final.
- Se corrigió `inflexion` a `inflection`, el paquete que proporciona la función utilizada.
- `findiplist` devuelve una matriz. La expresión original `tail(..., 1)` proporcionaba varios índices y producía una matriz de clusters. Se utiliza explícitamente `["EDE", "j1"]`, equivalente a `[2]`, que ya seleccionaba el script original de umbrales. La partición resultante se verificó contra el Excel histórico.
- Se fijó la semilla en 2025. Se mantienen algoritmos, filtros y distancias; los IDs alteran el orden de entrada, por lo que la orientación de las figuras y la numeración de clusters pueden cambiar.

## Archivos excluidos

- Historial de consola y configuración de despliegue, incluidos secretos.
- 81 figuras personales originales, reemplazadas por 81 figuras con IDs; las tres agregadas también se regeneran.
- Tabla histórica de aristas sin identidad, redundante con la versión conservada una vez retirada la columna de identidad.
- Borrador exploratorio, instalador de despliegue y pareja duplicada de interfaz/servidor.
- Propiedades y objetos de Excel ajenos a los valores analíticos; campos personales y comentarios abiertos.

Los originales permanecen en su carpeta, sin edición. No se publicó ni se inicializó Git automáticamente.
