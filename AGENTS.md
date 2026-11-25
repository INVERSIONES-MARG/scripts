# AGENTS.md

## Recursos: el trabajo pesado va a la oficina

**Regla permanente de Mauricio, ratificada el 16/11/2026: aplica a todos
los repositorios y a todas las sesiones, actuales y futuras.** El servidor
AWS comparte recursos con MARGO, Oxford, Marg-flow y Cimenta en producción.
Aquí solo se edita código y se ejecutan tareas livianas: git, gh, lecturas
y comandos cortos.

- Toda instalación de dependencias, prueba, compilación, revisión de tipos,
  prueba con navegador y base de datos de laboratorio se ejecuta en la oficina
  con `en-oficina`, desde dentro del repositorio. También los comandos de los
  README y de otras instrucciones, aunque estén escritos sin ese prefijo.
- Nunca ejecutar en AWS `tsc`, `vitest`, `jest`, `next build`, `vite build`,
  instalaciones ni contenedores o bases de datos de prueba, aunque el cambio
  o la prueba sean pequeños.
- Antes de lanzar trabajo pesado, consultar `en-oficina --estado`. Si la carga
  supera aproximadamente 20, esperar. Probar solo lo modificado y con un máximo
  de dos procesos; la suite completa, cuando se solicite o antes del PR.
- Si la oficina no responde, avisar y dejar pendiente la comprobación.
  **AWS no se usa como alternativa.** Coordinar las pruebas si otra sesión
  está usando la misma copia del repositorio en la oficina.
- `en-oficina` copia el repositorio sin `.git` ni `node_modules`; los cambios
  generados allá no vuelven automáticamente. No sustituye el flujo de git y PR.

Ejemplos (usar el gestor y los comandos del proyecto):

```bash
en-oficina --estado
en-oficina pnpm install
en-oficina npx vitest run ruta/al/test --maxWorkers=2
en-oficina npm run build
```

Instrucciones para cualquier asistente de código (Codex, Cursor, Copilot,
Gemini, Claude…).

## Idioma: siempre en español

**Las sesiones se manejan únicamente en español.** Todo lo que le escribes a la
persona va en español, tuteando: las respuestas, los avisos cortos entre un paso
y otro, las preguntas con opciones (la pregunta, las opciones y sus
descripciones), los planes, los resúmenes y la descripción de cada comando.
Desde el primer mensaje y también después de un resumen de contexto, aunque el
mensaje, el código, un error o un documento estén en inglés.

> **Este repo es PÚBLICO**: lo que se anote acá lo puede leer cualquiera en
> internet. Nada interno que no se pueda mostrar.

1. **Lo primero: leer los dos instaladores** (`install_aw_macos.sh` e
   `install_aw_windows.ps1`): instalan ActivityWatch y lo apuntan al servidor
   de la empresa. No hay README.
2. **Después, `docs/memoria.md`**: lo que ya se explicó en una conversación y no
   está en otro documento. Lo que está escrito ahí no se vuelve a preguntar.
3. **Al trabajar, anotar.** Si en la conversación se explica algo que no está
   escrito (cómo funciona el negocio, una decisión, una corrección, una
   preferencia), se anota en el mismo commit del trabajo: en el documento de su
   tema si lo tiene y, si no, en `docs/memoria.md`. Nada secreto: ni claves, ni
   contraseñas, ni datos de clientes.

La memoria del proyecto es texto plano en este repo para que no dependa de
ninguna herramienta: la lee cualquier asistente y cualquier persona, y cada
copia del repo la tiene entera.

## Resumen de cada publicación

Al abrir o actualizar una solicitud de integración (PR o merge request),
deja en su descripción un resumen detallado en español, listo para copiar
y compartir con el equipo. Usa la plantilla del repositorio y actualiza el
resumen cuando cambie el alcance.

- Explica qué problema se resolvió, qué se hizo y por qué. Describe el antes
  y el después por cada cambio que afecte la operación, a qué áreas, personas
  o tiendas aplica y qué pasos debe seguir el equipo, si los hay. Incluye
  ejemplos y excepciones cuando ayuden a entender el cambio.
- Indica las pruebas realizadas, su entorno, sus resultados y qué queda
  pendiente. Incluye los enlaces a la solicitud y a la evidencia que se pueda
  compartir.
- Cuando se integre la solicitud, informa su estado en el chat. Después de
  verificar la publicación, entrega a quien pidió el cambio el resumen final
  en el chat, listo para reenviar. Indica qué se publicó, la fecha, el entorno,
  la versión o commit y cómo lo comprobaste. Si el despliegue es parcial o
  falla, indica qué componentes se comprobaron y cuáles siguen pendientes.
- Si salen varias solicitudes juntas, revisa el lote realmente desplegado y
  explica qué aportó cada una con su enlace, incluidas las de otras sesiones.
  Mantén las credenciales y los datos personales fuera del resumen.
