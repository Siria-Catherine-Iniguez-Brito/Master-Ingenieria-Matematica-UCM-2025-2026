!===============================================================================
! PRACTICA 7: SISTEMAS DE ECUACIONES NO LINEALES
!
! Objetivo:
!   Resolver un sistema de dos ecuaciones no lineales en dos incógnitas (x, y):
!
!     f₁(x, y) = a₁·exp(x)² + a₂·exp(x) + a₃·(1 + exp(x)²)/exp(y)² + a₄·exp(x)/exp(y)
!               + a₅·exp(x)²·exp(y) + 5·(exp(x)·exp(y))² + 4·exp(x)·exp(y) + 1 = 0
!
!     f₂(x, y) = b₁·(x·y + y·sqrt(4 + x²) + sqrt(4 + x²)·sqrt(6 + y²))
!               + b₂·x·sqrt(4 + x²) + b₃·x·sqrt(6 + y²)
!               + b₄·x² + b₅·y² + b₆ = 0
!
! Método:
!   Se utiliza el algoritmo de Newton modificado, a través de la rutina HYBRD1 
!   de la biblioteca MINPACK, que emplea un método iterativo con derivadas 
!   numéricas para resolver sistemas de ecuaciones no lineales.
!
! Entradas:
!   - Archivo 'Datos7.dat': contiene los coeficientes a₁–a₅ y b₁–b₆ que definen
!     el sistema de ecuaciones para un único caso.
!
! Salidas:
!   - Archivo 'Solucion7.sol': contiene la solución aproximada (x, y) del sistema
!     con 5 cifras decimales de precisión, así como la evaluación de las funciones
!     f₁(x, y), f₂(x, y) en la solución, la norma del vector resultante y el
!     código de salida de la rutina HYBRD1.
!
! Notas:
!   - Se parte de una estimación inicial (x₀, y₀) = (0.5, 0.5).
!   - Si el método converge correctamente, se informa de la solución con detalle.
!   - Si no converge, se presenta un mensaje de error explicativo.
!
!===============================================================================

!============================ MÓDULO DE PARÁMETROS ============================
MODULE Params_Mod1
    IMPLICIT NONE
    ! Declaración de los coeficientes a₁–a₅ y b₁–b₆ como variables globales de doble precisión
    REAL(8) :: a1, a2, a3, a4, a5
    REAL(8) :: b1, b2, b3, b4, b5, b6
END MODULE Params_Mod1

!============================= PROGRAMA PRINCIPAL =============================
PROGRAM Practica7
    USE Params_Mod1 ! Importa los coeficientes del módulo
    IMPLICIT NONE

    !--------------------- Declaraciones ----------------------
    INTEGER, PARAMETER        :: n = 2, unit_out = 50
    REAL(8)                   :: x(n), fvec(n), tol
    INTEGER                   :: info, lwa
    REAL(8), ALLOCATABLE      :: wa(:)
    EXTERNAL                  :: fcn

    !------------------ Leer coeficientes desde el fichero ---------------------
    CALL Leer_Coeficientes("Datos7.dat")

    !------------------ Condiciones iniciales e hiperparámetros ----------------
    x(1) = 0.5D0 ! Estimación inicial para x
    x(2) = 0.5D0 ! Estimación inicial para y
    tol  = 1.0D-8 ! Tolerancia de convergencia
    lwa  = (n * (3 * n + 13)) / 2 ! Tamaño requerido por el algoritmo HYBRD1
    ALLOCATE(wa(lwa)) ! Reserva memoria para vector de trabajo

    !------------------ Resolver sistema no lineal con HYBRD1 ------------------
    CALL hybrd1(fcn, n, x, fvec, tol, info, wa, lwa)

    !------------------ Escribir solución en el archivo de salida --------------
    OPEN(unit = unit_out, file = "Solucion7.sol", status = "replace", action = "write")
    WRITE(unit_out, '(A)') "|=============================================================|"
    WRITE(unit_out, '(A)') "|   SOLUCION PRACTICA 7: SISTEMAS-DE-ECUACIONES-NO-LINEALES   |"
    WRITE(unit_out, '(A)') "|=============================================================|"
    WRITE(unit_out, *)
    WRITE(unit_out, '(A)') "|==================================|"
    WRITE(unit_out, '(A)') "| Sistema de ecuaciones:"
    WRITE(unit_out, '(A)') "| f₁(x,y) = 0   ;   f₂(x,y) = 0 "
    WRITE(unit_out, '(A)') "|==================================|"
    WRITE(unit_out, *)
    WRITE(unit_out, '(A)') "|==================================|"
    WRITE(unit_out, '(A)') "| Solución aproximada: "
    WRITE(unit_out, '(A, F12.5)') "| x = ", x(1) 
    WRITE(unit_out, '(A, F12.5)') "| y = ", x(2) 
    WRITE(unit_out, '(A)') "|==================================|"
    WRITE(unit_out, *)

    WRITE(unit_out, '(A)') "|==================================|"
    WRITE(unit_out, '(A)') "| Evaluación en la solución:"
    WRITE(unit_out, '(A, F12.5)') "| f₁(x,y) = ", fvec(1)
    WRITE(unit_out, '(A, F12.5)') "| f₂(x,y) = ", fvec(2)
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

        OPEN(unit = 10, file = filename, status = 'old', action = 'read', IOSTAT = ios)
        IF (ios /= 0) THEN
            PRINT *, "Error: No se pudo abrir el archivo ", filename
            STOP
        END IF

        DO
            READ(10,'(A)', IOSTAT = ios) linea
            IF (ios /= 0) EXIT
            IF (INDEX(linea,'a1=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) a1
            IF (INDEX(linea,'a2=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) a2
            IF (INDEX(linea,'a3=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) a3
            IF (INDEX(linea,'a4=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) a4
            IF (INDEX(linea,'a5=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) a5
            IF (INDEX(linea,'b1=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) b1
            IF (INDEX(linea,'b2=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) b2
            IF (INDEX(linea,'b3=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) b3
            IF (INDEX(linea,'b4=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) b4
            IF (INDEX(linea,'b5=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) b5
            IF (INDEX(linea,'b6=') > 0) READ(linea(INDEX(linea,'=') + 1:), *) b6
        END DO
        CLOSE(10)
    END SUBROUTINE Leer_Coeficientes

END PROGRAM Practica7

!===============================================================================
! SUBRUTINA QUE CALCULA EL SISTEMA DE ECUACIONES NO LINEALES
!
! Entradas:
!   n     - número de variables (2)
!   x     - vector de variables [x(1) = x, x(2) = y]
!   iflag - indicador para la función (no usado aquí)
!
! Salidas:
!   fvec  - vector resultado con f₁(x,y) y f₂(x,y)
!
!===============================================================================
SUBROUTINE fcn(n, x, fvec, iflag)
    USE Params_Mod1
    IMPLICIT NONE
    INTEGER, INTENT(IN)     :: n, iflag
    REAL(8), INTENT(IN)     :: x(n) 
    REAL(8), INTENT(OUT)    :: fvec(n) 
    REAL(8) :: ex, ey, rx, ry ! Variables intermedias: exp(x), exp(y), sqrt(4 + x^2), sqrt(6 + y^2)
    
    ! Calcula las funciones auxiliares
    ex = EXP(x(1))
    ey = EXP(x(2))
    rx = SQRT(4.0D0 + x(1)**2)
    ry = SQRT(6.0D0 + x(2)**2)

    ! Primera ecuación no lineal
    fvec(1) = a1*ex**2 + a2*ex + a3*(1.0D0 + ex**2)/(ey**2) + a4*ex/ey + &
              a5*ex**2*ey + 5.0D0*(ex*ey)**2 + 4.0D0*ex*ey + 1.0D0

    ! Segunda ecuación no lineal
    fvec(2) = b1*(x(1)*x(2) + x(2)*rx + rx*ry) + b2*x(1)*rx + b3*x(1)*ry + &
              b4*x(1)**2 + b5*x(2)**2 + b6
END SUBROUTINE fcn
