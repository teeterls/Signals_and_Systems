function [BER] = Ejercicio5(n_bits,SNR)
nSym=10000*log2(n_bits);
%% OJO para hacerlo con las funciones de Matlab, esto tiene que ser una funcion columna
secuencia_bits_tx_QAM = round(rand(nSym, 1));

%Creo el objeto modulador y modulo la secuencia_bits_tx_QAM
secuencia_simbolos_tx_QAM = qammod(secuencia_bits_tx_QAM, n_bits, 'gray', 'InputType','bit');
scatterplot(secuencia_simbolos_tx_QAM);

% A?ado ruido 
secuencia_simbolos_rx_QAM = awgn(secuencia_simbolos_tx_QAM,SNR,'measured');
scatterplot(secuencia_simbolos_rx_QAM);

%Creo el objeto demodulador basandome en el modulador y demodulo la secuencia_simbolos_rx_QAM
secuencia_bits_rx_QAM = qamdemod(secuencia_simbolos_rx_QAM, n_bits,'gray', 'OutputType','bit');

%Calculo la BER
BER = calculaBER(secuencia_bits_tx_QAM,secuencia_bits_rx_QAM,false)

end

