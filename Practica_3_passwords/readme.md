
# FPGA Hardware Password Validator

Un sistema de validación de contraseñas de 4 dígitos implementado totalmente en hardware (Verilog) para la placa **DE10-Lite Standard**.

## Funcionalidad
- **Validación por Estados:** Implementación de una Máquina de Estados de Moore para la secuencia de entrada.
- **Interfaz Visual:** Salida a 4 displays de 7 segmentos con codificación Hexadecimal-a-7Seg personalizada.
- **Seguridad:** Bloqueo de sistema y reinicio por hardware mediante `rst`.

## Verificación (Testbench)
El proyecto incluye un banco de pruebas (`passw_tb.vcd`) diseñado para simular:
1. Entrada de contraseña correcta.
2. Manejo de errores en la secuencia.
3. Comportamiento ante ruidos en el botón de ingreso (`btn`).
<img src="images/Screenshot_2026-03-12-22-10-35.png" alt="NO hay imagen" width="500" align="center">


## RTL
<img src="images/Screenshot_2026-03-12-21-46-49.png" alt="NO hay imagen" width="500" align="center">
<img src="images/Screenshot_2026-03-12-21-48-59.png" alt="NO hay imagen" width="500" align="center">

## Maquina de estados
<img src="images/Screenshot_2026-03-12-21-49-24.png" alt="NO hay imagen" width="500" align="center">
