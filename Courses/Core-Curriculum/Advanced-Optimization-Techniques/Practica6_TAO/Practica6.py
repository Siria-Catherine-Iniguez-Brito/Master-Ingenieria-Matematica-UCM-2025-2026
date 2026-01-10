import pyomo.environ as pyo
import sys
import re 
import os 
import random

# ======================== LECTURA Y EXTRACCIÓN DE DATOS ======================

def Leer_Datos(nombre_archivo):
    
    """
    Lee los datos de un archivo 
    Retorna (n_sop, C_s, k, m_i_list, TODOS_LOS_PESOS)
    """
    
    try:
        # 1. Leer todas las líneas no vacías y que no sean comentarios
        with open(nombre_archivo, 'r') as f:
            # Quitamos los comentarios y limpiamos espacios
            lines = [line.strip() for line in f if line.strip() and not line.strip().startswith('#')]
        
        data = {}
        TODOS_LOS_PESOS = []
        
        # Función auxiliar para extraer todos los números de una cadena
        # Ignora números que probablemente sean índices (como en 'Grupo 1')
        def extract_numbers(line):
            return [n for n in re.findall(r'[+-]?\d+\.?\d*', line)]

        def get_values_part(line):
            return line.split('=', 1)[1].strip() if '=' in line else line.strip()

        # 2. Procesar las líneas
        for line in lines:
            line_lower = line.lower()
            
            if 'numero de contenedores' in line_lower:
                numbers = [int(n) for n in extract_numbers(get_values_part(line))]
                if numbers:
                    data['n_sop'] = int(numbers[0])

            elif 'pesos maximos' in line_lower:
                numbers = [float(n) for n in extract_numbers(get_values_part(line))]
                n_sop = data.get('n_sop')
                if n_sop and len(numbers) == n_sop:
                    data['C_s'] = {s + 1: numbers[s] for s in range(n_sop)}
                
            elif 'numero de grupos' in line_lower:
                numbers = [int(n) for n in extract_numbers(get_values_part(line))]
                if numbers:
                    data['k'] = int(numbers[0])
            
            elif 'numero de objetos' in line_lower:
                pass 

            elif 'numero minimo a incluir' in line_lower:
                numbers = [int(n) for n in extract_numbers(get_values_part(line))]
                k = data.get('k')
                if k and len(numbers) == k:
                    data['m_i_list'] = numbers
            
            elif 'grupo' in line_lower and '::' in line:
                parts = line.split('::')
                if len(parts) > 1:
                    numbers = [float(n) for n in extract_numbers(parts[1])]
                    TODOS_LOS_PESOS.append(numbers)
        
        return data['n_sop'], data['C_s'], data['k'], data['m_i_list'], TODOS_LOS_PESOS
        
    except FileNotFoundError:
        print(f" Error: No se encontró el archivo de datos '{nombre_archivo}'")
        sys.exit(1)
    except Exception as e:
        print(f" Error al leer o procesar el archivo de datos: {e}")
        sys.exit(1)


# ===================== RESOLUCIÓN DEL MODELO PYOMO/CBC =====================

def Resolver_PLE (n_sop, C_s, k, m_i_list, TODOS_LOS_PESOS):
    
    """
    Construye y resuelve el modelo de Programación Lineal Entera (PLE)
    para el problema de asignación generalizada (GAP).

    Args:
        n_sop (int): Número de soportes.
        C_s (dict): Capacidad máxima de cada soporte {1: C1, 2: C2, ...}.
        k (int): Número de grupos.
        m_i_list (list): Mínimo de objetos a seleccionar por grupo [m1, m2, ...].
        TODOS_LOS_PESOS (list of list): Pesos de los objetos por grupo.
        
    Return:
        tuple: (peso total, lista de las asignaciones) or (None, None) si no encuentra la solucion.
    """
    
    # 1. Preparación de Datos 
    n_i = [len(g) for g in TODOS_LOS_PESOS]
    
    # Crear un diccionadio de pesos  d[(i, j)] = pesos
    d = {}
    for i, pesos_grupo in enumerate(TODOS_LOS_PESOS, 1):
        for j, peso in enumerate(pesos_grupo, 1):
            d[(i, j)] = peso

    # 2. Creacion del modelo y conjuntos
    model = pyo.ConcreteModel()

    # Conjunto I: Grupos (i = 1...k)
    model.I = pyo.RangeSet(1, k)
    # Conjunto S: Contenedores (s = 1...n_sop)
    model.S = pyo.RangeSet(1, n_sop)    

    # Pre-ordenación de los índices (i, j) por peso 
    indexed_weights = [((i, j), d[(i, j)]) for i in model.I.data() 
                        for j in range(1, n_i[i-1] + 1)]
    indexed_weights.sort(key=lambda x: x[1], reverse=True)

    # Conjunto INDEX_IJ: Par (grupo, objeto) ordenado por peso
    INDEX_IJ_ORDERED = [item[0] for item in indexed_weights]
    model.INDEX_IJ = pyo.Set(initialize=INDEX_IJ_ORDERED)

    # 3. Variables de decision 
    # x[(i, j), s] = 1 si el objeto j del grupo i es asignado al soporte s
    model.x = pyo.Var(model.INDEX_IJ, model.S, within=pyo.Binary)


    # 4. Funcion Objetivo
    def FunObj(model):
        return sum(d[(i, j)] * model.x[(i, j), s]
                   for (i, j) in model.INDEX_IJ for s in model.S)
    model.objetivo= pyo.Objective(rule=FunObj, sense=pyo.maximize)


    # 5. Restricciones
    # R1: Restricción de Capacidad del Contenedor
    def Res_Capacidad(model, s):
        return sum(d[(i, j)] * model.x[(i, j), s]
                   for (i, j) in model.INDEX_IJ) <= C_s[s]
    model.ResCapacidad = pyo.Constraint(model.S, rule=Res_Capacidad)

    # R2: Incluir minimo por grupo 
    def Res_MinGrupo(model, i):
        return sum(model.x[(i_check, j), s]
                   for (i_check, j) in model.INDEX_IJ if i_check == i for s in model.S) >= m_i_list[i-1]
    model.ResMinGrupo = pyo.Constraint(model.I, rule=Res_MinGrupo)

    # R3: Solo ser asignado a un contenedor como mucho 
    def Res_Unicidad(model, i, j):
        return sum(model.x[(i, j), s] for s in model.S) <= 1
    model.ResUnicidad = pyo.Constraint(model.INDEX_IJ, rule=Res_Unicidad)

    # 6. Resolucion (CBC)
    solver = pyo.SolverFactory('cbc')
    results = solver.solve(model, tee=False)
    total_weight = None
    asignaciones_optimas = None


    # 7. Analisis y representacion 
    if results.solver.termination_condition == pyo.TerminationCondition.optimal:
        total_weight = pyo.value(model.objetivo)
        asignaciones_optimas = []
        for (i, j) in model.INDEX_IJ:
            for s in model.S:
                if pyo.value(model.x[(i, j), s]) > 0.5:
                    asignaciones_optimas.append((s, i, j, d[(i, j)]))
        asignaciones_optimas.sort()

    elif results.solver.termination_condition == pyo.TerminationCondition.maxTimeLimit:
        print("\n Límite de tiempo alcanzado por CBC.")
        total_weight = pyo.value(model.objective)
        print(f"Mejor valor encontrado: Z = {total_weight:.2f}")
        
    else:
        print("\nNo se encontró solución óptima (verifique el log de CBC).")
        print(f"Estado del solver: {results.solver.termination_condition}")
    
    return total_weight, asignaciones_optimas


# ===================== ESCRITURA DE RESULTADOS MEJORADA =====================

def Escribir_Resultados(archivo_salida, peso_total_basico, asignaciones_basico,
                                 peso_total_incomp, asignaciones_incomp):
    """
    Escribe ambas soluciones (básica y con incompatibilidades)
    """
    
    try:
        with open(archivo_salida, 'w') as f:  
            
            # PARTE 1: SOLUCIÓN BÁSICA
            f.write("PRACTICA 6: COLECCION - SOLUCIÓN BÁSICA\n")
            f.write("            ===========================\n\n")
            
            if peso_total_basico is not None and asignaciones_basico is not None:
                f.write(f"VALOR ÓPTIMO (MODELO BÁSICO): {peso_total_basico:.2f}\n")
                f.write("\n----------------------------------------------------\n")
                f.write("             DETALLE DE ASIGNACIONES ÓPTIMAS          \n")
                f.write("----------------------------------------------------\n")
                
                # Encabezado
                f.write(f"{'Contenedor':<12} | {'Grupo':<8} | {'Objeto':<8} | {'Peso':<8}\n")
                f.write("-" * 40 + "\n")
                
                # Datos
                for s, i, j, peso in asignaciones_basico:
                    f.write(f"{s:<12} | {i:<8} | {j:<8} | {peso:<8.2f}\n")
                
                f.write("----------------------------------------------------\n")
                f.write(f"Total objetos asignados: {len(asignaciones_basico)}\n")
            
            else:
                f.write("\nNo se pudo encontrar solución para el modelo básico.\n")
            
            f.write("\n\n" + "="*70 + "\n")
            f.write("="*70 + "\n\n")
            
            # PARTE 2: SOLUCIÓN CON INCOMPATIBILIDADES
            f.write("PRACTICA 6: COLECCION - SOLUCIÓN CON INCOMPATIBILIDADES\n")
            f.write("            ==========================================\n\n")
            
            if peso_total_incomp is not None and asignaciones_incomp is not None:
                f.write(f"VALOR ÓPTIMO (CON INCOMPATIBILIDADES): {peso_total_incomp:.2f}\n")
                
                # Mostrar diferencia si tenemos ambos resultados
                if peso_total_basico is not None:
                    diferencia = peso_total_incomp - peso_total_basico
                    f.write(f"Diferencia respecto al modelo básico: {diferencia:+.2f}\n")
                
                f.write("\n----------------------------------------------------\n")
                f.write("             DETALLE DE ASIGNACIONES ÓPTIMAS          \n")
                f.write("----------------------------------------------------\n")
                
                # Encabezado - MISMO FORMATO
                f.write(f"{'Contenedor':<12} | {'Grupo':<8} | {'Objeto':<8} | {'Peso':<8}\n")
                f.write("-" * 40 + "\n")
                
                for s, i, j, peso in asignaciones_incomp:
                    f.write(f"{s:<12} | {i:<8} | {j:<8} | {peso:<8.2f}\n")
                
                f.write("----------------------------------------------------\n")
                f.write(f"Total objetos asignados: {len(asignaciones_incomp)}\n")
            
            else:
                f.write("\nNo se pudo encontrar solución para el modelo con incompatibilidades.\n")
                
    except Exception as e:
        print(f"Error al escribir el archivo de resultados '{archivo_salida}': {e}")


# ===================== RESOLUCIÓN DEL MODELO CON INCOPATBILIDADES =====================
def generar_incompatibilidades_recopilatorio(TODOS_LOS_PESOS, num_incompat):
    """
    Genera conjuntos de objetos incompatibles 
    Cada conjunto J_r tiene un límite t_r de objetos que se pueden incluir
    
    Args:
        TODOS_LOS_PESOS: Lista de listas con los pesos de los objetos
        num_incompat: Número de conjuntos de incompatibilidad a generar
        
    Returns:
        Lista de diccionarios con las incompatibilidades generadas
    """
    incompatibilidades = []
    
    # Crear lista de todos los objetos
    todos_objetos = []
    for i, grupo in enumerate(TODOS_LOS_PESOS, 1):
        for j in range(1, len(grupo) + 1):
            todos_objetos.append((i, j))
    
    random.seed(42)
    
    # Generar 'num_incompat' conjuntos de incompatibilidad
    for r in range(1, num_incompat + 1):
        # Tamaño aleatorio del conjunto J_r (entre 3 y 6 objetos)
        tamaño_Jr = random.randint(3, 6)
        
        # Asegurarse de que no intentamos muestrear más objetos de los disponibles
        if tamaño_Jr > len(todos_objetos):
            tamaño_Jr = len(todos_objetos)
            
        Jr = random.sample(todos_objetos, tamaño_Jr)
        
        # Límite t_r (entre 1 y tamaño_Jr-1)
        t_r = random.randint(1, max(1, tamaño_Jr - 1))
        
        incompatibilidades.append({
            'conjunto': Jr,
            'limite': t_r,
            'id': r
        })
    
    return incompatibilidades



def Resolver_PLE_con_incompatibilidades(n_sop, C_s, k, m_i_list, TODOS_LOS_PESOS, icompatibilidaes):
    """
    Construye y resuelve el modelo PLE con restricciones de incompatibilidad.
    
    """
    
    # 1. Preparación de Datos 
    n_i = [len(g) for g in TODOS_LOS_PESOS]
    
    # Diccionario de pesos d[(i, j)]
    d = {}
    for i, pesos_grupo in enumerate(TODOS_LOS_PESOS, 1):
        for j, peso in enumerate(pesos_grupo, 1):
            d[(i, j)] = peso
    

    
    # 3. Creación del modelo
    model = pyo.ConcreteModel()
    
    # Conjuntos
    model.I = pyo.RangeSet(1, k)  # Grupos
    model.S = pyo.RangeSet(1, n_sop)  # Soportes/contenedores
    
    # Conjunto de objetos INDEX_IJ
    INDEX_IJ = [(i, j) for i in model.I.data() 
                for j in range(1, n_i[i-1] + 1)]
    model.INDEX_IJ = pyo.Set(initialize=INDEX_IJ)
    
    # Conjunto de incompatibilidades
    model.R = pyo.RangeSet(1, len(incompatibilidades))
    
    # 3. Variables de decisión
    model.x = pyo.Var(model.INDEX_IJ, model.S, within=pyo.Binary)
    
    # 4. Función Objetivo (maximizar peso total)
    def FunObj(model):
        return sum(d[(i, j)] * model.x[(i, j), s]
                   for (i, j) in model.INDEX_IJ for s in model.S)
    model.objetivo = pyo.Objective(rule=FunObj, sense=pyo.maximize)
    
    # 5. Restricciones originales
    
    # Restricción de Capacidad del Contenedor
    def Res_Capacidad(model, s):
        return sum(d[(i, j)] * model.x[(i, j), s]
                   for (i, j) in model.INDEX_IJ) <= C_s[s]
    model.ResCapacidad = pyo.Constraint(model.S, rule=Res_Capacidad)
    
    # Mínimo por grupo
    def Res_MinGrupo(model, i):
        return sum(model.x[(i, j), s]
                   for j in range(1, n_i[i-1] + 1) for s in model.S) >= m_i_list[i-1]
    model.ResMinGrupo = pyo.Constraint(model.I, rule=Res_MinGrupo)
    
    # Unicidad: cada objeto como máximo en un contenedor
    def Res_Unicidad(model, i, j):
        return sum(model.x[(i, j), s] for s in model.S) <= 1
    model.ResUnicidad = pyo.Constraint(model.INDEX_IJ, rule=Res_Unicidad)
    
    # 7. NUEVA RESTRICCIÓN: Incompatibilidades
    def Res_Incompatibilidad(model, r):
        Jr = incompatibilidades[r-1]['conjunto']
        t_r = incompatibilidades[r-1]['limite']
        return sum(model.x[(i, j), s] 
                   for (i, j) in Jr for s in model.S) <= t_r
    model.ResIncompatibilidad = pyo.Constraint(model.R, rule=Res_Incompatibilidad)
    
    # 8. Resolver
    solver = pyo.SolverFactory('cbc')
    
    # Configurar parámetros
    solver.options['sec'] = 60  # 60 segundos límite
    solver.options['ratio'] = 0.01  # Gap del 1%
    
    
    results = solver.solve(model, tee=False)
    
    # 9. Procesar resultados
    peso_total = None
    asignaciones = None
    
    if results.solver.termination_condition == pyo.TerminationCondition.optimal:
        peso_total = pyo.value(model.objetivo)
        asignaciones = []
        
        # Recolectar asignaciones
        for (i, j) in model.INDEX_IJ:
            for s in model.S:
                if pyo.value(model.x[(i, j), s]) > 0.5:
                    asignaciones.append((s, i, j, d[(i, j)]))
        asignaciones.sort()
    
    elif results.solver.termination_condition == pyo.TerminationCondition.maxTimeLimit:
        print("\n Límite de tiempo alcanzado")
        if hasattr(model, 'objetivo'):
            peso_total = pyo.value(model.objetivo)
            print(f"Mejor solución encontrada: {peso_total:.2f}")
            # Recuperar asignaciones parciales
            asignaciones = []
            for (i, j) in model.INDEX_IJ:
                for s in model.S:
                    if hasattr(model.x[(i, j), s], 'value') and pyo.value(model.x[(i, j), s]) > 0.5:
                        asignaciones.append((s, i, j, d[(i, j)]))
            asignaciones.sort()
    else:
        print(f"\nNo se encontró solución óptima.")
        print(f"Estado del solver: {results.solver.termination_condition}")
    
    return peso_total, asignaciones


# ===================== BLOQUE PRINCIPAL DE EJECUCIÓN  =====================
ARCHIVO_DATOS = "Datos6.dat"
ARCHIVO_SALIDA = "Solucion6.sol"


num_incompat = 5
if __name__ == '__main__':
    
    
    # 1. Cargar datos
    try:
        n_sop, C_s, k, m_i_list, TODOS_LOS_PESOS = Leer_Datos(ARCHIVO_DATOS)
        
    except SystemExit:
        sys.exit(1)
    
    #2.Resolver problema basico
    peso_total_basico, asignaciones_basico = Resolver_PLE(
        n_sop, C_s, k, m_i_list, TODOS_LOS_PESOS)
    
    # 3. Resolver problema con incopatibilidades
    incompatibilidades = generar_incompatibilidades_recopilatorio(TODOS_LOS_PESOS, num_incompat)
    peso_total_incomp, asignaciones_incomp = Resolver_PLE_con_incompatibilidades(
        n_sop, C_s, k, m_i_list, TODOS_LOS_PESOS, incompatibilidades)
    

    
    # 3. Escribir ambas soluciones en un solo archivo
    if (peso_total_basico is not None and asignaciones_basico is not None and
        peso_total_incomp is not None and asignaciones_incomp is not None):
        
        Escribir_Resultados(
            ARCHIVO_SALIDA,
            peso_total_basico,
            asignaciones_basico,
            peso_total_incomp,
            asignaciones_incomp
        )

        
        
        
        
        