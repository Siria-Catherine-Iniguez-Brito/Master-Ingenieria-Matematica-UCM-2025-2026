#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Nov 16 15:34:41 2025

@author: cati
"""
import re
import itertools
import pyomo.environ as pyo
from pyomo.opt import SolverFactory
import sys

# =============================================================================
# PRÁCTICA 3: CORTE UNIDIMENSIONAL DE MATERIALES
#
# Objetivo:
# 	Minimizar la longitud total de material sobrante (desperdicio) generado
# 	al cortar planchas de longitud fija (LP) para satisfacer una demanda
# 	específica d(i) de piezas de diferentes longitudes L(i).
#
#
# Método Implementado:
# 	1. Generación de Patrones: Se buscan y listan todos los posibles
# 	   patrones de corte (combinaciones de piezas L(i)) que caben en una
# 	   plancha LP. Se identifican y marcan los patrones no dominados,
# 	   que son aquellos que minimizan el desperdicio para la plancha.
# 	2. Optimización: Se formula un modelo de Programación Lineal (PL)para 
#      determinar qué cantidad de cada patrón de corte debe utilizarse 
#      para satisfacer la demanda d(i) con el mínimo número total de planchas LP.
#   3. Optimización – MODELO 2 (exceso aprovechable como sobrante). 
#
# Entradas:
# 	- Archivo de datos ('Datos3_TAO.dat') o parámetros: Longitud de la
# 	  plancha (LP), número de tipos de piezas (t), vector de longitudes L(i),
# 	  y vector de demandas d(i).
#
# Salidas:
#   - Archivo de solución ('Solucion3.sol'), que incluye:
#         · Lista de todos los patrones de corte generados.
#         · Identificación de patrones dominados / no dominados.
#         · Solución del MODELO 1:
#               - Valores óptimos de x(j)
#               - Sobrante total y nº de planchas utilizadas
#         · Solución del MODELO 2:
#               - Valores óptimos de x(j) y de los excesos y(i)
#               - Sobrante total considerando exceso de piezas como sobrante 
# =============================================================================


# ======================== LECTURA Y EXTRACCIÓN DE DATOS ======================

def Leer_Datos_Archivo(nombre_archivo):

    """
    Lee un archivo de datos que contiene la longitud de la plancha (LP),
    las longitudes de las piezas (Li) y las demandas requeridas (di).
    """
    
    LP = None
    t = None
    longitudes_i = []
    demandas_i = []
    
    try:
        with open(nombre_archivo, 'r', encoding='utf-8') as f:
            lineas = f.readlines()
        
        # 1. Buscar LP (Longitud de la Plancha) y t (Tipos de Piezas) en la cabecera
        for linea in lineas:
            if "LP =" in linea:
                match_lp = re.search(r'LP\s*=\s*(\d+\.?\d*)', linea)
                if match_lp:
                    LP = float(match_lp.group(1))
            if "Tipos de piezas" in linea and "t =" in linea:
                match_t = re.search(r't\s*=\s*(\d+)', linea)
                if match_t:
                    t = int(match_t.group(1))
        
        # 2. Buscar longitudes y demandas en el cuerpo de la tabla
        for linea in lineas:
            # Extracción de las longitudes (Li)
            if "longitud" in linea and "Li" in linea:
                longitudes_i = [float(x) for x in re.findall(r'\d+\.\d+', linea)]
                
            # Extracción de las demandas (di)
            if "demanda" in linea and "di" in linea:
                demandas_i = [int(x) for x in re.findall(r'\d+', linea)]
        
        # 3. Validación final de los datos extraídos
        if LP is None or t is None or len(longitudes_i) != t or len(demandas_i) != t:
            print("Error: no se pudieron extraer correctamente LP, t, longitudes o demandas.")
            print("LP:", LP, "t:", t, "longitudes:", longitudes_i, "demandas:", demandas_i)
            
            return None, None, None
        
        return LP, longitudes_i, demandas_i
    
    except Exception as e:
        print("Error leyendo archivo:", e)
        
        return None, None, None



# ======================= FUNCIÓN DE GENERACIÓN DE PATRONES ===================

def Generar_Patrones(LP, longitudes_i, t):

    """
    Genera todos los patrones de corte unidimensionales válidos.

    Un patrón es una tupla (a1, a2, ..., at), donde 'ai' es el número de piezas
    del tipo 'i' cortadas, siempre que la suma de sus longitudes no exceda LP.

    Parámetros:
        - LP (float): Longitud total de la plancha disponible.
        - longitudes_i : Lista de longitudes de las 't' piezas demandadas.
        - t (int): Número de tipos de piezas.

    Devuelve:
        - Lista ordenada de patrones de corte únicos y factibles.
    """
    
    # Inicializa un conjunto para almacenar patrones. Un conjunto garantiza
    # que solo se almacenen patrones únicos
    TODOS_LOS_PATRONES = set()

    # 1. Para cada tipo i, cuántas piezas máximo pueden entrar en la plancha
    max_cortes_por_pieza = []
    for L_i in longitudes_i:
        max_cortes = int(LP // L_i) if L_i > 0 else 0
        max_cortes_por_pieza.append(range(max_cortes + 1))

    # 2. Producto cartesiano para probar todas combinaciones posibles
    for patron in itertools.product(*max_cortes_por_pieza):
        longitud_usada = sum(patron[i] * longitudes_i[i] for i in range(t))

        # Debe cortar al menos una pieza y no exceder LP
        if 0 < longitud_usada <= LP:
            TODOS_LOS_PATRONES.add(tuple(patron))

    # Convertimos a lista ordenada 
    patrones_lista = sorted(list(TODOS_LOS_PATRONES))
    
    return patrones_lista



# ====================== FUNCION PARA EL CALCULO DE DOMINANCIA ================

def Calcular_Dominancia(t, PATRONES_LISTA):
    dominancia_j = []
        
    # Iterar sobre el patrón j (el que estamos verificando)
    for j, patron_j in enumerate(PATRONES_LISTA):
        is_dominated = False
            
        # Iterar sobre el patrón k (el potencial dominador)
        for k, patron_k in enumerate(PATRONES_LISTA):
            if j == k:
                continue
                
            k_dominates_j_in_pieces = True
            k_cuts_strictly_more = False
                
            for i in range(t):
                if patron_k[i] < patron_j[i]:
                    k_dominates_j_in_pieces = False
                    break
                    
                if patron_k[i] > patron_j[i]:
                    k_cuts_strictly_more = True

            if k_dominates_j_in_pieces and k_cuts_strictly_more:
                is_dominated = True
                break
            
        dominancia_j.append("DOMINADO" if is_dominated else "NO DOMINADO")
            
    return dominancia_j



# ======================== RESOLUCIÓN DEL PROBLEMA PLE ========================

def Resolver_PLE(LP: float, longitudes_i: list[float], demandas_i: list[int], PATRONES_LISTA: list[tuple]):
    
    """
    Construye y resuelve el modelo de Programación Lineal Entera (PLE)
    para el Problema de Corte Unidimensional, usando el conjunto completo de patrones.

    El objetivo es minimizar el desperdicio total.

    Parámetros:
        - LP (float): Longitud de la plancha.
        - longitudes_i (list[float]): Longitudes de las piezas.
        - demandas_i (list[int]): Demandas de las piezas.
        - PATRONES_LISTA: Lista de patrones de corte factibles.

    Devuelve:
        - tuple: El modelo resuelto y los resultados.
          Devuelve (None, None) si el solver falla.
    """
    
    t = len(longitudes_i)
    num_patrones = len(PATRONES_LISTA)

    model = pyo.ConcreteModel()
    
    # Conjuntos
    model.I = pyo.RangeSet(0, t - 1)          # Índice de piezas (i)
    model.J = pyo.RangeSet(0, num_patrones - 1) # Índice de patrones (j)

    # Parámetros
    # Demanda (d_i)
    dem_dict = {i: demandas_i[i] for i in range(t)}
    model.dem = pyo.Param(model.I, initialize=dem_dict, within=pyo.NonNegativeReals)

    # Matriz A (a_ij): Coeficientes de cada patrón (piezas de tipo i cortadas por patrón j)
    def matriz_coeficientes_rule(model, i, j):
        return PATRONES_LISTA[j][i]
    model.A = pyo.Param(model.I, model.J, initialize=matriz_coeficientes_rule, within=pyo.NonNegativeIntegers)

    # Cálculo del Sobrante (R_j) para cada patrón, usado como costo objetivo
    R_dict = {}
    for j in model.J:
        patron = PATRONES_LISTA[j]
        longitud_usada = sum(patron[i] * longitudes_i[i] for i in model.I)
        Rj = LP - longitud_usada
        if Rj < 0 and Rj > -1e-8:
            Rj = 0.0
        R_dict[j] = float(Rj)
    model.R = pyo.Param(model.J, initialize=R_dict, within=pyo.NonNegativeReals)

    # Variables de Decisión: X[j] = Número de veces que se usa el patrón j (entero >= 0)
    model.X = pyo.Var(model.J, domain=pyo.NonNegativeIntegers)

    # Objetivo: Minimizar el desperdicio total (Suma de Rj * Xj)
    def ObjRule(model):
        return sum(model.R[j] * model.X[j] for j in model.J)
    model.obj = pyo.Objective(rule=ObjRule, sense=pyo.minimize)

    # Restricciones: Cubrir la demanda de cada pieza i
    def Restriccion_demanda(model, i):
        # Suma de (a_ij * Xj) para todos los patrones debe ser >= demanda d_i
        return sum(model.A[i, j] * model.X[j] for j in model.J) >= model.dem[i]
    model.demanda = pyo.Constraint(model.I, rule=Restriccion_demanda)

    # Resolver el modelo
    solver = pyo.SolverFactory('glpk')
    try:
        results = solver.solve(model, tee=False)
    
        return model, results
    
    except Exception as e:
        print("Error al invocar el solver. Asegúrate de que GLPK está instalado y accesible.")
        print("Excepción:", e)
        
        return None, None


# ----- Resolver_PLE (versión para el modelo con variables y_i) -----

#El exceso de piezas cortadas tambien es sobrante 
def Resolver_PLE_V2(LP: float, longitudes_i: list[float], demandas_i: list[int], PATRONES_LISTA: list[tuple]):
    
    t = len(longitudes_i)
    num_patrones = len(PATRONES_LISTA)

    model = pyo.ConcreteModel()
    model.I = pyo.RangeSet(0, t - 1)
    model.J = pyo.RangeSet(0, num_patrones - 1)

    # Demanda
    dem_dict = {i: demandas_i[i] for i in range(t)}
    model.dem = pyo.Param(model.I, initialize=dem_dict, within=pyo.NonNegativeReals)

    # Matriz A (a_ij)
    def matriz_coeficientes_rule2(model, i, j):
        return PATRONES_LISTA[j][i]
    model.A = pyo.Param(model.I, model.J, initialize=matriz_coeficientes_rule2, within=pyo.NonNegativeIntegers)

    # R_j
    R_dict = {}
    for j in model.J:
        patron = PATRONES_LISTA[j]
        longitud_usada = sum(patron[i] * longitudes_i[i] for i in model.I)
        Rj = LP - longitud_usada
        if Rj < 0 and Rj > -1e-8:
            Rj = 0.0
        R_dict[j] = float(Rj)
    model.R = pyo.Param(model.J, initialize=R_dict, within=pyo.NonNegativeReals)

    # Variables
    model.X = pyo.Var(model.J, domain=pyo.NonNegativeIntegers)   # número de planchas por patrón
    model.y = pyo.Var(model.I, domain=pyo.NonNegativeIntegers)   # exceso de piezas por tipo (holgura)

    # Objetivo: suma residuos + suma longitudes de exceso
    def ObjRule(model):
        return sum(model.R[j] * model.X[j] for j in model.J) + sum(longitudes_i[i] * model.y[i] for i in model.I)
    model.obj = pyo.Objective(rule=ObjRule, sense=pyo.minimize)

    # Restricciones: igualdad con holgura negativa en el lado del exceso
    def Restriccion_demanda(model, i):
        return sum(model.A[i, j] * model.X[j] for j in model.J) - model.y[i] == model.dem[i]
    model.demanda = pyo.Constraint(model.I, rule=Restriccion_demanda)

    solver = pyo.SolverFactory('glpk')
    try:
        results = solver.solve(model, tee=False)
        return model, results
    except Exception as e:
        print("Error al invocar el solver. Asegúrate de que GLPK está instalado y accesible.")
        print("Excepción:", e)
        return None, None


# ============================ FORMATEO DE SALIDA =============================

def Escribir_Solucion(filename, LP, t, longitudes_i, demandas_i, num_patrones_total, model_results_tuple, model_results_tuple_v2, PATRONES_LISTA):
        
    # --- Funciones Auxiliares 
    def pad(s, width):  
        # Centra la cadena 's' en un ancho fijo 'width'.
        return str(s).center(width)

    # Calculo dominancia
    dominancia_j = Calcular_Dominancia(t, PATRONES_LISTA)

    
    model, results = model_results_tuple
    output_lines = []
    
    
    # --- 1. Inicialización y Cálculos de Resultados (Obtenidos de Pyomo) ---
    sobrante_total = 0.0
    num_planchas_usadas = 0

    # Determinar si la solución es óptima 
    es_optima = (str(results.solver.status).lower() == "ok" and 
                   str(results.solver.termination_condition).lower() == "optimal")

    if es_optima:
        for j, patron in enumerate(PATRONES_LISTA):
            try:
                # Obtener el valor de la variable de decisión X[j] (uso del patrón j)
                uso_xj = int(round(pyo.value(model.X[j])))
            except:
                # En caso de error (e.g., variable no inicializada), se asume 0 uso.
                uso_xj = 0
            
            # Calcular la longitud utilizada y el sobrante del patrón.
            longitud_utilizada = sum(patron[i] * longitudes_i[i] for i in range(t))
            sobrante_rj = LP - longitud_utilizada
            
            # Acumular el sobrante total y el número de planchas usadas.
            sobrante_total += uso_xj * sobrante_rj
            num_planchas_usadas += uso_xj
    
    # Formatear valores para la sección de resumen.
    sobrante_display = f"{sobrante_total:.4f}"
    planchas_display = f"{num_planchas_usadas}"



    # 2. Generación de Contenido - CABECERA, TABLA DE PIEZAS, RESUMEN
    # --- Cabecera con Parámetros Principales ---
    output_lines.extend([
        "=" * (54+12),
        f"|Longitud de las planchas |LP = {int(LP):<3d} | Tipos de piezas     |t = {t:<2d} |".ljust(54),
        "=" * (54 +12),
        "", 
        "=" * 54,
    ])
    
    # --- Tabla de Longitudes (Li) y Demandas (di) ---
    header_col_text = f"|{'tipo de pieza i':<{16}}"
    header_col_pieces = "".join([f"|{pad(i+1, 5)}" for i in range(t)])
    output_lines.append(f"{header_col_text}{header_col_pieces}|".ljust(54)) 

    dashes_col_text = f"|{'-'*16}"
    dashes_col_pieces = "".join([f"|{'-'*5}" for _ in range(t)])
    output_lines.append(f"{dashes_col_text}{dashes_col_pieces}|".ljust(54))
    
    # Fila de Longitudes Li
    li_col_text = f"|{'longitud (Li)':<{16}}"
    longitudes_str = "".join([f"|{f'{longitudes_i[i]:>5.2f}'}" for i in range(t)])
    output_lines.append(f"{li_col_text}{longitudes_str}|".ljust(54))
    
    output_lines.append(f"{dashes_col_text}{dashes_col_pieces}|".ljust(54))
    
    # Fila de Demandas di
    di_col_text = f"|{'demanda (di)':<{16}}"
    demandas_str = "".join([f"|{demandas_i[i]:^5d}" for i in range(t)])
    output_lines.append(f"{di_col_text}{demandas_str}|".ljust(54))
    
    output_lines.append("=" * 54) 

    # --- Resumen de la Solución ---
    output_lines.append("") 
    
    # Número de patrones posibles
    output_lines.append("=" * (44+7)) 
    ANCHO_VALOR_PATRONES = 4
    line_patrones = f"SOLUCION OPTIMA: Numero de patrones posibles |{pad(num_patrones_total, ANCHO_VALOR_PATRONES)}|"
    output_lines.append(f"{line_patrones}")
    output_lines.append("=" * (44+7)) 
    
    # Sobrante total y Número de planchas usadas
    output_lines.append("=" * 62) 
    ANCHO_TEXTO_SOBRANTE = 15
    ANCHO_VALOR_SOBRANTE = 10
    ANCHO_TEXTO_PLANCHAS = 29
    ANCHO_VALOR_PLANCHAS = 4
    line_sobrante = f"{'Sobrante total':<{ANCHO_TEXTO_SOBRANTE}}|{sobrante_display:<{ANCHO_VALOR_SOBRANTE}}|"
    line_planchas = f"{'Numero de planchas cortadas':<{ANCHO_TEXTO_PLANCHAS}}|{pad(planchas_display, ANCHO_VALOR_PLANCHAS)}|"
    linea_final_resumen = f"{line_sobrante}{line_planchas}"
    output_lines.append(f"{linea_final_resumen}")
    output_lines.append("=" * 62) 
    output_lines.append("\n")


    # 3. Tabla de patrones detallada 
    # Recalcular el ancho total de la tabla
    ANCHO_COL1 = 6            
    ANCHO_COL2 = t * 4 + (t - 1) 
    ANCHO_COL3 = 8        
    ANCHO_COL4 = 4           
    ANCHO_COL5 = 12    

    ANCHO_TABLA_PATRONES_TOTAL = (
        1 + ANCHO_COL1 + 1 + ANCHO_COL2 + 1 + ANCHO_COL3 + 1 + ANCHO_COL4 + 1 + ANCHO_COL5 + 1
    )
    
    output_lines.append("=" * ANCHO_TABLA_PATRONES_TOTAL)
    
    # --- Encabezado Principal ---
    H1_STR = pad("Patron", ANCHO_COL1) 
    H2_STR = pad("Piezas que corta de cada tipo", ANCHO_COL2) 
    H3_STR = pad("Sobrante", ANCHO_COL3) 
    H4_STR = pad("Uso", ANCHO_COL4) 
    H5_STR = pad("Dominancia", ANCHO_COL5)
    
    output_lines.append(f"|{H1_STR}|{H2_STR}|{H3_STR}|{H4_STR}|{H5_STR}|")
    
    # --- Encabezado Secundario (Indices) ---
    header_piezas_patron = "".join([f"|{pad(i+1, 4)}" for i in range(t)])
    encabezado_secundario = f"|{pad('j', ANCHO_COL1)}{header_piezas_patron}|{pad('Rj', ANCHO_COL3)}|{pad('xj', ANCHO_COL4)}|{pad('Dom', ANCHO_COL5)}|"
    output_lines.append(encabezado_secundario)
    
    # --- Línea Separadora ---
    linea_sep_patron = "-" * ANCHO_COL1
    linea_sep_rj = "-" * ANCHO_COL3
    linea_sep_xj = "-" * ANCHO_COL4
    linea_sep_dom = "-" * ANCHO_COL5 
    piece_dashes = [("-" * 4) for _ in range(t)]
    linea_sep_piezas_completa = "".join([f"|{d}" for d in piece_dashes])
    linea_separadora_completa_patron = f"|{linea_sep_patron}{linea_sep_piezas_completa}|{linea_sep_rj}|{linea_sep_xj}|{linea_sep_dom}|"
    output_lines.append(linea_separadora_completa_patron)

    # --- Filas de Datos de Patrones ---
    for j, patron in enumerate(PATRONES_LISTA):
        
        # Recalculo de Rj (sobrante) para esta fila.
        longitud_utilizada = sum(patron[i] * longitudes_i[i] for i in range(t))
        Rj = LP - longitud_utilizada
        
        # Corrección de valores cercanos a cero debido a errores de punto flotante
        if Rj < 0 and Rj > -1e-8:
            Rj = 0.0

        # Obtener el uso del patrón, asegurando el manejo de errores si Pyomo no da un valor.
        try:
            xj = int(round(pyo.value(model.X[j])))
        except:
            xj = 0
            
        dominancia_status = dominancia_j[j] 
            
        # Formatear el contenido del patrón (a_ij)
        piezas_str = "".join([f"|{p:^{4}}" for p in patron])
        
        # Construir la línea completa del patrón
        line = (
            f"|{pad(j+1, ANCHO_COL1)}"             # Índice del patrón j
            f"{piezas_str}"                        # Cantidades de piezas cortadas
            f"|{Rj:>{ANCHO_COL3}.2f}"              # Sobrante Rj
            f"|{pad(xj, ANCHO_COL4)}"              # Uso del patrón xj
            f"|{pad(dominancia_status, ANCHO_COL5)}|" ) # Estado de Dominancia
        
        output_lines.append(line)

        output_lines.append(linea_separadora_completa_patron)

    output_lines.append("=" * ANCHO_TABLA_PATRONES_TOTAL)

    # 4. Añadir solucion del segundo modelo si existe 
    if model_results_tuple_v2 is not None:

        model2, results2 = model_results_tuple_v2

        output_lines.append("\n")
        output_lines.append("=" * ANCHO_TABLA_PATRONES_TOTAL)
        output_lines.append(" SOLUCION DEL SEGUNDO MODELO (el exceso sobre la demanda cuenta como sobrante) ".center(ANCHO_TABLA_PATRONES_TOTAL))
        output_lines.append("=" * ANCHO_TABLA_PATRONES_TOTAL)

        # Comprobar optimalidad
        es_opt2 = (
            str(results2.solver.status).lower() == "ok"
            and str(results2.solver.termination_condition).lower() == "optimal"
        )

        if not es_opt2:
            output_lines.append(" **El modelo 2 NO tiene solución óptima**")
            output_lines.append("=" * ANCHO_TABLA_PATRONES_TOTAL)

        else:
            # ------------------------------------------------------------------
            # Igual que el modelo 1: Tabla resumen y tabla completa de patrones
            # ------------------------------------------------------------------
            
            # Cálculo del sobrante total
            sobrante_total_2 = 0
            num_planchas_usadas_2 = 0

            for j, patron in enumerate(PATRONES_LISTA):
                xj = int(round(pyo.value(model2.X[j])))
                longitud_usada = sum(patron[i] * longitudes_i[i] for i in range(t))
                Rj = LP - longitud_usada
                if Rj < 0 and Rj > -1e-8:
                    Rj = 0.0
                sobrante_total_2 += xj * Rj
                num_planchas_usadas_2 += xj

            # Ahora añadir al sobrante total el exceso de piezas * longitud
            for i in range(t):
                yi = int(round(pyo.value(model2.y[i])))
                sobrante_total_2 += yi * longitudes_i[i]

            # Resumen
            output_lines.append("")
            output_lines.append(f"Sobrante total modelo 2:        {sobrante_total_2:.4f}")
            output_lines.append(f"Planchas usadas modelo 2:       {num_planchas_usadas_2}")
            output_lines.append("")

            # ------------------------
            # Tabla de patrones (V2)
            # ------------------------
            output_lines.append("=" * ANCHO_TABLA_PATRONES_TOTAL)
            output_lines.append(f"|{H1_STR}|{H2_STR}|{H3_STR}|{H4_STR}|{H5_STR}|")
            output_lines.append(encabezado_secundario)
            output_lines.append(linea_separadora_completa_patron)

            for j, patron in enumerate(PATRONES_LISTA):

                # Recalcular Rj
                longitud_usada = sum(patron[i] * longitudes_i[i] for i in range(t))
                Rj = LP - longitud_usada
                if Rj < 0 and Rj > -1e-8:
                    Rj = 0.0

                # Uso Xj del modelo 2
                try:
                    xj2 = int(round(pyo.value(model2.X[j])))
                except:
                    xj2 = 0

                # Dominancia idéntica
                dominancia_status = dominancia_j[j]

                piezas_str = "".join([f"|{p:^{4}}" for p in patron])

                line = (
                    f"|{pad(j+1, ANCHO_COL1)}"
                    f"{piezas_str}"
                    f"|{Rj:>{ANCHO_COL3}.2f}"
                    f"|{pad(xj2, ANCHO_COL4)}"
                    f"|{pad(dominancia_status, ANCHO_COL5)}|"
                )

                output_lines.append(line)
                output_lines.append(linea_separadora_completa_patron)

            output_lines.append("=" * ANCHO_TABLA_PATRONES_TOTAL)

            # ------------------------
            # Valores de y_i (exceso)
            # ------------------------
            output_lines.append("\nExceso de piezas por tipo (y_i):")
            for i in range(t):
                yi = int(round(pyo.value(model2.y[i])))
                output_lines.append(f"   Tipo {i+1}: y_{i+1} = {yi}")
            output_lines.append("")
            output_lines.append("=" * ANCHO_TABLA_PATRONES_TOTAL)

    # 5. Escribir a archivo
    try:
        with open(filename, 'w', encoding='utf-8') as f:
            # Escribir cabecera fija del informe
            f.write('|====================|\n')
            f.write('| PRACTICA 3: CORTES |\n')
            f.write('|====================|\n')
            f.write('\n')
            # Escribir todas las líneas de contenido generadas
            f.write('\n'.join(output_lines))
    except Exception as e:
        # Manejo de error si no se puede escribir el archivo
        print(f"\n Error al escribir el archivo '{filename}': {e}")  
        
        
# ======================== FUNCIÓN DE EJECUCIÓN PRINCIPAL =====================

def Ejecutar_Modelo_Corte(nombre_archivo_entrada: str, nombre_archivo_salida: str):
    
    """
    Coordina el flujo completo del Problema de Corte Unidimensional:
    1. Lee datos.
    2. Genera todos los patrones factibles.
    3. Resuelve el modelo de Programación Lineal Entera (PLE).
    4. Escribe los resultados en un archivo de salida.

    Parámetros:
        - nombre_archivo_entrada (str): Nombre del archivo que contiene LP, Li y di.
        - nombre_archivo_salida (str): Nombre del archivo donde se guardará la solución.
    """
    
    # 1. Lectura de datos
    LP_extraido, longitudes_extraidas, demandas_extraidas = Leer_Datos_Archivo(nombre_archivo_entrada)

    if LP_extraido is not None:
        t = len(longitudes_extraidas)

        # 2. Generación de patrones
        PATRONES_LISTA = Generar_Patrones(LP_extraido, longitudes_extraidas, t)
        num_patrones = len(PATRONES_LISTA)
        
        # 3. Resolucion del modelo de PLE
        model1, results1 = Resolver_PLE(LP_extraido, longitudes_extraidas, demandas_extraidas, PATRONES_LISTA)
        model2, results2 = Resolver_PLE_V2(LP_extraido, longitudes_extraidas, demandas_extraidas, PATRONES_LISTA)      
        
        if model1 is not None and model2 is not None:
            Escribir_Solucion( nombre_archivo_salida, LP_extraido, t, longitudes_extraidas, demandas_extraidas,
                num_patrones, (model1, results1),(model2, results2), PATRONES_LISTA)
        
            
        else:
            # Error manejado dentro de Resolver_PLE 
            print("\nEl script se detiene debido a un error del solver.")
    else:
        # Error manejado dentro de Leer_Datos_Archivo
         print("\nEl script se detiene. Por favor, asegúrate de que el archivo de datos está accesible y con el formato correcto.")


# ============================== CÓDIGO PRINCIPAL =============================

if __name__ == "__main__":
    # Llama a la función principal con los nombres de archivo
    Ejecutar_Modelo_Corte("Datos3_TAO.dat", "Solucion3_TAO.sol")
    
    
    
    
    
    
    
    