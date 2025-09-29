!===============================================================================
! EXAMEN 2: ECUACIÓN TRANSCENDENTE
!
! Objetivo:
!   Resolver una ecuación no lineal en una variable real x, de tipo trascendente:
!
!       r*ln(1 + x²) + s*√(1 + x⁴) + t*e^(-1/x) + u*x² = v
!
!   donde los coeficientes r, s, t, u, v se leen desde un archivo externo.
!   La solución se obtiene utilizando rutinas del paquete MINPACK (HYBRD1).
!
! Entradas:
!   - Archivo 'DatosE2.dat': contiene los valores de los coeficientes r, s, t, u, v
!
! Salidas:
!   - Archivo 'SolucionE2.sol': contiene:
!       • La solución aproximada de la ecuación (valor de x).
!       • La evaluación de la función en dicha solución.
!       • La norma ||F(x)|| del residuo.
!       • El código de salida devuelto por HYBRD1 con su interpretación.
!
! Resultado:
!   - Se escribe el siguiente formato en el fichero de salida:
!
!     ==================================
!     | Solución aproximada:
!     | x = ...
!     ==================================
!
!     ==================================
!     | Evaluación en la solución:
!     | f(x) = ...
!     | Norma ||F(x)|| = ...
!     ==================================
!
!     ==================================
!     | Código de salida de MINPACK: ...
!     | → [Mensaje interpretando el código]
!     ==================================
!
! Método:
!   1. Leer los coeficientes r, s, t, u, v desde 'DatosE2.dat'.
!   2. Definir una condición inicial x₀ y la tolerancia de convergencia.
!   3. Resolver la ecuación con la subrutina HYBRD1.
!   4. Evaluar la función en el valor obtenido.
!   5. Escribir los resultados detallados en 'SolucionE2.sol'.
!
! Notas:
!   - La solución debe imprimirse con al menos 9 cifras significativas.
!
!===============================================================================


!============================ MÓDULO DE PARÁMETROS ============================
MODULE Params_ModE1
    IMPLICIT NONE
    
    REAL(8) :: r, s, t, u, v
END MODULE Params_ModE1

!============================== PROGRAMA PRINCIPAL =============================
PROGRAM Examen2
    USE Params_ModE1 ! Importa los coeficientes del módulo
    IMPLICIT NONE

    !--------------------- Declaraciones ----------------------
    INTEGER, PARAMETER        :: n = 2, unit_out = 50
    REAL(8)                   :: x(n), fvec(n), tol
    INTEGER                   :: info, lwa
    REAL(8), ALLOCATABLE      :: wa(:)
    EXTERNAL                  :: fcn

    !------------------ Leer coeficientes desde el fichero ---------------------
    CALL Leer_Coeficientes("DatosE2.dat")

    !------------------ Condiciones iniciales e hiperparámetros ----------------
    x(1) = 0.5D0 ! Estimación inicial para x
    x(2) = 0.5D0 ! Estimación inicial para y
    tol  = 1.0D-8 ! Tolerancia de convergencia
    lwa  = (n * (3 * n + 13)) / 2 ! Tamaño requerido por el algoritmo HYBRD1
    ALLOCATE(wa(lwa)) ! Reserva memoria para vector de trabajo

    !------------------ Resolver sistema no lineal con HYBRD1 ------------------
    CALL hybrd1(fcn, n, x, fvec, tol, info, wa, lwa)

    !------------------ Escribir solución en el archivo de salida --------------
    OPEN(unit = unit_out, file = "SolucionE2.sol", status = "replace", action = "write")
    WRITE(unit_out, '(A)') "|===============================================|"
    WRITE(unit_out, '(A)') "|   SOLUCION EXAMEN-2: ECUACION TRANSCENDENTE   |"
    WRITE(unit_out, '(A)') "|===============================================|"
    WRITE(unit_out, *)
    WRITE(unit_out, '(A)') "|==================================|"
    WRITE(unit_out, '(A)') "| Sistema de ecuaciones:"
    WRITE(unit_out, '(A)') "| f(x) = 0 (Ver documentacion) "
    WRITE(unit_out, '(A)') "|==================================|"
    WRITE(unit_out, *)
    WRITE(unit_out, '(A)') "|==================================|"
    WRITE(unit_out, '(A)') "| Solución aproximada: "
    WRITE(unit_out, '(A, F12.9)') "| x = ", x(1) 
    WRITE(unit_out, '(A)') "|==================================|"
    WRITE(unit_out, *)

    WRITE(unit_out, '(A)') "|==================================|"
    WRITE(unit_out, '(A)') "| Evaluación en la solución:"
    WRITE(unit_out, '(A, F12.5)') "| f(x) = ", fvec(1)
    WRITE(unit_out, '(A, F12.5)') "| Norma ||F(x)|| = ", SQRT(SUM(fvec**2))
    WRITE(unit_out, '(A)') "|===================================|"
    WRITE(unit_out, *)
    WRITE(unit_out, '(A)') "|===================================|"
    WRITE(unit_out, '(A, I2)') "| Código de salida de MINPACK: ", info
    SELECT CASE (info)
        CASE (1)
            WRITE(unit_out, '(A)') "| → Convergencia alcanzada."
            WRITE(unit_out, '(A)') "|===================================|"
        CASE (2)
            WRITE(unit_out, '(A)') "| → Exceso de llamadas a fcn."
            WRITE(unit_out, '(A)') "|===================================|"
        CASE DEFAULT
            WRITE(unit_out, '(A)') "| → Error desconocido en la ejecución."
            WRITE(unit_out, '(A)') "|===================================|"
    END SELECT
    DEALLOCATE(wa)
    CLOSE(unit_out)

CONTAINS
    SUBROUTINE Leer_Coeficientes(filename)
        USE Params_Mod1
        CHARACTER(len = *), INTENT(IN) :: filename
        CHARACTER(len = 200) :: linea
        INTEGER :: ios
        INTEGER, PARAMETER :: unit_in = 30

        OPEN(unit = unit_in, file = filename, status = 'old', action = 'read', IOSTAT = ios)
        IF (ios /= 0) THEN
            PRINT *, "Error: No se pudo abrir el archivo ", filename
            STOP
        END IF

        DO
            READ(unit_in,'(A)', IOSTAT = ios) linea
            IF (ios /= 0) EXIT
            IF (INDEX(linea,'r =') > 0) READ(linea(INDEX(linea,'=') + 1:), *) r
            IF (INDEX(linea,'s =') > 0) READ(linea(INDEX(linea,'=') + 1:), *) s
            IF (INDEX(linea,'t =') > 0) READ(linea(INDEX(linea,'=') + 1:), *) t
            IF (INDEX(linea,'u =') > 0) READ(linea(INDEX(linea,'=') + 1:), *) u
            IF (INDEX(linea,'v =') > 0) READ(linea(INDEX(linea,'=') + 1:), *) v
        END DO
        CLOSE(unit_in)
    END SUBROUTINE Leer_Coeficientes

END PROGRAM Examen2


!===============================================================================
! SUBRUTINA QUE CALCULA EL SISTEMA DE ECUACIONES NO LINEALES
!
! Entradas:
!   n     - número de variables (1)
!   x     - vector de variables [x(1) = x]
!   iflag - indicador para la función (no usado aquí)
!
! Salidas:
!   fvec  - vector resultado con f(x) 
!
!===============================================================================

SUBROUTINE fcn(n, x, fvec, iflag)
    USE Params_ModE1
    IMPLICIT NONE
    INTEGER, INTENT(IN)     :: n, iflag
    REAL(8), INTENT(IN)     :: x(n) 
    REAL(8), INTENT(OUT)    :: fvec(n) 

    ! Primera ecuación no lineal
    fvec(1) = r*LOG(1+x(1)**2) + s*SQRT(1+x(1)**4) + t*EXP(-1/x(1)) + u*x(1)**2 - v  
END SUBROUTINE fcn