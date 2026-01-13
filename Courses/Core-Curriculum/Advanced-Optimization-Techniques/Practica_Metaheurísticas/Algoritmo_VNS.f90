!============================== PROGRAMA PRINCIPAL DE ANÁLISIS =============================
MODULE Params_MDP
    IMPLICIT NONE
    
    ! Parámetros de dimensión del problema
    INTEGER :: n   ! Número total de elementos disponibles
    INTEGER :: m   ! Número de elementos a seleccionar (tamaño de la solución)
    
    ! Matriz de distancias
    REAL(8), ALLOCATABLE :: D(:,:)  ! Matriz de distancias (Diversidad)
	REAL(8), PARAMETER :: TOL = 1.0D-8 
    
    ! --- Variables para control de número aleatorio ---
END MODULE Params_MDP


PROGRAM Algoritmo_BEV

    USE Params_MDP
    IMPLICIT NONE
    
    !INTEGER, PARAMETER :: SEED_SIZE = 8
    !INTEGER :: RND_SEED(SEED_SIZE)
    
      ! --- Definir vectores separados para cada configuración ---
    REAL(8) :: P1(2), P2(2), P3(3), P4(3)
    
    ! --- Parámetros fijos ---
    INTEGER :: REP_FIJAS = 3
    INTEGER, PARAMETER :: Max_IC = 15      ! Iteraciones máximas
    INTEGER, PARAMETER :: Max_SMC = 8
	REAL(8) :: mejor_fitness, fitness_promedio, tiempo_promedio, Mejor_Absoluto, Media_Absoluta

    
 
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
    
		! Configuraciones para k_max = 2 (2 niveles de perturbación)
	P1 = [0.10_8, 0.25_8] 
	P2 = [0.15_8, 0.35_8]  

	! Configuraciones para k_max = 3 (3 niveles de perturbación)
	P3 = [0.08_8, 0.20_8, 0.40_8]  
	P4 = [0.12_8, 0.25_8, 0.50_8]  

	!Calibracion nivel de perturbacion 
    !ALL Calibracion_K(Archivo1, P1, P2, P3, P4, Max_IC, Max_SMC, REP_FIJAS)
    !CALL Calibracion_K(Archivo2, P1, P2, P3, P4, Max_IC, Max_SMC, REP_FIJAS)
    !CALL Calibracion_K(Archivo3, P1, P2, P3, P4, Max_IC, Max_SMC,  REP_FIJAS)
    !CALL Calibracion_K(Archivo4, P1, P2, P3, P4, Max_IC, Max_SMC, REP_FIJAS)
    !CALL Calibracion_K(Archivo5, P1, P2, P3, P4, Max_IC, Max_SMC, REP_FIJAS)
    !CALL Calibracion_K(Archivo6, P1, P2, P3, P4, Max_IC, Max_SMC, REP_FIJAS)
    !CALL Calibracion_K(Archivo7, P1, P2, P3, P4, Max_IC, Max_SMC, REP_FIJAS)
    !CALL Calibracion_K(Archivo8, P1, P2, P3, P4, Max_IC, Max_SMC, REP_FIJAS)
	!CALL Calibracion_K(Archivo9, P1, P2, P3, P4, Max_IC, Max_SMC, REP_FIJAS)
    !CALL Calibracion_K(Archivo10, P1, P2, P3, P4, Max_IC, Max_SMC, REP_FIJAS)
	
	!Resulatdos del conjunto de test
!	CALL Resultados(ArchivoR1, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)
					
!	CALL Resultados(ArchivoR2, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR3, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR4, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR5, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR6, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR7, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR8, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR9, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR10, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR12, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR13, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR14, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR15, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR16, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)

!	CALL Resultados(ArchivoR17, 5, P2, REP_FIJAS, mejor_fitness, fitness_promedio, &
!					tiempo_promedio, Max_IC, Max_SMC)


!Parar el algoritmo por tiempo Cambiar 30 por 60 
! CALL Evaluar_VNS_Tiempo(ArchivoR1, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)   

! CALL Evaluar_VNS_Tiempo(ArchivoR2, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)   

 !CALL Evaluar_VNS_Tiempo(ArchivoR3, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta) 
  
! CALL Evaluar_VNS_Tiempo(ArchivoR4, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)  
 
! CALL Evaluar_VNS_Tiempo(ArchivoR5, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)  
 
! CALL Evaluar_VNS_Tiempo(ArchivoR5, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta) 
  
! CALL Evaluar_VNS_Tiempo(ArchivoR6, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)  
 
! CALL Evaluar_VNS_Tiempo(ArchivoR7, 30.0_8, 3, P4, &
 !                            Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)  
 
 !CALL Evaluar_VNS_Tiempo(ArchivoR8, 30.0_8, 3, P4, &
 !                            Max_IC , Max_SMC, 3, &
 !                            Mejor_Absoluto, Media_Absoluta) 
 
 !CALL Evaluar_VNS_Tiempo(ArchivoR9, 30.0_8, 3, P4, &
 !                            Max_IC , Max_SMC, 3, &
 !                            Mejor_Absoluto, Media_Absoluta) 
 
!CALL Evaluar_VNS_Tiempo(ArchivoR10, 60.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)   

! CALL Evaluar_VNS_Tiempo(ArchivoR11, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta) 
  
! CALL Evaluar_VNS_Tiempo(ArchivoR12, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)  
 
! CALL Evaluar_VNS_Tiempo(ArchivoR13, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta) 
  
! CALL Evaluar_VNS_Tiempo(ArchivoR14, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta) 
  
! CALL Evaluar_VNS_Tiempo(ArchivoR15, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
   
! CALL Evaluar_VNS_Tiempo(ArchivoR16, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)   

! CALL Evaluar_VNS_Tiempo(ArchivoR17, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta) 
  
! CALL Evaluar_VNS_Tiempo(ArchivoR18, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)
   
! CALL Evaluar_VNS_Tiempo(ArchivoR19, 30.0_8, 3, P4, &
!                             Max_IC , Max_SMC, 3, &
!                             Mejor_Absoluto, Media_Absoluta)   

    CONTAINS
        
		!===== SUBRUTINA 0
		SUBROUTINE init_random_seed()
			IMPLICIT NONE
			INTEGER :: i, n_seed, clock
			INTEGER, ALLOCATABLE :: seed(:)
			
			CALL RANDOM_SEED(SIZE = n_seed)
			ALLOCATE(seed(n_seed))
			
			CALL SYSTEM_CLOCK(COUNT=clock)
			seed = clock + 37 * (/ (i - 1, i = 1, n_seed) /)
			CALL RANDOM_SEED(PUT = seed)
			
			DEALLOCATE(seed)
		END SUBROUTINE init_random_seed
		

		!===== SUBRUTINA 1: Lectura de datos ====
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
            D = 0.0_8
            DO 
                READ(10, *, IOSTAT=status) i, j, d_val
                IF (status /= 0) EXIT 

                D(i + 1, j + 1) = d_val
                D(j + 1, i + 1) = d_val
            END DO
            
            CLOSE(10)
        END SUBROUTINE Leer_Datos_MDP


		!===== SUBRUTINA 2: Busqueda en entorno variable ====
		SUBROUTINE VNS_General(K_max, Frac_Perturbacion, Max_Iteraciones, Max_Sin_Mejora, Iteraciones, Mejor_Z)
			USE Params_MDP
			IMPLICIT NONE

			REAL(8), INTENT(OUT) :: Mejor_Z
			INTEGER, INTENT(OUT) :: Iteraciones

			INTEGER, INTENT(IN) :: K_max
			REAL(8), DIMENSION(K_max), INTENT(IN) :: Frac_Perturbacion 
			INTEGER, INTENT(IN) :: Max_Iteraciones, Max_Sin_Mejora

			INTEGER :: mloc, k_shake_actual, k_vns, iter_sin_mejora
			INTEGER, ALLOCATABLE :: S_global(:), S_local(:), S_temp_vnd(:)   
			REAL(8) :: z_global, z_vnd_init, z_vnd_final, z_anterior
			LOGICAL :: hubo_mejora

			mloc = m

			! Construir solución inicial
			CALL Construir_Solucion_Inicial(S_global, z_global)
			z_anterior = z_global
			ALLOCATE(S_local(mloc), S_temp_vnd(mloc))
			
			! Mejora inicial con VND
			z_vnd_init = z_global
			CALL VND(S_global, S_local, z_vnd_init, z_global) 
			S_global = S_local
			
			! Inicializar contadores
			Iteraciones = 0
			iter_sin_mejora = 0
			hubo_mejora = .TRUE.  
			
			! Bucle principal VNS por iteraciones
			DO WHILE (Iteraciones < Max_Iteraciones .AND. iter_sin_mejora < Max_Sin_Mejora)
				k_vns = 1 
				hubo_mejora = .FALSE.
				DO WHILE (k_vns <= K_max)
					! Perturbación
					k_shake_actual = MAX(1, INT(Frac_Perturbacion(k_vns) * REAL(mloc, 8)))
					CALL Perturbacion_kSwap(S_global, S_local, k_shake_actual)
					
					! Búsqueda local VND
					z_vnd_init = Calcular_Diversidad(S_local)
					CALL VND(S_local, S_temp_vnd, z_vnd_init, z_vnd_final) 
					
					! Criterio de aceptación
					IF (z_vnd_final > z_global + 1.0d-8) THEN
						S_global = S_temp_vnd
						z_global = z_vnd_final
						k_vns = 1  ! Reiniciar a primera perturbación
						hubo_mejora = .TRUE.
					ELSE
						k_vns = k_vns + 1  ! Siguiente nivel de perturbación
					END IF
				END DO		
				Iteraciones = Iteraciones + 1
				! Actualizar contador de convergencia
				IF (hubo_mejora) THEN
					iter_sin_mejora = 0  ! Resetear si hubo mejora
				ELSE
					iter_sin_mejora = iter_sin_mejora + 1
				END IF
				
				! También verificar mejora respecto a iteración anterior
				IF (ABS(z_global - z_anterior) < 1.0d-8) THEN
					! No hubo mejora significativa
				ELSE
					z_anterior = z_global
				END IF
				
			END DO

			Mejor_Z = z_global
			
			! Liberar memoria
			IF (ALLOCATED(S_global)) DEALLOCATE(S_global)
			IF (ALLOCATED(S_local)) DEALLOCATE(S_local)
			IF (ALLOCATED(S_temp_vnd)) DEALLOCATE(S_temp_vnd)
			
		END SUBROUTINE VNS_General


 
		!===== SUBRUTINA 3: Constructor Greddy ====
		SUBROUTINE Greedy_Con(p1, P, z)
			USE Params_MDP
			IMPLICIT NONE
			
			INTEGER, INTENT(IN) :: p1
			INTEGER, ALLOCATABLE, INTENT(OUT) :: P(:)
			REAL(8), INTENT(OUT) :: z
			
			INTEGER :: i, t, k, p1_local
			REAL(8), ALLOCATABLE :: G(:)
			LOGICAL, ALLOCATABLE :: seleccionado(:)
			INTEGER, ALLOCATABLE :: indices_no_seleccionados(:)
			INTEGER :: num_no_seleccionados
			
			ALLOCATE(P(m), G(n), seleccionado(n))
			ALLOCATE(indices_no_seleccionados(n))
			
			! Inicialización
			P = 0
			seleccionado = .FALSE.
			p1_local = MIN(MAX(p1, 1), n)
			
			P(1) = p1_local
			seleccionado(p1_local) = .TRUE.
			
			! Lista de elementos no seleccionados
			num_no_seleccionados = 0
			DO i = 1, n
				IF (.NOT. seleccionado(i)) THEN
					num_no_seleccionados = num_no_seleccionados + 1
					indices_no_seleccionados(num_no_seleccionados) = i
				END IF
			END DO
			
			! Ganancias iniciales
			DO i = 1, num_no_seleccionados
				G(indices_no_seleccionados(i)) = D(p1_local, indices_no_seleccionados(i))
			END DO
			
			z = 0.0D0
			
			! Bucle greedy
			DO t = 2, m
				! Encontrar máximo usando lista reducida
				k = indices_no_seleccionados(1)
				DO i = 2, num_no_seleccionados
					IF (G(indices_no_seleccionados(i)) > G(k)) THEN
						k = indices_no_seleccionados(i)
					END IF
				END DO
				
				P(t) = k
				seleccionado(k) = .TRUE.
				z = z + G(k)
				
				! Actualizar lista de no seleccionados
				DO i = 1, num_no_seleccionados
					IF (indices_no_seleccionados(i) == k) THEN
						indices_no_seleccionados(i) = indices_no_seleccionados(num_no_seleccionados)
						EXIT
					END IF
				END DO
				num_no_seleccionados = num_no_seleccionados - 1
				
				! Actualizar ganancias
				DO i = 1, num_no_seleccionados
					G(indices_no_seleccionados(i)) = G(indices_no_seleccionados(i)) + D(k, indices_no_seleccionados(i))
				END DO
			END DO
		
			! Calcular valor exacto
			z = Calcular_Diversidad(P)
		
			DEALLOCATE(G, seleccionado, indices_no_seleccionados)
		
		END SUBROUTINE Greedy_Con
		

		!===== SUBRUTINA 4: Construir Solucion inicial con Greddy ====
		SUBROUTINE Construir_Solucion_Inicial(S_out, z_out)
			USE Params_MDP
			IMPLICIT NONE
			
			! --- Argumentos ---
			INTEGER, ALLOCATABLE, INTENT(OUT) :: S_out(:)  ! Solución construída
			REAL(8), INTENT(OUT) :: z_out                  ! Valor de la solución (diversidad)
			
			! --- Variables locales ---
			INTEGER :: semilla_aleatoria
			REAL(8) :: r
			
			! --- Inicializar array de salida ---
			ALLOCATE(S_out(m))
			
			! --- Generar semilla aleatoria entre 1 y n ---
			CALL RANDOM_NUMBER(r)
			semilla_aleatoria = INT(r * n) + 1
			
			! Asegurarse de que esté en el rango correcto
			IF (semilla_aleatoria < 1) semilla_aleatoria = 1
			IF (semilla_aleatoria > n) semilla_aleatoria = n
			
			! --- Llamar al constructor greedy con la semilla aleatoria ---
			CALL Greedy_Con(semilla_aleatoria, S_out, z_out)
			   
		END SUBROUTINE Construir_Solucion_Inicial


		!===== SUBRUTINA 5: Busqueda descendente ====
		SUBROUTINE VND (S_in, S_out, z_in, z_out)
			USE Params_MDP
			IMPLICIT NONE
			
			INTEGER, INTENT(IN) :: S_in(m)
			INTEGER, INTENT(OUT) :: S_out(m)
			REAL(8), INTENT(IN) :: z_in
			REAL(8), INTENT(OUT) :: z_out
			
			INTEGER, ALLOCATABLE :: S_actual(:)
			REAL(8) :: z_actual
			INTEGER :: k, iteraciones, max_iteraciones_vnd
			INTEGER, PARAMETER :: k_max = 2
			LOGICAL :: mejoro, hubo_mejora_global
			INTEGER :: intentos_sin_mejora
			
			ALLOCATE(S_actual(m))
			S_actual = S_in
			z_actual = z_in
			
			! Inicializaciones
			iteraciones = 0
			hubo_mejora_global = .TRUE.
			intentos_sin_mejora = 0
			max_iteraciones_vnd = 50  ! Límite para evitar bucles muy largos
			
			! Bucle principal VND 
			DO WHILE (hubo_mejora_global .AND. intentos_sin_mejora < 3 .AND. iteraciones < max_iteraciones_vnd)
				hubo_mejora_global = .FALSE.
				k = 1
				
				DO WHILE (k <= k_max)
					mejoro = .FALSE.
					
					! Llamar a búsqueda local con límites estrictos
					SELECT CASE (k)
						CASE (1)
							CALL Busqueda_Local_E1_PM(S_actual, z_actual, mejoro)
						CASE (2)
							CALL Busqueda_Local_E2_PM(S_actual, z_actual, mejoro)
					END SELECT
					
					iteraciones = iteraciones + 1
					
					IF (mejoro) THEN
						! Se encontró mejora en vecindad k
						hubo_mejora_global = .TRUE.
						intentos_sin_mejora = 0  ! Resetear contador
						k = 1  ! Resetear a primera vecindad
						EXIT
					ELSE
						! No hubo mejora, pasar a siguiente vecindad
						k = k + 1
					END IF
				END DO
				
				! Si no hubo mejora en ningún vecindario, incrementar contador
				IF (.NOT. hubo_mejora_global) THEN
					intentos_sin_mejora = intentos_sin_mejora + 1
				END IF
			END DO
			
			! Asignar resultados
			S_out = S_actual
			z_out = z_actual
			
			DEALLOCATE(S_actual)
			
		END SUBROUTINE VND


		!===== SUBRUTINA 6: Busqueda local en E1 ====
		SUBROUTINE Busqueda_Local_E1_PM(S_actual, z_actual, mejoro)
			USE Params_MDP
			IMPLICIT NONE
			INTEGER, INTENT(INOUT) :: S_actual(m)
			REAL(8), INTENT(INOUT) :: z_actual
			LOGICAL, INTENT(OUT) :: mejoro
			
			INTEGER :: i_in, j_out, Node_drop, Node_add
			REAL(8) :: Delta_Z
			LOGICAL, ALLOCATABLE :: S_mask(:)
			INTEGER, ALLOCATABLE :: Fuera(:)
			INTEGER :: nf, idx_mejor_out
			REAL(8) :: mejor_delta
			
			mejoro = .FALSE.

			! 1. Crear máscara y lista de nodos fuera 
			ALLOCATE(S_mask(n), Fuera(n-m))
			S_mask = .FALSE. 
			S_mask(S_actual) = .TRUE.
			
			! Precalcular lista de nodos fuera
			nf = 0
			DO j_out = 1, n
				IF (.NOT. S_mask(j_out)) THEN
					nf = nf + 1
					Fuera(nf) = j_out
				END IF
			END DO

			DO i_in = 1, m 
				Node_drop = S_actual(i_in)
				mejor_delta = 0.0d0
				idx_mejor_out = 0
				
				DO j_out = 1, nf
					Node_add = Fuera(j_out)
					
					! Calcular el cambio en la diversidad
					Delta_Z = Calculo_Delta_E1(S_actual, Node_drop, Node_add)
					
					IF (Delta_Z > mejor_delta + 1.0d-8) THEN
						mejor_delta = Delta_Z
						idx_mejor_out = j_out
					END IF
				END DO
				
				! Si encontramos mejora, aplicarla y salir
				IF (mejor_delta > 1.0d-8) THEN
					Node_add = Fuera(idx_mejor_out)
					
					! Aceptar movimiento
					S_actual(i_in) = Node_add
					S_mask(Node_drop) = .FALSE.
					S_mask(Node_add) = .TRUE.
					
					! Actualizar lista Fuera
					Fuera(idx_mejor_out) = Node_drop
					
					z_actual = z_actual + mejor_delta
					mejoro = .TRUE.
					
					DEALLOCATE(S_mask, Fuera)
					RETURN
				END IF
			END DO
			
			DEALLOCATE(S_mask, Fuera)
		END SUBROUTINE Busqueda_Local_E1_PM


		!===== SUBRUTINA 7: Busqueda local en E2 ====
		SUBROUTINE Busqueda_Local_E2_PM(S_actual, z_actual, mejoro)
			USE Params_MDP
			IMPLICIT NONE
			
			INTEGER, INTENT(INOUT) :: S_actual(m)
			REAL(8), INTENT(INOUT) :: z_actual
			LOGICAL, INTENT(OUT) :: mejoro

			! Parámetros de Control optimizados
			INTEGER, PARAMETER :: MAX_EVAL = 5000  ! Reducido de 100000 para mayor velocidad
			
			! Variables Locales
			INTEGER :: i1_in, i2_in, p, q, idx_in1, idx_in2, idx_out1, idx_out2
			INTEGER :: drop1, drop2, add1, add2
			INTEGER :: contador_evaluaciones, eval_max_actual
			REAL(8) :: Delta_Z, r
			
			! Arrays Dinámicos
			LOGICAL, ALLOCATABLE :: S_mask(:)
			INTEGER, ALLOCATABLE :: Fuera(:)
			REAL(8), ALLOCATABLE :: contrib(:)

			mejoro = .FALSE.
			contador_evaluaciones = 0
			
			! Usar muestreo para todos los casos - más rápido
			eval_max_actual = MIN(MAX_EVAL, 1000)  ! Más restrictivo

			! --- 1) Construir máscara y lista de nodos fuera ---
			ALLOCATE(S_mask(n), Fuera(MAX(0, n - m)), contrib(n))
			
			! Crear máscara de nodos seleccionados
			S_mask = .FALSE.
			DO i1_in = 1, m
				S_mask(S_actual(i1_in)) = .TRUE.
			END DO

			! Crear lista de nodos FUERA 
			idx_out1 = 0
			DO i1_in = 1, n
				IF (.NOT. S_mask(i1_in)) THEN
					idx_out1 = idx_out1 + 1
					Fuera(idx_out1) = i1_in
				END IF
			END DO

			IF (idx_out1 < 2) THEN
				DEALLOCATE(S_mask, Fuera, contrib)
				RETURN
			END IF

			! --- 2) Calcular contrib(i) para todos i = 1..n ---
			! contrib(i) = sum_{s in S_actual} D(i, s)
			contrib = 0.0d0
			DO i1_in = 1, m
				drop1 = S_actual(i1_in)
				DO i2_in = 1, n
					contrib(i2_in) = contrib(i2_in) + D(i2_in, drop1)
				END DO
			END DO

			! --- 3) Búsqueda usando muestreo aleatorio (siempre) ---
			DO WHILE (contador_evaluaciones < eval_max_actual)
				! Seleccionar dos índices diferentes dentro de S
				CALL RANDOM_NUMBER(r)
				idx_in1 = INT(r * m) + 1
				CALL RANDOM_NUMBER(r)
				idx_in2 = MOD(INT(r * (m-1)), m) + 1
				IF (idx_in2 >= idx_in1) idx_in2 = idx_in2 + 1
				
				drop1 = S_actual(idx_in1)
				drop2 = S_actual(idx_in2)
				
				! Seleccionar dos índices diferentes fuera de S
				CALL RANDOM_NUMBER(r)
				idx_out1 = INT(r * (n - m)) + 1
				CALL RANDOM_NUMBER(r)
				idx_out2 = MOD(INT(r * (n - m - 1)), (n - m)) + 1
				IF (idx_out2 >= idx_out1) idx_out2 = idx_out2 + 1
				
				add1 = Fuera(idx_out1)
				add2 = Fuera(idx_out2)
				
				contador_evaluaciones = contador_evaluaciones + 1
				
				! Cálculo optimizado del delta
				Delta_Z = contrib(add1) + contrib(add2) - contrib(drop1) - contrib(drop2) &
						- ( D(add1,drop1) + D(add1,drop2) + D(add2,drop1) + D(add2,drop2) ) &
						+ D(add1,add2) + D(drop1,drop2)

				IF (Delta_Z > TOL) THEN
					! Aceptar movimiento
					S_actual(idx_in1) = add1
					S_actual(idx_in2) = add2
					z_actual = z_actual + Delta_Z
					mejoro = .TRUE.
					
					! Actualizar contribuciones parcialmente (aproximado, pero más rápido)
					! Podemos omitir esta actualización para ganar velocidad
					DEALLOCATE(S_mask, Fuera, contrib)
					RETURN
				END IF
			END DO

			DEALLOCATE(S_mask, Fuera, contrib)
		END SUBROUTINE Busqueda_Local_E2_PM
	
        
		!===== SUBRUTINA 8: Perturbacion ====
        SUBROUTINE Perturbacion_kSwap(S_in, S_out, k)
            USE Params_MDP
            IMPLICIT NONE
            INTEGER, INTENT(IN) :: S_in(m)
            INTEGER, INTENT(OUT) :: S_out(m)
            INTEGER, INTENT(IN) :: k ! Número de swaps a realizar
            
            INTEGER :: i, idx_in, idx_out, temp, iter
            REAL(8) :: r
            INTEGER :: S_temp(m), pool(n)
            LOGICAL :: S_mask(n)
            
            S_temp = S_in
            
            S_mask = .FALSE. 
            S_mask(S_in) = .TRUE. 
            
            pool = 0
            idx_out = 0
            DO i = 1, n
                IF (.NOT. S_mask(i)) THEN
                    idx_out = idx_out + 1
                    pool(idx_out) = i
                END IF
            END DO
            
            DO iter = 1, k
                ! 1. Seleccionar elemento a salir (de S)
                CALL RANDOM_NUMBER(r)
                idx_in = INT(r * REAL(m, 8)) + 1
                
                ! 2. Seleccionar elemento a entrar (de pool)
                CALL RANDOM_NUMBER(r)
                idx_out = INT(r * REAL(n - m - (iter - 1), 8)) + 1 
                
                ! 3. Realizar swap y actualizar
                temp = S_temp(idx_in) ! Nodo que sale
                S_temp(idx_in) = pool(idx_out) ! Nodo que entra
                
                ! 4. Actualizar pool para el siguiente swap
                pool(idx_out) = temp ! El nodo que salió pasa al pool
                
            END DO
            
            S_out = S_temp
        END SUBROUTINE Perturbacion_kSwap


		!===== SUBRUTINA 9: Calcular diversidad ====
		FUNCTION Calcular_Diversidad(S_in) RESULT(z_div)
			USE Params_MDP
			IMPLICIT NONE
			INTEGER, INTENT(IN) :: S_in(m)
			REAL(8) :: z_div
			INTEGER :: i, j, si, sj
			
			z_div = 0.0D0
			DO i = 1, m-1
				si = S_in(i)
				DO j = i + 1, m
					sj = S_in(j)
					z_div = z_div + D(si, sj)
				END DO
			END DO
		END FUNCTION Calcular_Diversidad
		

		!===== SUBRUTINA 10: Funcion auxiliar 1 ====
		FUNCTION Calculo_Delta_E1(S, nodo_drop, nodo_add) RESULT(delta)
			USE Params_MDP
			IMPLICIT NONE
			INTEGER, INTENT(IN) :: S(m)
			INTEGER, INTENT(IN) :: nodo_drop, nodo_add
			REAL(8) :: delta
			INTEGER :: k, sk
			
			delta = 0.0D0
			DO k = 1, m
				sk = S(k)
				IF (sk /= nodo_drop) THEN
					delta = delta + D(sk, nodo_add) - D(sk, nodo_drop)
				END IF
			END DO
		END FUNCTION Calculo_Delta_E1		
        

		!===== SUBRUTINA 11: Funcion auxiliar 2 ====
        FUNCTION Calculo_Delta_E2(S, drop1, drop2, add1, add2) RESULT(delta)
            USE Params_MDP
            IMPLICIT NONE
            INTEGER, INTENT(IN) :: S(m)
            INTEGER, INTENT(IN) :: drop1, drop2, add1, add2
            REAL(8) :: delta
            INTEGER :: k
            
            delta = 0.0D0
            ! 1. Cambios con elementos existentes en S (O(m))
            DO k = 1, m
                IF (S(k) /= drop1 .AND. S(k) /= drop2) THEN
                    ! Contribución de los nodos salientes
                    delta = delta - D(S(k), drop1) - D(S(k), drop2)
                    ! Contribución de los nodos entrantes
                    delta = delta + D(S(k), add1) + D(S(k), add2)
                END IF
            END DO
            
            ! 2. Contribución de la nueva conexión entre los nodos entrantes (O(1))
            delta = delta + D(add1, add2)
            ! 3. Restar la contribución de la conexión entre los nodos salientes (O(1))
            delta = delta - D(drop1, drop2)
            
        END FUNCTION Calculo_Delta_E2


		!===== SUBRUTINA 12: Calibrar Perturbacion ====
		SUBROUTINE Calibracion_K(filename, P1, P2, P3, P4, Max_Iteraciones, Max_Sin_Mejora, Reps)
			USE Params_MDP
			IMPLICIT NONE
			
			CHARACTER(LEN=*), INTENT(IN) :: filename
			REAL(8), INTENT(IN) :: P1(:), P2(:), P3(:), P4(:)
			INTEGER, INTENT(IN) :: Max_Iteraciones, Max_Sin_Mejora, Reps
			
			INTEGER :: rep
			REAL(8) :: Mejor_Z_temp, suma1, suma2, suma3, suma4, suma5, suma6
			REAL(8) :: tiempo_inicio, tiempo_fin, tiempo_total
			REAL(8) :: media1, media2, media3, media4, media5, media6
			INTEGER :: Iteraciones_temp, iter_promedio1, iter_promedio2, iter_promedio3
			INTEGER :: iter_promedio4, iter_promedio5, iter_promedio6
			INTEGER :: sin_mejora1, sin_mejora2, sin_mejora3, sin_mejora4, sin_mejora5, sin_mejora6
			
			! 1. Leer datos
			CALL Leer_Datos_MDP(filename)
			
			! 2. Mostrar cabecera
			WRITE(*,*) ""
			WRITE(*,*) "CALIBRANDO INSTANCIA: ", TRIM(filename)
			WRITE(*,*) "-----------------------------------------"
			WRITE(*,*) "n = ", n, ", m = ", m
			WRITE(*,*) "Máximo de iteraciones: ", Max_Iteraciones
			WRITE(*,*) "Máximo sin mejora: ", Max_Sin_Mejora
			WRITE(*,*) "Repeticiones por configuración: ", Reps
			WRITE(*,*) ""
			WRITE(*,*) "------------------------------------------------------------------------------------------"
			WRITE(*,*) " Opc | k_max | Porcentajes     | Diversidad | Iteraciones | Sin Mejora | Tiempo (s)"
			WRITE(*,*) "------------------------------------------------------------------------------------------"
			
			! 3. Probar configuración 1 (k_max=2)
			suma1 = 0.0D0
			iter_promedio1 = 0
			sin_mejora1 = 0
			CALL CPU_TIME(tiempo_inicio)
			DO rep = 1, Reps
				CALL init_random_seed()
				CALL VNS_General(2, P1, Max_Iteraciones, Max_Sin_Mejora, Iteraciones_temp, Mejor_Z_temp)
				suma1 = suma1 + Mejor_Z_temp
				iter_promedio1 = iter_promedio1 + Iteraciones_temp
			END DO
			CALL CPU_TIME(tiempo_fin)
			media1 = suma1 / REAL(Reps, 8)
			iter_promedio1 = iter_promedio1 / Reps
			sin_mejora1 = sin_mejora1 / Reps
			tiempo_total = tiempo_fin - tiempo_inicio
			WRITE(*, '(I3, A4, I3, A4, F5.2, A1, F5.2, A6, F12.5, A3, I8, A3, I6, A3, F8.3)') &
				1, ' | ', 2, ' | ', P1(1), ',', P1(2), ' | ', media1, ' | ', &
				iter_promedio1, ' | ', sin_mejora1, ' | ', tiempo_total
			
			! 4. Probar configuración 2 (k_max=2)
			suma2 = 0.0D0
			iter_promedio2 = 0
			sin_mejora2 = 0
			CALL CPU_TIME(tiempo_inicio)
			DO rep = 1, Reps
				CALL init_random_seed()
				CALL VNS_General(2, P2, Max_Iteraciones, Max_Sin_Mejora, Iteraciones_temp, Mejor_Z_temp)
				suma2 = suma2 + Mejor_Z_temp
				iter_promedio2 = iter_promedio2 + Iteraciones_temp
			END DO
			CALL CPU_TIME(tiempo_fin)
			media2 = suma2 / REAL(Reps, 8)
			iter_promedio2 = iter_promedio2 / Reps
			sin_mejora2 = sin_mejora2 / Reps
			tiempo_total = tiempo_fin - tiempo_inicio
			WRITE(*, '(I3, A4, I3, A4, F5.2, A1, F5.2, A6, F12.5, A3, I8, A3, I6, A3, F8.3)') &
				2, ' | ', 2, ' | ', P2(1), ',', P2(2), ' | ', media2, ' | ', &
				iter_promedio2, ' | ', sin_mejora2, ' | ', tiempo_total
			
			! 5. Probar configuración 3 (k_max=3)
			suma3 = 0.0D0
			iter_promedio3 = 0
			sin_mejora3 = 0
			CALL CPU_TIME(tiempo_inicio)
			DO rep = 1, Reps
				CALL init_random_seed()
				CALL VNS_General(3, P3, Max_Iteraciones, Max_Sin_Mejora, Iteraciones_temp, Mejor_Z_temp)
				suma3 = suma3 + Mejor_Z_temp
				iter_promedio3 = iter_promedio3 + Iteraciones_temp
			END DO
			CALL CPU_TIME(tiempo_fin)
			media3 = suma3 / REAL(Reps, 8)
			iter_promedio3 = iter_promedio3 / Reps
			sin_mejora3 = sin_mejora3 / Reps
			tiempo_total = tiempo_fin - tiempo_inicio
			WRITE(*, '(I3, A4, I3, A4, F5.2, A1, F5.2, A1, F5.2, A4, F12.5, A3, I8, A3, I6, A3, F8.3)') &
				3, ' | ', 3, ' | ', P3(1), ',', P3(2), ',', P3(3), ' | ', media3, ' | ', &
				iter_promedio3, ' | ', sin_mejora3, ' | ', tiempo_total
			
			! 6. Probar configuración 4 (k_max=3)
			suma4 = 0.0D0
			iter_promedio4 = 0
			sin_mejora4 = 0
			CALL CPU_TIME(tiempo_inicio)
			DO rep = 1, Reps
				CALL init_random_seed()
				CALL VNS_General(3, P4, Max_Iteraciones, Max_Sin_Mejora, Iteraciones_temp, Mejor_Z_temp)
				suma4 = suma4 + Mejor_Z_temp
				iter_promedio4 = iter_promedio4 + Iteraciones_temp
			END DO
			CALL CPU_TIME(tiempo_fin)
			media4 = suma4 / REAL(Reps, 8)
			iter_promedio4 = iter_promedio4 / Reps
			sin_mejora4 = sin_mejora4 / Reps
			tiempo_total = tiempo_fin - tiempo_inicio
			WRITE(*, '(I3, A4, I3, A4, F5.2, A1, F5.2, A1, F5.2, A4, F12.5, A3, I8, A3, I6, A3, F8.3)') &
				4, ' | ', 3, ' | ', P4(1), ',', P4(2), ',', P4(3), ' | ', media4, ' | ', &
				iter_promedio4, ' | ', sin_mejora4, ' | ', tiempo_total
			
			WRITE(*,*) "------------------------------------------------------------------------------------------"
			
		END SUBROUTINE Calibracion_K
 

		!===== SUBRUTINA 13: Aplicar el algoritmo al conjunto de test ==== 
		SUBROUTINE Resultados(filename, K_max, Frac_Perturbacion, &
							  repeticiones, mejor_fitness, fitness_promedio, &
							  tiempo_promedio, Max_Iteraciones, &
							  Max_Sin_Mejora)
			USE Params_MDP
			IMPLICIT NONE
			
			! Parámetros de entrada
			CHARACTER(LEN=*), INTENT(IN) :: filename
			INTEGER, INTENT(IN) :: K_max, repeticiones, Max_Iteraciones, Max_Sin_Mejora
			REAL(8), DIMENSION(K_max), INTENT(IN) :: Frac_Perturbacion
			
			! Resultados de salida
			REAL(8), INTENT(OUT) :: mejor_fitness, fitness_promedio, tiempo_promedio
			
			! Variables locales
			INTEGER :: rep, i, iteraciones_actual
			REAL(8) :: fitness_actual, suma_fitness, suma_tiempo
			INTEGER, ALLOCATABLE :: solucion_actual(:), S_temp(:)
			REAL(8) :: tiempo_inicio, tiempo_fin
			CHARACTER(LEN=200) :: linea_separador
			
			! 1. Leer los datos del archivo
			CALL Leer_Datos_MDP(filename)
			
			! 2. Inicializar variables
			linea_separador = '========================================================='
			
			ALLOCATE(solucion_actual(m))
			ALLOCATE(S_temp(m))
			
			mejor_fitness = -HUGE(1.0_8)  ! Inicializar con valor muy bajo
			suma_fitness = 0.0_8
			suma_tiempo = 0.0_8
			
			! 3. Mostrar cabecera
			WRITE(*, *) ''
			WRITE(*, *) TRIM(linea_separador)
			WRITE(*, *) '=== EJECUCION MULTIPLE DE VNS (VARIABLE NEIGHBORHOOD SEARCH) ==='
			WRITE(*, *) TRIM(linea_separador)
			WRITE(*, *) ''
			WRITE(*, '(A, A)') 'Archivo: ', TRIM(filename)
			WRITE(*, '(A, I6, A, I6)') 'Dimensiones: N = ', n, ', M = ', m
			WRITE(*, *) ''
			WRITE(*, *) 'PARAMETROS VNS UTILIZADOS:'
			WRITE(*, *) '---------------------------------------------------------'
			WRITE(*, '(A, I6)') 'K_max (Niveles perturbacion): ', K_max
			WRITE(*, '(A, I6)') 'Max Iteraciones:              ', Max_Iteraciones
			WRITE(*, '(A, I6)') 'Max Sin Mejora:               ', Max_Sin_Mejora
			WRITE(*, '(A, I4)') 'Repeticiones:                ', repeticiones
			WRITE(*, *) ''
			WRITE(*, *) 'Fracciones de perturbacion por nivel:'
			DO i = 1, K_max
				WRITE(*, '(A, I2, A, F6.3)') '  Nivel ', i, ': ', Frac_Perturbacion(i)
			END DO
			WRITE(*, *) ''
			WRITE(*, *) 'PROGRESO DE LAS EJECUCIONES:'
			WRITE(*, *) '---------------------------------------------------------'
			
			! 4. Bucle de repeticiones
			DO rep = 1, repeticiones
				! Inicializar semilla aleatoria diferente para cada ejecución
				CALL init_random_seed()
				
				! Medir tiempo de ejecución
				CALL CPU_TIME(tiempo_inicio)
				
				! Ejecutar VNS
				CALL VNS_General(K_max, Frac_Perturbacion, Max_Iteraciones, &
								Max_Sin_Mejora, iteraciones_actual, fitness_actual)
				
				CALL CPU_TIME(tiempo_fin)
				
				! Actualizar estadísticas
				suma_fitness = suma_fitness + fitness_actual
				suma_tiempo = suma_tiempo + (tiempo_fin - tiempo_inicio)
				
				! Verificar si es la mejor solución encontrada
				IF (fitness_actual > mejor_fitness) THEN
					mejor_fitness = fitness_actual
				END IF
				
				! Mostrar progreso
				WRITE(*, '(I3, A, F18.6, A, I6, A, F8.3, A)') &
					rep, ' - Fitness: ', fitness_actual, &
					' | Iter: ', iteraciones_actual, &
					' | Tiempo: ', tiempo_fin - tiempo_inicio, ' s'
			END DO
			
			! 5. Calcular promedios
			fitness_promedio = suma_fitness / REAL(repeticiones, 8)
			tiempo_promedio = suma_tiempo / REAL(repeticiones, 8)
			
			! 6. Mostrar resultados finales
			WRITE(*, *) '---------------------------------------------------------'
			WRITE(*, *) ''
			WRITE(*, *) 'RESULTADOS FINALES VNS:'
			WRITE(*, *) '---------------------------------------------------------'
			WRITE(*, '(A, F18.6)') 'Mejor fitness encontrado:  ', mejor_fitness
			WRITE(*, '(A, F18.6)') 'Fitness promedio:          ', fitness_promedio
			WRITE(*, '(A, F8.3, A)') 'Tiempo promedio por ejecucion: ', tiempo_promedio, ' s'
			WRITE(*, '(A, F8.3, A)') 'Tiempo total:                ', suma_tiempo, ' s'
			WRITE(*, *) ''
			
			
			! 8. Liberar memoria local
			DEALLOCATE(solucion_actual, S_temp)
			
			WRITE(*, *) TRIM(linea_separador)
			WRITE(*, *) 'Ejecucion multiple VNS completada.'
			WRITE(*, *) TRIM(linea_separador)
			WRITE(*, *) ''
			
		END SUBROUTINE Resultados

		
		!===== SUBRUTINA 14: VNS poniendo limitracion de tiempo ==== 
		SUBROUTINE VNS_General_Tiempo(Max_Tiempo, K_max, Frac_Perturbacion, Max_Iteraciones, Max_Sin_Mejora, Iteraciones, Mejor_Z)
			USE Params_MDP
			IMPLICIT NONE

			REAL(8), INTENT(OUT) :: Mejor_Z
			INTEGER, INTENT(OUT) :: Iteraciones

			INTEGER, INTENT(IN) :: K_max
			REAL(8), DIMENSION(K_max), INTENT(IN) :: Frac_Perturbacion 
			INTEGER, INTENT(IN) :: Max_Iteraciones, Max_Sin_Mejora
			REAL(8), INTENT(IN) :: Max_Tiempo

			INTEGER :: mloc, k_shake_actual, k_vns, iter_sin_mejora
			INTEGER, ALLOCATABLE :: S_global(:), S_local(:), S_temp_vnd(:)   
			REAL(8) :: z_global, z_vnd_init, z_vnd_final, z_anterior, tiempo_actual, tiempo_inicio
			LOGICAL :: hubo_mejora, tiempo_excedido
			INTEGER :: stats(4)

			mloc = m

			CALL Construir_Solucion_Inicial(S_global, z_global)
			z_anterior = z_global
			

			ALLOCATE(S_local(mloc), S_temp_vnd(mloc))
			
			Iteraciones = 0
			iter_sin_mejora = 0
			tiempo_excedido = .FALSE.
			CALL CPU_TIME(tiempo_inicio)
			
			
			!  BUCLE PRINCIPAL VNS
			DO WHILE (Iteraciones < Max_Iteraciones .AND. iter_sin_mejora < Max_Sin_Mejora .AND. .NOT. tiempo_excedido)
				
				Iteraciones = Iteraciones + 1
				hubo_mejora = .FALSE.
			
				
				! Verificar tiempo
				CALL CPU_TIME(tiempo_actual)
				IF ((tiempo_actual - tiempo_inicio) > Max_Tiempo) THEN
					tiempo_excedido = .TRUE.
					EXIT
				END IF
				
				! 5. CICLO DE PERTURBACIONES
				k_vns = 1 
				DO WHILE (k_vns <= K_max .AND. .NOT. hubo_mejora .AND. .NOT. tiempo_excedido)
					
					! A. PERTURBACIÓN
					k_shake_actual = MAX(1, INT(Frac_Perturbacion(k_vns) * REAL(mloc, 8)))
					CALL Perturbacion_kSwap(S_global, S_local, k_shake_actual)
					
					! B. VND (BUSQUEDA LOCAL)
					z_vnd_init = Calcular_Diversidad(S_local)
					
					! Llamar a VND con límite de tiempo implícito
					CALL VND(S_local, S_temp_vnd, z_vnd_init, z_vnd_final)
					
					! Verificar tiempo después de VND
					CALL CPU_TIME(tiempo_actual)
					IF ((tiempo_actual - tiempo_inicio) > Max_Tiempo) THEN
						tiempo_excedido = .TRUE.
						EXIT
					END IF
					
					! C. CRITERIO DE ACEPTACIÓN
					IF (z_vnd_final > z_global + 1.0d-8) THEN
						! MEJORA ENCONTRADA
						S_global = S_temp_vnd
						z_global = z_vnd_final
						hubo_mejora = .TRUE.
						iter_sin_mejora = 0
						
						EXIT  ! Salir del bucle k_vns
						
					ELSE
						! No hay mejora, siguiente nivel de perturbación
						k_vns = k_vns + 1
					END IF
					
				END DO  ! Fin while k_vns
				
				! Actualizar contador si no hubo mejora
				IF (.NOT. hubo_mejora) THEN
					iter_sin_mejora = iter_sin_mejora + 1
				END IF
				
			END DO  ! Fin while principal
			Mejor_Z = z_global
			
			CALL CPU_TIME(tiempo_actual)
			
			DEALLOCATE(S_local, S_temp_vnd)
			
		END SUBROUTINE VNS_General_Tiempo
			
	
		! ========== SUBRUTINA 15: Aplicar tiempo a los conjuntos de test para VNS ==========
		SUBROUTINE Evaluar_VNS_Tiempo(filename, Tiempo_limite, K_max, Frac_Perturbacion, &
									 Max_Iteraciones, Max_Sin_Mejora, Reps, &
									 Mejor_Absoluto, Media_Absoluta)
			USE Params_MDP
			IMPLICIT NONE
		   
			! Parámetros de entrada
			CHARACTER(LEN=*), INTENT(IN) :: filename
			REAL(8), INTENT(IN) :: Tiempo_limite
			INTEGER, INTENT(IN) :: K_max, Max_Iteraciones, Max_Sin_Mejora, Reps
			REAL(8), DIMENSION(K_max), INTENT(IN) :: Frac_Perturbacion
			
			! Resultados de salida
			REAL(8), INTENT(OUT) :: Mejor_Absoluto
			REAL(8), INTENT(OUT) :: Media_Absoluta

			! Variables locales
			INTEGER :: rep, i, iteraciones_actual
			REAL(8) :: tiempo_inicio, tiempo_fin
			REAL(8), ALLOCATABLE :: resultados(:), tiempos(:)
			REAL(8) :: suma, suma_cuadrados, mejor_rep, tiempo_promedio, desv_estandar
			
			! --- Inicialización ---
			ALLOCATE(resultados(Reps), tiempos(Reps))
			resultados = 0.0D0
			tiempos = 0.0D0
			Mejor_Absoluto = -HUGE(1.0D0)
			
			! 1. Leer datos del problema
			CALL Leer_Datos_MDP(filename)
			
			! 2. Mostrar cabecera
			WRITE(*,*) ""
			WRITE(*,*) "=============================================================="
			WRITE(*,*) "EVALUACION DE BUSQUEDA EN ENTORNO VARIABLE (VNS) POR TIEMPO"
			WRITE(*,*) "=============================================================="
			WRITE(*,*) "Instancia: ", TRIM(filename)
			WRITE(*,*) "n = ", n, ", m = ", m
			WRITE(*,*) "Tiempo limite: ", Tiempo_limite, " segundos"
			WRITE(*,*) "Parametros VNS:"
			WRITE(*,*) "  K_max (niveles perturbacion): ", K_max
			WRITE(*,*) "  Max Iteraciones:               ", Max_Iteraciones
			WRITE(*,*) "  Max Sin Mejora:                ", Max_Sin_Mejora
			WRITE(*,'(A)', ADVANCE='NO') "  Fracciones perturbacion:     "
			DO i = 1, K_max
				WRITE(*,'(F6.3)', ADVANCE='NO') Frac_Perturbacion(i)
				IF (i < K_max) WRITE(*,'(A2)', ADVANCE='NO') ", "
			END DO
			WRITE(*,*) ""
			WRITE(*,*) "Repeticiones: ", Reps
			WRITE(*,*) "=============================================================="
			WRITE(*,*) ""
			WRITE(*,'(A10, A12, A15, A10)') "Replica", "Tiempo(s)", "Mejor Fitness", "Iter"
			WRITE(*,*) "--------------------------------------------------------------"
			
			! 3. Ejecutar múltiples repeticiones
			suma = 0.0D0
			suma_cuadrados = 0.0D0
			
			DO rep = 1, Reps
				! Inicializar semilla aleatoria
				CALL init_random_seed()
				
				! Medir tiempo
				CALL CPU_TIME(tiempo_inicio)
				
				! Ejecutar VNS con límite de tiempo
				CALL VNS_General_Tiempo(Tiempo_limite, K_max, Frac_Perturbacion, &
									   Max_Iteraciones, Max_Sin_Mejora, &
									   iteraciones_actual, mejor_rep)
				
				CALL CPU_TIME(tiempo_fin)
				
				! Almacenar resultados
				resultados(rep) = mejor_rep
				tiempos(rep) = tiempo_fin - tiempo_inicio
				suma = suma + mejor_rep
				suma_cuadrados = suma_cuadrados + mejor_rep**2
				
				! Actualizar mejor absoluto
				IF (mejor_rep > Mejor_Absoluto) THEN
					Mejor_Absoluto = mejor_rep
				END IF
				
				! Mostrar progreso
				WRITE(*,'(I10, F12.3, F15.5, I10)') rep, tiempos(rep), mejor_rep, iteraciones_actual
			END DO
			
			! 4. Calcular estadísticas
			Media_Absoluta = suma / REAL(Reps, 8)
			tiempo_promedio = SUM(tiempos) / REAL(Reps, 8)
			
			! Calcular desviación estándar si hay más de 1 réplica
			IF (Reps > 1) THEN
				desv_estandar = SQRT((suma_cuadrados - suma**2/REAL(Reps,8)) / REAL(Reps-1,8))
			ELSE
				desv_estandar = 0.0D0
			END IF
			
			! 5. Mostrar resultados finales
			WRITE(*,*) "=============================================================="
			WRITE(*,*) "RESULTADOS FINALES VNS"
			WRITE(*,*) "=============================================================="
			WRITE(*,'(A, F18.6)') "Mejor resultado absoluto:   ", Mejor_Absoluto
			WRITE(*,'(A, F18.6)') "Media de los mejores:       ", Media_Absoluta
			WRITE(*,'(A, F12.3, A)') "Tiempo promedio (s):        ", tiempo_promedio, " s"
			WRITE(*,'(A, F12.3, A)') "Tiempo total (s):           ", SUM(tiempos), " s"
			
			! Mostrar desviación estándar solo si hay más de 1 réplica
			IF (Reps > 1) THEN
				WRITE(*,'(A, F18.6)') "Desviacion estandar:        ", desv_estandar
			END IF
			
			! Mostrar eficiencia (fitness por segundo)
			IF (tiempo_promedio > 0.0D0) THEN
				WRITE(*,'(A, F18.6)') "Eficiencia (fitness/s):     ", Media_Absoluta / tiempo_promedio
			END IF
			
			WRITE(*,*) "=============================================================="
			WRITE(*,*) ""
			
			! Liberar memoria
			DEALLOCATE(resultados, tiempos)
			
		END SUBROUTINE Evaluar_VNS_Tiempo
END PROGRAM Algoritmo_BEV
