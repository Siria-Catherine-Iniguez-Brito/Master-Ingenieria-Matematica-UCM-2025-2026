!===============================================================================
! PRACTICA 4: MEDIDAS EN UN TRIANGULO
!
! Objetivo:
!   A partir de las longitudes de los tres lados de un triángulo, calcular:
!
!   (1) Los ángulos A, B y C (opuestos a los lados a, b y c respectivamente),
!       expresados en grados, minutos y segundos sexagesimales.
!
!   (2) Las longitudes de las alturas ha, hb y hc, correspondientes a los lados.
!
!   (3) Las longitudes de las medianas ma, mb y mc, desde cada vértice al punto
!       medio del lado opuesto.
!
!   (4) Las longitudes de las bisectrices va, vb y vc, que dividen los ángulos
!       del triángulo y llegan a los lados opuestos.
!
! Entradas:
!   - Archivo 'Datos4.dat': contiene las longitudes de los lados de varios
!     triángulos, junto con el formato de presentación que incluye los nombres
!     y secciones para insertar los resultados.
!
! Salidas:
!   - Archivo 'Solucion4.sol': el mismo formato que el archivo de entrada, pero
!     con los valores calculados de los ángulos, alturas, medianas y bisectrices
!     completando cada sección correspondiente.
!
! Notas:
!   - Los ángulos deben escribirse en grados, minutos y segundos (GMS).
!   - Las medidas deben tener 7 decimales de precisión.
!   - Las alturas se refieren a las perpendiculares trazadas desde cada vértice
!     al lado opuesto (o su prolongación si es necesario).
!
!===============================================================================

PROGRAM Practica4
    IMPLICIT NONE

    INTEGER, PARAMETER :: unit_in = 30, unit_out = 50
    CHARACTER(LEN=200) :: linea
    CHARACTER(LEN=50)  :: sublinea
    INTEGER :: i, ios, pos1, pos2, pos3, pos4
    REAL(8) :: a, b, c
    REAL(8) :: aA, bB, cC
    REAL(8) :: alt1, alt2, alt3
    REAL(8) :: med1, med2, med3
    REAL(8) :: bis1, bis2, bis3
    INTEGER :: A_gr, A_min, A_seg
    INTEGER :: B_gr, B_min, B_seg
    INTEGER :: C_gr, C_min, C_seg
    LOGICAL :: es_triangulo

    OPEN(unit = unit_in, file = 'Datos4.dat', status = 'old', action = 'read')
    OPEN(unit = unit_out, file = 'Solucion4.sol', status = 'replace', action = 'write')
    
    !------------------- Cabecera en salida -------------------
    WRITE(unit_out, '(A)') '|==================================================|'
    WRITE(unit_out, '(A)') '|   SOLUCION PRACTICA 4: MEDIDAS-EN-UN-TRIANGULO   |'
    WRITE(unit_out, '(A)') '|==================================================|'
    WRITE(unit_out, '(A)') ''
    es_triangulo = .TRUE.

    DO
        READ(unit_in, '(A)', IOSTAT = ios) linea
        IF (ios /= 0) EXIT

        IF (INDEX(linea, '=') > 0 .OR. INDEX(linea, 'TRI') > 0) THEN
            WRITE(unit_out, '(A)') linea
            CYCLE
        END IF

        IF (INDEX(linea, '|') == 0) THEN
            WRITE(unit_out, '(A)') linea
            CYCLE
        END IF

        pos1 = INDEX(linea, '|')
        pos2 = INDEX(linea(pos1 + 1:), '|') + pos1
        sublinea = ADJUSTL(TRIM(linea(pos1 + 1: pos2 - 1)))

        SELECT CASE(TRIM(sublinea))
            CASE ('Lados')
                WRITE(unit_out, '(A)') linea

                pos3 = pos2
                DO i = 1, 3
                    pos4 = INDEX(linea(pos3 + 1:), '|') + pos3
                    sublinea = ADJUSTL(TRIM(linea(pos3 + 1: pos4 - 1)))
                    SELECT CASE (i)
                        CASE(1); READ(sublinea, '(F12.7)', IOSTAT=ios) a
                        CASE(2); READ(sublinea, '(F12.7)', IOSTAT=ios) b
                        CASE(3); READ(sublinea, '(F12.7)', IOSTAT=ios) c
                    END SELECT
                    pos3 = pos4
                END DO

                IF (a + b > c .AND. a + c > b .AND. b + c > a) THEN
                    es_triangulo = .TRUE.
                    CALL Calculos(a, b, c, aA, bB, cC, alt1, alt2, alt3, med1, med2, med3, bis1, bis2, bis3)
                    CALL Rad2DMS(aA, A_gr, A_min, A_seg)
                    CALL Rad2DMS(bB, B_gr, B_min, B_seg)
                    CALL Rad2DMS(cC, C_gr, C_min, C_seg)
                ELSE
                    es_triangulo = .FALSE.
                END IF

            CASE ('Angulos')
                IF (es_triangulo) THEN
                    WRITE(unit_out, '(A,3(I3,A,I3,A,I3,A,2X,A))') linea(:pos2), &
                        A_gr, 'º', A_min, "'", A_seg, "''", '|', &
                        B_gr, 'º', B_min, "'", B_seg, "''", '|', &
                        C_gr, 'º', C_min, "'", C_seg, "''", '|'
                ELSE
                    WRITE(unit_out, '(A,A)') linea(:pos2), '   NO EXISTE   |   NO EXISTE   |   NO EXISTE   |'
                END IF

            CASE ('Alturas')
                IF (es_triangulo) THEN
                    WRITE(unit_out, '(A,3(X,F12.7,2X,A))') linea(:pos2), alt1, '|', alt2, '|', alt3, '|'
                ELSE
                    WRITE(unit_out, '(A,A)') linea(:pos2), '   NO EXISTE   |   NO EXISTE   |   NO EXISTE   |'
                END IF

            CASE ('Medianas')
                IF (es_triangulo) THEN
                    WRITE(unit_out, '(A,3(X,F12.7,2X,A))') linea(:pos2), med1, '|', med2, '|', med3, '|'
                ELSE
                    WRITE(unit_out, '(A,A)') linea(:pos2), '   NO EXISTE   |   NO EXISTE   |   NO EXISTE   |'
                END IF

            CASE ('Bisectrices')
                IF (es_triangulo) THEN
                    WRITE(unit_out, '(A,3(X,F12.7,2X,A))') linea(:pos2), bis1, '|', bis2, '|', bis3, '|'
                ELSE
                    WRITE(unit_out, '(A,A)') linea(:pos2), '   NO EXISTE   |   NO EXISTE   |   NO EXISTE   |'
                END IF

            CASE DEFAULT
                WRITE(unit_out, '(A)') linea
        END SELECT
    END DO

    CLOSE(unit_in)
    CLOSE(unit_out)

CONTAINS

    SUBROUTINE Calculos(a, b, c, aA, bB, cC, alt1, alt2, alt3, med1, med2, med3, bis1, bis2, bis3)
        IMPLICIT NONE
        REAL(8), INTENT(IN)  :: a, b, c
        REAL(8), INTENT(OUT) :: aA, bB, cC
        REAL(8), INTENT(OUT) :: alt1, alt2, alt3
        REAL(8), INTENT(OUT) :: med1, med2, med3
        REAL(8), INTENT(OUT) :: bis1, bis2, bis3

        REAL(8) :: s, area
        REAL(8) :: senA, cosA, senB, cosB, senC, cosC

        s = 0.5D0 * (a + b + c)
        area = SQRT(s * (s - a) * (s - b) * (s - c))

        senA = 2D0 * area / (b * c)
        cosA = (b**2 + c**2 - a**2) / (2D0 * b * c)
        aA = ATAN2(senA, cosA)

        senB = 2D0 * area / (a * c)
        cosB = (a**2 + c**2 - b**2) / (2D0 * a * c)
        bB = ATAN2(senB, cosB)

        senC = 2D0 * area / (a * b)
        cosC = (a**2 + b**2 - c**2) / (2D0 * a * b)
        cC = ATAN2(senC, cosC)

        alt1 = 2D0 * area / a
        alt2 = 2D0 * area / b
        alt3 = 2D0 * area / c

        med1 = 0.5D0 * SQRT(2D0 * b**2 + 2D0 * c**2 - a**2)
        med2 = 0.5D0 * SQRT(2D0 * a**2 + 2D0 * c**2 - b**2)
        med3 = 0.5D0 * SQRT(2D0 * a**2 + 2D0 * b**2 - c**2)

        bis1 = 2D0 / (b + c) * SQRT(b * c * s * (s - a))
        bis2 = 2D0 / (a + c) * SQRT(a * c * s * (s - b))
        bis3 = 2D0 / (a + b) * SQRT(a * b * s * (s - c))
    END SUBROUTINE Calculos

    SUBROUTINE Rad2DMS(rad, gr, min, sec)
        IMPLICIT NONE
        REAL(8), INTENT(IN)  :: rad
        INTEGER, INTENT(OUT) :: gr, min, sec
        REAL(8) :: total_deg

        total_deg = rad * 180D0 / ACOS(-1D0)
        gr  = INT(total_deg)
        min = INT((total_deg - gr) * 60D0)
        sec = INT((((total_deg - gr) * 60D0) - min) * 60D0)
    END SUBROUTINE Rad2DMS

END PROGRAM Practica4
