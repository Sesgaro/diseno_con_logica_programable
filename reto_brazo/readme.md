Este proyecto implementa un administrador de memoria síncrona en Verilog diseñado para controlar los movimientos de un brazo robótico multieje utilizando la FPGA **Intel MAX 10 (DE10-Lite)**.

## Características
- **Arquitectura de 4 Ejes:** Control independiente para los ejes X, Y, Z y Garra (G).
- **Controlador de Memoria Síncrono:** Registros de 17 bits.
- **Dual Mode:** - **Modo Grabación (Write):** Captura posiciones en tiempo real con cronómetro integrado.
  - **Modo Reproducción (Read):** Ejecuta trayectorias con sincronización entre ejes (Sync Ready State).
