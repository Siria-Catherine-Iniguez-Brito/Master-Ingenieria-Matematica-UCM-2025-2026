PROGRAM greedy_con_reinicio
  IMPLICIT NONE
  
  !Parametros globales
  INTEGER :: N,M, i,t,p,k
  DOUBLE PRECISION, DIMENSION(:,:), ALLOCATABLE :: Distancias(:,:), g(:)
  DOUBLE PRECISION z, total
  INTEGER, DIMENSION(:), ALLOCATABLE ::  Ind,Pc, sub
	   
  CALL LeerDatos()
  ALLOCATE(Ind(N),Pc(N),g(N),sub(N))
  
  total=0
  ! Greedy con reinicio
  DO p=1,INT(N/M)
	  Ind=1
	  PC=0
	  
	  t=1
	  z=0.d0
	  Pc(p)=1
	  Ind(p)=0
	  
	  !Calculo de g(i)=d(i,p)
	  DO i=1,n
		g(i)=Distancias(i,p)
	  ENDDO
	  	  
	  DO t=1,m-1
		k= MAXLOC(g,DIM=1)
		Pc(k)=1
		Ind(k)=0
		z=z+g(k)
		DO i=1,n
			IF (Ind(i)==1) THEN
				g(i)=g(i)+Distancias(i,k)
			ELSE
				g(i) = 0.d0
			ENDIF
		ENDDO
	  ENDDO
	  total=total+z
  ENDDO
	  
	DEALLOCATE(Distancias)
	PRINT*, total/INT(N/M)
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

  
END PROGRAM greedy_con_reinicio