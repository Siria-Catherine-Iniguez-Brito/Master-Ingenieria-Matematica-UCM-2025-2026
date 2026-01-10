import numpy as np
import re
import sys


# ============================= LECTURA DE DATOS =============================

def Leer_Datos(nombre_archivo):
    """
    Lee los datos del archivo de entrada.
    """
    A_list = []
    b_list = []
    p_list = []
    q_list = []
    alpha = None
    beta = None

    regex_f = r"f\(x\) = \((.*?)\*x1 \+ (.*?)\*x2 \+ (.*?)\) / \((.*?)\*x1 \+ (.*?)\*x2 \+ (.*?)\)"
    
    regex_restriccion_escalable = r"A\d+1\s*=\s*([-\d\.]+)\s*A\d+2\s*=\s*([-\d\.]+)\s*b\d+\s*=\s*([-\d\.]+)"
    
    try:
        with open(nombre_archivo, 'r') as archivo:
            contenido = archivo.read().replace('\n', ' ') 
            
            # Función objetivo
            match_f = re.search(regex_f, contenido)
            if match_f:
                p_list.extend([float(match_f.group(1)), float(match_f.group(2))])
                alpha = float(match_f.group(3))
                q_list.extend([float(match_f.group(4)), float(match_f.group(5))])
                beta = float(match_f.group(6))
            
            # Restricciones
            all_matches = re.findall(regex_restriccion_escalable, contenido)

            for match in all_matches:
                A_i1 = float(match[0])
                A_i2 = float(match[1])
                b_i = float(match[2])
                
                A_list.append([A_i1, A_i2])
                b_list.append(b_i)

        # Convertir a arrays
        p_np = np.array(p_list, dtype=float) if p_list else None
        q_np = np.array(q_list, dtype=float) if q_list else None
        A_np = np.array(A_list, dtype=float) if A_list else None
        b_np = np.array(b_list, dtype=float) if b_list else None
        
        return p_np, q_np, alpha, beta, A_np, b_np

    except Exception as e:
        sys.stderr.write(f"Error: {e}\n")
        return None, None, None, None, None, None


# ============================= FUNCIONES MATEMÁTICAS INDEPENDIENTES =============================

def Funcion_f(p, q, alpha, beta, x):
    """
    Función objetivo fraccional: f(x) = (p·x + α) / (q·x + β)
    """
    numerador = np.dot(p, x) + alpha
    denominador = np.dot(q, x) + beta
    if abs(denominador) < 1e-12:
        return float('inf')
    return numerador / denominador

def gradiente_f(p, q, alpha, beta, x):
    """
    Gradiente de la función objetivo: ∇f(x) = [D(x)·p - N(x)·q] / [D(x)]²
    
    Donde:
    N(x) = p·x + α (numerador)
    D(x) = q·x + β (denominador)
    
    """
    
    D = np.dot(q, x) + beta
    if abs(D) < 1e-12:
        return np.array([float('inf'), float('inf')])
    N = np.dot(p, x) + alpha
    return (D * p - N * q) / (D**2)


# ============================= ANÁLISIS DE PROPIEDADES TEÓRICAS (PDF) =============================

def Calcular_Vertices(A, b):
    """
    Calcula TODOS los vértices del poliedro.
    Considera todas las combinaciones posibles de 2 restricciones.
    """
    m = len(b)  # número de restricciones
    vertices = []
    
    # Probar todas las combinaciones de 2 restricciones de las m disponibles
    for i in range(m):
        for j in range(i + 1, m):
            A_ij = np.array([A[i], A[j]])
            b_ij = np.array([b[i], b[j]])
            
            try:
                # Resolver el sistema de ecuaciones
                x = np.linalg.solve(A_ij, b_ij)
                
                # Verificar factibilidad con TODAS las restricciones
                es_factible = True
                for k in range(m):
                    if np.dot(A[k], x) > b[k] + 1e-8:
                        es_factible = False
                        break
                
                if es_factible:
                    # Evitar duplicados 
                    es_nuevo = True
                    for v in vertices:
                        if np.linalg.norm(v - x) < 1e-8:
                            es_nuevo = False
                            break
                    if es_nuevo:
                        vertices.append(x)
                        
            except np.linalg.LinAlgError:
                # El sistema es singular (filas linealmente dependientes)
                continue
    if len(vertices) > 0:
        centro = np.mean(vertices, axis=0)
        vertices.sort(key=lambda v: np.arctan2(v[1]-centro[1], v[0]-centro[0]))
    
    return np.array(vertices)

def Identificar_Restricciones(A, b, vertices):
    """
    Identifica qué restricción corresponde a cada lado del cuadrilátero.
    """
    n = len(vertices)
    lado_por_restriccion = {}
    
    for i in range(len(b)):
        ai1, ai2 = A[i]
        bi = b[i]
        
        # Verificar qué vértices satisfacen exactamente esta restricción
        vertices_activos = []
        for j in range(n):
            if abs(ai1*vertices[j][0] + ai2*vertices[j][1] - bi) < 1e-8:
                vertices_activos.append(j)
        
        # Si exactamente 2 vértices están activos, es una arista
        if len(vertices_activos) == 2:
            lado_por_restriccion[i] = tuple(sorted(vertices_activos))
    
    return lado_por_restriccion

def Verificar_Propiedades_Teoricas(p, q, alpha, beta, vertices):
    """
    Verifica las propiedades teóricas.
    Retorna True si todas las propiedades se cumplen.
    """

    
    a, b = p[0], p[1]
    d, e = q[0], q[1]
    
    # 1. Verificar condición ae - bd = 1 
    condicion = a*e - b*d

    if abs(condicion - 1) < 1e-8:
        condicion_cumplida = True
    else:
        condicion_cumplida = False
    
    # 2. Verificar que denominador es positivo en todos los vértices 
    todos_positivos = True
    for i, v in enumerate(vertices):
        denominador = np.dot(q, v) + beta
        if denominador > 0:
            continue
           
        else:
            todos_positivos = False
    
    # 3. Verificar existencia de segmentos constantes 
    if len(vertices) == 4:
        # Evaluar función en vértices
        f_vals = [Funcion_f(p, q, alpha, beta, v) for v in vertices]
        
        # Buscar pares de vértices con igual valor de f
        segmentos_min = []
        segmentos_max = []
        
        # Verificar lados opuestos
        for i in range(4):
            j = (i + 1) % 4
            f_i = f_vals[i]
            f_j = f_vals[j]
            
            if abs(f_i - f_j) < 1e-8:
                # Verificar si es mínimo o máximo
                if abs(f_i - min(f_vals)) < 1e-8:
                    segmentos_min.append((i, j))
                    print(f"   Segmento V{i+1}-V{j+1}: f = {f_i:.6f} (MÍNIMO)")
                elif abs(f_i - max(f_vals)) < 1e-8:
                    segmentos_max.append((i, j))
                    print(f"   Segmento V{i+1}-V{j+1}: f = {f_i:.6f} (MÁXIMO)")
        
        if (len(segmentos_min) == 1 and len(segmentos_max) == 1 and 
            abs(segmentos_min[0][0] - segmentos_max[0][0]) == 2):
            print(f" Se encontraron segmentos opuestos como mínimo/máximo")
        else:
            print(f" No se encontraron segmentos opuestos claros")
    
    return condicion_cumplida and todos_positivos



# ============================= CÁLCULO DE MULTIPLICADORES KKT ANALÍTICOS =============================

def calcular_multiplicadores_analiticos(p, q, alpha, beta, vert, A, b, vertices, f_vals, lado_por_restriccion):
    """
    Calcula multiplicadores KKT usando fórmulas analíticas del PDF.
    """

    a, b_coef = p[0], p[1]
    c = alpha
    d, e = q[0], q[1]
    
    # Punto E del centro (página 9)
    p_centro = b_coef - c*e  # p = b - ce
    
    x1, x2 = vert[0], vert[1]
    D = d*x1 + e*x2 + 1  # Denominador en el punto
    
    # Encontrar qué restricciones están activas en este punto
    restricciones_activas = []
    for i in range(len(b)):
        if abs(np.dot(A[i], vert) - b[i]) < 1e-8:
            restricciones_activas.append(i)
    
    multiplicadores = np.zeros(len(b))
    
    # Si es un vértice, tiene 2 restricciones activas
    if len(restricciones_activas) == 2:
        # Determinar si es mínimo o máximo
        f_vert = Funcion_f(p, q, alpha, beta, vert)
        f_min = min(f_vals)
        f_max = max(f_vals)
        
        # Para cada restricción activa, determinar a qué lado corresponde
        for restr_idx in restricciones_activas:
            # Verificar si esta restricción corresponde a un lado del cuadrilátero
            if restr_idx in lado_por_restriccion:
                v1_idx, v2_idx = lado_por_restriccion[restr_idx]
                
                # Verificar si este lado es de mínimo o máximo
                f1 = f_vals[v1_idx]
                f2 = f_vals[v2_idx]
                
                # Si los dos vértices tienen el mismo valor de f
                if abs(f1 - f2) < 1e-8:
                    if abs(f1 - f_min) < 1e-8:
                        # Es un lado de MÍNIMO 
                        u3 = 1.0 / (D**2)
                        multiplicadores[restr_idx] = u3
                    
                    elif abs(f1 - f_max) < 1e-8:
                        # Es un lado de MÁXIMO 
                        if abs(x1 - p_centro) > 1e-12:
                            u1 = p_centro / (x1 - p_centro)
                            multiplicadores[restr_idx] = u1
    
    return multiplicadores, restricciones_activas


# ============================= RESOLUCIÓN COMPLETA KKT =============================

def resolver_KKT_completo(p, q, alpha, beta, A, b, vertices, f_vals):
    """
    Resuelve las condiciones KKT.
    """
    m = len(b)
    soluciones_min = []
    soluciones_max = []
    
    # Identificar mapeo de restricciones a lados
    lado_por_restriccion = Identificar_Restricciones(A, b, vertices)
    restriccion_por_lado = {v: k for k, v in lado_por_restriccion.items()}
    
    # Encontrar índices de mínimo y máximo
    idx_min = np.argmin(f_vals)
    idx_max = np.argmax(f_vals)
    f_min = f_vals[idx_min]
    f_max = f_vals[idx_max]
    
    
    # 1. Análisis de vértices
    for i, vert in enumerate(vertices):
        f_val = f_vals[i]
        
        # Calcular multiplicadores analíticos CON el mapeo
        mult_analiticos, activas = calcular_multiplicadores_analiticos(
            p, q, alpha, beta, vert, A, b, vertices, f_vals, lado_por_restriccion
        )
        
        # Calcular multiplicadores numéricos
        try:
            A_act = A[activas]
            g = gradiente_f(p, q, alpha, beta, vert)
            
            if not np.any(np.isinf(g)) and len(activas) > 0:
                lambda_act = np.linalg.solve(A_act.T, -g)
                
                # Crear vector completo
                lambda_completo = np.zeros(m)
                for idx, a in enumerate(activas):
                    lambda_completo[a] = lambda_act[idx]
                
                es_minimo = abs(f_val - f_min) < 1e-8
                es_maximo = abs(f_val - f_max) < 1e-8
                
                # Determinar tipo de punto
                lados_del_vertice = []
                for lado, restr_idx in restriccion_por_lado.items():
                    if i in lado:
                        lados_del_vertice.append(restr_idx)
                
                tipo = 'vertice'
                if len(lados_del_vertice) == 2:
                    # Verificar si está en un segmento de valor constante
                    # Buscar el otro vértice del lado
                    for lado in lados_del_vertice:
                        restr_idx = restriccion_por_lado.get(lado)
                        if restr_idx is not None:
                            # Encontrar el otro vértice de este lado
                            for v1, v2 in [lado]:
                                if v1 == i:
                                    otro_vert = v2
                                elif v2 == i:
                                    otro_vert = v1
                                else:
                                    continue
                                
                                # Si f es igual en ambos vértices, es parte de un segmento constante
                                if abs(f_vals[i] - f_vals[otro_vert]) < 1e-8:
                                    tipo = 'segmento'
                                    extremos = (vertices[i], vertices[otro_vert])
                
                # Guardar solución si es óptimo
                if es_minimo:
                    sol_dict = {
                        'x': vert, 
                        'f': f_val, 
                        'activas': activas,
                        'lambda_completo': lambda_completo,
                        'lambda_analiticos': mult_analiticos,
                        'tipo': tipo,
                        'optimo': 'minimo',
                        'satisface_kkt': np.all(lambda_act >= -1e-8)
                    }
                    if tipo == 'segmento':
                        sol_dict['extremos'] = extremos
                    soluciones_min.append(sol_dict)
                
                if es_maximo:
                    sol_dict = {
                        'x': vert, 
                        'f': f_val, 
                        'activas': activas,
                        'lambda_completo': lambda_completo,
                        'lambda_analiticos': mult_analiticos,
                        'tipo': tipo,
                        'optimo': 'maximo',
                        'satisface_kkt': np.all(lambda_act <= 1e-8)
                    }
                    if tipo == 'segmento':
                        sol_dict['extremos'] = extremos
                    soluciones_max.append(sol_dict)
                    
        except np.linalg.LinAlgError:
            continue
    
    # 2. Análisis de segmentos (puntos intermedios)
    for restr_idx, lado in lado_por_restriccion.items():
        v1_idx, v2_idx = lado
        v1 = vertices[v1_idx]
        v2 = vertices[v2_idx]
        f_v1 = f_vals[v1_idx]
        f_v2 = f_vals[v2_idx]
        
        # Verificar si f es constante en el segmento
        if abs(f_v1 - f_v2) < 1e-8:
            # Tomar punto medio
            x_medio = (v1 + v2) / 2
            
            # Calcular λ numéricamente
            g = gradiente_f(p, q, alpha, beta, x_medio)
            if not np.any(np.isinf(g)):
                a_k = A[restr_idx]
                lambda_k = -np.dot(g, a_k) / np.dot(a_k, a_k)
                
                # Crear vector completo
                lambda_completo = np.zeros(m)
                lambda_completo[restr_idx] = lambda_k
                
                es_minimo_segmento = abs(f_v1 - f_min) < 1e-8
                es_maximo_segmento = abs(f_v1 - f_max) < 1e-8
                
                # Calcular multiplicadores analíticos para el punto medio
                mult_analiticos, _ = calcular_multiplicadores_analiticos(
                    p, q, alpha, beta, x_medio, A, b, vertices, f_vals, lado_por_restriccion
                )
                
                # Guardar soluciones de segmentos
                if es_minimo_segmento:
                    soluciones_min.append({
                        'x': x_medio, 
                        'f': f_v1, 
                        'activas': [restr_idx],
                        'lambda_completo': lambda_completo,
                        'lambda_analiticos': mult_analiticos,
                        'tipo': 'segmento',
                        'extremos': (v1, v2),
                        'optimo': 'minimo',
                        'satisface_kkt': lambda_k >= -1e-8
                    })
                
                if es_maximo_segmento:
                    soluciones_max.append({
                        'x': x_medio, 
                        'f': f_v1, 
                        'activas': [restr_idx],
                        'lambda_completo': lambda_completo,
                        'lambda_analiticos': mult_analiticos,
                        'tipo': 'segmento',
                        'extremos': (v1, v2),
                        'optimo': 'maximo',
                        'satisface_kkt': lambda_k <= 1e-8
                    })
    
    return soluciones_min, soluciones_max, lado_por_restriccion


# ============================= ESCRITURA DE RESULTADOS COMPLETA =============================

def escribir_resultados_completos(archivo_salida, datos):
    """
    Escribe los resultados.
    """
    # Desempaquetar datos
    p = datos['p']
    q = datos['q']
    alpha = datos['alpha']
    beta = datos['beta']
    A = datos['A']
    b = datos['b']
    vertices = datos['vertices']
    f_vals = datos['f_vals']
    idx_min = datos['idx_min']
    idx_max = datos['idx_max']
    soluciones_min_KKT = datos['soluciones_min_KKT']
    soluciones_max_KKT = datos['soluciones_max_KKT']
    propiedades_cumplidas = datos.get('propiedades_cumplidas', False)
    
    # Encabezado
    archivo_salida.write("PRÁCTICA 8: PROGRAMACIÓN LINEAL FRACCIONAL 2 VARIABLES\n")
    archivo_salida.write("            ===========================================\n")
    
    # Información del problema
    archivo_salida.write("INFORMACIÓN DEL PROBLEMA:\n")
    archivo_salida.write(f"  f(x) = ({p[0]}·x1 + {p[1]}·x2 + {alpha}) / ({q[0]}·x1 + {q[1]}·x2 + {beta})\n")
    archivo_salida.write(f"  Condición teórica: a*e - b*d = {p[0]}*{q[1]} - {p[1]}*{q[0]} = {p[0]*q[1] - p[1]*q[0]}\n")
    archivo_salida.write(f"  Propiedades teóricas cumplidas: {'SÍ' if propiedades_cumplidas else 'NO'}\n\n")
    
    # Vértices
    archivo_salida.write("VÉRTICES DEL CUADRILÁTERO:\n")
    for i, vert in enumerate(vertices):
        archivo_salida.write(f"  V_{i+1}: ({vert[0]:.6f}, {vert[1]:.6f})\n")
    
    # Valores de la función en vértices
    archivo_salida.write("\nVALORES DE f(x) EN VÉRTICES:\n")
    for i, (vert, f_val) in enumerate(zip(vertices, f_vals)):
        denominador = np.dot(q, vert) + beta
        archivo_salida.write(f"  V_{i+1}: f = {f_val:.12f}")
        archivo_salida.write(f" (D(x) = {denominador:.6f} {'> 0 ' if denominador > 0 else '≤ 0 '})\n")
    
    # Óptimos globales
    archivo_salida.write("\nÓPTIMOS GLOBALES:\n")
    archivo_salida.write(f"  MÍNIMO GLOBAL: f = {f_vals[idx_min]:.12f}\n")
    archivo_salida.write(f"     En: x = ({vertices[idx_min][0]:.6f}, {vertices[idx_min][1]:.6f})\n")
    archivo_salida.write(f"     Vértice: V_{idx_min+1}\n")
    
    archivo_salida.write(f"\n  MÁXIMO GLOBAL: f = {f_vals[idx_max]:.12f}\n")
    archivo_salida.write(f"     En: x = ({vertices[idx_max][0]:.6f}, {vertices[idx_max][1]:.6f})\n")
    archivo_salida.write(f"     Vértice: V_{idx_max+1}\n")
    
    # Soluciones KKT para MÍNIMO
    archivo_salida.write("\n" + "="*80 + "\n")
    archivo_salida.write("SOLUCIONES KKT PARA MÍNIMO\n")
    archivo_salida.write("="*80 + "\n")
    
    if soluciones_min_KKT:
        archivo_salida.write(f"Mínimos que satisfacen condiciones KKT:\n\n")
        
        for i, sol in enumerate(soluciones_min_KKT):
            archivo_salida.write(f"Solución {i+1}:\n")
            archivo_salida.write(f"  Punto: ({sol['x'][0]:.6f}, {sol['x'][1]:.6f})\n")
            archivo_salida.write(f"  Tipo: {sol['tipo']}\n")
            archivo_salida.write(f"  Valor función: {sol['f']:.12f}\n")
            
            if sol['tipo'] == 'segmento':
                vi, vj = sol['extremos']
                archivo_salida.write(f"  Extremos: ({vi[0]:.2f}, {vi[1]:.2f}) → ({vj[0]:.2f}, {vj[1]:.2f})\n")
            
            archivo_salida.write(f"  Restricciones activas: {[a+1 for a in sol['activas']]}\n")
            
            
            if 'lambda_completo' in sol and sol['lambda_completo'] is not None:
                archivo_salida.write(f"  Multiplicadores (λ₁ a λ₄):\n")
                lambda_completo = sol['lambda_completo']
                for j in range(len(lambda_completo)):
                    λ_val = lambda_completo[j]
                    if abs(λ_val) < 1e-12:
                        archivo_salida.write(f"    λ_{j+1} = 0.0000000000  (cero)")
                    elif λ_val < 0:
                        archivo_salida.write(f"    λ_{j+1} = {λ_val:.10f}  (negativo)")
                    else:
                        archivo_salida.write(f"    λ_{j+1} = {λ_val:.10f}  (positivo)")
                    archivo_salida.write("\n")
            
    else:
        archivo_salida.write("No se encontraron soluciones KKT para el mínimo\n")
    
    # Soluciones KKT para MÁXIMO
    archivo_salida.write("\n" + "="*80 + "\n")
    archivo_salida.write("SOLUCIONES KKT PARA MÁXIMO\n")
    archivo_salida.write("="*80 + "\n")
    
    if soluciones_max_KKT:
        archivo_salida.write(f"Máximos que satisfacen condiciones KKT:\n\n")
        
        for i, sol in enumerate(soluciones_max_KKT):
            archivo_salida.write(f"Solución {i+1}:\n")
            archivo_salida.write(f"  Punto: ({sol['x'][0]:.6f}, {sol['x'][1]:.6f})\n")
            archivo_salida.write(f"  Tipo: {sol['tipo']}\n")
            archivo_salida.write(f"  Valor función: {sol['f']:.12f}\n")
            
            if sol['tipo'] == 'segmento':
                vi, vj = sol['extremos']
                archivo_salida.write(f"  Extremos: ({vi[0]:.2f}, {vi[1]:.2f}) → ({vj[0]:.2f}, {vj[1]:.2f})\n")
            
            archivo_salida.write(f"  Restricciones activas: {[a+1 for a in sol['activas']]}\n")
            
            
            
            if 'lambda_completo' in sol and sol['lambda_completo'] is not None:
                archivo_salida.write(f"  Multiplicadores (λ₁ a λ₄):\n")
                lambda_completo = sol['lambda_completo']
                for j in range(len(lambda_completo)):
                    λ_val = lambda_completo[j]
                    archivo_salida.write(f"    λ_{j+1} = {λ_val:.10f}")
                    if λ_val < -1e-10:
                        archivo_salida.write("  (negativo)")
                    elif λ_val > 1e-10:
                        archivo_salida.write(" (positivo)")
                    else:
                        archivo_salida.write("  (cero)")
                    archivo_salida.write("\n")
            
            archivo_salida.write("\n")
    else:
        archivo_salida.write("No se encontraron soluciones KKT para el máximo\n")
    
    # Resumen y conclusiones
    archivo_salida.write("\n" + "="*80 + "\n")
    archivo_salida.write("CONCLUSIONES FINALES\n")
    archivo_salida.write("="*80 + "\n")
    
    archivo_salida.write(f"\n1. Propiedades teóricas del PDF:\n")
    if propiedades_cumplidas:
        archivo_salida.write(f" El problema cumple las propiedades del PDF\n")
        archivo_salida.write(f" Denominador positivo en toda la región factible\n")
        archivo_salida.write(f" Existencia de segmentos de mínimo y máximo opuestos\n")
    else:
        archivo_salida.write(f"  El problema NO cumple todas las propiedades del PDF\n")
        archivo_salida.write(f"   (puede ser un problema más general)\n")
    
    archivo_salida.write(f"\n2. Resultados numéricos:\n")
    archivo_salida.write(f"   • Mínimo global: f = {f_vals[idx_min]:.12f}\n")
    archivo_salida.write(f"   • Máximo global: f = {f_vals[idx_max]:.12f}\n")
    
    # Verificar segmentos constantes
    segmentos_min = []
    segmentos_max = []
    n = len(vertices)
    for i in range(n):
        j = (i + 1) % n
        if abs(f_vals[i] - f_vals[j]) < 1e-8:
            if abs(f_vals[i] - f_vals[idx_min]) < 1e-8:
                segmentos_min.append((i, j))
            elif abs(f_vals[i] - f_vals[idx_max]) < 1e-8:
                segmentos_max.append((i, j))
    
    archivo_salida.write(f"\n3. Segmentos constantes:\n")
    if segmentos_min:
        archivo_salida.write(f"   - Segmento(s) de MÍNIMO \n")
        for i, j in segmentos_min:
            archivo_salida.write(f"     V_{i+1}-V_{j+1}: f = {f_vals[i]:.6f}\n")
    
    if segmentos_max:
        archivo_salida.write(f"   - Segmento(s) de MÁXIMO \n")
        for i, j in segmentos_max:
            archivo_salida.write(f"     V_{i+1}-V_{j+1}: f = {f_vals[i]:.6f}\n")
    

# ============================= PROGRAMA PRINCIPAL =============================

def main(archivo_entrada, archivo_salida):
    try:
        # 1. Leer datos
        p, q, alpha, beta, A, b = Leer_Datos(archivo_entrada)
        
        if p is None or q is None or A is None or b is None:
            sys.stderr.write(" Error leyendo datos del archivo\n")
            return
    
        
        # 2. Calcular vértices
        vertices = Calcular_Vertices(A, b)
        
        if len(vertices) != 4:
            sys.stderr.write(f" No se encontraron los 4 vértices esperados (encontrados: {len(vertices)})\n")
            return
        
        
        # 3. Evaluar función en vértices
        f_vals = []
        for i, v in enumerate(vertices):
            f_val = Funcion_f(p, q, alpha, beta, v)
            f_vals.append(f_val)
        
        # 4. Encontrar mínimo y máximo
        idx_min = np.argmin(f_vals)
        idx_max = np.argmax(f_vals)
        
        # 5. Verificar propiedades teóricas 
        propiedades_cumplidas = Verificar_Propiedades_Teoricas(p, q, alpha, beta, vertices)
        
        # 6. Resolver condiciones KKT 
        soluciones_min_KKT, soluciones_max_KKT, lado_por_restriccion = resolver_KKT_completo(
    p, q, alpha, beta, A, b, vertices, f_vals)

        # 7. Preparar datos para escritura 
        datos_resultados = {
            'p': p,
            'q': q,
            'alpha': alpha,
            'beta': beta,
            'A': A,
            'b': b,
            'vertices': vertices,
            'f_vals': f_vals,
            'idx_min': idx_min,
            'idx_max': idx_max,
            'soluciones_min_KKT': soluciones_min_KKT,
            'soluciones_max_KKT': soluciones_max_KKT,
            'propiedades_cumplidas': propiedades_cumplidas,
            'lado_por_restriccion': lado_por_restriccion  # Nuevo
        }
        
    
        # 8. Escribir resultados a archivo
        with open(archivo_salida, 'w', encoding='utf-8') as archivo:
            escribir_resultados_completos(archivo, datos_resultados)
        
        
    except Exception as e:
        sys.stderr.write(f"\n ERROR DURANTE LA EJECUCIÓN: {e}\n")
        import traceback
        traceback.print_exc()


# ============================= EJECUCIÓN =============================

if __name__ == "__main__":
    archivo_entrada = "Datos8.dat"
    archivo_salida = "Solucion8.sol"
    main(archivo_entrada, archivo_salida)
    
    
    
    
    
    