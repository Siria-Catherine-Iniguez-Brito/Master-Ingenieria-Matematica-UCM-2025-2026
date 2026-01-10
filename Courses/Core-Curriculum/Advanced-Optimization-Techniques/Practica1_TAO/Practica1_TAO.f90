!===============================================================================
! PRACTICA 1: PROBLEMA DE MÁXIMA DIVERSIDAD (MDP)
!
! Objetivo:
!   Implementar y comparar heurísticas para el Problema de Máxima Diversidad,
!   que consiste en seleccionar un subconjunto de 'm' elementos con la
!   mayor diversidad posible (máxima suma de distancias por pares).
!
! Métodos implementados:
!   1. Algoritmo Greedy sin reemplazamiento.
!   2. Algoritmo Greedy con inicialización.
!   3. Algoritmos de Búsqueda Local (Primera Mejora y Mayor Mejora)
!      aplicados a un conjunto de soluciones iniciales consecutivas.
!
! Entradas:
!   - Archivo 'Datos1.dat': contiene los parámetros de dimensión (n, m) y
!     los coeficientes (a, b) necesarios para construir la matriz de distancias.
!
! Salidas:
!   - Archivo 'Solucion1.sol': resultados detallados de cada heurística, incluyendo
!     el subconjunto solución, la diversidad obtenida (z), la Matriz PH y
!     estadísticas de los algoritmos de Búsqueda Local.
!
!===============================================================================

!============================ MÓDULO DE PARÁMETROS ============================
MODULE Params_MDP
    IMPLICIT NONE
    ! Parámetros de dimensión del problema
    INTEGER :: n, m
    ! Parámetros para la función de distancia
    REAL(8) :: a, b 
    ! Matriz de distancias
    REAL(8), ALLOCATABLE :: D(:,:)  ! Matriz de distancias
END MODULE Params_MDP


!============================== PROGRAMA PRINCIPAL =============================
PROGRAM Practica1_TAO
    USE Params_MDP
    IMPLICIT NONE

    !--------------------- Declaraciones de Solución --------------------------
    INTEGER, ALLOCATABLE :: P(:)
    REAL(8) :: z    
    
    !------------------- Declaraciones de Búsqueda Local ----------------------  
    INTEGER, ALLOCATABLE :: X(:,:)         
    REAL(8), ALLOCATABLE :: vzini(:), vzpri(:), vzmay(:)
    INTEGER, ALLOCATABLE :: vnpri(:), vnmay(:)
    INTEGER, ALLOCATABLE :: Subset_Mask(:)  
    
    !---------------------- Declaraciones de Medias ---------------------------
    REAL(8) :: media_zini, media_zpri, media_zmay
    REAL(8) :: media_npri, media_nmay

    !--------------------- Declaraciones de Control ---------------------------
    INTEGER :: unit_out, i, j, k, colM, colP, IOSTAT , totalK

    !-------------------------- Inicialización --------------------------------
    CALL Leer_Datos_MDP("Datos1_TAO.dat")
    CALL Construir_Matriz_D()
    
    !--------------------- Greedy Sin Reemplazamiento -------------------------
    CALL Greedy_Sin(P,z)


    unit_out = 20
    OPEN(unit = unit_out, file = 'Solucion1_TAO.sol', status='replace', action='write', iostat = IOSTAT)
       IF (IOSTAT /= 0) THEN
        PRINT *, "Error al abrir el archivo "
        RETURN
    END IF

    WRITE(unit_out, '(A)') '|=====================================|'
    WRITE(unit_out, '(A)') '|   SOLUCION PRACTICA 1: DIVERSIDAD   |'
    WRITE(unit_out, '(A)') '|=====================================|'
    WRITE(unit_out, '(A)') ' '
    
    !----------------------- Resultados Greedy Sin ----------------------------
    WRITE(unit_out, '(A)') '|--------------------------------------------------------------------|'
    WRITE(unit_out, '(A)') '| SOLUCION GREEDY-SIN REINICIO:'
    WRITE(unit_out, '(A)') '|'
    WRITE(unit_out, '(A)', ADVANCE='NO') '|  Subconjunto = '
    DO i = 1, SIZE(P)
        WRITE(unit_out, '(I5)', ADVANCE='NO') P(i)
    END DO
    WRITE(unit_out, *) 
    WRITE(unit_out, '(A,F12.6)') '|  Diversidad  = ', z
    WRITE(unit_out, '(A)') '|--------------------------------------------------------------------|'

    DEALLOCATE(P) !Libero la memoria del vector P Greedy sin remplazamiento

    !------------------- Escribir la solucion Greedy con  ---------------------
    WRITE(unit_out, '(A)') ' '
    WRITE(unit_out, '(A)') ' '
    WRITE(unit_out, '(A)') '|-----------------------------------------------------------------------'// &
    & '----------------------------------------|'
    
    ! Encabezado de índices 
    WRITE(unit_out, '(A)', ADVANCE='NO') '| p1 | '
    DO j = 1, n
        WRITE(unit_out, '(I2, A1)', ADVANCE='NO') j, ' '
    END DO
    WRITE(unit_out, '(A)') ' |  DIVERSIDAD |'
    WRITE(unit_out, '(A)') '|----------------------------------------------------------------'// &
    & '-----------------------------------------------|'
    
    ! Escribir la solucion Greedy con
    DO i = 1, n
        CALL Greedy_Con(i, P, z)
        
        ! --- Generar el vector máscara de 0s y 1s ---
        ALLOCATE(Subset_Mask(n))
        Subset_Mask = 0  ! Inicializar a cero
        
        DO k = 1, m      
            Subset_Mask(P(k)) = 1
        END DO
        
        ! Escribir línea: p1 | máscara | diversidad
        WRITE(unit_out, '(A, I2, A)', ADVANCE='NO') '| ', i, ' | '
        DO j = 1, n
            WRITE(unit_out, '(I1, A2)', ADVANCE='NO') Subset_Mask(j), '  '
        END DO
        WRITE(unit_out, '(A, F10.4, A)') ' | ', z, ' |'

        ! Liberar memoria
        DEALLOCATE(P)
        DEALLOCATE(Subset_Mask) 
    END DO
    WRITE(unit_out, '(A)') '|--------------------------------------------------------------'// &
    & '-------------------------------------------------|' 

    !--------------------- Búsqueda Local (Matriz PH) -------------------------
    CALL Matriz_PH(X, vzini, vzpri, vnpri, vzmay, vnmay)
    totalK = SIZE(vzini, 1)
    WRITE(unit_out, '(A)') ' '
    WRITE(unit_out, '(A)') ' '
    WRITE(unit_out, '(A)') '|---------------------------------------------------------------------------------------------|'
    ! Encabezado k->|  1|  2| ... | 21|
    WRITE(unit_out,'(A)', advance='no') '   k->|'
    DO k = 1, totalK
        WRITE(unit_out,'(I3,A)', advance='no') k, '|'
    END DO
    WRITE(unit_out,'(A)') ''  

    ! Encabezado j |P M|P M|...| Fr
    WRITE(unit_out,'(A)', advance='no') '    j |'
    DO k = 1, totalK
        WRITE(unit_out,'(A)', advance='no') 'P M|'
    END DO
    WRITE(unit_out,'(A)') ' Fr'
    WRITE(unit_out,'(A)') REPEAT('-', 7 + 4*totalK + 4)

    ! Cuerpo de la tabla: fila por fila (j = 1..n)
    DO i = 1, n
        WRITE(unit_out,'(I5,A)', advance='no') i, ' |'
        DO k = 1, totalK
            colP = 2*(k - 1) + 1
            colM = colP + 1
            WRITE(unit_out,'(I1,1X,I1,A)', advance='no') X(i, colP), X(i, colM), '|'
        END DO
        ! Frecuencia
        WRITE(unit_out,'(I3)') X(i, 2*totalK + 1)
    END DO
    WRITE(unit_out,'(A)') REPEAT('-', 7 + 4*totalK + 4)

    DEALLOCATE(X)

    !---------------------Resumen de Búsqueda Local ---------------------------
    media_zini = SUM(vzini(:)) / totalK
    media_zpri = SUM(vzpri(:)) / totalK
    media_npri = REAL(SUM(vnpri(:))) / totalK
    media_zmay = SUM(vzmay(:)) / totalK
    media_nmay = REAL(SUM(vnmay(:))) / totalK
    WRITE(unit_out,'(A)') ''
    WRITE(unit_out,*) 'FUNCION OBJETIVO Y NUMERO DE INTERCAMBIOS:'
    WRITE(unit_out,'(A)') ''
    WRITE(unit_out,'(A)') '   k |    zini    |   zpri    | npri|   zmay    | nmay|'
    WRITE(unit_out,'(A)') '  -----------------------------------------------------'

    DO i = 1, totalK
        WRITE(unit_out,'(I4,2X,F10.4,2X,F10.4,2X,I4,2X,F10.4,2X,I4)') &
              i, vzini(i), vzpri(i), vnpri(i), vzmay(i), vnmay(i)
    END DO

    WRITE(unit_out,'(A)') '  -----------------------------------------------------'
    WRITE(unit_out,'(A)', ADVANCE="NO") ' medias'
    WRITE(unit_out,'(3X,F10.4,2X,F10.4,2X,F5.2,2X,F10.4,2X,F5.2)') &
          media_zini, media_zpri, media_npri, media_zmay, media_nmay

    DEALLOCATE(vzini, vzpri, vnpri, vzmay, vnmay)
    CLOSE(unit_out)


    CONTAINS
    SUBROUTINE Leer_Datos_MDP(filename)
        USE Params_MDP
        IMPLICIT NONE
        CHARACTER(len = *), INTENT(IN) :: filename
        CHARACTER(len = 200) :: linea
        INTEGER :: ios, unit_in

        unit_in = 10

        OPEN(unit = unit_in, file = filename, status = 'old', action = 'read', IOSTAT = ios)
        IF (ios /= 0) THEN
            PRINT *, "Error: No se pudo abrir el archivo ", filename
            STOP
        END IF

        DO
            READ(unit_in, '(A)', IOSTAT = ios) linea
            IF (ios /= 0) EXIT

            IF (INDEX(linea, 'n =') > 0) READ(linea(INDEX(linea, '=') + 1:), *) n
            IF (INDEX(linea, 'm =') > 0) READ(linea(INDEX(linea, '=') + 1:), *) m
            IF (INDEX(linea, 'a =') > 0) READ(linea(INDEX(linea, '=') + 1:), *) a
            IF (INDEX(linea, 'b =') > 0) READ(linea(INDEX(linea, '=') + 1:), *) b
        END DO

        CLOSE(unit_in)
    END SUBROUTINE Leer_Datos_MDP

    SUBROUTINE Construir_Matriz_D()
        USE Params_MDP
        IMPLICIT NONE

        INTEGER :: i, j
        REAL(8) :: pi, h

        pi = 4.0d0 * ATAN(1.0d0)

        ! Asegurar que la matriz esté asignada
        IF (.NOT. ALLOCATED(D)) THEN
            ALLOCATE(D(n, n))
        END IF

        ! Inicializamos diagonal en cero 
        DO i = 1, n
            D(i, i) = 0.0d0
        END DO

        ! Calcular solo la mitad superior y copiar a la mitad inferior
        DO i = 1, n
            DO j = i + 1, n
                h = (a + ABS(i - j)) / (b + i + j)
                D(i, j) = 20.0d0 * SIN(2.0d0 * pi * h) + &
                        25.0d0 * COS(2.0d0 * pi / h) + 50.0d0
                D(j, i) = D(i, j)  ! Simetría
            END DO
        END DO

    END SUBROUTINE Construir_Matriz_D

    RECURSIVE SUBROUTINE QuickSort_Desc(v, idx, left, right)
        IMPLICIT NONE
        REAL(8), INTENT(INOUT) :: v(:)
        INTEGER, INTENT(INOUT) :: idx(:)
        INTEGER, INTENT(IN) :: left, right

        INTEGER :: i, j
        REAL(8) :: pivot, temp_v
        INTEGER :: temp_i

        IF (left >= right) RETURN

        pivot = v((left + right) / 2)
        i = left
        j = right

        DO
            DO WHILE (v(i) > pivot)
                i = i + 1
            END DO
            DO WHILE (v(j) < pivot)
                j = j - 1
            END DO

            IF (i <= j) THEN
                ! Intercambiar valores
                temp_v = v(i)
                v(i) = v(j)
                v(j) = temp_v

                ! Intercambiar índices
                temp_i = idx(i)
                idx(i) = idx(j)
                idx(j) = temp_i

                i = i + 1
                j = j - 1
            END IF

            IF (i > j) EXIT
        END DO

        CALL QuickSort_Desc(v, idx, left, j)
        CALL QuickSort_Desc(v, idx, i, right)
    END SUBROUTINE QuickSort_Desc

    SUBROUTINE Greedy_Sin(P,z)
        USE Params_MDP         ! Para acceder a n y m

        IMPLICIT NONE

        INTEGER, ALLOCATABLE, INTENT(OUT) :: P(:)   
        REAL(8), INTENT(OUT) :: z                   

        INTEGER :: i, j, k 
        REAL(8), ALLOCATABLE :: G(:)
        INTEGER, ALLOCATABLE :: idx(:)


        ALLOCATE(G(n), idx(n))
        G = SUM(D, DIM=2) 
        DO i = 1, n
            idx(i) = i
        END DO
        

        CALL QuickSort_Desc(G, idx, 1, n)
        ALLOCATE (P(m))
        P = idx(1:m)
        z = 0 
        DO j = 1, m-1
            DO k = j+1, m 
                z = z + D(P(j),P(k))
            END DO
        END DO 

    END SUBROUTINE 

    SUBROUTINE Greedy_Con(p1,P,z)
        USE Params_MDP         
        IMPLICIT NONE

        INTEGER, INTENT(IN) :: p1
        INTEGER, ALLOCATABLE, INTENT(OUT) :: P(:)   
        REAL(8), INTENT(OUT) :: z                   

        INTEGER :: t, k, i
        INTEGER :: pos_max(1)
        REAL(8), ALLOCATABLE :: G(:)

        ALLOCATE(G(n), P(m))

        ! Inicializar vector G con las distancias desde p1 a todos los demás
        G = D(p1,:)
        z = 0.0d0 
        P(1) = p1

        DO t = 2, m 
            ! Encontrar la posición con el máximo valor en G
            pos_max = MAXLOC(G)     
            k = pos_max(1)
            P(t) = k 

            ! Acumular el valor objetivo con la distancia seleccionada
            z = z + G(k)

            ! Actualizar G sumando las distancias desde el nuevo elemento k,
            ! solo para las posiciones donde G y D(k,:) no sean "cero" (considerando tolerancia)
            DO i = 1, n
                IF (ABS(G(i)) > 1.0D-12 .AND. ABS(D(k,i)) > 1.0D-12) THEN
                    G(i) = G(i) + D(k,i)
                END IF
            END DO

            ! Marcar el elemento k para no volver a seleccionarlo
            G(k) = 0.0d0
        END DO 
    END SUBROUTINE

    SUBROUTINE Optimo_Local(S, P , H, zini, zpri, npri, zmay, nmay)
        USE Params_MDP
        IMPLICIT NONE
        INTEGER, INTENT(IN) :: S(:)           ! S es lista de m elementos (valores 1..n)
        INTEGER, ALLOCATABLE, INTENT(OUT) :: P(:), H(:)   ! máscaras 0/1 de tamaño n
        REAL(8), INTENT(OUT) :: zini, zpri, zmay
        INTEGER, INTENT(OUT) :: npri, nmay

        INTEGER :: nloc, mloc
        INTEGER :: i, j, ii, k, enP
        REAL(8) :: vi, dk, gmax
        INTEGER :: imax, kmax

        INTEGER, ALLOCATABLE :: Plist(:)   ! vector de length m con índices de elementos en la solución temporales
        LOGICAL :: cambio

        mloc = SIZE(S)
        zini = 0.0d0
        DO i = 1, mloc - 1
            DO j = i + 1, mloc
                zini = zini + D(S(i), S(j))
            END DO
        END DO

        ! Inicializo Plist con la solución inicial S
        ALLOCATE(Plist(mloc))
        Plist = S

        ALLOCATE(P(n))
        ALLOCATE(H(n))
        ! ---------------------------
        ! Primera mejora
        ! ---------------------------
        zpri = zini
        npri = 0
        cambio = .TRUE.
        DO WHILE (cambio)
            cambio = .FALSE.
            ! recorremos posiciones ii = 1..m
            DO ii = 1, mloc
                ! calcular Vi = suma de distancias del elemento en la posición ii
                Vi = 0.0d0
                DO j = 1, mloc
                    IF (j /= ii) Vi = Vi + D(Plist(j), Plist(ii))
                END DO

                ! buscar k en 1..n que NO esté en Plist
                DO k = 1, n
                    enP = 0
                    DO j = 1, mloc
                        IF (Plist(j) == k) THEN
                            enP = 1
                            EXIT
                        END IF
                    END DO
                    IF (enP == 1) CYCLE

                    ! calcular dk
                    Dk = 0.0d0
                    DO j = 1, mloc
                        IF (j /= ii) Dk = Dk + D(Plist(j), k)
                    END DO

                    IF (Dk > Vi) THEN
                        ! aceptar intercambio y reiniciar búsqueda (primera mejora)
                        Plist(ii) = k
                        zpri = zpri + Dk - Vi
                        npri = npri + 1
                        cambio = .TRUE.
                        EXIT   ! sale del DO k, reiniciar desde ii=1 por el DO WHILE
                    END IF
                END DO

                IF (cambio) EXIT
            END DO
        END DO

        ! construir máscara P a partir de Plist (resultado de primera mejora)
        P = 0
        DO i = 1, mloc
            IF (Plist(i) >= 1 .AND. Plist(i) <= n) P(Plist(i)) = 1
        END DO

        ! ---------------------------
        ! Mayor mejora: empezar desde la solución inicial S
        ! ---------------------------
        ! Restaurar Plist a la solución inicial S
        Plist = S
        zmay = zini
        nmay = 0

        DO
            gmax = 0.0d0
            imax = 0
            kmax = 0
            cambio = .FALSE.

            ! recorremos posiciones ii = 1..m
            DO ii = 1, mloc
                ! calcular vi
                vi = 0.0d0
                DO j = 1, mloc
                    IF (j /= ii) vi = vi + D(Plist(j), Plist(ii))
                END DO

                ! buscar candidatos fuera de Plist
                DO k = 1, n
                    enP = 0
                    DO j = 1, mloc
                        IF (Plist(j) == k) THEN
                            enP = 1
                            EXIT
                        END IF
                    END DO
                    IF (enP == 1) CYCLE

                    Dk = 0.0d0
                    DO j = 1, mloc
                        IF (j /= ii) Dk = Dk + D(Plist(j), k)
                    END DO

                    IF (Dk > Vi) THEN
                        cambio = .TRUE.
                        IF ((Dk - Vi) > gmax) THEN
                            gmax = dk - vi
                            imax = ii
                            kmax = k
                        END IF
                    END IF
                END DO
            END DO

            IF (.NOT. cambio) EXIT
            ! aplicar mejor intercambio encontrado
            Plist(imax) = kmax
            zmay = zmay + gmax
            nmay = nmay + 1
        END DO

        ! construir máscara H a partir de Plist (resultado de mayor mejora)
        H = 0
        DO i = 1, mloc
            IF (Plist(i) >= 1 .AND. Plist(i) <= n) H(Plist(i)) = 1
        END DO

        DEALLOCATE(Plist)

    END SUBROUTINE Optimo_Local
    
    SUBROUTINE Matriz_PH(X, vzini, vzpri, vnpri, vzmay, vnmay)
        USE Params_MDP 
        IMPLICIT NONE 

        INTEGER, ALLOCATABLE, INTENT(OUT) :: X(:,:)
        REAL(8), ALLOCATABLE, INTENT(OUT) :: vzini(:), vzpri(:), vzmay(:)
        INTEGER, ALLOCATABLE, INTENT(OUT) :: vnpri(:), vnmay(:)

        REAL(8) :: zini, zpri, zmay
        INTEGER :: npri, nmay

        INTEGER :: i, j, columna
        INTEGER, ALLOCATABLE :: S(:),P(:),H(:)

        ALLOCATE(X(n,2*(n - m + 1)+1), S(m))
        ALLOCATE(vzini(n - m + 1), vzpri(n - m + 1), vnpri(n - m + 1), vzmay(n - m + 1), vnmay(n - m + 1))
        columna = 1 
        DO i = 1, n - m + 1
            S = [(j, j = i, i + m - 1)]
            CALL Optimo_Local(S, P , H, zini, zpri, npri, zmay, nmay)
            X(:, columna) = P 
            X(:, columna + 1) = H
            columna = columna + 2
            DEALLOCATE(P, H)
            vzini(i) = zini
            vzpri(i) = zpri
            vnpri(i) = npri
            vzmay(i) = zmay
            vnmay(i) = nmay  
        END DO 
        DEALLOCATE(S)
        DO i = 1, n 
            X(i, 2*(n - m + 1) + 1) = SUM(X(i,1: 2*(n - m + 1)))
        END DO  

    END SUBROUTINE

END PROGRAM Practica1_TAO