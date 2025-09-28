! PRACTICA 8: INTEGRAL DEFINIDA DE UNA FUNCION DE UNA VARIABLE
!
! Objetivo:
!   Calcular la integral definida de la función:
!
!     f(x) = 0.5 / sqrt(b + exp(a*x)) * (c*exp((a-1)*x) - d*exp(-(b+1)*x)) 
!           + f*exp(g*x) - 2*a*b*exp(-x)
!
!   en el intervalo x = 0 a x = 1, utilizando los coeficientes dados.
!
! Entradas:
!   - Archivo 'Datos8.dat': contiene los coeficientes a, b, c, d, f, g necesarios
!                          para la evaluación de la función integrando.
!
! Método utilizado:
!   - Cuadratura adaptativa (DQAGS - QUADPACK)
!
! Salidas:
!   - Valor numérico de la integral definida en el intervalo especificado
!   - Resultado guardado en el archivo 'Solucion8.sol'
!
!===============================================================================

!============================ MODULO DE PARAMETROS ============================
MODULE Params_Mod2
    IMPLICIT NONE
    !--------------------- Variables globales ----------------------
    DOUBLE PRECISION :: a, b, c, d, ff, g
END MODULE Params_Mod2

!============================== PROGRAMA PRINCIPAL =============================
PROGRAM Practica8
    USE Params_Mod2
    IMPLICIT NONE

    !--------------------- Declaraciones ----------------------
    INTEGER, PARAMETER :: unit_out = 40
    DOUBLE PRECISION :: result, abseest
    INTEGER :: neval, ier, limit, lenw, last
    PARAMETER (limit = 100, lenw = 4 * limit)
    DOUBLE PRECISION :: work(lenw)
    INTEGER :: iwork(limit)

    !--------------------- Leer coeficientes ----------------------
    CALL Leer_Coeficientes('Datos8.dat')

    !--------------------- Integración ----------------------
    CALL DQAGS(f, 0.0D0, 1.0D0, 1.0D-9, 1.0D-9, result, abseest, &
               neval, ier, limit, lenw, last, iwork, work)

    !--------------------- Verificación del estado IER ----------------------
    IF (IER /= 0) THEN
        WRITE(*,*) 'ADVERTENCIA: La rutina DQAGS retornó un código IER =', IER
        WRITE(*,*) 'Esto indica que hubo dificultades en la integración.'
        SELECT CASE (IER)
            CASE (1)
                WRITE(*,*) 'Posible pérdida de la precisión deseada.'
            CASE (2)
                WRITE(*,*) 'Número máximo de subdivisiones excedido (LIMIT).'
            CASE (3)
                WRITE(*,*) 'Integrando con comportamiento singular o altamente oscilante.'
            CASE (4)
                WRITE(*,*) 'Error de redondeo excesivo en la función integrando.'
            CASE (5)
                WRITE(*,*) 'Fallo al alcanzar tolerancia debido a comportamiento irregular.'
            CASE (6)
                WRITE(*,*) 'La subrutina fue llamada con argumentos inválidos.'
            CASE DEFAULT
                WRITE(*,*) 'Código de error no documentado.'
        END SELECT
    END IF

    !--------------------- Escritura en archivo ----------------------
    OPEN(unit = unit_out, file = 'Solucion8.sol', status = 'replace', action = 'write')

    !--------------------- Cabecera de salida ----------------------
    WRITE(unit_out, '(A)') '|=====================================|'
    WRITE(unit_out, '(A)') '|   SOLUCION PRACTICA 8: INTEGRAL-1   |'
    WRITE(unit_out, '(A)') '|=====================================|'
    WRITE(unit_out, '(A)') ''
    WRITE(unit_out, '(A)') '|====================================================================|'
    WRITE(unit_out, '(A)') '| Subprograma o       | Valor de la integral                         |'
    WRITE(unit_out, '(A)') '| procedimiento       |                                              |'
    WRITE(unit_out, '(A)') '|=====================|==============================================|'
    WRITE(unit_out, '(A,A1,F24.16,A1)') '|  DQAGS - QUADPACK   |', ' ', result, ' |'
    WRITE(unit_out, '(A)') '|---------------------|----------------------------------------------|'
    WRITE(unit_out, '(A)') '| Observaciones:                                                       '
    WRITE(unit_out, '(A)') '| - Integral evaluada entre x = 0 y x = 1                             '
    WRITE(unit_out, '(A)') '| - Método: DQAGS (cuadratura adaptativa de QUADPACK)                '
    WRITE(unit_out, '(A)') '|====================================================================|'

    !--------------------- Cierre del archivo ----------------------
    CLOSE(unit_out)

!============================= BLOQUE CONTAINS ================================
CONTAINS

    !--------------------- Función F(x) a integrar ----------------------
    DOUBLE PRECISION FUNCTION f(x)
        DOUBLE PRECISION, INTENT(IN) :: x

        f = 0.5D0 / SQRT(b + EXP(a * x)) * &
            (c * EXP((a - 1.D0) * x) - d * EXP(-(b + 1.D0) * x) + &
             ff * EXP(g * x) - 2.D0 * a * b * EXP(-x))
    END FUNCTION f

    !--------------------- Subrutina Leer_Coeficientes ----------------------
    SUBROUTINE Leer_Coeficientes(filename)
        USE Params_Mod2
        IMPLICIT NONE

        !------------------ Declaraciones internas ---------------------
        CHARACTER(LEN=*), INTENT(IN) :: filename
        INTEGER :: unit_in, ios, pos_igual, pos_barra
        CHARACTER(LEN=200) :: linea, valor_str
        CHARACTER(LEN=10) :: clave
        DOUBLE PRECISION :: valor

        !------------------ Apertura del archivo ----------------------
        OPEN(unit = unit_in, file = filename, status = 'old', action = 'read', iostat = ios)
        IF (ios /= 0) THEN
            PRINT *, 'ERROR al abrir archivo: ', filename
            STOP
        END IF

        !------------------ Lectura línea por línea -------------------
        DO
            READ(unit_in, '(A)', IOSTAT = ios) linea
            IF (ios /= 0) EXIT  ! Fin de archivo

            pos_igual = INDEX(linea, '=')
            IF (pos_igual > 0) THEN
                ! Extraer clave (nombre del coeficiente)
                clave = ADJUSTL(linea(MAX(1, pos_igual - 2):pos_igual - 1))
                valor_str = ADJUSTL(linea(pos_igual + 1:))
                pos_barra = INDEX(valor_str, '|')
                IF (pos_barra > 0) THEN
                    valor_str = valor_str(1:pos_barra - 1)
                END IF

                READ(valor_str, *, IOSTAT = ios) valor
                IF (ios /= 0) CYCLE  ! Ignorar si hay error de lectura

                ! Asignar el valor al coeficiente correspondiente
                SELECT CASE (TRIM(clave))
                    CASE ('a'); a = valor
                    CASE ('b'); b = valor
                    CASE ('c'); c = valor
                    CASE ('d'); d = valor
                    CASE ('f'); ff = valor
                    CASE ('g'); g = valor
                END SELECT
            END IF
        END DO

        !------------------ Cierre del archivo -----------------------
        CLOSE(unit_in)

    END SUBROUTINE Leer_Coeficientes

END PROGRAM Practica8