# Validación de la entrega

Verificación realizada el 8 de septiembre de 2026.

- Inventario completo: 109 archivos, 10,318,394 bytes. Se volvieron a calcular sus SHA-256 al terminar y coincidieron con los iniciales. No se agregaron ni retiraron archivos en el original.
- Inspeccionados: nueve scripts R, cinco CSV, tres XLSX, 90 imágenes, historial y configuración de despliegue. No se encontraron notebooks, XLS binarios ni documentos adicionales.
- Excel: comparación exacta de todos los valores retenidos con la fuente; 27 IDs, 67 asignaciones y 18 campos de títulos. Se inspeccionaron todas las partes ZIP/XML, propiedades, relaciones y hojas de los originales y de los cuatro libros finales, incluido el resultado regenerado. Sin identificadores directos detectados en la entrega.
- Las conexiones válidas coinciden fila por fila, considerando multiplicidad: mares 1,256; biodiversidad 1,760; clima 1,652. Las referencias conservan además 9, 14 y 9 filas con extremos vacíos, respectivamente.
- Las 16 agrupaciones finales conservan exactamente los mismos conjuntos de temas que la referencia histórica. Solo cambia la numeración: seis grupos en mares, seis en biodiversidad, cuatro en clima.
- Pipeline completo ejecutado después de corregir el código. Se generaron 84 redes (27 individuales y una agregada por categoría), una figura de umbrales y las tablas de resultados.
- Aplicación: prueba del servidor Shiny para las tres categorías, tanto agregados como selección individual; seis salidas gráficas comprobadas. No se hizo una sesión manual de interacción en navegador ni un despliegue remoto.
- Privacidad: búsqueda recursiva de identidades detectadas en la fuente, variantes sin acentos, correos, usernames, rutas privadas y patrones de credenciales. Se revisaron XML descomprimidos, nombres de archivos y metadatos gráficos. Cero hallazgos en la copia final.
- OCR sobre las 90 imágenes originales y las 94 públicas, sin errores de lectura. Sin coincidencias con identificadores buscados en el texto reconocido de las figuras públicas. Se revisaron visualmente las figuras agregadas y vistas de todas las hojas de los libros reconstruidos; OCR puede omitir texto y no sustituye una garantía formal de anonimato.
- Dependencias: R 4.5.3 y 76 paquetes fijados en renv.lock. El pipeline se ejecutó con esas dependencias disponibles. No se realizó una restauración integral desde cero del lockfile en otra máquina.

## Limitaciones documentadas

Las figuras históricas MM_* y la tabla legacy_edges no tienen una receta completa en los scripts activos originales. Se conservan como referencias, sin afirmar que sean regenerables por el pipeline principal. Algunas etiquetas de redes se superponen como en el diseño original. R emite un aviso de obsolescencia sobre el parámetro gráfico size; no impidió ejecutar el análisis.

No se creó un repositorio Git ni se publicaron archivos. La copia permite git init y contiene .gitignore. Persiste el riesgo de vinculación externa propio de datos individuales seudonimizados y texto temático.
