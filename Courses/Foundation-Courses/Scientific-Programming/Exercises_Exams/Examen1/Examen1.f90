!===============================================================================
! PRACTICA EXAMEN-1: SUBMATRIZ-ABSMIN
!
! Objetivo:
!   Localizar, dentro de una matriz X(25,11), la submatriz rectangular A(p,q)
!   formada por p filas consecutivas y q columnas consecutivas, tal que el valor 
!   absoluto de la suma de sus elementos sea mínimo:
!
!       f(A) = ABS(SUM(A(i,j)))
!
!   En este caso, se desea hallar la submatriz A(r,s) = X(r:r+4, s:s+2) de 
!   dimensiones 5x3 (p = 5, q = 3), con el menor valor de f(A) entre todas las 
!   submatrices posibles en X.
!
! Entradas:
!   - Archivo 'DatosE1.dat': contiene la matriz X de dimensiones 25 x 11
!
! Salidas:
!   - Archivo 'SolucionE1.sol': contiene:
!       • Los índices r y s que definen la submatriz A(r,s) con menor f(A).
!       • El valor f(A(r,s)).
!       • La suma de los elementos de las matrices B'B y BB', siendo B = A(r,s) y 
!         B' su transpuesta.
!       • Los valores máximo y mínimo de los elementos de B'B y BB'.
!
! Método:
!   1. Leer la matriz X(25,11) desde 'DatosE1.dat'.
!   2. Para cada submatriz A(r,s) = X(r:r+4, s:s+2), calcular:
!        • f(A) = valor absoluto de la suma de sus elementos.
!   3. Identificar la submatriz con valor mínimo de f(A).
!   4. Calcular B'B y BB' con B = A(r,s).
!   5. Escribir en 'SolucionE1.sol' todos los resultados requeridos.
!
!===============================================================================


!============================== PROGRAMA PRINCIPAL =============================
PROGRAM Examen1
    IMPLICIT NONE

    !--------------------- Declaraciones ---------------------
    INTEGER, PARAMETER :: unit_out = 50
    INTEGER :: m, n, p, q
    INTEGER :: ios, pos, i, j, d, f

    REAL(kind = 8), allocatable :: X(:,:), A(:,:), B(:,:), C1(:,:), C2(:,:)
    REAL(kind = 8) :: fabsoluto, suma1, suma2, max1, max2, min1, min2

    !--------------------- Leer datos ---------------------
    CALL Leer_Coeficientes("DatosE1.dat", X, m, n, p, q)

    !--------------------- Validación ---------------------
    IF (p > m .OR. q > n) THEN
        PRINT *, "Error: p y q deben ser menores o iguales que m y n respectivamente."
        STOP
    END IF

    !--------------------- Búsqueda de submatriz óptima ---------------------
    CALL Buscar_Submatriz_AbsMin(X, m, n, p, q, d, f, A, fabsoluto)

    !--------------------- Cálculo de B'B y BB' ---------------------
    ALLOCATE(B(q,p), C1(q,q), C2(p,p))
    B = TRANSPOSE(A)
    C1 = MATMUL(B, A)
    C2 = MATMUL(A, B)

    suma1 = SUM(C1)
    suma2 = SUM(C2)
    max1  = MAXVAL(C1)
    max2  = MAXVAL(C2)
    min1  = MINVAL(C1)
    min2  = MINVAL(C2)
    
    !--------------------- Escritura en archivo de salida ---------------------
    OPEN(unit = unit_out, file = 'SolucionE1.sol', status = 'replace', action = 'write')
  
    WRITE(unit_out, '(A)') '|=========================================|'
    WRITE(unit_out, '(A)') '|   SOLUCION EXAMEN-1: SUBMATRIZ-ABSMIN   |'
    WRITE(unit_out, '(A)') '|=========================================|'
    WRITE(unit_out, '(A)') ''
    WRITE(unit_out,'(A)') '|=======      ========        =======================|'
    WRITE(unit_out,'(A, I3, 6X, A, I3, 8X, A, F10.6)') '| r = ', d, 's = ', f, 'f(A(r,s)) = ', fabsoluto
    WRITE(unit_out,'(A)') '|=======      ========        =======================|'
    WRITE(unit_out,'(A)') ''
    WRITE(unit_out,'(A)') ''
    WRITE(unit_out, '(A)') '|====================================================|'
    WRITE(unit_out,'(A)') '| Sea B = A(r,s)'
    WRITE(unit_out,'(A)') '|'
    WRITE(unit_out,'(A, F7.3, 3X, A, F7.3)') '| SUMA(B''B) = ', suma1, 'SUMA(BB'') = ', suma2
    WRITE(unit_out,'(A, F7.3, 3X, A, F7.3)') '| max(B''B)  = ', max1,  'max(BB'')  = ', max2
    WRITE(unit_out,'(A, F7.3, 3X, A, F7.3)') '| min(B''B)  = ', min1,  'min(BB'')  = ', min2
    WRITE(unit_out, '(A)') '|====================================================|'
    


    !--------------------- Liberar memoria ---------------------
    DEALLOCATE(X, A, B, C1, C2)
    CLOSE(unit_out)


CONTAINS
    !-----------------------------------------------------------------------------
    ! Subrutina: Leer_Coeficientes
    ! Lee la matriz X y los valores de m, n, p, q desde el archivo de entrada
    !-----------------------------------------------------------------------------
    SUBROUTINE Leer_Coeficientes(filename, X, m, n, p, q)
        IMPLICIT NONE
        CHARACTER(len=*), INTENT(IN) :: filename
        REAL(8), ALLOCATABLE, INTENT(OUT) :: X(:,:)
        INTEGER, INTENT(OUT) :: m, n, p, q

        INTEGER :: i, j, idx, unit_in, ios
        CHARACTER(len = 200) :: line
        INTEGER :: pos_m, pos_n, pos_p, pos_q

        ! Abrir fichero
        OPEN(unit = unit_in, file = filename, status = 'old', action = 'read', IOSTAT = ios)
        IF (ios /= 0) THEN
            PRINT *, 'Error al abrir archivo: ', filename
            STOP
        END IF

        ! Leer primera línea (con m,n,p,q)
        READ(unit_in, '(A)', IOSTAT = ios) line
        IF (ios /= 0) THEN
            PRINT *, "Error leyendo línea de parámetros"
            STOP
        END IF

        ! Buscar posiciones y extraer valores
        pos_m = INDEX(line, "m =")
        pos_n = INDEX(line, "n =")
        pos_p = INDEX(line, "p =")
        pos_q = INDEX(line, "q =")

        IF (pos_m == 0 .OR. pos_n == 0 .OR. pos_p == 0 .OR. pos_q == 0) THEN
            PRINT *, "No se encontraron todos los parámetros en la línea:"
            PRINT *, TRIM(line)
            STOP
        END IF

        READ(line(pos_m+3:), *, IOSTAT = ios) m
        IF (ios /= 0) THEN
            PRINT *, "Error leyendo 'm' en:", line(pos_m:)
            STOP
        END IF

        READ(line(pos_n+3:), *, IOSTAT = ios) n
        IF (ios /= 0) THEN
            PRINT *, "Error leyendo 'n' en:", line(pos_n:)
            STOP
        END IF

        READ(line(pos_p+3:), *, IOSTAT = ios) p
        IF (ios /= 0) THEN
            PRINT *, "Error leyendo 'p' en:", line(pos_p:)
            STOP
        END IF

        READ(line(pos_q+3:), *, IOSTAT = ios) q
        IF (ios /= 0) THEN
            PRINT *, "Error leyendo 'q' en:", line(pos_q:)
            STOP
        END IF

        ! Saltar 2 líneas de encabezado
        READ(unit_in, '(A)', IOSTAT = ios) line
        READ(unit_in, '(A)', IOSTAT = ios) line


        ALLOCATE(X(m, n))

        ! Leer matriz
        DO i = 1, m
            READ(unit_in, '(A)', IOSTAT = ios) line
            IF (ios /= 0) THEN
                PRINT *, "Error leyendo fila ", i
                STOP
            END IF
            ! Leer desde carácter después de la barra '|'
            idx = INDEX(line,'|') + 1
            READ(line(idx:), *, IOSTAT = ios) (X(i,j), j = 1, n)
            IF (ios /= 0) THEN
                PRINT *, "Error interpretando datos fila ", i
                STOP
            END IF
        END DO

        CLOSE(unit_in)
    END SUBROUTINE Leer_Coeficientes

    !-----------------------------------------------------------------------------
    ! Subrutina: Buscar_Submatriz_AbsMin
    ! Busca la submatriz A(p,q) con menor valor absoluto de la suma de elementos
    !-----------------------------------------------------------------------------
    SUBROUTINE Buscar_Submatriz_AbsMin(X, m, n, p, q, r, s, A, fabsoluto)
        IMPLICIT NONE
        INTEGER, INTENT(IN) :: m, n, p, q
        REAL(8), INTENT(IN) :: X(m,n)
        INTEGER, INTENT(OUT) :: r, s
        REAL(8), ALLOCATABLE, INTENT(OUT) :: A(:,:)
        REAL(8), INTENT(OUT) :: fabsoluto
        INTEGER :: i, j
        REAL(8) :: aux

        fabsoluto = HUGE(1.0D0)  ! Inicializar con valor muy grande
        r = 1
        s = 1

        DO i = 1, m - p + 1
            DO j = 1, n - q + 1
                aux = ABS(SUM(X(i:i+p-1, j:j+q-1)))
                IF (aux < fabsoluto) THEN
                    fabsoluto = aux
                    r = i
                    s = j
                END IF
            END DO
        END DO
        ALLOCATE(A(p,q))
        A = X(r : r + p - 1, s : s + q - 1)
    END SUBROUTINE Buscar_Submatriz_AbsMin

END PROGRAM Examen1