/*TRABAJO 1*/
title1 'Indice de comercio al por menor';
title2 'Series Temporales';

libname Trabajo1 'C:\MARTA\Mestrado\Asignaturas ahora\EAMD\Trabajo1';
proc import datafile = "C:\MARTA\Mestrado\Asignaturas ahora\EAMD\Trabajo1\ic.xlsx"
	out = Trabajo1.ic;
	getnames = yes;
run;

Data Trabajo1.ic_entrenamiento;
	SET Trabajo1.ic;
	logINDICE = log(INDICE);
	IF FECHANUEVA < '01OCT2024'd;
run;

/*Visualizar serie*/
proc timeseries data=Trabajo1.ic_entrenamiento plot=series;
   id Fechanueva interval=month;
   var logIndice;
run;

*Ver si es necesario transformar la serie;
%boxcoxar(Trabajo1.ic_entrenamiento,INDICE,nlambda=3,lambdalo=0,lambdahi=1);
%logtest(Trabajo1.ic_entrenamiento,INDICE,print=yes);

*Necesitamos de hacer una transformación logaritmica;

*test de raices unitarias;
%dftest(Trabajo1.ic_entrenamiento,INDICE,dlag=1,ar=4,trend=0);
%put &dfpvalue;

proc arima data=Trabajo1.ic_entrenamiento;
identify var=indice stationarity=(adf=(1 2 3 4 5) dlag=1);
run;
quit;

*error en ARIMA(1,0,0)(1,0,1)s;
proc arima data=Trabajo1.ic_entrenamiento;
identify var=logIndice;
estimate p =(1)(12) q=(12) plot;
run;


*regresores;
Data Trabajo1.ic_entrenamiento_regresores;
	SET Trabajo1.ic_entrenamiento;
	COVID = (FECHANUEVA >= '01MAR2020'd and FECHANUEVA <= '01MAY2020'd);
run;


/*Comprobar final con regresores*/
proc arima data=Trabajo1.ic_entrenamiento_regresores;
identify var=logINDICE(1 12)
crosscorr=(COVID(1 12));
estimate plot q = (1 2)(12) noint
input=(COVID)
method=ML;
run;

/*anadir lineas covid para predicciones*/
data Trabajo1.nuevos;
    do i = 1 to 12;
        fechanueva = intnx('month', '01SEP2024'd, i);
        format fechanueva date9.;
        COVID = 0;
        output;
    end;
	drop i;
run;

data Trabajo1.datos_completo;
    set Trabajo1.ic_entrenamiento_regresores
        Trabajo1.nuevos;
run;


/**/
proc arima data=Trabajo1.datos_completo
   plots = forecast(forecasts);
   identify var=logINDICE(1 12) crosscorr=(COVID(1 12));
   estimate plot q = (1 2)(12) noint input=(COVID) method=ML; 
   forecast  lead=12 id=Fechanueva interval=month printall out=Trabajo1.predicciones;
run;




data Trabajo1.datos_completo_transformados;
set Trabajo1.predicciones;
indice_original = exp( logIndice );
forecast = exp( forecast );
l95 = exp( l95 );
u95 = exp( u95 );
run;



proc sgplot data=Trabajo1.datos_completo_transformados;
where fechanueva >= '1jan58'd;
band Upper=u95 Lower=l95 x=Fechanueva
/ LegendLabel="95% Confidence Limits";
scatter x=Fechanueva y=indice_original;
series x=Fechanueva y=forecast;
run;

/*Visualizar*/
data Trabajo1.comparaciones;
    merge Trabajo1.datos_completo_transformados (in=a)
          Trabajo1.Ic (in=b);
    by fechanueva;
run;
proc sgplot data=Trabajo1.comparaciones;
	where year(fechanueva) >= 2020;
	band Upper=u95 Lower=l95 x=Fechanueva / LegendLabel="95% Confidence Limits";
    series x=fechanueva y=Indice / lineattrs=(color=blue thickness=2) legendlabel="Original";
    series x=fechanueva y=Forecast / lineattrs=(color=red thickness=2 pattern=shortdash) legendlabel="Predicción";
    xaxis label="Fecha";
    yaxis label="Índice";
    title "Índices Originales vs Predicciones";
run;

