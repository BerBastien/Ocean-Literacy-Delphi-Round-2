# Tratamiento de privacidad

- Los nombres completos, variantes de escritura, nombres abreviados e iniciales se sustituyeron por 27 IDs neutros, compartidos por todos los archivos. La asignación aleatoria no codifica orden alfabético ni cronológico; los IDs quedan fijos en esta entrega.
- No se incluye una tabla de correspondencias con identidades originales ni el programa privado de conversión.
- Se excluyeron fechas de envío, correos, categorías profesionales, pertenencia a comunidades y participación previa. Estos campos no intervienen en los scripts de análisis.
- Se excluyeron las tres columnas de comentarios abiertos, que incluyen menciones a terceros y texto potencialmente identificable. Se preservaron íntegros los 67 campos de agrupación y los 18 campos de títulos temáticos.
- Los tres Excel originales se inspeccionaron completos, incluidos XML, relaciones, propiedades, tablas, nombres definidos, fórmulas, validaciones, comentarios, enlaces y posibles objetos incrustados. Contenían tres hojas visibles, sin hojas ocultas ni fórmulas. Dos libros contenían autoría personal en sus propiedades.
- Los Excel públicos se reconstruyeron desde los valores revisados. No arrastran propiedades personales, comentarios, enlaces, objetos, cachés ni nombres definidos del original. La tabla nativa original se sustituyó por un rango de datos plano, sin pérdida de valores analíticos.
- Las 81 figuras individuales con nombres en el título se excluyeron y regeneraron con IDs. Se conservaron nueve figuras agregadas históricas y se limpiaron metadatos PNG/JPEG. Los títulos y nombres de los archivos nuevos usan IDs.
- Se excluyeron historial de R, configuración privada y script de despliegue con credenciales. No se transfirió historial Git. Se retiró información descriptiva de autoría/contacto de paquetes del lockfile, conservando los campos necesarios para restaurar versiones.

## Límite de anonimización

La conservación de relaciones individuales y texto temático implica riesgo residual de vinculación con información externa o con las respuestas originales. Los IDs eliminan identificadores directos; no constituyen una garantía de anonimato irreversible ni una evaluación formal de riesgo estadístico. La copia no sirve para análisis demográficos o de comentarios, pues esos campos se excluyeron expresamente por privacidad.

La revisión final combina búsqueda de variantes con y sin acentos, inspección de contenedores Excel, metadatos de imágenes y reconocimiento de texto de figuras. La verificación no publica las cadenas originales de búsqueda.
