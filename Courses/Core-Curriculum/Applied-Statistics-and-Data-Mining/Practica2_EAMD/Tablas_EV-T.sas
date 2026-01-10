/* -------------------------------
1️⃣ Crear librería
---------------------------------- */
libname mi_lib 'C:/Users/IB_an/Desktop/Practica_EAMD_2/2_contratacionSeguroMovil';

/* -------------------------------
2️⃣ Verificar tabla original
---------------------------------- */
proc contents data=mi_lib.contratacionseguromovil;
run;

/* -------------------------------
3️⃣ Crear dataset Test (20%) y Train+Validation (80%)
---------------------------------- */
data mi_lib.DATA_CSM_TEST mi_lib.DATA_CSM_TRAINVAL;
    set mi_lib.contratacionseguromovil;
    
    /* Inicializar generador de números aleatorios */
    if _N_ = 1 then call streaminit(12345);
    
    /* Número aleatorio entre 0 y 1 */
    randnum = rand("uniform");
    
    /* Separar Test y Train+Validation */
    if randnum <= 0.2 then output mi_lib.DATA_CSM_TEST;
    else output mi_lib.DATA_CSM_TRAINVAL;
run;

/* -------------------------------
4️⃣ Eliminar variable auxiliar randnum
---------------------------------- */
data mi_lib.DATA_CSM_TEST;
    set mi_lib.DATA_CSM_TEST;
    drop randnum;
run;

data mi_lib.DATA_CSM_TRAINVAL;
    set mi_lib.DATA_CSM_TRAINVAL;
    drop randnum;
run;

/* -------------------------------
5️⃣ Verificar proporciones de clases
---------------------------------- */

/* Proporción en el dataset original */
proc freq data=mi_lib.contratacionseguromovil;
tables ContrataSeguroMovil / nocum out=work.original_freq;
run;

/* Proporción en Train+Validation */
proc freq data=mi_lib.DATA_CSM_TRAINVAL;
tables ContrataSeguroMovil / nocum out=work.trainval_freq;
run;

/* Proporción en Test */
proc freq data=mi_lib.DATA_CSM_TEST;
tables ContrataSeguroMovil / nocum out=work.test_freq;
run;
