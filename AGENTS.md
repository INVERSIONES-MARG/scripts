# AGENTS.md

Instrucciones para cualquier asistente de código (Codex, Cursor, Copilot,
Gemini, Claude…).

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
