!===============================================================================
! PRACTICA 5: MINIMO DE UNA FUNCION DE n VARIABLES EN UN HIPER-RECTANGULO
!
! Objetivo:
!   Encontrar el mínimo de una función de n variables definida en un hiper-rectángulo,
!   utilizando una rejilla de puntos. La función a minimizar es:
!
!       f(x1, ..., xn) = SUMA(a(j)*x(j)**2, j=1:n) + SUMA(b(j)*x(j), j=1:n) +
!                         x(n)**2 * SUMA(c(j)*x(j)**2, j=1:n-1) + x(n)**2 * 
!                         SUMA(d(j)*x(j), j=1:n-1) + x(1)**2 * SUMA(e(j)*x(j), 
!                         j=2:n) + x(1)**2 * SUMA(x(j)**2, j=2:n-1)
!
!   La función se evalúa en una rejilla de puntos generada a partir de las cotas 
!   v(j) <= x(j) <= u(j) para cada variable j. El número de puntos en cada 
!   dimensión está determinado por el parámetro p(j) = 60/j. La mejor estimación 
!   del mínimo será el punto de la rejilla donde la función toma el menor valor.
!
! Entradas:
!   - Para cada valor de n (2, 3, 4, 5, 6), se proporcionan los parámetros de la 
!     función: v(j), u(j), a(j), b(j), c(j), d(j), e(j) en el archivo Datos5.dat
!   - Los m de las cotas v(j) y u(j) definen el hiper-rectángulo en el que
!     se buscará el mínimo.
!
! Salidas:
!   - El programa genera un archivo de salida Solucion5.sol con el formato 
!     siguiente para cada valor de n :
!       • El mejor punto de la rejilla xmejor, donde la función toma su mínimo.
!       • El valor mínimo de la función en xmejor.
!
! Resultado:
!   El archivo de salida contiene la siguiente información:
!   Procesando caso #:   1
!   Numero de variables n = 
!   Numero total de puntos P(n) = 1800
!   Resultado:
!   Mejor punto de la rejilla (xmejor) =
!   x( 1) =   
!   ...   
!   x(n) =    2
!   f(xmejor) =   
!   ================================================
!
! Método:
!   1. Fijado el numero de variables n, para cada variable j se consideran p(j)=60/j   
!      puntos equiespaciados entre sus cotas, esto es, sea h(j)=(u(j)-v(j))/(p(j)-1)   
!      y los puntos x(j,k) = v(j)+(k-1)h(j), k=1..p(j)..
!   2. Evaluar la función en cada punto de la rejilla.
!   3. Identificar el punto en la rejilla que minimiza la función.
!   4. Escribir los resultados (xmejor y f(xmejor)) en un archivo de salida.
!
!===============================================================================


!============================== PROGRAMA PRINCIPAL =============================
PROGRAM Practica5

    IMPLICIT NONE

    !--------------------- Parámetros y Declaraciones ---------------------
    REAL(8), ALLOCATABLE:: v(:), u(:), a(:), b(:), c(:), d(:), e(:)   !Guardar los datos del problema en vectores 
    INTEGER, ALLOCATABLE:: p(:)                                       ! Connstruir el vector p con p(j)=60/j 
   
    REAL(8), ALLOCATABLE :: punto_min(:)                              !Punto donde la funcion alcanza el minimo
    REAL(8) :: fmin                                                   ! Valor de la funcion en ese punto
    
    ! --- Variables Auxiliares ---
    INTEGER :: ios, unit_in, unit_out
    REAL(8), ALLOCATABLE :: m(:,:)
    CHARACTER(len = 300) :: linea
    CHARACTER(len = 200) :: sublinea
    INTEGER :: N, i

    !--------------------- Unidades de entrada/salida ---------------------
    unit_in = 10
    unit_out = 30 

    !--------------------- Apertura de archivos ---------------------
    OPEN(unit = unit_in, file = 'Datos5.dat', status = 'old', action = 'read', IOSTAT = ios)
    IF (ios /= 0) THEN
        PRINT *, 'ERROR: no puedo abrir el archivo'
        STOP
    END IF 
    
    OPEN(unit = unit_out, file = 'Solucion5.sol', status = 'replace', action = 'write')
    !------------------- Cabecera en salida -------------------
    WRITE(unit_out, '(A)') '|======================================================================================|'
    WRITE(unit_out, '(A)') '|   SOLUCION PRACTICA 5: MINIMO-DE-UNA-FUNCION-DE-n-VARIABLES-EN-UN-HIPER-RECTANGULO   |'
    WRITE(unit_out, '(A)') '|======================================================================================|'
    WRITE(unit_out, '(A)') ''

    !--------------------- Lectura de los datos ---------------------
    DO 
        READ(unit_in, '(A)', IOSTAT = ios) linea
        IF (ios /= 0) EXIT  ! Fin del archivo
        
        ! Ignorar las lineas que contenga 'Pa', 'jor'
        IF (INDEX(linea, 'Pa') > 0 .OR. INDEX(linea, 'jor') > 0) CYCLE

        IF (INDEX(linea, "Numero") > 0) THEN
            ! Extraemos la subcadena que contiene el número de variables
            READ(linea(INDEX(linea, "=") + 2: ), *, IOSTAT = ios) N
            IF (ios /= 0) THEN
                PRINT *, "Error al leer el número."
                EXIT
            END IF
        END IF
        
        ! Lectura de los parametros: v, u, a, b, c, d, e
        IF (INDEX(linea, 'v =') > 0) THEN
            ALLOCATE(v(N))
            sublinea = linea(INDEX(linea, '=') + 2:)
            sublinea = TRIM(ADJUSTL(sublinea))
            READ(sublinea, *) v
        END IF
        IF (INDEX(linea, 'u =') > 0) THEN
            ALLOCATE(u(N))
            sublinea = linea(INDEX(linea, '=') + 2:)
            sublinea = TRIM(ADJUSTL(sublinea))
            READ(sublinea, *) u
        END IF
        IF (INDEX(linea, 'a =') > 0) THEN
            ALLOCATE(a(N))
            sublinea = linea(INDEX(linea, '=') + 2:)
            sublinea = TRIM(ADJUSTL(sublinea))
            READ(sublinea, *) a
        END IF
        IF (INDEX(linea, 'b =') > 0) THEN
            ALLOCATE(b(N))
            sublinea = linea(INDEX(linea, '=') + 2:)
            sublinea = TRIM(ADJUSTL(sublinea))
            READ(sublinea, *) b
        END IF
        IF (INDEX(linea, 'c =') > 0) THEN
            ALLOCATE(c(N))
            sublinea = linea(INDEX(linea, '=') + 2:)
            sublinea = TRIM(ADJUSTL(sublinea))
            READ(sublinea, *) c
        END IF
        IF (INDEX(linea, 'd =') > 0) THEN
            ALLOCATE(d(N))
            sublinea = linea(INDEX(linea, '=') + 2:)
            sublinea = TRIM(ADJUSTL(sublinea))
            READ(sublinea, *) d
        END IF
        IF (INDEX(linea, 'e =') > 0) THEN
            ALLOCATE(e(N))
            sublinea = linea(INDEX(linea, '=') + 2:)
            sublinea = TRIM(ADJUSTL(sublinea))
            READ(sublinea, *) e
        END IF
        
        IF (INDEX(linea, '--') > 0) THEN                                      ! He terminado de leer los parametros de un caso 
            ! Construimos el vector p
            ALLOCATE(p(N))
            DO i = 1, N 
               p(i) = 60 / i  
            END DO 

            m = Construir_rejilla(p, v, u)                                   ! Construccion de la rejilla de puntos 
            CALL Encontrar_min(m, p, N, a, b, c, d, e, punto_min, fmin)      ! Encontramos el minimo de la funcion en la rejilla 
        
            ! Imprimimos la salida
            WRITE(unit_out, '(A)') '|-------------------------------------------------------------|'
            WRITE(unit_out,'(A, I0)' ) '| Numero de variables:  ', N
            WRITE(unit_out, '(A)') '|'
            WRITE(unit_out, '(A)', advance = 'no') '| xmejor = '
            DO i = 1, N
                WRITE(unit_out, '(F0.5, " ")', advance = 'no') punto_min(i)  ! Separar con espacios
            END DO
            WRITE(unit_out, '(A)') ''  ! Salto de línea despues de imprimir el vector
            WRITE(unit_out, '(A,F0.5)') '| f(xmejor) = ',  fmin
            WRITE(unit_out, '(A)') '|-------------------------------------------------------------|'
            WRITE(unit_out, '(A)') ''

            ! Liberar la memoria de los vectores y saltamos al siguiente caso
            DEALLOCATE(v, u, a, b, c, d, e, punto_min, p, m)
        END IF 
    END DO 

    CLOSE(unit_in)
    CLOSE(unit_out)

    CONTAINS
    !=======================================================================
    ! FUNCTION: Construir_rejilla
    !
    ! Descripción:
    ! Genera una matriz donde cada fila contiene los puntos equiespaciados
    ! correspondientes a una variable entre sus cotas v(j) y u(j).
    !
    ! Parámetros de entrada:
    !   - v(:): Vector de tamaño N con las cotas inferiores para cada variable.
    !   - u(:): Vector de tamaño N con las cotas superiores para cada variable.
    !   - p(:): Vector de tamaño N con el número de puntos a generar por variable.
    !
    ! Valor de retorno:
    !   - m(:,:): Matriz de tamaño (N, max(p)) donde cada fila j contiene los
    !             p(j) puntos equiespaciados entre v(j) y u(j).
    !             Los elementos no usados (en columnas > p(j)) quedan en cero.
    !
    ! Método:
    !   Para cada variable j, se calcula el paso h = (u(j)-v(j)) / (p(j)-1), y
    !   se generan los puntos:
    !     x_j(k) = v(j) + (k-1) * h   ,  k = 1..p(j)
    !
    ! Ejemplo:
    !   Si v = [0, 1], u = [1, 2], p = [3, 2], entonces:
    !
    !     m = [ 0.0   0.5  1.0
    !           1.0   2.0   0.0 ]
    !
    !=======================================================================
    FUNCTION Construir_rejilla(p, v, u) RESULT(m)
        REAL(8), INTENT(IN) :: v(:), u(:)  ! Cotas inferior y superior por variable
        INTEGER, INTENT(IN) :: p(:)        ! Número de puntos por variable
        REAL(8), ALLOCATABLE :: m(:,:)     ! Matriz resultado: valores por variable

        INTEGER :: j, k, tam 
        REAL(8) :: h                       ! Paso entre puntos
            
        tam = size(p)
        ALLOCATE(m(tam, MAXVAL(p)))
        m = 0 

        ! Para cada variable j, se generan p(j) puntos equiespaciados entre v(j) y u(j)
        DO j = 1, tam
            h = (u(j)-v(j))/(p(j)-1)       ! Paso entre puntos
            DO k = 1, p(j)
                m(j,k) = v(j)+(k-1)*h      ! x(j,k) = v(j)+(k-1)h(j)
            END DO 
        END DO 
    END FUNCTION 
    
    !========================================================================================
    ! SUBRUTINA: Encontrar_min
    !
    ! Descripción:
    !   Busca el mínimo valor de una función f(x₁,...,xₙ) evaluada en todos los puntos de 
    !   una rejilla regular dentro de un hiper-rectángulo. 
    !
    ! Parámetros de entrada:
    !   - m(:,:)     : Matriz (N, MAXVAL(p)) que contiene los valores posibles por variable.
    !                  La fila i contiene los p(i) puntos para la variable x(i).
    !   - p(:)       : Vector con el número de puntos por variable (tamaño N).
    !   - N          : Número de variables del problema.
    !   - a(:), b(:), c(:), d(:), e(:) : Coeficientes del modelo a minimizar.
    !
    ! Parámetros de salida:
    !   - punto_min(:): Coordenadas del punto en la rejilla donde f(x) alcanza su mínimo.
    !   - fmin        : Valor mínimo de la función en punto_min.
    !
    ! Método:
    !   - Se recorre el espacio de búsqueda mediante un vector de índices idx(:) que 
    !     representa la posición actual en cada dimensión de la rejilla.
    !   - En cada iteración:
    !       1. Se construye el punto x a partir de m y idx.
    !       2. Se evalúa f(x)con Evaluar_funcion usando los coeficientes dados.
    !       3. Se actualiza el mínimo si corresponde.
    !       4. Se avanza al siguiente índice multidimensional usando SiguienteIndice.
    !
    ! Dependencias:
    !   - Requiere la función externa Evaluar_funcion(x, a, b, c, d, e, N)
    !   - Requiere la subrutina SiguienteIndice(idx, p, fin) para generar combinaciones.
    !
    !========================================================================================

    SUBROUTINE Encontrar_min(m, p, N, a, b, c, d, e, punto_min, fmin)
        REAL(8), INTENT(IN) :: a(:), b(:), c(:), d(:), e(:)    ! Coeficientes del modelo
        INTEGER, INTENT(IN) :: N                               ! Número de variables
        REAL(8), INTENT(IN) :: m(:,:)                          ! Valores posibles por variable
        INTEGER, INTENT(IN) :: p(:)                            ! Número de puntos por variable
        REAL(8), INTENT(out) :: fmin                           ! Valor mínimo de f
        REAL(8), ALLOCATABLE, INTENT(OUT) :: punto_min(:)      ! Punto donde se alcanza fmin
        
        REAL(8):: f_val
        INTEGER :: i, j 
        INTEGER, ALLOCATABLE :: idx(:)
        LOGICAL :: fin
        REAL(8), ALLOCATABLE :: punto(:)
        INTEGER :: max_operations
        ALLOCATE(idx(N), punto(N), punto_min(N))
        
        fin = .FALSE.
        fmin = huge(0.0d0)                                     ! Inicializar con un valor muy grande
        idx = 1
        
        ! Bucle principal: recorre todos los puntos de la rejilla
        DO WHILE (.NOT. fin)
        ! Construir el punto actual
            DO i = 1, N
                punto(i) = m(i, idx(i))                         ! m(j, k): j=variable, k=posición
            END DO
            
            ! Evaluar la función en el punto actual
            f_val = Evaluar_funcion(punto, a, b, c, d, e, N)
            
            ! Verificar si es el nuevo mínimo
            IF (f_val < fmin) THEN
                fmin = f_val
                punto_min = punto
            END IF
    
            ! Avanzar al siguiente índice
            CALL SiguienteIndice(idx, p, fin)
        END DO
    END SUBROUTINE

    !---------------------------------------------------------------------------
    ! FUNCTION Evaluar_funcion
    !
    ! Descripción:
    ! Evalúa la función objetivo en un punto dado x(1)...x(N).
    !
    ! Entradas:
    !   - punto(:): Vector con las coordenadas actuales x(j), j=1..N
    !   - a(:), b(:), c(:), d(:), e(:): Coeficientes del problema, vectores de tamaño N
    !   - N: Número de variables
    !
    ! Salida:
    !   - f: Valor de la función evaluada en punto.
    !---------------------------------------------------------------------------
    FUNCTION Evaluar_funcion(punto, a, b, c, d, e, N) RESULT(f)
        
        IMPLICIT NONE
        
        INTEGER, INTENT(IN) :: N
        REAL(8), INTENT(IN) :: punto(N), a(N), b(N), c(N), d(N), e(N)
        REAL(8) :: f
        REAL(8) :: sum1, sum2, sum3, sum4, sum5, sum6
        REAL(8) :: xn2, x1_2
        REAL(8), ALLOCATABLE :: x2(:)
        INTEGER :: i

        !---------------------------
        ! Preparar el vector x2 = punto.^2
        !---------------------------
        ALLOCATE(x2(N))
        DO i = 1, N
            x2(i) = punto(i)**2
        END DO

        !---------------------------
        ! Calcular las sumas parciales:
        ! sum1 = Σ a(j)*x(j)^2  para j=1..N
        ! sum2 = Σ b(j)*x(j)    para j=1..N
        ! sum3 = Σ c(j)*x(j)^2  para j=1..N-1
        ! sum4 = Σ d(j)*x(j)    para j=1..N-1
        ! sum5 = Σ e(j)*x(j)    para j=2..N
        ! sum6 = Σ x(j)^2       para j=2..N-1 (solo si N > 2)
        !---------------------------
        sum1 = DOT_PRODUCT(a, x2)
        sum2 = DOT_PRODUCT(b, punto)
        sum3 = DOT_PRODUCT(c(1:N-1), x2(1:N-1))
        sum4 = DOT_PRODUCT(d(1:N-1), punto(1:N-1))
        sum5 = DOT_PRODUCT(e(2:N), punto(2:N))
        
        IF (N > 2) THEN
            sum6 = SUM(x2(2:N-1))
        ELSE
            sum6 = 0.0D0
        END IF

        !---------------------------
        ! Guardar los valores al cuadrado de x(N) y x(1)
        !---------------------------
        xn2  = x2(N)
        x1_2 = x2(1)

        !---------------------------
        ! Evaluar la función con la fórmula dada
        !---------------------------
        f = sum1 + sum2 + xn2 * (sum3 + sum4) + x1_2 * (sum5 + sum6)

        DEALLOCATE(x2)
    END FUNCTION Evaluar_funcion

    !=======================================================================
    ! SUBRUTINA: SiguienteIndice
    ! Genera la siguiente combinación de índices multidimensionales.
    !=======================================================================
    SUBROUTINE SiguienteIndice(idx, p, fin)
        INTEGER, INTENT(INOUT) :: idx(:)
        INTEGER, INTENT(IN)    :: p(:)
        LOGICAL, INTENT(OUT)   :: fin
        INTEGER :: i

        fin = .FALSE.
        DO i = SIZE(idx), 1, -1
            idx(i) = idx(i) + 1
            IF (idx(i) <= p(i)) THEN
                RETURN  ! Siguiente combinación válida
            ELSE
                idx(i) = 1
            END IF
        END DO
        fin = .TRUE.  ! Hemos terminado todas las combinaciones
    END SUBROUTINE SiguienteIndice

END PROGRAM Practica5