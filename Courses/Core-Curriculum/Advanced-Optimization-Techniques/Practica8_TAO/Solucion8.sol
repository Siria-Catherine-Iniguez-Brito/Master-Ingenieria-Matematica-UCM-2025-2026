PRÁCTICA 8: PROGRAMACIÓN LINEAL FRACCIONAL 2 VARIABLES
            ===========================================
INFORMACIÓN DEL PROBLEMA:
  f(x) = (103.0·x1 + 137.0·x2 + 36.0) / (3.0·x1 + 4.0·x2 + 1.0)
  Condición teórica: a*e - b*d = 103.0*4.0 - 137.0*3.0 = 1.0
  Propiedades teóricas cumplidas: SÍ

VÉRTICES DEL CUADRILÁTERO:
  V_1: (98.000000, -70.000000)
  V_2: (62.000000, 14.000000)
  V_3: (16.000000, 8.000000)
  V_4: (14.000000, -10.000000)

VALORES DE f(x) EN VÉRTICES:
  V_1: f = 36.000000000000 (D(x) = 15.000000 > 0 )
  V_2: f = 34.320987654321 (D(x) = 243.000000 > 0 )
  V_3: f = 34.320987654321 (D(x) = 81.000000 > 0 )
  V_4: f = 36.000000000000 (D(x) = 3.000000 > 0 )

ÓPTIMOS GLOBALES:
  MÍNIMO GLOBAL: f = 34.320987654321
     En: x = (62.000000, 14.000000)
     Vértice: V_2

  MÁXIMO GLOBAL: f = 36.000000000000
     En: x = (14.000000, -10.000000)
     Vértice: V_4

================================================================================
SOLUCIONES KKT PARA MÍNIMO
================================================================================
Mínimos que satisfacen condiciones KKT:

Solución 1:
  Punto: (62.000000, 14.000000)
  Tipo: vertice
  Valor función: 34.320987654321
  Restricciones activas: [3, 4]
  Multiplicadores (λ₁ a λ₄):
    λ_1 = 0.0000000000  (cero)
    λ_2 = 0.0000000000  (cero)
    λ_3 = 0.0000508053  (positivo)
    λ_4 = 0.0000000000  (cero)
Solución 2:
  Punto: (16.000000, 8.000000)
  Tipo: vertice
  Valor función: 34.320987654321
  Restricciones activas: [2, 3]
  Multiplicadores (λ₁ a λ₄):
    λ_1 = 0.0000000000  (cero)
    λ_2 = 0.0000000000  (cero)
    λ_3 = 0.0001524158  (positivo)
    λ_4 = 0.0000000000  (cero)
Solución 3:
  Punto: (39.000000, 11.000000)
  Tipo: segmento
  Valor función: 34.320987654321
  Extremos: (62.00, 14.00) → (16.00, 8.00)
  Restricciones activas: [3]
  Multiplicadores (λ₁ a λ₄):
    λ_1 = 0.0000000000  (cero)
    λ_2 = 0.0000000000  (cero)
    λ_3 = 0.0000762079  (positivo)
    λ_4 = 0.0000000000  (cero)

================================================================================
SOLUCIONES KKT PARA MÁXIMO
================================================================================
Máximos que satisfacen condiciones KKT:

Solución 1:
  Punto: (98.000000, -70.000000)
  Tipo: vertice
  Valor función: 36.000000000000
  Restricciones activas: [1, 4]
  Multiplicadores (λ₁ a λ₄):
    λ_1 = -0.0666666667  (negativo)
    λ_2 = 0.0000000000  (cero)
    λ_3 = 0.0000000000  (cero)
    λ_4 = -0.0000000000  (cero)

Solución 2:
  Punto: (14.000000, -10.000000)
  Tipo: vertice
  Valor función: 36.000000000000
  Restricciones activas: [1, 2]
  Multiplicadores (λ₁ a λ₄):
    λ_1 = -0.3333333333  (negativo)
    λ_2 = -0.0000000000  (cero)
    λ_3 = 0.0000000000  (cero)
    λ_4 = 0.0000000000  (cero)

Solución 3:
  Punto: (56.000000, -40.000000)
  Tipo: segmento
  Valor función: 36.000000000000
  Extremos: (98.00, -70.00) → (14.00, -10.00)
  Restricciones activas: [1]
  Multiplicadores (λ₁ a λ₄):
    λ_1 = -0.1111111111  (negativo)
    λ_2 = 0.0000000000  (cero)
    λ_3 = 0.0000000000  (cero)
    λ_4 = 0.0000000000  (cero)


================================================================================
CONCLUSIONES FINALES
================================================================================

1. Propiedades teóricas del PDF:
 El problema cumple las propiedades del PDF
 Denominador positivo en toda la región factible
 Existencia de segmentos de mínimo y máximo opuestos

2. Resultados numéricos:
   • Mínimo global: f = 34.320987654321
   • Máximo global: f = 36.000000000000

3. Segmentos constantes:
   - Segmento(s) de MÍNIMO 
     V_2-V_3: f = 34.320988
   - Segmento(s) de MÁXIMO 
     V_4-V_1: f = 36.000000
