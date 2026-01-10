#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Nov 21 14:44:42 2025

@author: cati
"""
import pyomo.environ as pyo
from pyomo.opt import SolverFactory
import sys
import numpy as np 

# =============================================================================
# PRACTICA 2: TEORÍA DE JUEGOS
#
# Objetivo:
#   Resolver juegos bipersonales de suma nula (dado que la matriz representa
#   los pagos al jugador A) encontrando las estrategias mixtas óptimas (x para
#   el jugador maximizador A, e y para el jugador minimizador B) y el valor
#   del juego (v).
#
# Método Implementado:
#   El problema se formula y resuelve como un par de problemas duales de
#   Programación Lineal (PL) utilizando la librería Pyomo:
#   - El problema primario (maximización) modela la perspectiva del jugador A,
#     buscando maximizar el valor mínimo esperado (alpha).
#   - La solución para el jugador B (estrategias mixtas y) se extrae de las
#     variables duales del problema primario de A.
#
# Entradas:
#   - Archivo 'Datos2_TAO.dat': contiene las matrices de pagos de los juegos.
#
# Salidas:
#   - Archivo 'Solucion2_TAO.sol': resultados detallados de cada juego,
#     incluyendo la matriz de pagos original, las estrategias mixtas óptimas
#     en los márgenes (x(A) y y(B)), y el valor del juego (v).
#
# =============================================================================


# ======================== LECTURA Y EXTRACCIÓN DE DATOS ======================

def Leer_archivo(file_path: str) -> str:
	
	"""
	Lee el contenido del archivo de datos.
	"""
	
	try:
		with open(file_path, 'r', encoding='utf-8') as f:
			return f.read()
		
	except UnicodeDecodeError:
		with open(file_path, 'r', encoding='latin-1') as f:
			return f.read()
		

def Extraer_Matrices_Juegos(file_content: str) -> list[tuple[int, list]]:
	
	"""
	Busca y extrae todas las matrices de pagos de juegos en el archivo.
	"""
	
	lines = file_content.split('\n')
	juegos_encontrados = []
	current_game_number = None
	current_matrix = []
	
	for line in lines:
		line = line.strip()
		
		# 1. Identificar el inicio de un nuevo juego (e.g., "JUEGO 1:")
		if line.startswith("JUEGO ") and line.endswith(":"):
			if current_matrix and current_game_number is not None:
				juegos_encontrados.append((current_game_number, current_matrix))
			
			try:
				number_str = line.split(' ')[1][:-1]
				current_game_number = int(number_str) 
				current_matrix = []
			except ValueError:
				current_game_number = None
			continue

		# 2. Identificar filas de la matriz
		if current_game_number is not None and line.startswith('| A-'):
			parts = line.split('|')[2:-2] 
			
			row = []
			for part in parts:
				try:
					row.append(float(part.strip().replace(',', '.'))) 
				except ValueError:
					continue
			
			if row:
				current_matrix.append(row)
		
		# 3. Identificar el final de la matriz (línea divisoria)
		if current_game_number is not None and line.startswith('|=====') and current_matrix:
			juegos_encontrados.append((current_game_number, current_matrix))
			current_game_number = None
			current_matrix = []
			
	if current_game_number is not None and current_matrix:
		juegos_encontrados.append((current_game_number, current_matrix))

	if not juegos_encontrados:
		raise ValueError("No se pudo parsear ninguna matriz de pagos en el archivo.")

	return juegos_encontrados


# ========================== SOLUCIÓN PUNTO DE SILLA ==========================

def Resolver_PS (PAGOS_A: list) -> tuple or None:
	
	"""
	Busca un punto de silla (estrategias puras) en la matriz de pagos.
	"""
	
	matriz = np.array(PAGOS_A)
	
	# Mínimos de Fila (Maximin de A)
	minimos_fila = np.min(matriz, axis=1)
	valor_maximin = np.max(minimos_fila)
	
	# Máximos de Columna (Minimax de B)
	maximos_columna = np.max(matriz, axis=0)
	valor_minimax = np.min(maximos_columna)

	# Comprobar Punto de Silla con tolerancia
	TOLERANCIA = 1e-9
	if abs(valor_maximin - valor_minimax) < TOLERANCIA:
		v = valor_maximin
		
		indice_maximin_A = np.argmax(minimos_fila)
		indice_minimax_B = np.argmin(maximos_columna)

		M = matriz.shape[0]
		N = matriz.shape[1]
		
		# Estrategias puras
		estrategia_A = [0.0] * M
		estrategia_A[indice_maximin_A] = 1.0

		estrategia_B = [0.0] * N
		estrategia_B[indice_minimax_B] = 1.0
		
		return v, estrategia_A, estrategia_B
	else:
		return None


# ============================ PROGRAMACIÓN LINEAL ===========================

def Resolver_LP(PAGOS_A: list) -> tuple:
	
	"""
	Resuelve el juego de suma nula mediante Programación Lineal (PL).
	"""
	
	model = pyo.ConcreteModel()
	
	M = len(PAGOS_A)
	N = len(PAGOS_A[0])
	model.I = pyo.RangeSet(1, M)
	model.J = pyo.RangeSet(1, N)
	
	matrix_data = {(i, j): PAGOS_A[i-1][j-1] for i in model.I for j in model.J}
	model.A = pyo.Param(model.I, model.J, initialize=matrix_data)
	
	model.X = pyo.Var(model.I, domain=pyo.NonNegativeReals)
	model.alpha = pyo.Var(domain=pyo.Reals)
	
	model.obj = pyo.Objective(expr=model.alpha, sense=pyo.maximize)
	
	def Restriccion_alpha_rule(model, j):
		return sum(model.A[i, j] * model.X[i] for i in model.I) >= model.alpha
	model.dominancia = pyo.Constraint(model.J, rule=Restriccion_alpha_rule)

	def prob_sum_A_rule(model):
		return sum(model.X[i] for i in model.I) == 1
	model.prob_sum = pyo.Constraint(rule=prob_sum_A_rule)

	model.dual = pyo.Suffix(direction=pyo.Suffix.IMPORT_EXPORT)
	solver = pyo.SolverFactory('glpk', keepfiles=False, verbose=False)
	solver.solve(model, tee=False)

	valor_del_juego = pyo.value(model.alpha)
	estrategia_A = [pyo.value(model.X[i]) for i in model.I]
	
	dual_values = [model.dual[model.dominancia[j]] for j in model.J]
	estrategia_B = []
	TOLERANCIA = 1e-9
	
	try:
		suma_duales = sum(d for d in dual_values if d is not None)
		
		if suma_duales is not None and abs(suma_duales) > TOLERANCIA: 
			estrategia_B = [d / suma_duales for d in dual_values]
		else:
			estrategia_B = [0.0] * N 
			
	except (TypeError, ZeroDivisionError):
		estrategia_B = [0.0] * N
		
	return valor_del_juego, estrategia_A, estrategia_B


# ============================ FORMATEO DE SALIDA =============================

def formatear_salida(game_number: int, metodo: str, matriz: list, v: float, x: list, y: list) -> str:
	
	"""
	Genera la cadena de texto con el resultado, incluyendo el método usado.
	"""
	
	M = len(matriz)
	N = len(matriz[0])
	
	# Definición de formatos
	FMT_MATRIZ = "{:^9.2f}"	 
	FMT_SOL = "{:^9.4f}"	 
	TOLERANCIA_CERO = 1e-9

	# Cadenas de separación
	sep_9 = "---------" 
	eq_9 = "=========" 
	sep_4 = "----"
	eq_4 = "===="

	# 1. Construcción de la Cabecera
	header_b_content = "".join([f"|{'B-'+str(j+1):^9s}" for j in range(N)])
	header_line = f"|{'A|B':^4s}|{header_b_content}||{'x(A)':^9s}|\n" 
	
	# 2. Líneas Divisorias
	sep_inner_content = ("|" + sep_9) * N
	eq_inner_content = ("|" + eq_9) * N
	separator_line_top = f"|{eq_4:^4s}|{eq_inner_content}||{eq_9}|\n"
	separator_line_mid = f"|{sep_4:^4s}|{sep_inner_content}||{sep_9}|\n"
	
	total_width = len(header_line.strip())
	equals_line = "=" * total_width + "\n"
	
	# Encabezado del juego con método
	output = f"JUEGO {game_number}:\n"
	output += f"(Método: {metodo})\n\n"
	
	output += equals_line
	output += header_line
	output += separator_line_top
	
	# 3. Filas de la Matriz con estrategias x(A)
	for i in range(M):
		row_data = "".join([f"|{FMT_MATRIZ.format(matriz[i][j])}" for j in range(N)])
		
		x_val = x[i] if len(x) > i else 0.0
		
		# Suprimir valores muy cercanos a cero para claridad
		if abs(x_val) < TOLERANCIA_CERO:
			row_x = f"||{'0.0000':^9s}|"
		else:
			row_x = f"||{FMT_SOL.format(x_val)}|"
		
		row_label_content = f"A-{i+1}"
		
		output += f"|{row_label_content:^4s}|{row_data}{row_x}\n"
		
		if i < M - 1:
			output += separator_line_mid
			
	# 4. Fila de estrategias y(B) y Valor del Juego (v)
	output += separator_line_top
	
	row_y_data = "".join([f"|{FMT_SOL.format(y[j] if len(y) > j and abs(y[j]) > TOLERANCIA_CERO else 0.0)}" for j in range(N)])
	
	row_v = f"||{FMT_SOL.format(v)}|"
	
	row_label_y_content = "y(B)"
	
	output += f"|{row_label_y_content:^4s}|{row_y_data}{row_v}\n"
	output += equals_line
	
	output += "\n\n"
	
	return output


# ============================ PROGRAMA PRINCIPAL ============================

def Ejecucion (input_file: str, output_file: str):
    
	"""
	Función principal que ejecuta la práctica.
	"""
	
	FILE_PATH = input_file
	OUTPUT_FILE = output_file
	final_output = ""

	try:
		# A) LECTURA Y EXTRACCIÓN
		file_content = Leer_archivo(FILE_PATH)
		
		juegos_a_resolver = Extraer_Matrices_Juegos(file_content)
		
		# B) SOLUCIÓN DE TODOS LOS PROBLEMAS ENCONTRADOS
		for game_number, matriz_pagos in juegos_a_resolver:
			
			# 1. Intentar resolver con punto de silla (estrategias puras)
			solucion = Resolver_PS(matriz_pagos)
			
			if solucion:
				v, x, y = solucion
				metodo = "Estrategias Puras (Punto de Silla)"
			else:
				# 2. Si no hay, usar Programación Lineal (estrategias mixtas)
				v, x, y = Resolver_LP(matriz_pagos)
				metodo = "Estrategias Mixtas (Programación Lineal)"

			# C) FORMATEO Y ACUMULACIÓN DE LA SALIDA (PASANDO EL MÉTODO)
			final_output += formatear_salida(game_number, metodo, matriz_pagos, v, x, y)
			
		
		# D) ESCRITURA EN EL FICHERO DE SALIDA
		
		with open(OUTPUT_FILE, 'w') as f:
			f.write('|====================|\n')
			f.write('| PRÁCTICA 2: JUEGOS |\n')
			f.write('|====================|\n')
			f.write('\n')
			f.write(final_output)
			
	except FileNotFoundError:
		print(f"Error: No se encontró el archivo de entrada: {FILE_PATH}.", file=sys.stderr)
	except ValueError as e:
		print(f"Error de interpretación de los datos o solución: {e}", file=sys.stderr)
	except Exception as e:
		print(f"Ocurrió un error inesperado durante la ejecución: {e}", file=sys.stderr)
		

if __name__ == '__main__':
	INPUT_FILE = 'Datos2_TAO.dat'
	OUTPUT_FILE = 'Solucion2_TAO.sol'
	
	Ejecucion(INPUT_FILE, OUTPUT_FILE)
    
    
    
    
    