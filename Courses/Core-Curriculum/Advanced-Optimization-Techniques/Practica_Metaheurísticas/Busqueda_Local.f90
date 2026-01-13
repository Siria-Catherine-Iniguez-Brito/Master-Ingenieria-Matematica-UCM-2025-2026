PROGRAM busqueda_local
  IMPLICIT NONE
  
  !Parametros globales
  INTEGER :: N,M ,i,j,k,i_max,k_max,elopt,p
  DOUBLE PRECISION, DIMENSION(:,:), ALLOCATABLE :: Distancias
  
  INTEGER, DIMENSION(:), ALLOCATABLE :: S,Pfinal,Pcur,enS
	DOUBLE PRECISION :: zfinal,z,dk_i,gmax, aleatorio
	DOUBLE PRECISION, DIMENSION(:), ALLOCATABLE ::v,totalA
  

  CALL LeerDatos()
   ALLOCATE(Pfinal(M),Pcur(M),enS(N),v(M),totalA(N),S(M))

  !Generar un número p aleatorio entre 1 y N-M+1
  CALL RANDOM_NUMBER(aleatorio)
  p = INT(aleatorio * (N-M+1)) + 1

  	!Conjunto P; enS: si pertenece a conjunto S
	enS=0
	DO i=1,m
		S(i)=p+i-1
		enS(S(i))=1
	ENDDO	
	Pcur = S


	! z inicial. Paso 0.
	z=-Coste(Pcur)

	100 CONTINUE
	gmax=0.0d0
	elopt=1
	i_max=-1
	k_max=-1
	
	DO i=1,m   ! Calcular vi
	  v(i) = 0.0d0
	  DO j=1,m
		if (j /= i) v(i)=v(i)+Distancias(Pcur(j),Pcur(i))
	  ENDDO
	ENDDO
	
	DO k=1,n
	  totalA(k) = 0.0d0
	  DO j=1,m
		totalA(k) = totalA(k)+Distancias(Pcur(j), k)
	  ENDDO
	ENDDO

	  DO i=1,m
		DO k=1,n
		  IF (enS(k)==0) THEN
			dk_i = totalA(k) - Distancias(Pcur(i), k)
			IF(dk_i > v(i)) THEN
				elopt=0
				IF (dk_i - v(i) > gmax) THEN
				  gmax = dk_i - v(i)
				  i_max = i
				  k_max = k
				ENDIF
			ENDIF
		  ENDIF
		ENDDO
	  ENDDO
	  
	  IF (elopt==0) THEN  ! Trocar y volver paso 1
		enS(Pcur(i_max))=0
		Pcur(i_max) = k_max
		enS(k_max)=1
		z = z + gmax
		GOTO 100 ! volver paso 1
	  ELSE ! la solucion actual es optimo local
		Pfinal = Pcur
		zfinal = z
	  ENDIF
	  PRINT*,zfinal
	DEALLOCATE(Distancias)
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
 
END PROGRAM busqueda_local