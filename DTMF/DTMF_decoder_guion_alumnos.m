function pulsacionesDetectadas = DTMF_decoder_guion_alumnos(x,PLOT)
senyal = generaDTMF(x,PLOT);

% Datos tabla DTMF
f = [697,770,852,941,1209 ,1336 ,1477 ,1633];
MATRIZNUMEROS=[['1','2','3','A'];['4','5','6','B'];['7','8','9','C'];['*','0','#','D']];
Fs = 8000;
Ts = 1/Fs;

% Diseño las frecuencias de corte de los filtros de manera que caigan (por ejemplo) en el punto medio entre cada uno de los tonos
fc = [660 734 811 897 1075 1273 1407 1555 1711];


xFiltrada = zeros(length(senyal),length(f)); % Preallocation con ceros

% Relleno cada columna de la matriz xFiltrada con la salida de cada uno de los filtros:
% Puede que necesite algún tipo de bucle
    xFiltrada(:,1)=filtra(senyal,[fc(1) fc(2)],Fs,PLOT);
    xFiltrada(:,2)=filtra(senyal,[fc(2) fc(3)],Fs,PLOT);
    xFiltrada(:,3)=filtra(senyal,[fc(3) fc(4)],Fs,PLOT);
    xFiltrada(:,4)=filtra(senyal,[fc(4) fc(5)],Fs,PLOT);
    xFiltrada(:,5)=filtra(senyal,[fc(5) fc(6)],Fs,PLOT);
    xFiltrada(:,6)=filtra(senyal,[fc(6) fc(7)],Fs,PLOT);
    xFiltrada(:,7)=filtra(senyal,[fc(7) fc(8)],Fs,PLOT);
    xFiltrada(:,8)=filtra(senyal,[fc(8) fc(9)],Fs,PLOT);
    
    if PLOT % Estos plots puede que no funcionen si hay algún nombre que no encaje. Llamad al profesor si tenéis problemas con ellos.
    figure
    stem(f,ones(1,length(f)))
    hold on
    stem(fc,ones(1,length(fc)))
    legend('Frecuencias de los tonos','Frecuencias de corte de los filtros')
    figure
    t = 0:Ts:(size(xFiltrada,1)-1)*Ts;
    plot(t,xFiltrada)
    xlabel('Timepo [s]')
    end

if PLOT % Estos plots puede que no funcionen si hay algún nombre que no encaje. Llamad al profesor si tenéis problemas con ellos.
    %Les pongo un offset para verlas bien
    xFiltradaPlot= xFiltrada + repmat(1:size(xFiltrada,2),size(xFiltrada,1),1);
    
    figure
    plot(t,xFiltradaPlot)
    xlabel('Timepo [s]')
    title('Salidas de cada filtro con offset (para verlas bien)')
    legend([repmat('salida filtro',size(xFiltradaPlot,2),1) , num2str((1:size(xFiltradaPlot,2))') ])
end

% Rectifico las señales tomando su valor absoluto
xFiltradaRectificada = abs(xFiltrada);

if PLOT % Estos plots puede que no funcionen si hay algún nombre que no encaje. Llamad al profesor si tenéis problemas con ellos.
    figure
    xFiltradaRectificadaPlot= xFiltradaRectificada + repmat(1:size(xFiltrada,2),size(xFiltrada,1),1);
    plot(t,xFiltradaRectificadaPlot)
    xlabel('Timepo [s]')
    title('Salidas de cada filtro Y RECTIFICADAS con offset (para verlas bien)')
    legend([repmat('salida filtro',size(xFiltradaPlot,2),1) , num2str((1:size(xFiltradaPlot,2))') ])
    
end

% Filtro para quedarme con la continua. Para quedarme con la continua filtro todas las señales rectificadas de manera que solo pase la componente continua.
% ¿Cómo puedo saber la frecuencia de corte a utilizar?

    xFiltradaRectificadaFiltrada = filtra(xFiltradaRectificada,100,Fs,PLOT);


if PLOT % Estos plots puede que no funcionen si hay algún nombre que no encaje. Llamad al profesor si tenéis problemas con ellos.
    xFiltradaRectificadaFiltradaPlot = xFiltradaRectificadaFiltrada + repmat(1:size(xFiltrada,2),size(xFiltrada,1),1);
    figure
    plot(t,xFiltradaRectificadaFiltradaPlot)
    xlabel('Timepo [s]')
    title('Salidas de cada filtro, rectificada Y FILTRADA con offset (para verlas bien)')
    legend([repmat('Rama ',size(xFiltradaPlot,2),1) , num2str((1:size(xFiltradaPlot,2))') ])
end


% Detecto las posiciones de cada señal en las que tengo componente de señal
% diferente de cero.
detectorThreshold = 0.25; % Para no comparar con 0, puedo comparar con un cierto umbral. Quizá haya que afinarlo mirando la señal
[nf,nc]=size(xFiltradaRectificadaFiltrada);


R = xFiltradaRectificadaFiltrada;
for f = 1:nf % fila a fila
ind=find(xFiltradaRectificadaFiltrada>=detectorThreshold);
R(ind)=1;

ind2=find(xFiltradaRectificadaFiltrada<detectorThreshold);
R(ind2)=0;

end
xDetectada = R;
if PLOT % Estos plots puede que no funcionen si hay algún nombre que no encaje. Llamad al profesor si tenéis problemas con ellos.
    xDetectadaPlot= xDetectada + repmat(1:size(xDetectada,2),size(xDetectada,1),1);
    figure
    plot(t,xDetectadaPlot)
    xlabel('Timepo [s]')
    title('Entradas al detector con offset (para verlas bien)')
    legend([repmat('Rama ',size(xFiltradaPlot,2),1) , num2str((1:size(xFiltradaPlot,2))') ])
end

% Detecto las filas mirando las salidas de las cuatro primeras señales
filasmat=xDetectada(:,1:4);
columnasmat=xDetectada(:,5:8);
for i=1:4
    filasmat(:,i)= filasmat(:,i)*i;
end
for i=1:4
    columnasmat(:,i)= columnasmat(:,i)*i;
end
filas=sum(filasmat,2);
columnas=sum(columnasmat,2);
filasPulsadas = diff(filas);

ind=[];
for i=1:length(filasPulsadas)
    if(filasPulsadas(i)<=0)
        ind=[ind i];
    end
end
filasPulsadas([ind])=[];

columnasPulsadas = diff(columnas)
ind=[];
for i=1:length(columnasPulsadas)
    if(columnasPulsadas(i)<=0)
        ind=[ind i];
    end
end
columnasPulsadas([ind])=[];
% Detecto las columnas mirando las salidas de las cuatro últimas señales


% Para el caso de haber pulsado los números 1 4 6, el resultado de los
% vectores filasPulsadas y columnasPulsadas sería:
%
%  columnasPulsadas =
%
%      1
%      1
%      3
%
%   filasPulsadas =
%
%      1
%      2
%      2

% Decodifico los valores
pulsacionesDetectadas = MATRIZNUMEROS(sub2ind(size(MATRIZNUMEROS),filasPulsadas, columnasPulsadas))'
disp(['Las pulsaciones detectadas son: ',num2str(pulsacionesDetectadas)])
