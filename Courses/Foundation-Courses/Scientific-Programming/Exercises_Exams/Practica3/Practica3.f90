!===============================================================================
! PRACTICA 3: SIGUIENTE-COMBINACION
!
! Objetivo:
!   Dado un conjunto de números naturales del 1 al m y una k-combinación sin
!   repetición en orden lexicográfico, se desea obtener la siguiente k-combinación.
!
!   La siguiente combinación se determina incrementando el primer elemento desde
!   la derecha que aún no ha alcanzado su valor máximo posible, y ajustando los
!   valores posteriores de forma consecutiva.
!
! Entradas:
!   - Archivo 'Datos3.dat': contiene varios casos con m, k y una k-combinación p
!
! Salidas:
!   - Archivo 'Solucion3.sol': contiene la siguiente combinación p+1 en orden
!     lexicográfico; en caso de que no exista tal combinaacion devuelve un vector de -1
!
!===============================================================================

PROGRAM Practica3
    IMPLICIT NONE

    !--------------------- Parámetros y Declaraciones ---------------------
    INTEGER, PARAMETER :: unit_in = 30, unit_out = 50
    INTEGER :: m, k                    ! m: tamaño del conjunto, k: tamaño de la combinación
    INTEGER :: i, idx, ios, pos1, pos2
    CHARACTER(LEN = 200) :: linea
    CHARACTER(LEN = 50)  :: sublinea
    INTEGER, ALLOCATABLE :: current_combination(:), next_combination(:)

    !--------------------- Apertura de Archivos ---------------------
    OPEN(unit = unit_in, file = 'Datos3.dat', status = 'OLD', action = 'read')
    OPEN(unit = unit_out, file = 'Solucion3.sol', status = 'REPLACE', action = 'write')

    !--------------------- Cabecera en salida ---------------------
    WRITE(unit_out, '(A)') '|================================================|'
    WRITE(unit_out, '(A)') '|   SOLUCION PRACTICA 3: SIGUIENTE-COMBINACION   |'
    WRITE(unit_out, '(A)') '|================================================|'
    WRITE(unit_out, '(A)') ''
    !--------------------- Procesamiento de Casos ---------------------
    DO
        READ(unit_in, '(A)', IOSTAT=ios) linea
        IF (ios /= 0) EXIT  ! Fin del archivo

        ! Saltar encabezados o separadores
        IF (INDEX(linea, '=') > 0 .OR. INDEX(linea, 'm') > 0 .OR. INDEX(linea, '-') > 0) THEN
            WRITE(unit_out, '(A)') linea
            CYCLE
        END IF

        pos1 = INDEX(linea, '|')
        DO i = 1, 3
            pos2 = INDEX(linea(pos1 + 1:), '|') + pos1
            sublinea = TRIM(ADJUSTL(linea(pos1 + 1 : pos2 - 1)))

            SELECT CASE (i)
                CASE (1)
                    READ(sublinea, *, IOSTAT = ios) m
                CASE (2)
                    READ(sublinea, *, IOSTAT = ios) k
                    WRITE(unit_out, '(3X,"| ",I2," | ",I2," |")', advance ='no') m, k
                CASE (3)
                    ALLOCATE(current_combination(k))
                    READ(sublinea, *, IOSTAT = ios) current_combination
                    WRITE(unit_out, '(A)', advance = 'no') linea(pos1 + 1 : pos2)
            END SELECT

            pos1 = pos2
        END DO

        !--------------------- Calcular siguiente combinación ---------------------
        CALL Siguiente_Combinacion(current_combination, m, k, next_combination)

        !--------------------- Escribir resultado ---------------------
        WRITE(unit_out, '(A)', advance='NO') REPEAT(' ', 22 - 3 * k)
        DO idx = 1, k
            WRITE(unit_out, '(I2,1X)', advance='NO') next_combination(idx)
        END DO
        WRITE(unit_out, '(A)') '| '

        !--------------------- Liberar memoria ---------------------
        DEALLOCATE(current_combination)
        DEALLOCATE(next_combination)
    END DO

    !--------------------- Cierre de Archivos ---------------------
    CLOSE(unit_in)
    CLOSE(unit_out)


    CONTAINS

        !-------------------------------------------------------------------------
        ! SUBRUTINA: Siguiente_Combinacion
        ! Calcula la siguiente combinación en orden lexicográfico.
        !
        ! Parámetros:
        !   - p(k)     : combinación actual
        !   - m        : número máximo
        !   - k        : tamaño de la combinación
        !   - resultado(k) : siguiente combinación (o vector de -1 si no existe)
        !-------------------------------------------------------------------------
        SUBROUTINE Siguiente_Combinacion(p, m, k, resultado)
            IMPLICIT NONE
            INTEGER, INTENT(IN)  :: m, k
            INTEGER, INTENT(IN)  :: p(k)
            INTEGER, ALLOCATABLE, INTENT(OUT) :: resultado(:)

            INTEGER :: i, j
            LOGICAL :: cambio

            ALLOCATE(resultado(k))
            resultado = p
            cambio = .FALSE.

            DO i = k, 1, -1
                IF (p(i) < m - (k - i)) THEN
                    resultado(i) = p(i) + 1
                    DO j = i + 1, k
                        resultado(j) = resultado(j - 1) + 1
                    END DO
                    cambio = .TRUE.
                    EXIT
                END IF
            END DO

            IF (.NOT. cambio) THEN
                resultado = -1
            END IF
        END SUBROUTINE Siguiente_Combinacion

END PROGRAM Practica3
