PROGRAM Temple_Simulado
  IMPLICIT NONE
  
  !Parametros globales
  INTEGER :: N,M
  DOUBLE PRECISION, DIMENSION(:,:), ALLOCATABLE :: Distancias
  
  
  !Parametros del algoritmo
  DOUBLE PRECISION, PARAMETER :: T_inicial = 4.0, T_final = 0.00001, Alpha = 0.99
  INTEGER, PARAMETER :: iter=200, sin_mejora=100
  
  !Variables
  DOUBLE PRECISION :: T, C_actual, C_vecina, delta, u, total
  INTEGER :: niter, p, mejora, k_salida_val, val_entra
  
  INTEGER, DIMENSION(:), ALLOCATABLE :: x_actual, x_vecina, x_opt
  
  CALL LeerDatos()
  
	total=0
	DO p=1,5
	  ALLOCATE(x_actual(M),x_vecina(M), x_opt(M))
	  
	  CALL ConstruirInicial(N,M,x_actual)
	  x_opt = x_actual
	  C_actual = Coste(x_actual)
	  
	  T=T_inicial
	  mejora=0
	  
	  PRINT*,'Inicio del Temple Simulado'
	  WRITE(*,'(A3,I4,A5,I4)') ' N=',N,',M=',M
	  PRINT 901, T_inicial,Alpha,iter
	901 FORMAT (' T inicial: ', F6.2,', Alpha: ',F5.3,', Iteraciones/T: ', I2)
	  PRINT 902, -C_actual
	902 FORMAT (' Diversidad Inicial: ', F13.4)

	  !Mientras no se haya alcanzado criterio de parada
	  DO WHILE (T>T_final .AND. mejora<sin_mejora ) 
		!Repetir N(T) veces
		DO niter=1, iter
		  !Generar sol vecina
		  CALL GenerarVecino(x_actual,x_vecina,k_salida_val,val_entra)

		  !Evaluar y calcular delta
		  delta = CosteVecino(x_actual,k_salida_val,val_entra)
		  C_vecina = C_actual + delta
		  
		  !delta<0, vecina es mejor que x_actual
		  IF (delta<0.0) THEN
			x_actual=x_vecina
			C_actual=C_vecina
			
			!Si C(x)<C(x*)
			IF (C_actual<Coste(x_opt)) THEN
			  x_opt=x_actual
			  mejora=0
			ENDIF

		  ELSE 
			!Generar numero aleatorio u en (0,1)
			CALL RANDOM_NUMBER(u)
			
			!Si u<exp(-delta/T))
			IF (u<EXP(-delta/T)) THEN
			  x_actual=x_vecina
			  C_actual=C_vecina
			ENDIF
		  ENDIF
		ENDDO
		mejora=mejora+1
		
		!Disminuir temperatura
		T=T*Alpha
	  ENDDO
	  
	  !Resultados finales
	  PRINT *
	  PRINT *, "=========================================="
	  PRINT *, "Temple Simulado Finalizado."
	  PRINT *, "Mejor Diversidad Encontrada: ", -Coste(x_opt)
	  PRINT *, "=========================================="
	  PRINT*
	  total=total-Coste(x_opt)
	  
	  DEALLOCATE(x_actual,x_vecina,x_opt)
	ENDDO
	DEALLOCATE(Distancias)
	PRINT*, total/5
CONTAINS

  !Lectura de los datos: N, M, y matriz de Distancias
  SUBROUTINE LeerDatos()
    INTEGER :: i, j, nfile, lineas, k, Elemento1, Elemento2
	DOUBLE PRECISION :: Distancia
	DOUBLE PRECISION, ALLOCATABLE :: D(:,:)
	
	nfile=11
	OPEN(nfile,FILE='GKD-c_19_n500_m50.txt')
	READ(nfile, '(I4,I4)') N, M 
	WRITE(*,'(A23,I4,A5,I4)') "Dimensiones Leidas: N =", N, ", M =", M
	PRINT*
	
	lineas=N*(N-1)/2
	ALLOCATE(D(N,N))
	D=0
	
	!Leer i,j,Distancia
	DO i=1,lineas
	  READ(nfile,*) Elemento1, Elemento2, Distancia
	  D(Elemento1+1,Elemento2+1)=Distancia
	  D(Elemento2+1,Elemento1+1)=Distancia  
	ENDDO
	CLOSE(nfile)
	Distancias=D
    DEALLOCATE(D)
  ENDSUBROUTINE LeerDatos
  
  
  !Funcion para calcular el coste=-Diversidad
  FUNCTION Coste(solucion) RESULT(C)
    DOUBLE PRECISION :: C, Diversidad
	INTEGER, DIMENSION(M) :: solucion
	INTEGER :: i,j
	
	Diversidad=0.0
	DO i=1,M
      DO j=i+1,M 
        Diversidad=Diversidad+Distancias(solucion(i),solucion(j))
      ENDDO
    ENDDO
    C=-Diversidad
  ENDFUNCTION Coste


  !Solucion Inicial
  SUBROUTINE ConstruirInicial(N,M,x_salida)	
    INTEGER :: N,M, i, j, indice
	REAL :: aleatorio
    LOGICAL, DIMENSION(N) :: Seleccionado
	INTEGER, DIMENSION(M) :: x_salida
    
	Seleccionado = .FALSE.
    CALL RANDOM_SEED()
    
    i = 1
    DO WHILE (i <= M)
      ! Elegir un índice aleatorio entre 1 y N
      CALL RANDOM_NUMBER(aleatorio)
      indice = INT(aleatorio * N) + 1
      
      ! Si el elemento no ha sido seleccionado, añadirlo
      IF (.NOT. Seleccionado(indice)) THEN
        x_salida(i) = indice
        Seleccionado(indice) = .TRUE.
        i = i + 1
      END IF
    END DO
  ENDSUBROUTINE ConstruirInicial
	
	
  !Generar Vecino aleatorio por intercambio simple
 SUBROUTINE GenerarVecino(x_entrada, x_salida, k_salida_val, val_entra)
  INTEGER, DIMENSION(M) :: x_entrada, x_salida
  INTEGER :: k_entrada_pos
  INTEGER, INTENT(OUT) :: k_salida_val, val_entra
  LOGICAL, DIMENSION(N) :: EnSolucion
  REAL :: u
 
   x_salida=x_entrada
 
   EnSolucion=.FALSE.
   DO k_entrada_pos = 1, M
     EnSolucion(x_entrada(k_entrada_pos)) = .TRUE.
   ENDDO
  
 
    CALL RANDOM_NUMBER(u)
    k_entrada_pos=INT(u*M)+1
    k_salida_val=x_entrada(k_entrada_pos) !Valor del elemento a remover
  
    ! Elegir un elemento fuera de la solución para INCLUIR (val_in)
    DO
      CALL RANDOM_NUMBER(u)
      val_entra=INT(u*N)+1
      ! Si el índice aleatorio NO está en la solución actual, lo elegimos
      IF (.NOT. EnSolucion(val_entra)) THEN
        EXIT
      ENDIF
    ENDDO
    x_salida(k_entrada_pos) = val_entra   ! Actualizar el vecino
 ENDSUBROUTINE GenerarVecino
 
 
 !Funcion para calcular el cambio que ha existido en el coste ( Coste Vecino-Coste Actual) de forma eficiente
 FUNCTION CosteVecino(x_actual, k_salida_val, val_entra) RESULT(delta)
  DOUBLE PRECISION :: delta, Diversidad_Sale, Diversidad_Entra
  INTEGER, DIMENSION(M) :: x_actual
  INTEGER, INTENT(IN) :: k_salida_val, val_entra
  INTEGER :: i, k_vecino
  
  !Calcular primero la Diversidad que se pierde (restada al coste)
  !Para ello, sumar las distancias del elemento que sale con el resto de la solucion.
  
  !Calcular tambienla diversidad que se gana (sumada al coste)
  !Para ello, sumar las distancias del elemento que entra con el resto de la solucion.
  
  Diversidad_Sale = 0.0
  Diversidad_Entra = 0.0
  DO i=1,M
    k_vecino = x_actual(i)
	! Excluir el que sale 
	IF (k_vecino /= k_salida_val) THEN
      Diversidad_Sale = Diversidad_Sale + Distancias(k_salida_val, k_vecino)
	  Diversidad_Entra = Diversidad_Entra + Distancias(val_entra, k_vecino)
	ENDIF
  ENDDO
  
  ! Delta_Coste = Diversidad_Perdida - Diversidad_Ganada
  delta = Diversidad_Sale - Diversidad_Entra
  
 ENDFUNCTION CosteVecino
  
  
END PROGRAM Temple_Simulado