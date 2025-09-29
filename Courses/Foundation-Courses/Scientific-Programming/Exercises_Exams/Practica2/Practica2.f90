!===============================================================================
! PRACTICA 2: SUBMATRIZ CENTRO-ESQUINAS
!
! Objetivo:
!   Localizar, dentro de una matriz A(20,10), la submatriz cuadrada B de orden 5
!   (formada por 5 filas y 5 columnas consecutivas) que tiene el mayor valor de 
!   "diferencia centro-esquinas", definida como:
!
!       difcenesq(S) = S((n+1)/2,(n+1)/2) - (S(1,1) + S(1,n) + S(n,1) + S(n,n))
!
!   La operación se aplica a todas las submatrices 5x5 posibles dentro de A.
!
! Entradas:
!   - Archivo 'Datos2.dat': contiene la matriz A de dimensiones 20 x 10
!
! Salidas:
!   - Archivo 'Solucion2.sol': contiene:
!       • Los índices i y j de la submatriz B = A(i:i+4, j:j+4) con mayor 
!         diferencia centro-esquinas.
!       • El valor difcenesq(B).
!       • La diagonal principal de la matriz C = B^9 (potencia 9 de B),
!         escrita con cinco cifras decimales.
!
! Resultado:
!   - Se escribe el siguiente formato en el fichero de salida:
!
!         ======     ======                                               ============
!     i = |    |  j = |    |    difcenesq(B) = difcenesq(A(i:i+4,j:j+4)) = |          |
!         ======     ======                                               ============
!
!     =============================
!     | c(1,1) =                  |
!     | c(2,2) =                  |
!     | c(3,3) =                  |
!     | c(4,4) =                  |
!     | c(5,5) =                  |
!     =============================
!
! Método:
!   1. Leer la matriz A(20,10) desde 'Datos2.dat'.
!   2. Para cada submatriz B = A(i:i+4,j:j+4), calcular su diferencia
!      centro-esquinas.
!   3. Identificar la submatriz con el valor máximo de dicha métrica.
!   4. Calcular C = B^9 utilizando multiplicación matricial.
!   5. Escribir en 'Solucion2.sol' los valores requeridos.
!
!===============================================================================

!============================== PROGRAMA PRINCIPAL =============================
PROGRAM Practica2
    IMPLICIT NONE

    !--------------------- Parámetros y Declaraciones ---------------------
    INTEGER, PARAMETER :: N = 5
    INTEGER, PARAMETER :: unit_in = 30, unit_out = 50

    CHARACTER(LEN=500) :: linea
    INTEGER            :: ios, i, j, k, l
    INTEGER            :: nfilas, ncolum
    INTEGER            :: fila_max, col_max
    REAL(8), ALLOCATABLE :: A(:,:), B(:,:), C(:,:)
    REAL(8) :: dif_max

    !--------------------- Apertura de archivos ---------------------
    OPEN(unit = unit_out, file = 'Solucion2.sol', status = 'replace', action = 'write')

    !--------------------- Lectura de la matriz desde archivo ---------------------
    CALL Leer_Coeficientes('Datos2.dat', A, nfilas, ncolum)

    !--------------------- Verificación de tamaño ---------------------
    IF (nfilas < N .OR. ncolum < N) THEN
        WRITE(*,*) 'ERROR: La matriz debe ser al menos de tamaño 5x5'
        STOP
    END IF

    !--------------------- Asignación de submatrices ---------------------
    ALLOCATE(B(N,N), C(N,N))

    !--------------------- Búsqueda de submatriz óptima ---------------------
    CALL Buscar_Max_Dif(A, nfilas, ncolum, N, fila_max, col_max, B, dif_max)

    !--------------------- Escritura de resultados ---------------------
    WRITE(unit_out, '(A)') '|====================================================|'
    WRITE(unit_out, '(A)') '|   SOLUCION PRACTICA 2: SUBMATRIZ-CENTRO-ESQUINAS   |'
    WRITE(unit_out, '(A)') '|====================================================|'
    WRITE(unit_out, '(A)') ''
    WRITE(unit_out, '(A)') '|=====================================================|'
    WRITE(unit_out, '(A, I2, A, I2, A, ES14.6, A)') &
        '| i = ', fila_max, ' |  j = ', col_max, ' |   difcenesq(B) = ', dif_max, '  |'
    WRITE(unit_out, '(A)') '|=====================================================|'

    !--------------------- Cálculo de C = B^9 ---------------------
    C = B
    DO k = 2, 9
        C = MATMUL(C, B)
    END DO

    !--------------------- Escritura de la diagonal de C ---------------------
    WRITE(unit_out, '(A)') ''
    WRITE(unit_out, '(A)') '|================================|'
    WRITE(unit_out, '(A)') '| Diagonal de la matriz C = B^9: |'
    WRITE(unit_out, '(A)') '|================================|'

    DO l = 1, N
        WRITE(unit_out, '("|    c(", I1, ",", I1, ") = ", F0.5, "    |")') l, l, C(l,l)
    END DO

    WRITE(unit_out, '(A)') '|================================|'

    !--------------------- Cierre de archivo ---------------------
    CLOSE(unit_out)

CONTAINS

    !-------------------------------------------------------------------------
    ! Subrutina: Leer_Coeficientes
    ! Lee el archivo de datos y construye la matriz A dinámicamente
    !-------------------------------------------------------------------------
    SUBROUTINE Leer_Coeficientes(filename, A, nfilas, ncolum)
        IMPLICIT NONE
        CHARACTER(LEN=*), INTENT(IN)        :: filename
        REAL(8), ALLOCATABLE, INTENT(OUT)   :: A(:,:)
        INTEGER, INTENT(OUT)                :: nfilas, ncolum

        CHARACTER(LEN=500) :: linea, sublinea
        INTEGER :: ios, pos1, pos2, pos3
        INTEGER :: i, j
        INTEGER :: unit_in

        unit_in = 30

        !--------------------- Abrir archivo de entrada ---------------------
        OPEN(unit = unit_in, file = filename, status = 'old', action = 'read', IOSTAT = ios)
        IF (ios /= 0) STOP 'Error al abrir archivo de entrada'

        !--------------------- Leer dimensiones de la matriz ---------------------
        READ(unit_in, '(A)', IOSTAT = ios) linea
        IF (ios /= 0) STOP 'Error leyendo la línea de dimensiones'

        pos1 = INDEX(linea, '(')
        pos2 = INDEX(linea, ')')
        IF (pos1 == 0 .OR. pos2 == 0) STOP 'No se encontraron paréntesis en la línea de dimensiones'

        sublinea = linea(pos1 + 1 : pos2 - 1)
        READ(sublinea, *, IOSTAT = ios) nfilas, ncolum
        IF (ios /= 0) STOP 'Error leyendo nfilas y ncolum'

        !--------------------- Asignación de memoria ---------------------
        ALLOCATE(A(nfilas, ncolum))

        !--------------------- Saltar línea vacía ---------------------
        READ(unit_in, '(A)', IOSTAT = ios) linea
        IF (ios /= 0) STOP 'Error leyendo línea vacía después de dimensiones'

        !--------------------- Lectura de la matriz ---------------------
        DO i = 1, nfilas
            READ(unit_in, '(A)', IOSTAT=ios) linea
            IF (ios /= 0) STOP 'Error leyendo fila de datos'

            pos3 = INDEX(linea, ':')
            IF (pos3 == 0) STOP 'No se encontró ":" en la línea'

            sublinea = ADJUSTL(linea(pos3 + 1:))
            READ(sublinea, *, IOSTAT=ios) (A(i,j), j = 1, ncolum)
            IF (ios /= 0) STOP 'Error leyendo valores numéricos en la fila'
        END DO

        !--------------------- Cierre de archivo ---------------------
        CLOSE(unit_in)
    END SUBROUTINE Leer_Coeficientes

    !-------------------------------------------------------------------------
    ! Subrutina: Buscar_Max_Dif
    ! Encuentra la submatriz B de orden N que maximiza la diferencia:
    !     centro - (esquinas)
    !-------------------------------------------------------------------------
    SUBROUTINE Buscar_Max_Dif(A, nfilas, ncolum, N, fila_out, col_out, B_out, dif_max)
        IMPLICIT NONE
        INTEGER, INTENT(IN)    :: nfilas, ncolum, N
        REAL(8), INTENT(IN)    :: A(nfilas, ncolum)
        INTEGER, INTENT(OUT)   :: fila_out, col_out
        REAL(8), INTENT(OUT)   :: B_out(N, N), dif_max

        INTEGER :: i, j, ic, jc
        REAL(8) :: dif_actual

        dif_max  = -HUGE(1.0D0)
        fila_out = 1
        col_out  = 1

        ic = (N + 1) / 2
        jc = (N + 1) / 2

        DO i = 1, nfilas - N + 1
            DO j = 1, ncolum - N + 1
                dif_actual = A(i + ic - 1, j + jc - 1) - ( &
                             A(i, j) + A(i, j + N - 1) + A(i + N - 1, j) + A(i + N - 1, j + N - 1) )
                IF (dif_actual > dif_max) THEN
                    dif_max  = dif_actual
                    fila_out = i
                    col_out  = j
                END IF
            END DO
        END DO

        B_out = A(fila_out : fila_out + N - 1, col_out : col_out + N - 1)
    END SUBROUTINE Buscar_Max_Dif

END PROGRAM Practica2
