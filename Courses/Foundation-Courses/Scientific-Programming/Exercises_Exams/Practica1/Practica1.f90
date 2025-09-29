!===============================================================================
! PRACTICA 1: FUNCION DIRECTA-INVERSA
!
! Objetivo:
!   Ajustar una función del tipo:
!
!       f(x) = s + t·x + u/x
!
!   que pasa por tres puntos dados (a, fa), (b, fb), (c, fc), utilizando
!   fórmulas cerradas para calcular los parámetros s, t y u.
!
! Entradas:
!   - Archivo 'Datos1.dat': contiene 9 conjuntos de puntos (a,fa), (b,fb), (c,fc)
!
! Salidas:
!   - Archivo 'Solucion1.sol': contiene los valores de s, t y u para cada caso
!
!===============================================================================

!============================== PROGRAMA PRINCIPAL =============================
PROGRAM Practica1
    IMPLICIT NONE

    !--------------------- Declaraciones ----------------------
    CHARACTER(len = 200) :: linea
    CHARACTER(len = 50)  :: parentesis
    INTEGER :: ios, pos1, pos2, i, caso
    INTEGER, PARAMETER :: unit_in = 20, unit_out = 40
    REAL(8) :: a, fa, b, fb, c, fc
    REAL(8) :: p, q, m, s, t, u

    !------------------- Apertura de archivos -----------------
    OPEN(unit = unit_in, file = 'Datos1.dat', status = 'old', action = 'read')
    OPEN(unit = unit_out, file = 'Solucion1.sol', status = 'replace', action = 'write')

    !------------------- Cabecera en salida -------------------
    WRITE(unit_out, '(A)') '|==================================================|'
    WRITE(unit_out, '(A)') '|   SOLUCION PRACTICA 1: FUNCION-DIRECTA-INVERSA   |'
    WRITE(unit_out, '(A)') '|==================================================|'
    WRITE(unit_out, '(A)') ''
    WRITE(unit_out, '(A)') '|===========================================================================================|'
    WRITE(unit_out, '(A)') '| Caso |     (a,fa)     |    (b,fb)     |    (c,fc)    |       s       t       u            |'
    WRITE(unit_out, '(A)') '|===========================================================================================|'

    !------------------- Lectura de línea a línea -------------
    caso = 0
    DO
        READ(unit_in, '(A)', IOSTAT = ios) linea
        IF (ios /= 0) EXIT  ! Fin del archivo

        ! Ignorar encabezados o separadores
        IF (INDEX(linea, '===') > 0 .OR. INDEX(linea, 'Caso') > 0) CYCLE

        caso = caso + 1     ! Contador del número de caso
        pos1 = 1            ! Reiniciar búsqueda de paréntesis

        ! Bucle para leer (a,fa), (b,fb), (c,fc)
        DO i = 1, 3
            pos1 = INDEX(linea(pos1:), '(') + pos1 - 1
            IF (pos1 == 0) EXIT
            pos2 = INDEX(linea(pos1:), ')') + pos1 - 1
            IF (pos2 == 0) EXIT

            parentesis = linea(pos1 + 1 : pos2 - 1)

            SELECT CASE (i)
                CASE (1); READ(parentesis, *, IOSTAT = ios) a, fa
                CASE (2); READ(parentesis, *, IOSTAT = ios) b, fb
                CASE (3); READ(parentesis, *, IOSTAT = ios) c, fc
            END SELECT

            IF (ios /= 0) EXIT  ! Error de lectura
            pos1 = pos2 + 1     ! Avanzar al siguiente
        END DO

        !-------------------- Cálculos -------------------------
        p = (b - c)*(fb - fa)
        q = (a - b)*(fc - fb)
        m = (a - b)*(a - c)*(b - c)

        ! Comprobación de división por cero (evita crash)
        IF (ABS(m) < 1.0D-12) THEN
            WRITE(unit_out,'(A)') '| Error: División por cero en el cálculo de parámetros.                             |'
            CYCLE
        END IF

        s = (m*fa + p*(a**2 + b*c) - q*c*(a + b)) / m
        t = (q*c - p*a) / m
        u = a*b*c*(q - p) / m

        !-------------------- Escritura en salida --------------
        WRITE(unit_out, 900) caso, a, fa, b, fb, c, fc, s, t, u

    END DO

    !-------------------- Pie de tabla ------------------------
    WRITE(unit_out, '(A)') '|===========================================================================================|'

    !-------------------- Cierre de archivos ------------------
    CLOSE(unit_in)
    CLOSE(unit_out)

    !-------------------- Formato de salida -------------------
900 FORMAT('|', I3, '   | (', F0.3, ',', F0.3, ') | (', F0.3, ',', F0.3, ') | (', F0.3, ',', F0.3, ') |', &
           F10.5, 1X, F9.5, 1X, F9.5, '      |')

END PROGRAM Practica1
