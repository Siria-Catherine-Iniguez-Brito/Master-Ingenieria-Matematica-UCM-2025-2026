MODULE Params_MDP
  IMPLICIT NONE
  INTEGER :: n, m
  REAL(8), ALLOCATABLE :: D(:,:)  ! Matriz de distancias
END MODULE Params_MDP

PROGRAM Algoritmo_AG
    USE Params_MDP
    IMPLICIT NONE
    REAL(8), DIMENSION(5) :: ParametrosPM
    REAL(8), DIMENSION(4) :: ParametrosPC
	INTEGER, DIMENSION(4) :: ParametrosTam, ParametrosG
	REAL(8) :: Mejor_Absoluto, Media_Absoluta
	
    CHARACTER(LEN=50), PARAMETER :: Archivo1 = "GKD-c_1_n500_m50.txt"
    CHARACTER(LEN=50), PARAMETER :: Archivo2 = "GKD-c_2_n500_m50.txt"
    CHARACTER(LEN=50), PARAMETER :: Archivo3 = "SOM-b_1_n100_m10.txt"
    CHARACTER(LEN=50), PARAMETER :: Archivo4 = "SOM-b_2_n100_m20.txt"
    CHARACTER(LEN=50), PARAMETER :: Archivo5 = "MDG-a_1_n500_m50.txt"
    CHARACTER(LEN=50), PARAMETER :: Archivo6 = "MDG-a_2_n500_m50.txt"
    CHARACTER(LEN=50), PARAMETER :: Archivo7 = "MDG-b_1_n500_m50.txt" 
    CHARACTER(LEN=50), PARAMETER :: Archivo8 = "MDG-b_2_n500_m50.txt"
    CHARACTER(LEN=50), PARAMETER :: Archivo9 = "MDG-c_1_n3000_m300.txt" 
    CHARACTER(LEN=50), PARAMETER :: Archivo10 = "MDG-c_2_n3000_m300.txt"
	
	CHARACTER(LEN=50), PARAMETER :: ArchivoR1 = "GKD-c_19_n500_m50.txt"
    CHARACTER(LEN=50), PARAMETER :: ArchivoR2 = "GKD-c_20_n500_m50.txt"
	CHARACTER(LEN=50), PARAMETER :: ArchivoR3 = "SOM-b_4_n100_m40.txt"
    CHARACTER(LEN=50), PARAMETER :: ArchivoR4 = "SOM-b_8_n200_m80.txt"
	CHARACTER(LEN=50), PARAMETER :: ArchivoR5 = "SOM-b_12_n300_m120.txt"
    CHARACTER(LEN=50), PARAMETER :: ArchivoR6 = "SOM-b_16_n400_m160.txt"
	CHARACTER(LEN=50), PARAMETER :: ArchivoR7 = "SOM-b_20_n500_m200.txt"
    CHARACTER(LEN=50), PARAMETER :: ArchivoR8 = "MDG-a_19_n500_m50.txt"
	CHARACTER(LEN=50), PARAMETER :: ArchivoR9 = "MDG-a_20_n500_m50.txt"
	CHARACTER(LEN=50), PARAMETER :: ArchivoR10 = "MDG-a_39_n2000_m200.txt"
    CHARACTER(LEN=50), PARAMETER :: ArchivoR11 = "MDG-a_40_n2000_m200.txt"
	CHARACTER(LEN=50), PARAMETER :: ArchivoR12 = "MDG-b_19_n500_m50.txt"
    CHARACTER(LEN=50), PARAMETER :: ArchivoR13 = "MDG-b_20_n500_m50.txt"
	CHARACTER(LEN=50), PARAMETER :: ArchivoR14 = "MDG-b_39_n2000_m200.txt"
    CHARACTER(LEN=50), PARAMETER :: ArchivoR15 = "MDG-b_40_n2000_m200.txt"
	CHARACTER(LEN=50), PARAMETER :: ArchivoR16 = "MDG-c_5_n3000_m300.txt"
    CHARACTER(LEN=50), PARAMETER :: ArchivoR17 = "MDG-c_10_n3000_m400.txt"
	CHARACTER(LEN=50), PARAMETER :: ArchivoR18 = "MDG-c_15_n3000_m500.txt"
	CHARACTER(LEN=50), PARAMETER :: ArchivoR19 = "MDG-c_20_n3000_m600.txt"

 
	
	INTEGER :: N1 = 100, N2 = 1000, N3 = 1, N4 = 5
    REAL(8) :: PC_FIJA = 1.0_8
	REAL(8) :: PM_FIJAC = 0.2_8
	
	REAL(8) :: TIEMPO1 = 30.0_8
	REAL(8) :: TIEMPO2 = 60.0_8

	
	REAL(8) :: mejor_fitness, fitness_promedio, tiempo_promedio
    INTEGER, ALLOCATABLE :: mejor_solucion(:)
    
    ! Parámetros óptimos (obtenidos de calibración)
    INTEGER :: T_FINAL, G_FINAL
    REAL(8) :: PC_FINAL, PM_FINAL
    INTEGER, ALLOCATABLE :: Mejor_I(:)
    REAL(8) :: Mejor_A
    
    ! Parámetros del algoritmo
    T_FINAL = 150      ! Tamaño de población
    G_FINAL = 1500       ! Número de generaciones
    PC_FINAL = 0.75_8   ! Probabilidad de cruce
    PM_FINAL = 0.1_8  ! Probabilidad de mutación
	
	
	
	
    ! Inicialización del array en doble precisión
	ParametrosPM = [0.001_8, 0.01_8, 0.05_8, 0.1_8, 0.2_8]  
	ParametrosPC = [0.60_8, 0.75_8, 0.90_8, 1.00_8]
	ParametrosTaM = [50, 100, 150, 200] 
	ParametrosG= [500, 1000, 1500, 1700] 
    
	!Calibracion PM
    !CALL Calibrar_PM(Archivo1, ParametrosPM, 5, N1, N2, PC_FIJA, N4)
	!CALL Calibrar_PM(Archivo2, ParametrosPM, 5, N1, N2, PC_FIJA, N4)
    !CALL Calibrar_PM(Archivo3, ParametrosPM, 5, N1, N2, PC_FIJA, N4)
    !CALL Calibrar_PM(Archivo4, ParametrosPM, 5, N1, N2, PC_FIJA, N4)
    !CALL Calibrar_PM(Archivo5, ParametrosPM, 5, N1, N2, PC_FIJA, N4)
    !CALL Calibrar_PM(Archivo6, ParametrosPM, 5, N1, N2, PC_FIJA, N4)   
    !CALL Calibrar_PM(Archivo7, ParametrosPM, 5, N1, N2, PC_FIJA, N4)
    !CALL Calibrar_PM(Archivo8, ParametrosPM, 5, N1, N2, PC_FIJA, N4)
	!CALL Calibrar_PM(Archivo9, ParametrosPM, 5, N1, N2, PC_FIJA, N4)
	!CALL Calibrar_PM(Archivo10, ParametrosPM, 5, N1, N2, PC_FIJA, N4)



	!Calibracion PC 
    !CALL Calibrar_PC(Archivo1, ParametrosPC, 4, N1, N2, PM_FIJAC, N4)
	!CALL Calibrar_PC(Archivo2, ParametrosPC, 4, N1, N2, PM_FIJC, N4)
    !CALL Calibrar_PC(Archivo3, ParametrosPC, 4, N1, N2, PM_FIJAC, N4)
    !CALL Calibrar_PC(Archivo4, ParametrosPC, 4, N1, N2, PM_FIJAC, N4)
    !CALL Calibrar_PC(Archivo5, ParametrosPC, 4, N1, N2, PM_FIJAC, N4)
    !CALL Calibrar_PC(Archivo6, ParametrosPC, 4, N1, N2, PM_FIJAC, N4)   
    !CALL Calibrar_PC(Archivo7, ParametrosPC, 4, N1, N2, PM_FIJAC, N4)
    !CALL Calibrar_PC(Archivo8, ParametrosPC, 4, N1, N2, PM_FIJAC, N4)	
    !CALL Calibrar_PC(Archivo9, ParametrosPC, 4, N1, N2, PM_FIJAC, N4)
    !CALL Calibrar_PC(Archivo10, ParametrosPC, 4, N1, N2, PM_FIJAC, N4)	
	
	!CALIBRACION COMBINADA PM Y PC
    !CALL Calibrar_PM_PC(Archivo1, ParametrosPM, ParametrosPC, 5, 4, N1, N2, N4)
	!CALL Calibrar_PM_PC(Archivo2, ParametrosPM, ParametrosPC, 5, 4, N1, N2, N4)
	!CALL Calibrar_PM_PC(Archivo3, ParametrosPM, ParametrosPC, 5, 4, N1, N2, N4)
	!CALL Calibrar_PM_PC(Archivo4, ParametrosPM, ParametrosPC, 5, 4, N1, N2, N4)
	!CALL Calibrar_PM_PC(Archivo5, ParametrosPM, ParametrosPC, 5, 4, N1, N2, N4)
	!CALL Calibrar_PM_PC(Archivo6, ParametrosPM, ParametrosPC, 5, 4, N1, N2, N4)
	!CALL Calibrar_PM_PC(Archivo7, ParametrosPM, ParametrosPC, 5, 4, N1, N2, N4)
	!CALL Calibrar_PM_PC(Archivo8, ParametrosPM, ParametrosPC, 5, 4, N1, N2, N4)
	!CALL Calibrar_PM_PC(Archivo9, ParametrosPM, ParametrosPC, 5, 4, N1, N2, N4)
	!CALL Calibrar_PM_PC(Archivo10, ParametrosPM, ParametrosPC, 5, 4, N1, N2, N4)
	
	
	!Calibrar T 
    !CALL Calibrar_T(Archivo1, ParametrosTam, 4, N2, PC_FINAL, PM_FINAL, N4)
	!CALL Calibrar_T(Archivo2, ParametrosTam, 4, N2, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_T(Archivo3, ParametrosTam, 4, N2, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_T(Archivo4, ParametrosTam, 4, N2, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_T(Archivo5, ParametrosTam, 4, N2, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_T(Archivo6, ParametrosTam, 4, N2, PC_FINAL, PM_FINAL, N4)   
    !CALL Calibrar_T(Archivo7, ParametrosTam, 4, N2, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_T(Archivo8, ParametrosTam, 4, N2, PC_FINAL, PM_FINAL, N4)	
    !CALL Calibrar_T(Archivo9, ParametrosTam, 4, N2, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_T(Archivo10, ParametrosTam, 4, N2, PC_FINAL, PM_FINAL, N4)	
	
	!Calibrar G
    !CALL Calibrar_G(Archivo1, ParametrosG, 4, T_FINAL, PC_FINAL, PM_FINAL, N4)
	!CALL Calibrar_G(Archivo2, ParametrosG, 4, T_FINAL, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_G(Archivo3, ParametrosG, 4, T_FINAL, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_G(Archivo4, ParametrosG, 4, T_FINAL, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_G(Archivo5, ParametrosG, 4, T_FINAL, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_G(Archivo6, ParametrosG, 4, T_FINAL, PC_FINAL, PM_FINAL, N4)   
    !CALL Calibrar_G(Archivo7, ParametrosG, 4, T_FINAL, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_G(Archivo8, ParametrosG, 4, T_FINAL, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_G(Archivo9, ParametrosG, 5, T_FINAL, PC_FINAL, PM_FINAL, N4)
    !CALL Calibrar_G(Archivo10, ParametrosG, 5, T_FINAL, PC_FINAL, PM_FINAL, N4)	
	
	!Resultados 
    !CALL Resultados(ArchivoR1, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)

    !CALL Resultados(ArchivoR2, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR3, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR4, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR5, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR6, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
    !CALL Resultados(ArchivoR7, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)

    !CALL Resultados(ArchivoR8, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)

    !CALL Resultados(ArchivoR9, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR10, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR11, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR12, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR13, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR14, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
	!CALL Resultados(ArchivoR15, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR16, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR17, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR18, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	
    !CALL Resultados(ArchivoR19, T_FINAL, G_FINAL, &
    !                PC_FINAL, PM_FINAL, N4, &
    !                mejor_fitness, fitness_promedio, &
    !                mejor_solucion, tiempo_promedio)
	

	!Resultados	 OJO Cambiar TIEMPO1, Y TIEMPO2					 
	!CALL Evaluar_AG_Tiempo(ArchivoR1, TIEMPO2, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 5, &
    !                       Mejor_Absoluto, Media_Absoluta)
	
!	CALL Evaluar_AG_Tiempo(ArchivoR2, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
!							 
!	CALL Evaluar_AG_Tiempo(ArchivoR3, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
!							 
!	CALL Evaluar_AG_Tiempo(ArchivoR4, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
!
!	CALL Evaluar_AG_Tiempo(ArchivoR5, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
!
!	CALL Evaluar_AG_Tiempo(ArchivoR6, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
!
!	CALL Evaluar_AG_Tiempo(ArchivoR7, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
!							 
!	CALL Evaluar_AG_Tiempo(ArchivoR8, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
!	
!	CALL Evaluar_AG_Tiempo(ArchivoR9, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
!	
!	CALL Evaluar_AG_Tiempo(ArchivoR10, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
							 
!	CALL Evaluar_AG_Tiempo(ArchivoR11, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
							 
!	CALL Evaluar_AG_Tiempo(ArchivoR12, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
							 
!	CALL Evaluar_AG_Tiempo(ArchivoR13, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)

!	CALL Evaluar_AG_Tiempo(ArchivoR14, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)

!	CALL Evaluar_AG_Tiempo(ArchivoR15, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)

!	CALL Evaluar_AG_Tiempo(ArchivoR16, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
							 
!	CALL Evaluar_AG_Tiempo(ArchivoR17, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
							 
!	CALL Evaluar_AG_Tiempo(ArchivoR18, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
							 
!	CALL Evaluar_AG_Tiempo(ArchivoR19, TIEMPO1, G_FINAL, T_FINAL, PC_FINAL, PM_FINAL, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
CONTAINS


    ! ========== SUBRUTINA 1: Leer Datos ==========
    SUBROUTINE Leer_Datos_MDP(filename)
        USE Params_MDP
        IMPLICIT NONE
        CHARACTER(LEN=*), INTENT(IN) :: filename
        INTEGER :: i, j, status
        REAL(8) :: d_val
          
        OPEN(UNIT=10, FILE=TRIM(filename), STATUS='OLD', ACTION='READ', IOSTAT=status)
        IF (status /= 0) THEN
            WRITE(*, *) 'ERROR: No se pudo abrir el archivo de datos: ', TRIM(filename)
            STOP
        END IF
            
        READ(10, *) n, m
            
        IF (ALLOCATED(D)) DEALLOCATE(D)
        ALLOCATE(D(n, n))
        D = 0.0_8  ! Inicializar matriz
            
        DO 
            READ(10, *, IOSTAT=status) i, j, d_val
            IF (status /= 0) EXIT 
            D(i + 1, j + 1) = d_val
            D(j + 1, i + 1) = d_val
        END DO
            
        CLOSE(10)
    END SUBROUTINE Leer_Datos_MDP


    ! ========== SUBRUTINA 2: Inicializar semilla aleatoria ==========
    SUBROUTINE init_random_seed()
        INTEGER :: i, nseed, sc
        INTEGER, ALLOCATABLE :: seeds(:)
        
        CALL system_clock(count = sc)
        nseed = 8
        ALLOCATE(seeds(nseed))
        DO i = 1, nseed
            seeds(i) = MOD(sc + 37*i*(i+13), 2147483647)
            IF (seeds(i) < 1) seeds(i) = seeds(i) + 1
        END DO
        CALL random_seed(put = seeds)
        DEALLOCATE(seeds)
    END SUBROUTINE init_random_seed


    ! ========== SUBRUTINA 3: Función  fitness ==========
    SUBROUTINE Calcular_Fitness_Rapido(individuo, fitness)
        USE Params_MDP
        IMPLICIT NONE
        INTEGER, INTENT(IN) :: individuo(:)
        REAL(8), INTENT(OUT) :: fitness
        
        INTEGER :: i, j, gen_i, gen_j
        
        fitness = 0.0_8
        DO i = 1, m-1
            gen_i = individuo(i)
            DO j = i+1, m
                gen_j = individuo(j)
                fitness = fitness + D(gen_i, gen_j)
            END DO
        END DO
    END SUBROUTINE Calcular_Fitness_Rapido


    ! ========== SUBRUTINA 4: Crear Individuo  ==========
    SUBROUTINE Crear_Individuo(Individuo, Adaptacion_I)
        USE Params_MDP, ONLY: n, m
        IMPLICIT NONE
        INTEGER, ALLOCATABLE, INTENT(OUT) :: Individuo(:)
        REAL(8), INTENT(OUT) :: Adaptacion_I

        INTEGER :: i, j, temp
        REAL(8) :: r
        INTEGER, ALLOCATABLE :: perm(:)

        ALLOCATE(Individuo(m))
        ALLOCATE(perm(n))

        ! Inicializar permutación
        DO i = 1, n
            perm(i) = i
        END DO

        ! Mezcla Fisher-Yates optimizada
        DO i = n, 2, -1
            CALL random_number(r)
            j = 1 + INT(r * i)  
            temp = perm(i)
            perm(i) = perm(j)
            perm(j) = temp
        END DO

        ! Tomar primeros m elementos
        Individuo = perm(1:m)

        ! Calcular fitness usando la función optimizada
        CALL Calcular_Fitness_Rapido(Individuo, Adaptacion_I)

        DEALLOCATE(perm)
    END SUBROUTINE Crear_Individuo


	! ========== SUBRUTINA 5: Para crear un individuo Greedy ==========
	SUBROUTINE Greedy_Con(p1, P, z)
		USE Params_MDP
		IMPLICIT NONE
		
		! --- Argumentos ---
		INTEGER, INTENT(IN) :: p1                 ! Elemento semilla inicial
		INTEGER, ALLOCATABLE, INTENT(OUT) :: P(:) ! Solución construída (tamaño m)
		REAL(8), INTENT(OUT) :: z                 ! Valor de la solución (diversidad)
		
		! --- Variables locales ---
		INTEGER :: i, j, k, t, pos_max(1), p1_local
		REAL(8), ALLOCATABLE :: G(:)              ! Vector de ganancias
		LOGICAL, ALLOCATABLE :: seleccionado(:)   ! Elementos ya seleccionados
		
		! --- Inicialización ---
		ALLOCATE(P(m), G(n), seleccionado(n))
		
		! Inicializar arrays
		P = 0
		seleccionado = .FALSE.
		
		! Usar variable local para p1 
		p1_local = p1
		
		! Verificar que p1_local esté en rango válido
		IF (p1_local < 1) THEN
			p1_local = 1
		ELSE IF (p1_local > n) THEN
			p1_local = n
		END IF
		
		! Primer elemento seleccionado
		P(1) = p1_local
		seleccionado(p1_local) = .TRUE.
		
		! Inicializar vector de ganancias G con distancias desde p1_local
		DO i = 1, n
			G(i) = D(p1_local, i)
		END DO
		G(p1_local) = 0.0D0  ! El elemento p1_local ya está seleccionado
		
		! Inicializar valor de la solución
		z = 0.0D0
		
		! --- Construcción Greedy iterativa ---
		DO t = 2, m
			! Encontrar el elemento no seleccionado con máxima ganancia
			pos_max = 0
			DO i = 1, n
				IF (.NOT. seleccionado(i)) THEN
					IF (pos_max(1) == 0 .OR. G(i) > G(pos_max(1))) THEN
						pos_max(1) = i
					END IF
				END IF
			END DO
			
			! Si no se encuentra elemento válido, salir
			IF (pos_max(1) == 0) THEN
				EXIT
			END IF
			
			k = pos_max(1)
			
			! Agregar elemento k a la solución
			P(t) = k
			seleccionado(k) = .TRUE.
			
			! Acumular valor de la solución (ganancia del elemento seleccionado)
			z = z + G(k)
			
			! Actualizar ganancias para los elementos aún no seleccionados
			! Sumar distancias desde el nuevo elemento k
			DO i = 1, n
				IF (.NOT. seleccionado(i)) THEN
					G(i) = G(i) + D(k, i)
				END IF
			END DO
			
			! Marcar elemento k como procesado
			G(k) = 0.0D0
		END DO
		
		! --- Calcular valor exacto de la solución ---
		CALL Calcular_Fitness_Rapido(P,z)
		
		DEALLOCATE(G, seleccionado)
		
	END SUBROUTINE Greedy_Con


	! ========== SUBRUTINA 6: Crear una poblacion con elemntos Greedy ==========
	SUBROUTINE Poblacion_InicialG(T, Poblacion, Adaptacion_P, Mejor_I, Mejor_A)
		USE Params_MDP
		IMPLICIT NONE
		
		INTEGER, INTENT(IN) :: T
		INTEGER, ALLOCATABLE, INTENT(OUT) :: Poblacion(:,:)
		REAL(8), ALLOCATABLE, INTENT(OUT) :: Adaptacion_P(:)
		INTEGER, ALLOCATABLE, INTENT(OUT) :: Mejor_I(:)
		REAL(8), INTENT(OUT) :: Mejor_A
		
		! Variables locales
		REAL(8), PARAMETER :: PORCENTAJE_GREEDY = 0.5D0  ! 50% Greedy, 50% Aleatorio
		
		INTEGER :: i, semilla, num_greedy
		INTEGER, ALLOCATABLE :: Individuo(:)
		REAL(8) :: Adaptacion_I, rnd
		
		! Calcular número de soluciones Greedy
		num_greedy = INT(T * PORCENTAJE_GREEDY)
		
		! Asignar memoria para arrays de salida
		ALLOCATE(Poblacion(T, m), Adaptacion_P(T), Mejor_I(m))
		Mejor_A = -HUGE(1.0_8)  ! Inicializar con valor muy negativo
		
		! Inicializar semilla aleatoria
		CALL init_random_seed()
		
		! --- SOLUCIONES GREEDY (primera mitad) ---
		DO i = 1, num_greedy
			! Seleccionar semilla aleatoria
			CALL RANDOM_NUMBER(rnd)
			semilla = 1 + INT(rnd * n)
			semilla = MIN(MAX(semilla, 1), n)  
			
			! Construir solución Greedy
			CALL Greedy_Con(semilla, Individuo, Adaptacion_I)
			
			! Almacenar en población
			Poblacion(i, :) = Individuo
			Adaptacion_P(i) = Adaptacion_I
			
			! Actualizar mejor solución global
			IF (Adaptacion_I > Mejor_A) THEN
				Mejor_A = Adaptacion_I
				Mejor_I = Individuo
			END IF
			
			DEALLOCATE(Individuo)  ! Liberar memoria del individuo actual
		END DO
		
		! --- SOLUCIONES ALEATORIAS (segunda mitad) ---
		DO i = num_greedy + 1, T
			! Crear individuo aleatorio usando tu subrutina
			CALL Crear_Individuo(Individuo, Adaptacion_I)
			
			! Almacenar en población
			Poblacion(i, :) = Individuo
			Adaptacion_P(i) = Adaptacion_I
			
			! Actualizar mejor solución global
			IF (Adaptacion_I > Mejor_A) THEN
				Mejor_A = Adaptacion_I
				Mejor_I = Individuo
			END IF
			
			DEALLOCATE(Individuo)  ! Liberar memoria del individuo actual
		END DO
		
	END SUBROUTINE Poblacion_InicialG
    

	! ========== SUBRUTINA 7: Población con individuos creados al azar ==========
    SUBROUTINE Poblacion_Inicial(T, Poblacion, Adaptacion_P, Mejor_I, Mejor_A)
        USE Params_MDP
        IMPLICIT NONE
        INTEGER, INTENT(IN) :: T
        INTEGER, ALLOCATABLE, INTENT(OUT) :: Poblacion(:,:)
        REAL(8), ALLOCATABLE, INTENT(OUT) :: Adaptacion_P(:)
        INTEGER, ALLOCATABLE, INTENT(OUT) :: Mejor_I(:)
        REAL(8), INTENT(OUT) :: Mejor_A

        INTEGER, ALLOCATABLE :: Individuo(:)
        REAL(8) :: Adaptacion_I
        INTEGER :: i
        
        ALLOCATE(Poblacion(T, m))
        ALLOCATE(Adaptacion_P(T))
        ALLOCATE(Mejor_I(m))
        Mejor_A = -HUGE(1.0_8)

        DO i = 1, T
            CALL Crear_Individuo(Individuo, Adaptacion_I)
            Poblacion(i,:) = Individuo(:)
            Adaptacion_P(i) = Adaptacion_I
            
            IF (Adaptacion_I > Mejor_A) THEN
                Mejor_A = Adaptacion_I
                Mejor_I(:) = Individuo(:)
            END IF
            
            DEALLOCATE(Individuo)
        END DO
    END SUBROUTINE Poblacion_Inicial


    ! ========== SUBRUTINA 8: Selección Torneo Padres ==========
    SUBROUTINE Seleccion_Torneo_Padres(T, Poblacion, Adaptacion_P, Poblacion_Padres)
        USE Params_MDP, ONLY: m
        IMPLICIT NONE
       
        INTEGER, INTENT(IN) :: T
        INTEGER, INTENT(IN) :: Poblacion(T, m)
        REAL(8), INTENT(IN) :: Adaptacion_P(T)
        INTEGER, ALLOCATABLE, INTENT(OUT) :: Poblacion_Padres(:,:)
       
        INTEGER :: TP, i, a, b
        REAL(8) :: r1, r2
       
        IF (T <= 0) THEN
            WRITE(*,*) "ERROR: T debe ser positivo"
            RETURN
        END IF
       
        TP = MAX(1, T / 2)
       
        IF (ALLOCATED(Poblacion_Padres)) DEALLOCATE(Poblacion_Padres)
        ALLOCATE(Poblacion_Padres(TP, m))
       
        DO i = 1, TP
            CALL RANDOM_NUMBER(r1)
            CALL RANDOM_NUMBER(r2)
           
            a = 1 + FLOOR(r1 * T)
            b = 1 + FLOOR(r2 * T)
           
            a = MIN(MAX(a, 1), T)
            b = MIN(MAX(b, 1), T)
           
            IF (Adaptacion_P(a) >= Adaptacion_P(b)) THEN
                Poblacion_Padres(i,:) = Poblacion(a,:)
            ELSE
                Poblacion_Padres(i,:) = Poblacion(b,:)
            END IF
        END DO
    END SUBROUTINE Seleccion_Torneo_Padres


    ! ========== SUBRUTINA 9: Mutación  ==========
    SUBROUTINE Mutar_Hijo_Reemplazo(Hijo, Adaptacion_H)
        USE Params_MDP, ONLY: m, n, D
        IMPLICIT NONE
        INTEGER, INTENT(INOUT) :: Hijo(:)
        REAL(8), INTENT(INOUT) :: Adaptacion_H

        INTEGER :: pos, viejo_gen, nuevo_gen, j
        REAL(8) :: rand
        LOGICAL :: encontrado
        
        ! Seleccionar posición aleatoria
        CALL random_number(rand)
        pos = 1 + INT(rand * m)
        viejo_gen = Hijo(pos)

        ! Buscar nuevo gen que no esté en el individuo
        DO
            CALL random_number(rand)
            nuevo_gen = 1 + INT(rand * n)
            encontrado = .FALSE.
            
            ! Búsqueda optimizada: salir al encontrar
            DO j = 1, m
                IF (Hijo(j) == nuevo_gen) THEN
                    encontrado = .TRUE.
                    EXIT
                END IF
            END DO
            
            IF (.NOT. encontrado) EXIT
        END DO

        ! En lugar de restar y sumar todo, solo actualizamos diferencias
        DO j = 1, m
            IF (j /= pos) THEN
                Adaptacion_H = Adaptacion_H - D(viejo_gen, Hijo(j)) + D(nuevo_gen, Hijo(j))
            END IF
        END DO

        ! Reemplazar gen
        Hijo(pos) = nuevo_gen
    END SUBROUTINE Mutar_Hijo_Reemplazo


    ! ========== SUBRUTINA 10: Cruce y Mutacion ==========
    SUBROUTINE Cruce_PMX_ConMutacion(Poblacion_Padres, Hijos, Adaptacion_H, pc, pm, Mejor_I, Mejor_A)
        USE Params_MDP
        IMPLICIT NONE
        
        INTEGER, INTENT(IN) :: Poblacion_Padres(:, :)
        INTEGER, ALLOCATABLE, INTENT(OUT) :: Hijos(:, :)
        REAL(8), ALLOCATABLE, INTENT(OUT) :: Adaptacion_H(:)
        REAL(8), INTENT(IN) :: pc, pm
        INTEGER, INTENT(INOUT) :: Mejor_I(:)
        REAL(8), INTENT(INOUT) :: Mejor_A
        
        INTEGER :: TP, T, i, p1, p2, k, c1, c2, temp, j, pos, gen_p, gen_q
        REAL(8) :: rand_c, rand_m
        INTEGER, ALLOCATABLE :: hijo1(:), hijo2(:)
        LOGICAL :: ocupado1(m), ocupado2(m), encontrado
        
        TP = SIZE(Poblacion_Padres, 1)
        T = TP * 2
        ALLOCATE(Hijos(T, m))
        ALLOCATE(Adaptacion_H(T))
        ALLOCATE(hijo1(m), hijo2(m))
        
        DO i = 1, TP
            p1 = i
            p2 = MOD(i, TP) + 1
            
            CALL RANDOM_NUMBER(rand_c)
            
            IF (rand_c < pc) THEN
                CALL RANDOM_NUMBER(rand_m)
                c1 = 1 + INT(rand_m * (m-1))
                CALL RANDOM_NUMBER(rand_m)
                c2 = c1 + INT(rand_m * (m-c1))
                IF (c1 > c2) THEN
                    temp = c1
                    c1 = c2
                    c2 = temp
                END IF
                
                ! Inicializar hijos
                hijo1 = -1
                hijo2 = -1
                ocupado1 = .FALSE.
                ocupado2 = .FALSE.
                
                ! Copiar segmento central
                hijo1(c1:c2) = Poblacion_Padres(p1, c1:c2)
                hijo2(c1:c2) = Poblacion_Padres(p2, c1:c2)
                ocupado1(c1:c2) = .TRUE.
                ocupado2(c1:c2) = .TRUE.
                
                ! Llenar hijo1 con genes de padre2
                DO k = 1, m
                    temp = Poblacion_Padres(p2, k)
                    encontrado = .FALSE.
                    
                    ! Búsqueda manual más rápida que ANY()
                    DO j = 1, m
                        IF (hijo1(j) == temp) THEN
                            encontrado = .TRUE.
                            EXIT
                        END IF
                    END DO
                    
                    IF (.NOT. encontrado) THEN
                        DO pos = 1, m
                            IF (.NOT. ocupado1(pos)) THEN
                                hijo1(pos) = temp
                                ocupado1(pos) = .TRUE.
                                EXIT
                            END IF
                        END DO
                    END IF
                END DO
                
                ! Llenar hijo2 con genes de padre1
                DO k = 1, m
                    temp = Poblacion_Padres(p1, k)
                    encontrado = .FALSE.
                    
                    DO j = 1, m
                        IF (hijo2(j) == temp) THEN
                            encontrado = .TRUE.
                            EXIT
                        END IF
                    END DO
                    
                    IF (.NOT. encontrado) THEN
                        DO pos = 1, m
                            IF (.NOT. ocupado2(pos)) THEN
                                hijo2(pos) = temp
                                ocupado2(pos) = .TRUE.
                                EXIT
                            END IF
                        END DO
                    END IF
                END DO
                
                Hijos(2*i-1, :) = hijo1
                Hijos(2*i, :) = hijo2
                
            ELSE
                ! Sin cruce
                Hijos(2*i-1, :) = Poblacion_Padres(p1, :)
                Hijos(2*i, :) = Poblacion_Padres(p2, :)
            END IF
        END DO
        
        DEALLOCATE(hijo1, hijo2)
        
        ! Evaluar fitness de todos los hijos
        DO i = 1, T
            CALL Calcular_Fitness_Rapido(Hijos(i, :), Adaptacion_H(i))
            
            CALL RANDOM_NUMBER(rand_m)
            IF (rand_m < pm) THEN
                CALL Mutar_Hijo_Reemplazo(Hijos(i, :), Adaptacion_H(i))
            END IF
            
            IF (Adaptacion_H(i) > Mejor_A) THEN
                Mejor_A = Adaptacion_H(i)
                Mejor_I(:) = Hijos(i, :)
            END IF
        END DO
    END SUBROUTINE Cruce_PMX_ConMutacion


    ! ========== SUBRUTINA 11: Selección Torneo Final ==========
    SUBROUTINE Seleccion_Torneo_Final(Poblacion, Adaptacion_P, Hijos, Adaptacion_H)
        USE Params_MDP, ONLY: m
        IMPLICIT NONE
        
        INTEGER, INTENT(INOUT) :: Poblacion(:, :)
        REAL(8), INTENT(INOUT) :: Adaptacion_P(:)
        INTEGER, INTENT(IN) :: Hijos(:, :)
        REAL(8), INTENT(IN) :: Adaptacion_H(:)
        
        INTEGER, ALLOCATABLE :: Nueva_Poblacion(:, :)
        REAL(8), ALLOCATABLE :: Nueva_Adaptacion(:)
        INTEGER :: T, i, a_idx, b_idx, num_hijos
        REAL(8) :: r, adaptacion_a, adaptacion_b
        LOGICAL :: a_es_padre, b_es_padre
        
        T = SIZE(Poblacion, 1)
        num_hijos = SIZE(Hijos, 1)
        
        IF (T <= 0) THEN
            PRINT *, "ERROR: Tamaño de población inválido"
            RETURN
        END IF
        
        ALLOCATE(Nueva_Poblacion(T, m))
        ALLOCATE(Nueva_Adaptacion(T))
        
        DO i = 1, T
            ! Candidato A
            CALL RANDOM_NUMBER(r)
            IF (r < 0.5_8) THEN
                CALL RANDOM_NUMBER(r)
                a_idx = 1 + INT(r * T)
                a_idx = MIN(MAX(a_idx, 1), T)
                a_es_padre = .TRUE.
                adaptacion_a = Adaptacion_P(a_idx)
            ELSE
                IF (num_hijos > 0) THEN
                    CALL RANDOM_NUMBER(r)
                    a_idx = 1 + INT(r * num_hijos)
                    a_idx = MIN(MAX(a_idx, 1), num_hijos)
                    a_es_padre = .FALSE.
                    adaptacion_a = Adaptacion_H(a_idx)
                ELSE
                    CALL RANDOM_NUMBER(r)
                    a_idx = 1 + INT(r * T)
                    a_idx = MIN(MAX(a_idx, 1), T)
                    a_es_padre = .TRUE.
                    adaptacion_a = Adaptacion_P(a_idx)
                END IF
            END IF
            
            ! Candidato B
            CALL RANDOM_NUMBER(r)
            IF (r < 0.5_8) THEN
                CALL RANDOM_NUMBER(r)
                b_idx = 1 + INT(r * T)
                b_idx = MIN(MAX(b_idx, 1), T)
                b_es_padre = .TRUE.
                adaptacion_b = Adaptacion_P(b_idx)
            ELSE
                IF (num_hijos > 0) THEN
                    CALL RANDOM_NUMBER(r)
                    b_idx = 1 + INT(r * num_hijos)
                    b_idx = MIN(MAX(b_idx, 1), num_hijos)
                    b_es_padre = .FALSE.
                    adaptacion_b = Adaptacion_H(b_idx)
                ELSE
                    CALL RANDOM_NUMBER(r)
                    b_idx = 1 + INT(r * T)
                    b_idx = MIN(MAX(b_idx, 1), T)
                    b_es_padre = .TRUE.
                    adaptacion_b = Adaptacion_P(b_idx)
                END IF
            END IF
            
            ! Torneo
            IF (adaptacion_a >= adaptacion_b) THEN
                IF (a_es_padre) THEN
                    Nueva_Poblacion(i, :) = Poblacion(a_idx, :)
                    Nueva_Adaptacion(i) = adaptacion_a
                ELSE
                    Nueva_Poblacion(i, :) = Hijos(a_idx, :)
                    Nueva_Adaptacion(i) = adaptacion_a
                END IF
            ELSE
                IF (b_es_padre) THEN
                    Nueva_Poblacion(i, :) = Poblacion(b_idx, :)
                    Nueva_Adaptacion(i) = adaptacion_b
                ELSE
                    Nueva_Poblacion(i, :) = Hijos(b_idx, :)
                    Nueva_Adaptacion(i) = adaptacion_b
                END IF
            END IF
        END DO
        
        ! Reemplazar población
        Poblacion(:, :) = Nueva_Poblacion(:, :)
        Adaptacion_P(:) = Nueva_Adaptacion(:)
        
        DEALLOCATE(Nueva_Poblacion, Nueva_Adaptacion)
    END SUBROUTINE Seleccion_Torneo_Final


    ! ========== SUBRUTINA 12: Algoritmo Genético ==========
    SUBROUTINE Algoritmo_Genetico_Generaciones(G, T, PC, PM, Mejor_I, Mejor_A)
        USE Params_MDP
        IMPLICIT NONE

        INTEGER, INTENT(IN) :: G, T 
        REAL(8), INTENT(IN) :: PC, PM 
        INTEGER, ALLOCATABLE, INTENT(OUT) :: Mejor_I(:)
        REAL(8), INTENT(OUT) :: Mejor_A

        INTEGER, ALLOCATABLE :: Poblacion_I(:,:), Poblacion_Padres(:,:), Hijos(:,:)  
        REAL(8), ALLOCATABLE :: Adaptacion_P(:), Adaptacion_H(:)
        INTEGER :: Generaciones
        
        CALL Poblacion_InicialG(T, Poblacion_I, Adaptacion_P, Mejor_I, Mejor_A)
        
        ALLOCATE(Poblacion_Padres(T/2, m))
        ALLOCATE(Hijos(T, m))
        ALLOCATE(Adaptacion_H(T))

        DO Generaciones = 1, G 
            CALL Seleccion_Torneo_Padres(T, Poblacion_I, Adaptacion_P, Poblacion_Padres)
            CALL Cruce_PMX_ConMutacion(Poblacion_Padres, Hijos, Adaptacion_H, PC, PM, Mejor_I, Mejor_A)
            CALL Seleccion_Torneo_Final(Poblacion_I, Adaptacion_P, Hijos, Adaptacion_H)
        END DO 

        DEALLOCATE(Poblacion_Padres, Hijos, Adaptacion_H)
        DEALLOCATE(Poblacion_I)
        DEALLOCATE(Adaptacion_P)
    END SUBROUTINE Algoritmo_Genetico_Generaciones


    ! ========== SUBRUTINA 13: Calibración PM  ==========
    SUBROUTINE Calibrar_PM(filename, pm_values, num_pm, T, G, PC, Repeticiones)
        USE Params_MDP
        IMPLICIT NONE
        CHARACTER(LEN=*), INTENT(IN) :: filename
        REAL(8), INTENT(IN) :: pm_values(:)
        INTEGER, INTENT(IN) :: num_pm
        INTEGER, INTENT(IN) :: T, G, Repeticiones
        REAL(8), INTENT(IN) :: PC

        INTEGER :: i, rep
        REAL(8) :: PM_actual, Mejor_A_temp, Mejor_A_suma, Mejor_A_media
        INTEGER, ALLOCATABLE :: Mejor_I_temp(:)
        REAL(8) :: tiempo_inicio, tiempo_fin
        
        CALL Leer_Datos_MDP(filename)
        
        WRITE(*, *) ' '
        WRITE(*, *) '==================================================='
        WRITE(*, *) '=== INICIO DE LA CALIBRACION DE PM (MUTACION) ==='
        WRITE(*,*) "      CALIBRANDO INSTANCIA: ", TRIM(filename)
        WRITE(*,*) "---------------------------------------------------"
        WRITE(*, *) '==================================================='
        WRITE(*, *) ' '
        WRITE(*, '(A, I6)') 'Tamano de la Poblacion (T):', T
        WRITE(*, '(A, I6)') 'Generaciones por Prueba (G):', G
        WRITE(*, '(A, F6.4)') 'Prob. de Cruce (PC) FIJA:', PC
        WRITE(*, '(A, I6)') 'Repeticiones por PM:', Repeticiones
        WRITE(*, *) ' '
        WRITE(*, *) '---------------------------------------------------'
        WRITE(*, *) ' PM        | Fitness Promedio | Tiempo (s)'
        WRITE(*, *) '---------------------------------------------------'
        
        ALLOCATE(Mejor_I_temp(m))
        
        ! Bucle sobre valores de PM
        DO i = 1, num_pm
            PM_actual = pm_values(i)
            Mejor_A_suma = 0.0_8
            
            CALL CPU_TIME(tiempo_inicio)
            
            ! Repeticiones
            DO rep = 1, Repeticiones
                CALL init_random_seed() 
                CALL Algoritmo_Genetico_Generaciones(G, T, PC, PM_actual, Mejor_I_temp, Mejor_A_temp)
                Mejor_A_suma = Mejor_A_suma + Mejor_A_temp
            END DO
            
            CALL CPU_TIME(tiempo_fin)
            
            ! Calcular resultados
            Mejor_A_media = Mejor_A_suma / REAL(Repeticiones, 8)
            WRITE(*, '(F5.3, A4, F20.6, A4, F8.2)') PM_actual, ' | ', Mejor_A_media, ' | ', tiempo_fin - tiempo_inicio
        END DO
        
        DEALLOCATE(Mejor_I_temp)
        WRITE(*, *) '---------------------------------------------------'
        WRITE(*, *) ' '
    END SUBROUTINE Calibrar_PM


	! ========== SUBRUTINA 14: Calibración PC  ==========
	SUBROUTINE Calibrar_PC(filename, pc_values, num_pc, T, G, PM, Repeticiones)
		USE Params_MDP
		IMPLICIT NONE
		CHARACTER(LEN=*), INTENT(IN) :: filename
		REAL(8), INTENT(IN) :: pc_values(:)
		INTEGER, INTENT(IN) :: num_pc
		INTEGER, INTENT(IN) :: T, G, Repeticiones
		REAL(8), INTENT(IN) :: PM

		INTEGER :: i, rep
		REAL(8) :: PC_actual, Mejor_A_temp, Mejor_A_suma, Mejor_A_media
		INTEGER, ALLOCATABLE :: Mejor_I_temp(:)
		REAL(8) :: tiempo_inicio, tiempo_fin
		
		CALL Leer_Datos_MDP(filename)
		
		WRITE(*, *) ' '
		WRITE(*, *) '==================================================='
		WRITE(*, *) '=== INICIO DE LA CALIBRACION DE PC (CRUCE) ======='
		WRITE(*, *) '==================================================='
        WRITE(*,*) "      CALIBRANDO INSTANCIA: ", TRIM(filename)
        WRITE(*,*) "---------------------------------------------------"
        WRITE(*, *) '==================================================='
		WRITE(*, *) ' '
		WRITE(*, '(A, I6)') 'Tamano de la Poblacion (T):', T
		WRITE(*, '(A, I6)') 'Generaciones por Prueba (G):', G
		WRITE(*, '(A, F6.4)') 'Prob. de Mutacion (PM) FIJA:', PM
		WRITE(*, '(A, I6)') 'Repeticiones por PC:', Repeticiones
		WRITE(*, *) ' '
		WRITE(*, *) '---------------------------------------------------'
		WRITE(*, *) ' PC        | Fitness Promedio | Tiempo (s)'
		WRITE(*, *) '---------------------------------------------------'
		
		ALLOCATE(Mejor_I_temp(m))
		
		! Bucle sobre valores de PC
		DO i = 1, num_pc
			PC_actual = pc_values(i)
			Mejor_A_suma = 0.0_8
			
			CALL CPU_TIME(tiempo_inicio)
			
			! Repeticiones
			DO rep = 1, Repeticiones
				CALL init_random_seed() 
				CALL Algoritmo_Genetico_Generaciones(G, T, PC_actual, PM, Mejor_I_temp, Mejor_A_temp)
				Mejor_A_suma = Mejor_A_suma + Mejor_A_temp
			END DO
			
			CALL CPU_TIME(tiempo_fin)
			
			! Calcular resultados
			Mejor_A_media = Mejor_A_suma / REAL(Repeticiones, 8)
			WRITE(*, '(F5.3, A4, F20.6, A4, F8.2)') PC_actual, ' | ', Mejor_A_media, ' | ', tiempo_fin - tiempo_inicio
		END DO
		
		DEALLOCATE(Mejor_I_temp)
		WRITE(*, *) '---------------------------------------------------'
		WRITE(*, *) ' '
	END SUBROUTINE Calibrar_PC
  

	! ========== SUBRUTINA 13: Calibración TAMANO DE LA POBLACION  ==========
	SUBROUTINE Calibrar_T(filename, t_values, num_t, G, PC, PM, Repeticiones)
		USE Params_MDP
		IMPLICIT NONE
		CHARACTER(LEN=*), INTENT(IN) :: filename
		INTEGER, INTENT(IN) :: t_values(:)
		INTEGER, INTENT(IN) :: num_t
		INTEGER, INTENT(IN) :: G, Repeticiones
		REAL(8), INTENT(IN) :: PC, PM

		INTEGER :: i, rep
		INTEGER :: T_actual
		REAL(8) :: Mejor_A_temp, Mejor_A_suma, Mejor_A_media
		INTEGER, ALLOCATABLE :: Mejor_I_temp(:)
		REAL(8) :: tiempo_inicio, tiempo_fin
		
		! 1. Leer los datos
		CALL Leer_Datos_MDP(filename)
		
		WRITE(*, *) ' '
		WRITE(*, *) '==================================================='
		WRITE(*, *) '=== INICIO DE LA CALIBRACION DE T (POBLACION) ===='
		WRITE(*, *) '==================================================='
        WRITE(*,*) "      CALIBRANDO INSTANCIA: ", TRIM(filename)
        WRITE(*,*) "---------------------------------------------------"
        WRITE(*, *) '==================================================='
		WRITE(*, *) ' '
		WRITE(*, '(A, I6)') 'Generaciones por Prueba (G):', G
		WRITE(*, '(A, F6.4)') 'Prob. de Cruce (PC) FIJA:', PC
		WRITE(*, '(A, F6.4)') 'Prob. de Mutacion (PM) FIJA:', PM
		WRITE(*, '(A, I6)') 'Repeticiones por T:', Repeticiones
		WRITE(*, *) ' '
		WRITE(*, *) '---------------------------------------------------'
		WRITE(*, *) ' T (Tam. Pob) | Fitness Promedio | Tiempo (s)'
		WRITE(*, *) '---------------------------------------------------'
		
		! Bucle sobre valores de T (tamaño de población)
		DO i = 1, num_t
			T_actual = t_values(i)
			
			! Reasignar memoria según el tamaño actual de población
			IF (ALLOCATED(Mejor_I_temp)) DEALLOCATE(Mejor_I_temp)
			ALLOCATE(Mejor_I_temp(m))
			
			Mejor_A_suma = 0.0_8
			
			CALL CPU_TIME(tiempo_inicio)
			
			! Repeticiones
			DO rep = 1, Repeticiones
				CALL init_random_seed() 
				CALL Algoritmo_Genetico_Generaciones(G, T_actual, PC, PM, Mejor_I_temp, Mejor_A_temp)
				Mejor_A_suma = Mejor_A_suma + Mejor_A_temp
			END DO
			
			CALL CPU_TIME(tiempo_fin)
			
			! Calcular resultados
			Mejor_A_media = Mejor_A_suma / REAL(Repeticiones, 8)
			WRITE(*, '(I6, A8, F20.6, A4, F8.2)') T_actual, ' | ', Mejor_A_media, ' | ', tiempo_fin - tiempo_inicio
		END DO
		
		IF (ALLOCATED(Mejor_I_temp)) DEALLOCATE(Mejor_I_temp)
		WRITE(*, *) '---------------------------------------------------'
		WRITE(*, *) ' '
	END SUBROUTINE Calibrar_T
 
	! ========== SUBRUTINA 13: Calibración NUMERO DE GENERACIONES  ==========
	SUBROUTINE Calibrar_G(filename, g_values, num_g, T, PC, PM, Repeticiones)
		USE Params_MDP
		IMPLICIT NONE
		CHARACTER(LEN=*), INTENT(IN) :: filename
		INTEGER, INTENT(IN) :: g_values(:)
		INTEGER, INTENT(IN) :: num_g
		INTEGER, INTENT(IN) :: T, Repeticiones
		REAL(8), INTENT(IN) :: PC, PM

		INTEGER :: i, rep
		INTEGER :: G_actual
		REAL(8) :: Mejor_A_temp, Mejor_A_suma, Mejor_A_media
		INTEGER, ALLOCATABLE :: Mejor_I_temp(:)
		REAL(8) :: tiempo_inicio, tiempo_fin
		
		CALL Leer_Datos_MDP(filename)
		
		WRITE(*, *) ' '
		WRITE(*, *) '==================================================='
		WRITE(*, *) '=== INICIO DE LA CALIBRACION DE G (GENERACIONES) =='
		WRITE(*, *) '==================================================='
        WRITE(*,*) "      CALIBRANDO INSTANCIA: ", TRIM(filename)
        WRITE(*,*) "---------------------------------------------------"
        WRITE(*, *) '==================================================='
		WRITE(*, *) ' '
		WRITE(*, '(A, I6)') 'Tamano de Poblacion (T) FIJO:', T
		WRITE(*, '(A, F6.4)') 'Prob. de Cruce (PC) FIJA:', PC
		WRITE(*, '(A, F6.4)') 'Prob. de Mutacion (PM) FIJA:', PM
		WRITE(*, '(A, I6)') 'Repeticiones por G:', Repeticiones
		WRITE(*, *) ' '
		WRITE(*, *) '---------------------------------------------------'
		WRITE(*, *) ' G (Generac.) | Fitness Promedio | Tiempo (s)'
		WRITE(*, *) '---------------------------------------------------'
		
		! Asignar memoria una vez
		ALLOCATE(Mejor_I_temp(m))
		
		! Bucle sobre valores de G (número de generaciones)
		DO i = 1, num_g
			G_actual = g_values(i)
			Mejor_A_suma = 0.0_8
			
			CALL CPU_TIME(tiempo_inicio)
			
			! Repeticiones
			DO rep = 1, Repeticiones
				CALL init_random_seed() 
				CALL Algoritmo_Genetico_Generaciones(G_actual, T, PC, PM, Mejor_I_temp, Mejor_A_temp)
				Mejor_A_suma = Mejor_A_suma + Mejor_A_temp
			END DO
			
			CALL CPU_TIME(tiempo_fin)
			
			! Calcular resultados
			Mejor_A_media = Mejor_A_suma / REAL(Repeticiones, 8)
			WRITE(*, '(I6, A8, F20.6, A4, F8.2)') G_actual, ' | ', Mejor_A_media, ' | ', tiempo_fin - tiempo_inicio
		END DO
		
		DEALLOCATE(Mejor_I_temp)
		WRITE(*, *) '---------------------------------------------------'
		WRITE(*, *) ' '
	END SUBROUTINE Calibrar_G


	! ========== SUBRUTINA 14: Poner limite de tiempo al AG ==========
    SUBROUTINE Algoritmo_Genetico_Tiempo(Tiempo, G, T, PC, PM, Mejor_I, Mejor_A)
        USE Params_MDP
        IMPLICIT NONE

        INTEGER, INTENT(IN) :: G, T 
        REAL(8), INTENT(IN) :: PC, PM, Tiempo
        INTEGER, ALLOCATABLE, INTENT(OUT) :: Mejor_I(:)
        REAL(8), INTENT(OUT) :: Mejor_A
		        REAL(8) :: start_time, current_time

        INTEGER, ALLOCATABLE :: Poblacion_I(:,:), Poblacion_Padres(:,:), Hijos(:,:)  
        REAL(8), ALLOCATABLE :: Adaptacion_P(:), Adaptacion_H(:)
        INTEGER :: Generaciones
        
        CALL Poblacion_InicialG(T, Poblacion_I, Adaptacion_P, Mejor_I, Mejor_A)
        
        ALLOCATE(Poblacion_Padres(T/2, m))
        ALLOCATE(Hijos(T, m))
        ALLOCATE(Adaptacion_H(T))
		
		CALL CPU_TIME(start_time)
        DO Generaciones = 1, G 
            CALL Seleccion_Torneo_Padres(T, Poblacion_I, Adaptacion_P, Poblacion_Padres)
            CALL Cruce_PMX_ConMutacion(Poblacion_Padres, Hijos, Adaptacion_H, PC, PM, Mejor_I, Mejor_A)
            CALL Seleccion_Torneo_Final(Poblacion_I, Adaptacion_P, Hijos, Adaptacion_H)
            CALL CPU_TIME(current_time)
            IF (current_time - start_time > Tiempo) EXIT
			
		END DO 

        DEALLOCATE(Poblacion_Padres, Hijos, Adaptacion_H)
        DEALLOCATE(Poblacion_I)
        DEALLOCATE(Adaptacion_P)
    END SUBROUTINE Algoritmo_Genetico_Tiempo


	! ========== SUBRUTINA 15: Aplicar tiempo a los conjuntos de test==========
	SUBROUTINE Evaluar_AG_Tiempo(filename, Tiempo_limite, G, T, PC, PM, Reps, &
								 Mejor_Absoluto, Media_Absoluta)
		USE Params_MDP
		IMPLICIT NONE
	   
		CHARACTER(LEN=*), INTENT(IN) :: filename    ! Archivo de datos
		REAL(8), INTENT(IN) :: Tiempo_limite        ! Tiempo límite de ejecución
		INTEGER, INTENT(IN) :: G, T                 ! Parámetros AG
		REAL(8), INTENT(IN) :: PC, PM               ! Probabilidades de cruce y mutación
		INTEGER, INTENT(IN) :: Reps                 ! Número de repeticiones
		
		REAL(8), INTENT(OUT) :: Mejor_Absoluto      ! Mejor resultado de todas las ejecuciones
		REAL(8), INTENT(OUT) :: Media_Absoluta      ! Media de los mejores resultados

		INTEGER :: rep
		INTEGER, ALLOCATABLE :: Mejor_Individuo(:), Mejor_Global(:)
		REAL(8) :: tiempo_inicio, tiempo_fin
		REAL(8), ALLOCATABLE :: resultados(:), tiempos(:)
		REAL(8) :: suma, suma_cuadrados, mejor_rep, tiempo_promedio
		
		! --- Inicialización ---
		ALLOCATE(resultados(Reps), tiempos(Reps), Mejor_Global(m))
		resultados = 0.0D0
		tiempos = 0.0D0
		Mejor_Absoluto = -HUGE(1.0D0)
		
		! 1. Leer datos del problema
		CALL Leer_Datos_MDP(filename)
		
		! 2. Mostrar cabecera
		WRITE(*,*) ""
		WRITE(*,*) "=============================================================="
		WRITE(*,*) "EVALUACION DE ALGORITMO GENETICO POR TIEMPO"
		WRITE(*,*) "=============================================================="
		WRITE(*,*) "Instancia: ", TRIM(filename)
		WRITE(*,*) "n = ", n, ", m = ", m
		WRITE(*,*) "Tiempo limite: ", Tiempo_limite, " segundos"
		WRITE(*,*) "Parametros AG: G=", G, ", T=", T, ", PC=", PC, ", PM=", PM
		WRITE(*,*) "Repeticiones: ", Reps
		WRITE(*,*) "=============================================================="
		WRITE(*,*) ""
		WRITE(*,'(A10, A12, A15)') "Replica", "Tiempo(s)", "Mejor Fitness"
		WRITE(*,*) "--------------------------------------------------------------"
		
		! 3. Ejecutar múltiples repeticiones
		suma = 0.0D0
		suma_cuadrados = 0.0D0
		
		DO rep = 1, Reps
			! Inicializar semilla aleatoria
			CALL init_random_seed()
			
			! Medir tiempo
			CALL CPU_TIME(tiempo_inicio)
			
			! Ejecutar algoritmo genético
			CALL Algoritmo_Genetico_Tiempo(Tiempo_limite, G, T, PC, PM, &
										   Mejor_Individuo, mejor_rep)
			
			CALL CPU_TIME(tiempo_fin)
			
			! Almacenar resultados
			resultados(rep) = mejor_rep
			tiempos(rep) = tiempo_fin - tiempo_inicio
			suma = suma + mejor_rep
			suma_cuadrados = suma_cuadrados + mejor_rep**2
			
			! Actualizar mejor absoluto
			IF (mejor_rep > Mejor_Absoluto) THEN
				Mejor_Absoluto = mejor_rep
				Mejor_Global = Mejor_Individuo
			END IF
			
			! Mostrar progreso
			WRITE(*,'(I10, F12.3, F15.5)') rep, tiempos(rep), mejor_rep
			
			DEALLOCATE(Mejor_Individuo)
		END DO
		
		! 4. Calcular estadísticas
		Media_Absoluta = suma / REAL(Reps, 8)
		tiempo_promedio = SUM(tiempos) / REAL(Reps, 8)
		
		! 5. Mostrar resultados finales
		WRITE(*,*) "=============================================================="
		WRITE(*,*) "RESULTADOS FINALES"
		WRITE(*,*) "=============================================================="
		WRITE(*,'(A, F15.5)') "Mejor resultado absoluto: ", Mejor_Absoluto
		WRITE(*,'(A, F15.5)') "Media de los mejores:     ", Media_Absoluta
		WRITE(*,'(A, F15.3)') "Tiempo promedio (s):     ", tiempo_promedio
		WRITE(*,'(A, F15.3)') "Tiempo total (s):        ", SUM(tiempos)
		WRITE(*,*) "=============================================================="
		
		DEALLOCATE(resultados, tiempos, Mejor_Global)
		
	END SUBROUTINE Evaluar_AG_Tiempo


	! ========== SUBRUTINA 16: Calibracion CONJUNTA PM Y PC ==========
	SUBROUTINE Calibrar_PM_PC(filename, ParametrosPM, ParametrosPC, num_pm, num_pc, T, G, Repeticiones)
		USE Params_MDP
		IMPLICIT NONE
			CHARACTER(LEN=*), INTENT(IN) :: filename
		REAL(8), DIMENSION(:), INTENT(IN) :: ParametrosPM
		REAL(8), DIMENSION(:), INTENT(IN) :: ParametrosPC
		INTEGER, INTENT(IN) :: num_pm, num_pc
		INTEGER, INTENT(IN) :: T, G, Repeticiones
		
		INTEGER :: i, j, rep
		REAL(8) :: PM_actual, PC_actual, Mejor_A_temp, Mejor_A_suma, Mejor_A_media
		INTEGER, ALLOCATABLE :: Mejor_I_temp(:)
		REAL(8) :: tiempo_inicio, tiempo_fin
		REAL(8), ALLOCATABLE :: Resultados(:,:), Tiempos(:,:)
		INTEGER :: mejor_pm_idx, mejor_pc_idx
		REAL(8) :: mejor_valor, mejor_tiempo
		CHARACTER(LEN=200) :: linea_separador
		
		! 1. Leer los datos
		CALL Leer_Datos_MDP(filename)
		
		! 2. Verificar que num_pm y num_pc coinciden con los tamaños de arrays
		IF (SIZE(ParametrosPM) /= num_pm) THEN
			WRITE(*,*) 'ERROR: num_pm no coincide con tamaño de ParametrosPM'
			WRITE(*,*) 'num_pm =', num_pm, ' pero SIZE(ParametrosPM) =', SIZE(ParametrosPM)
			RETURN
		END IF
		
		IF (SIZE(ParametrosPC) /= num_pc) THEN
			WRITE(*,*) 'ERROR: num_pc no coincide con tamaño de ParametrosPC'
			WRITE(*,*) 'num_pc =', num_pc, ' pero SIZE(ParametrosPC) =', SIZE(ParametrosPC)
			RETURN
		END IF
		
		! 3. Cabecera informativa
		linea_separador = '========================================================='
		WRITE(*, *) ''
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) '=== CALIBRACION CONJUNTA PM (MUTACION) y PC (CRUCE) ==='
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) ''
		
		! Mostrar información de la instancia
		WRITE(*, *) 'INSTANCIA ACTUAL:'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, '(A, A)') 'Archivo: ', TRIM(filename)
		WRITE(*, '(A, I6)') 'N (nodos totales): ', n
		WRITE(*, '(A, I6)') 'M (nodos a seleccionar): ', m
		WRITE(*, *) ''
		
		WRITE(*, *) 'PARAMETROS DE CALIBRACION:'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, '(A, I6)') 'Tamano de la Poblacion (T):', T
		WRITE(*, '(A, I6)') 'Generaciones por Prueba (G):', G
		WRITE(*, '(A, I6)') 'Repeticiones por combinacion:', Repeticiones
		WRITE(*, *) ''
		
		! Mostrar rangos de valores a probar
		WRITE(*, *) 'RANGOS DE HIPERPARAMETROS A PROBAR:'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, '(A, I2, A)') 'Valores de PM (Mutacion): ', num_pm, ' valores'
		WRITE(*, '(10F8.3)') ParametrosPM
		WRITE(*, *) ''
		WRITE(*, '(A, I2, A)') 'Valores de PC (Cruce):    ', num_pc, ' valores'
		WRITE(*, '(10F8.3)') ParametrosPC
		WRITE(*, *) ''
		WRITE(*, *) 'Total de combinaciones a evaluar: ', num_pm * num_pc
		WRITE(*, *) 'Total de ejecuciones: ', num_pm * num_pc * Repeticiones
		WRITE(*, *) ''
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) ''
		
		! 4. Inicializar matrices para resultados
		ALLOCATE(Resultados(num_pm, num_pc))
		ALLOCATE(Tiempos(num_pm, num_pc))
		ALLOCATE(Mejor_I_temp(m))
		
		Resultados = 0.0_8
		Tiempos = 0.0_8
		
		! 5. Mostrar cabecera de progreso
		WRITE(*, *) 'PROGRESO DE LA CALIBRACION:'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, *) '(Para instancia: ' // TRIM(filename) // ')'
		WRITE(*, *) ''
		WRITE(*, '(A12, A10, A20, A15)') 'Combinacion', 'PM/PC', 'Fitness Promedio', 'Tiempo Medio'
		WRITE(*, '(A12, A10, A20, A15)') '-----------', '-----', '----------------', '------------'
		
		! 6. Bucle sobre todas las combinaciones PM x PC
		DO i = 1, num_pm
			PM_actual = ParametrosPM(i)
			
			DO j = 1, num_pc
				PC_actual = ParametrosPC(j)
				Mejor_A_suma = 0.0_8
				
				CALL CPU_TIME(tiempo_inicio)
				
				! Ejecutar el algoritmo con repeticiones
				DO rep = 1, Repeticiones
					CALL init_random_seed()
					CALL Algoritmo_Genetico_Generaciones(G, T, PC_actual, PM_actual, &
														Mejor_I_temp, Mejor_A_temp)
					Mejor_A_suma = Mejor_A_suma + Mejor_A_temp
				END DO
				
				CALL CPU_TIME(tiempo_fin)
				
				! Guardar resultados
				Mejor_A_media = Mejor_A_suma / REAL(Repeticiones, 8)
				Resultados(i,j) = Mejor_A_media
				Tiempos(i,j) = (tiempo_fin - tiempo_inicio) / REAL(Repeticiones, 8)
				
				! Mostrar progreso
				WRITE(*, '(I3, A1, I3, A2, F6.3, A1, F6.3, A2, F16.6, A4, F8.3, A)') &
					i, '-', j, ' (', PM_actual, ',', PC_actual, ')', &
					Mejor_A_media, '  [', Tiempos(i,j), 's]'
			END DO
			WRITE(*, *) '---'
		END DO
		
		! 7. Encontrar la mejor combinación
		mejor_valor = MAXVAL(Resultados)
		mejor_pm_idx = 0
		mejor_pc_idx = 0
		
		DO i = 1, num_pm
			DO j = 1, num_pc
				IF (ABS(Resultados(i,j) - mejor_valor) < 1.0E-6) THEN
					mejor_pm_idx = i
					mejor_pc_idx = j
					mejor_tiempo = Tiempos(i,j)
					EXIT
				END IF
			END DO
			IF (mejor_pm_idx /= 0) EXIT
		END DO
		
		! 8. Mostrar resultados finales
		WRITE(*, *) ''
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) 'RESULTADOS FINALES DE CALIBRACION'
		WRITE(*, *) 'Para instancia: ' // TRIM(filename)
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) ''
		
		! 9. Mostrar resultados individuales
		WRITE(*, *) 'RESULTADOS POR COMBINACION:'
		WRITE(*, *) '---------------------------------------------------------'
		
		DO i = 1, num_pm
			DO j = 1, num_pc
				IF (i == mejor_pm_idx .AND. j == mejor_pc_idx) THEN
					WRITE(*, '(A, F6.3, A, F6.3, A, F16.6, A, F8.3, A)') &
						'>>> PM=', ParametrosPM(i), ', PC=', ParametrosPC(j), &
						' | Fitness=', Resultados(i,j), ' | Tiempo=', Tiempos(i,j), ' s <<<'
				ELSE
					WRITE(*, '(A, F6.3, A, F6.3, A, F16.6, A, F8.3, A)') &
						'    PM=', ParametrosPM(i), ', PC=', ParametrosPC(j), &
						' | Fitness=', Resultados(i,j), ' | Tiempo=', Tiempos(i,j), ' s'
				END IF
			END DO
		END DO
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, *) ''
		
		! 10. Mostrar la mejor combinación de forma simple
		WRITE(*, *) 'MEJOR COMBINACION ENCONTRADA:'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, '(A, F6.3)') 'Probabilidad de Mutacion (PM): ', ParametrosPM(mejor_pm_idx)
		WRITE(*, '(A, F6.3)') 'Probabilidad de Cruce (PC):    ', ParametrosPC(mejor_pc_idx)
		WRITE(*, '(A, F18.6)') 'Fitness promedio:              ', mejor_valor
		WRITE(*, '(A, F8.3, A)') 'Tiempo medio por ejecucion:    ', mejor_tiempo, ' segundos'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, *) ''
		
		! 11. Resumen estadístico
		WRITE(*, *) 'RESUMEN ESTADISTICO:'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, '(A, F18.6)') 'Mejor fitness encontrado:  ', mejor_valor
		WRITE(*, '(A, F18.6)') 'Peor fitness encontrado:   ', MINVAL(Resultados)
		WRITE(*, '(A, F18.6)') 'Fitness promedio global:   ', SUM(Resultados)/SIZE(Resultados)
		WRITE(*, '(A, F18.6)') 'Rango (mejor - peor):      ', mejor_valor - MINVAL(Resultados)
		WRITE(*, *) ''
		
		! 12. Análisis de tiempo
		WRITE(*, *) 'ANALISIS DE TIEMPOS:'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, '(A, F8.3, A)') 'Tiempo mas rapido:        ', MINVAL(Tiempos), ' s'
		WRITE(*, '(A, F8.3, A)') 'Tiempo mas lento:         ', MAXVAL(Tiempos), ' s'
		WRITE(*, '(A, F8.3, A)') 'Tiempo promedio:          ', SUM(Tiempos)/SIZE(Tiempos), ' s'
		WRITE(*, *) ''
		
		! 13. Recomendación final simple
		WRITE(*, *) 'RECOMENDACION FINAL:'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, '(A, A)') 'Para la instancia: ', TRIM(filename)
		WRITE(*, '(A, F6.3, A, F6.3)') 'Se recomienda usar: PM = ', ParametrosPM(mejor_pm_idx), &
									   ', PC = ', ParametrosPC(mejor_pc_idx)
		WRITE(*, '(A, F16.6)') 'Fitness esperado: ', mejor_valor
		WRITE(*, '(A, F8.3, A)') 'Tiempo estimado por ejecucion: ', mejor_tiempo, ' s'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, *) ''
		
		! 14. Liberar memoria
		DEALLOCATE(Resultados, Tiempos, Mejor_I_temp)
		
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) 'Calibracion conjunta PM-PC completada.'
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) ''
		
	END SUBROUTINE Calibrar_PM_PC


	! ========== SUBRUTINA 16: Resultados de AG despues de las calibraciones ==========
	SUBROUTINE Resultados(filename, T_FINAL, G_FINAL, PC_FINAL, PM_FINAL, &
						  repeticiones, mejor_fitness, fitness_promedio, &
						  mejor_solucion, tiempo_promedio)
		USE Params_MDP
		IMPLICIT NONE
		
		! Parámetros de entrada
		CHARACTER(LEN=*), INTENT(IN) :: filename
		INTEGER, INTENT(IN) :: T_FINAL, G_FINAL, repeticiones
		REAL(8), INTENT(IN) :: PC_FINAL, PM_FINAL
		
		! Resultados de salida
		REAL(8), INTENT(OUT) :: mejor_fitness, fitness_promedio, tiempo_promedio
		INTEGER, ALLOCATABLE, INTENT(OUT) :: mejor_solucion(:)
		
		! Variables locales
		INTEGER :: rep, i
		REAL(8) :: fitness_actual, suma_fitness, suma_tiempo
		INTEGER, ALLOCATABLE :: solucion_actual(:)
		REAL(8) :: tiempo_inicio, tiempo_fin
		CHARACTER(LEN=200) :: linea_separador
		
		! 1. Leer los datos del archivo
		CALL Leer_Datos_MDP(filename)
		
		! 2. Inicializar variables
		linea_separador = '========================================================='
		
		ALLOCATE(solucion_actual(m))
		ALLOCATE(mejor_solucion(m))
		
		mejor_fitness = -HUGE(1.0_8)  ! Inicializar con valor muy bajo
		suma_fitness = 0.0_8
		suma_tiempo = 0.0_8
		
		! 3. Mostrar cabecera
		WRITE(*, *) ''
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) '=== EJECUCION MULTIPLE DEL ALGORITMO GENETICO ==='
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) ''
		WRITE(*, '(A, A)') 'Archivo: ', TRIM(filename)
		WRITE(*, '(A, I6, A, I6)') 'Dimensiones: N = ', n, ', M = ', m
		WRITE(*, *) ''
		WRITE(*, *) 'PARAMETROS OPTIMOS UTILIZADOS:'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, '(A, I6)') 'Tamano Poblacion (T): ', T_FINAL
		WRITE(*, '(A, I6)') 'Generaciones (G):     ', G_FINAL
		WRITE(*, '(A, F6.3)') 'Prob. Cruce (PC):     ', PC_FINAL
		WRITE(*, '(A, F6.3)') 'Prob. MutaciOn (PM):  ', PM_FINAL
		WRITE(*, '(A, I4)') 'Repeticiones:         ', repeticiones
		WRITE(*, *) ''
		WRITE(*, *) 'PROGRESO DE LAS EJECUCIONES:'
		WRITE(*, *) '---------------------------------------------------------'
		
		! 4. Bucle de repeticiones
		DO rep = 1, repeticiones
			WRITE(*, *) rep
			! Inicializar semilla aleatoria diferente para cada ejecución
			CALL init_random_seed()
			
			! Medir tiempo de ejecución
			CALL CPU_TIME(tiempo_inicio)
			
			! Ejecutar algoritmo genético
			CALL Algoritmo_Genetico_Generaciones(G_FINAL, T_FINAL, PC_FINAL, &
												PM_FINAL, solucion_actual, &
												fitness_actual)
			
			CALL CPU_TIME(tiempo_fin)
			
			! Actualizar estadísticas
			suma_fitness = suma_fitness + fitness_actual
			suma_tiempo = suma_tiempo + (tiempo_fin - tiempo_inicio)
			
			! Verificar si es la mejor solución encontrada
			IF (fitness_actual > mejor_fitness) THEN
				mejor_fitness = fitness_actual
				mejor_solucion = solucion_actual
			END IF
			
			! Mostrar progreso
			WRITE(*, '(I3, A, F18.6, A, F8.3, A)') &
				rep, ' - Fitness: ', fitness_actual, &
				' | Tiempo: ', tiempo_fin - tiempo_inicio, ' s'
		END DO
		
		! 5. Calcular promedios
		fitness_promedio = suma_fitness / REAL(repeticiones, 8)
		tiempo_promedio = suma_tiempo / REAL(repeticiones, 8)
		
		! 6. Mostrar resultados finales
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, *) ''
		WRITE(*, *) 'RESULTADOS FINALES:'
		WRITE(*, *) '---------------------------------------------------------'
		WRITE(*, '(A, F18.6)') 'Mejor fitness encontrado:  ', mejor_fitness
		WRITE(*, '(A, F18.6)') 'Fitness promedio:          ', fitness_promedio
		WRITE(*, '(A, F8.3, A)') 'Tiempo promedio por ejecucion: ', tiempo_promedio, ' s'
		WRITE(*, '(A, F8.3, A)') 'Tiempo total:                ', suma_tiempo, ' s'
		WRITE(*, *) ''
		
		! 8. Liberar memoria local
		DEALLOCATE(solucion_actual)
		
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) 'Ejecucion multiple completada.'
		WRITE(*, *) TRIM(linea_separador)
		WRITE(*, *) ''
		
	END SUBROUTINE Resultados
END PROGRAM Algoritmo_AG