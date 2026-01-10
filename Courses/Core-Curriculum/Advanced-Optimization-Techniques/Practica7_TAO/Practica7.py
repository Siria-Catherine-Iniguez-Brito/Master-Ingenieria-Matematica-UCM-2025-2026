#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Dec  4 20:51:26 2025

@author: cati
"""
# =============================================================================
# PRÁCTICA 7: CABLEADO
#
# Objetivo:
#    Minimizar el coste total de instalación de un cable que conecta los puntos
#    A y B, pasando por dos puntos intermedios P y Q, a través de tres zonas
#    con diferente coste unitario.
#
# Modelo de Optimización (Cálculo No Lineal):
#    La geometría se define en un plano 2D:
#    - A = (0, 0)
#    - P = (AR, y_P)  (donde y_P = RP)
#    - Q = (AR + RS, y_Q) (donde y_Q = SQ)
#    - B = (AR + RS + ST, TB)
#
#    La función de coste total C(y_P, y_Q) es la suma de (Longitud * Coste Unitario):
#    C(y_P, y_Q) = L_AP * 1 + L_PQ * m + L_QB * n
#
#    Donde las longitudes (L) se calculan por el teorema de Pitágoras:
#    L_AP = sqrt(AR^2 + y_P^2)
#    L_PQ = sqrt(RS^2 + (y_Q - y_P)^2)
#    L_QB = sqrt(ST^2 + (TB - y_Q)^2)
#
# Variables de Decisión:
#    - y_P (Longitud RP)
#    - y_Q (Longitud SQ)
#
# Restricciones:
#    - y_P >= 0
#    - y_Q >= 0
#
# Entradas:
#   - Archivo de entrada: 'Datos6.dat' conteniendo:
# Salidas:
#   - Archivo de salida: Solucion6.sol.
# =============================================================================

import pyomo.environ as pyo
from scipy.optimize import fsolve, minimize
import sys
import os
import numpy as np
from datetime import datetime


# ===================== FUNCIÓN PARA LEER DATOS DEL ARCHIVO =================== 

def Leer_Datos (nombre_archivo):
    
    """
    Lee los datos de un archivo con la estructura especificada.
    
    """
    casos = []
    
    try:
        with open(nombre_archivo, 'r') as f:
            lineas = f.readlines()
        
        # Buscar líneas que contengan datos de casos
        for linea in lineas:
            if linea.strip().startswith('|') and any(c.isdigit() for c in linea):
                partes = linea.strip().split('|')
                partes = [p.strip() for p in partes if p.strip()]
                if len(partes) >= 7:
                    try:
                        caso_id = int(partes[0])
                        m = float(partes[1])
                        n = float(partes[2])
                        AR = float(partes[3])
                        RS = float(partes[4])
                        ST = float(partes[5])
                        TB = float(partes[6])
                        
                        casos.append((m, n, AR, RS, ST, TB, caso_id))
                        
                    except (ValueError, IndexError) as e:
                        # Si hay error en la conversión, ignorar la línea
                        continue
        if not casos:
            raise ValueError("No se pudieron leer datos del archivo. Verifique el formato.")
        
        return casos
        
    except FileNotFoundError:
        print(f"Error: No se encontró el archivo '{nombre_archivo}'")
        sys.exit(1)
        
    except Exception as e:
        print(f"✗ Error al leer el archivo: {e}")
        sys.exit(1)




# ===================== FUNCIONES COMUNES =================== 
def Fun_Objetivo(x, y, m, n, AR, RS, ST, TB):
    
    """Función objetivo: coste total del cable"""
    
    AP = np.sqrt(AR**2 + x**2)
    PQ = np.sqrt(RS**2 + (y - x)**2)
    QB = np.sqrt(ST**2 + (TB - y)**2)
    
    return AP + m * PQ + n * QB


def Gradiente(x, y, m, n, AR, RS, ST, TB):
  
    """Gradiente de la función objetivo"""
    
    AP = np.sqrt(AR**2 + x**2)
    PQ = np.sqrt(RS**2 + (y - x)**2)
    QB = np.sqrt(ST**2 + (TB - y)**2)
    
    df_dx = x/AP - m*(y - x)/PQ
    df_dy = m*(y - x)/PQ - n*(TB - y)/QB
    
    return np.array([df_dx, df_dy])

 
# ====================== ESCRIBIR TABLA  ======================
 
def Escribir_Resultados(f, resultados, casos, nombre_metodo):
    
    """Escribe los resultados en un archivo de salida"""
    
    f.write(f"\nMÉTODO: {nombre_metodo}\n")
    f.write("="*82+ "\n")
    f.write("   |Caso |   m  |   n  |  AR  |  RS  |  ST  |  TB  |   RP   |   SQ   | coste total|\n")
    f.write("   |-----|------|------|------|------|------|------|--------|--------|------------|\n")
    
    for idx, (m, n, AR, RS, ST, TB, caso_id) in enumerate(casos):
        resultado = next((r for r in resultados if r[0] == caso_id), None)
        
        if resultado and resultado[1] is not None:
            RP = resultado[1]
            SQ = resultado[2]
            coste = resultado[3]
            
            f.write(f"   | {caso_id:3d} | {m:4.2f} | {n:4.2f} | {AR:4.2f} | {RS:4.2f} | {ST:4.2f} | {TB:4.2f} | "
                  f"{RP:6.4f} | {SQ:6.4f} | {coste:10.4f} |\n")
        else:
            f.write(f"   | {caso_id:3d} | {m:4.2f} | {n:4.2f} | {AR:4.2f} | {RS:4.2f} | {ST:4.2f} | {TB:4.2f} | "
                  f"{'---':6} | {'---':6} | {'---':10} |\n")
        
        if idx < len(casos) - 1:
            f.write("   |-----|------|------|------|------|------|------|--------|--------|------------|\n")
    
    f.write("="*82 + "\n")

# ============================
# MÉTODO NLP CON RESTRICCIONES (IPOPT)
# ============================
def Metodo_nlp(m, n, AR, RS, ST, TB, caso_id ):
    
    """Método 1: Optimización multivariable con restricciones (NLP - IPOPT)"""
    
    resultados = []
    
    model = pyo.ConcreteModel()
        
    model.x = pyo.Var(within=pyo.NonNegativeReals, bounds=(0, TB))
    model.y = pyo.Var(within=pyo.NonNegativeReals, bounds=(0, TB))
        
    def objetivo_rule(model):
        AP = (AR**2 + model.x**2)**0.5
        PQ = (RS**2 + (model.y - model.x)**2)**0.5
        QB = (ST**2 + (TB - model.y)**2)**0.5
        
        return AP + m * PQ + n * QB
        
    model.obj = pyo.Objective(rule=objetivo_rule, sense=pyo.minimize)
        
    solver = pyo.SolverFactory('ipopt')
    solver.options['tol'] = 1e-12
    solver.options['print_level'] = 0
        
    results = solver.solve(model, tee=False)
        
    if results.solver.termination_condition == pyo.TerminationCondition.optimal:
        RP = pyo.value(model.x)
        SQ = pyo.value(model.y)
        coste = pyo.value(model.obj)
        resultados.append((caso_id, RP, SQ, coste))
    else:
        resultados.append((caso_id, None, None, None))

    return resultados

# ============================
# OPTIMIZACIÓN UNIVARIABLE (ALTERNANDO VARIABLES)
# ============================
def metodo_univariable( m, n, AR, RS, ST, TB, caso_id):
    
    """Método 2: Optimización univariable (alternando variables)"""
    
    resultados = []
    
    x, y = TB/3, 2*TB/3
    phi = (np.sqrt(5) - 1) / 2
        
    for _ in range(50):
        
        x_prev, y_prev = x, y
            
        def f_x(x_val):
            return Fun_Objetivo(x_val, y, m, n, AR, RS, ST, TB)
            
        a, b = 0, TB
        for _ in range(30):
            x1 = b - phi * (b - a)
            x2 = a + phi * (b - a)
            if f_x(x1) < f_x(x2):
                b = x2
            else:
                a = x1
        x = (a + b) / 2
            
        def f_y(y_val):
            return Fun_Objetivo(x, y_val, m, n, AR, RS, ST, TB)
            
        a, b = 0, TB
        for _ in range(30):
            y1 = b - phi * (b - a)
            y2 = a + phi * (b - a)
            if f_y(y1) < f_y(y2):
                b = y2
            else:
                a = y1
        y = (a + b) / 2
            
        if abs(x - x_prev) < 1e-6 and abs(y - y_prev) < 1e-6:
            break
    
    coste = Fun_Objetivo(x, y, m, n, AR, RS, ST, TB)
    resultados.append((caso_id, x, y, coste))
    
   
    return resultados


#============================ NEWTON-RAPHSON MEJORADO ============================

def metodo_newton_mejorado(m, n, AR, RS, ST, TB, caso_id ):
    """Método 3: Resolución de ecuaciones no lineales (Newton-Raphson mejorado)"""

    resultados = []

    def ecuaciones(vars):
        x, y = vars
        AP = np.sqrt(AR**2 + x**2)
        PQ = np.sqrt(RS**2 + (y - x)**2)
        QB = np.sqrt(ST**2 + (TB - y)**2)
            
        eq1 = x/AP - m*(y - x)/PQ
        eq2 = m*(y - x)/PQ - n*(TB - y)/QB
        return np.array([eq1, eq2])
        
    mejores_puntos = [
        (TB/2.5, 2*TB/3),
        (TB/3, 2*TB/3),
        (TB/2, TB/2),
        (TB/3, TB/1.5),
    ]
        
    mejor_sol = None
    mejor_norma = float('inf')
        
    for x_ini, y_ini in mejores_puntos:
        x, y = x_ini, y_ini
            
        try:
            for iter in range(50):
                F = ecuaciones([x, y])
                    
                if np.linalg.norm(F) < 1e-10:
                    break
                    
                h = 1e-6
                J = np.zeros((2, 2))
                    
                F_xp = ecuaciones([x + h, y])
                F_xm = ecuaciones([x - h, y])
                J[0, 0] = (F_xp[0] - F_xm[0]) / (2*h)
                J[1, 0] = (F_xp[1] - F_xm[1]) / (2*h)
                    
                F_yp = ecuaciones([x, y + h])
                F_ym = ecuaciones([x, y - h])
                J[0, 1] = (F_yp[0] - F_ym[0]) / (2*h)
                J[1, 1] = (F_yp[1] - F_ym[1]) / (2*h)
                
                det = np.linalg.det(J)
                if abs(det) < 1e-12:
                    g = Gradiente(x, y, m, n, AR, RS, ST, TB)
                    x -= 0.01 * g[0]
                    y -= 0.01 * g[1]
                else:
                    delta = np.linalg.solve(J, -F)
                    x += delta[0]
                    y += delta[1]
                    
                x = max(0.01, min(x, TB - 0.01))
                y = max(0.01, min(y, TB - 0.01))
                    
                if iter > 10 and np.linalg.norm(F) > mejor_norma:
                    break
                
            norma_actual = np.linalg.norm(F)
            if norma_actual < mejor_norma:
                mejor_norma = norma_actual
                mejor_sol = (x, y)
                    
        except:
            continue
        
    if mejor_sol is not None:
        x, y = mejor_sol
        coste = Fun_Objetivo(x, y, m, n, AR, RS, ST, TB)
        resultados.append((caso_id, x, y, coste))
    else:
        resultados.append((caso_id, None, None, None))
    
    return resultados

# ============================
# GRADIENTE DESCENDENTE CON RESTRICCIONES
# ============================
def metodo_gradiente_descendente(m, n, AR, RS, ST, TB, caso_id ):
    
    """Método 4: Gradiente descendente con restricciones"""
    resultados = []
    
    x, y = TB/3, 2*TB/3
    alpha = 0.1
        
    for iter in range(500):
        AP = np.sqrt(AR**2 + x**2)
        PQ = np.sqrt(RS**2 + (y - x)**2)
        QB = np.sqrt(ST**2 + (TB - y)**2)
            
        df_dx = x/AP - m*(y - x)/PQ
        df_dy = m*(y - x)/PQ - n*(TB - y)/QB
            
        alpha_actual = alpha
        f_old = Fun_Objetivo(x, y, m, n, AR, RS, ST, TB)
            
        for _ in range(20):
            x_new = x - alpha_actual * df_dx
            y_new = y - alpha_actual * df_dy
                
            x_new = max(0, min(x_new, TB))
            y_new = max(0, min(y_new, TB))
                
            f_new = Fun_Objetivo(x_new, y_new, m, n, AR, RS, ST, TB)
                
            if f_new < f_old:
                break
            alpha_actual *= 0.5
            
        x, y = x_new, y_new
            
        if np.sqrt(df_dx**2 + df_dy**2) < 1e-6:
            break
        
    coste = Fun_Objetivo(x, y, m, n, AR, RS, ST, TB)
    resultados.append((caso_id, x, y, coste))
    
    return resultados

# ============================
# SCIPY FSOLVE 
# ============================
def metodo_fsolve_mejorado(m, n, AR, RS, ST, TB, caso_id):
    """Método 5: Scipy fsolve (resolución de sistema de ecuaciones)"""

    resultados = []
    
 
    def ecuaciones(vars):
        x, y = vars
        AP = np.sqrt(AR**2 + x**2)
        PQ = np.sqrt(RS**2 + (y - x)**2)
        QB = np.sqrt(ST**2 + (TB - y)**2)
            
        eq1 = x/AP - m*(y - x)/PQ
        eq2 = m*(y - x)/PQ - n*(TB - y)/QB
        return [eq1, eq2]
        
    mejores_puntos = [
        [TB/2.5, 2*TB/3],
        [TB/3, 2*TB/3],
        [TB/2, TB/2],
    ]
        
    mejor_sol = None
    mejor_coste = float('inf')
        
    for x0 in mejores_puntos:
        try:
            sol = fsolve(ecuaciones, x0, full_output=True, xtol=1e-12, maxfev=200)
            
            if sol[2] == 1:
                x, y = sol[0]
                    
                if 0 <= x <= TB and 0 <= y <= TB:
                    coste = Fun_Objetivo( x, y, m, n, AR, RS, ST, TB)
                        
                    g = Gradiente(x, y, m, n, AR, RS, ST, TB)
                    if np.linalg.norm(g) < 1e-6 and coste < mejor_coste:
                        mejor_coste = coste
                        mejor_sol = (x, y, coste)
        except:
            continue
        
    if mejor_sol is not None:
        x, y, coste = mejor_sol
        resultados.append((caso_id, x, y, coste))
    else:
        resultados.append((caso_id, None, None, None))

    return resultados

# ============================
# SCIPY MINIMIZE (L-BFGS-B)
# ============================
def metodo_bfgs(m, n, AR, RS, ST, TB, caso_id):
    """Método 6: Scipy minimize (L-BFGS-B)"""

    resultados = []
    
    def objetivo(vars):
        x, y = vars
        return Fun_Objetivo (x, y, m, n, AR, RS, ST, TB)
    
    x0 = [TB/3, 2*TB/3]
    
    try:
            result = minimize(objetivo, x0, method='L-BFGS-B', 
                            bounds=[(0, TB), (0, TB)],
                            options={'ftol': 1e-12, 'gtol': 1e-12, 'maxiter': 1000})
            
            if result.success:
                x, y = result.x
                coste = result.fun
                resultados.append((caso_id, x, y, coste))
            else:
                result = minimize(objetivo, x0, method='SLSQP',
                                bounds=[(0, TB), (0, TB)],
                                options={'ftol': 1e-12, 'maxiter': 1000})
                
                if result.success:
                    x, y = result.x
                    coste = result.fun
                    resultados.append((caso_id, x, y, coste))
                else:
                    resultados.append((caso_id, None, None, None))
    except:
        resultados.append((caso_id, None, None, None))
    

    return resultados

# ============================
# FUNCIÓN PARA GUARDAR TODOS LOS RESULTADOS
# ============================
def guardar_todos_resultados(casos, metodos_resultados, nombre_salida):
    
    """Guarda todos los resultados de todos los métodos en el archivo de salida"""
    try:
        with open(nombre_salida, 'w') as f:
            # Encabezado del archivo
            f.write("PRACTICA 7: CABLEADO \n")
            f.write("            ========\n \n")
            
            # Escribir resultados de cada método
            for nombre_metodo, resultados in metodos_resultados.items():
                Escribir_Resultados(f, resultados, casos, nombre_metodo)
            # Resumen final
            f.write("\n" + "="*82 + "\n")
            f.write("RESUMEN DE CONVERGENCIA POR MÉTODO\n")
            f.write("="*82 + "\n")
            
            for nombre_metodo, resultados in metodos_resultados.items():
                exitosos = sum(1 for r in resultados if r[1] is not None)
                porcentaje = (exitosos / len(casos)) * 100
                f.write(f"{nombre_metodo:20}: {exitosos:2d}/{len(casos):2d} casos ({porcentaje:5.1f}%)\n")
            
            f.write("="*82 + "\n")

        return True
        
    except Exception as e:
        print(f"✗ Error al guardar resultados: {e}")
        return False

# ============================
# PROGRAMA PRINCIPAL
# ============================
def main(archivo_entrada, archivo_salida):

    # Leer datos del archivo
    casos = Leer_Datos(archivo_entrada)


    # Ejecutar todos los métodos    
    resultados_nlp = []
    resultados_uni = []
    resultados_newton = []
    resultados_grad =[]
    resultados_fsolve = []
    resultados_bfgs = []

    for m, n, AR, RS, ST, TB, caso_id in casos:
        resultados_nlp.extend(Metodo_nlp(m, n, AR, RS, ST, TB, caso_id))
        resultados_uni.extend( metodo_univariable(m, n, AR, RS, ST, TB, caso_id))
        resultados_newton.extend( metodo_newton_mejorado(m, n, AR, RS, ST, TB, caso_id))
        resultados_grad.extend( metodo_gradiente_descendente(m, n, AR, RS, ST, TB, caso_id))
        resultados_fsolve.extend(metodo_fsolve_mejorado(m, n, AR, RS, ST, TB, caso_id))
        resultados_bfgs.extend( metodo_bfgs (m, n, AR, RS, ST, TB, caso_id))
        

    # Preparar diccionario con todos los resultados
    metodos_resultados = {
        "NLP (IPOPT)": resultados_nlp,
        "Univariable": resultados_uni,
        "Newton-Raphson": resultados_newton,
        "Gradiente Descendente": resultados_grad,
        "fsolve (Scipy)": resultados_fsolve,
        "BFGS (Scipy)": resultados_bfgs
    }
    
    # Guardar todos los resultados en el archivo
    guardar_todos_resultados(casos, metodos_resultados, archivo_salida)
    
    

# ============================
# EJECUCIÓN
# ============================

archivo_entrada = "Datos7.dat"
archivo_salida = "Solucion7.sol"
if __name__ == "__main__":
    main(archivo_entrada, archivo_salida)
    
    
    
    
    